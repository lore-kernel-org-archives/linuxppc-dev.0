Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 8622DDDDEF
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Feb 2008 23:40:19 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: copy_from_user problem
Date: Wed, 27 Feb 2008 13:40:02 +0100
References: <47C36FBA.1030600@us.ibm.com> <1204068146.15052.188.camel@pasglop>
	<47C5574D.2090409@us.ibm.com>
In-Reply-To: <47C5574D.2090409@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200802271340.02930.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 27 February 2008, Maynard Johnson wrote:
> > Sounds to me that your kernel module will try to copy_from_user() from
> > the user context of ... insmod :-)
> > =A0=20
> Yeah, that's probably the problem (along with my lack of understanding=20
> how VM works =A0-- heh). =A0I guess I was just getting lucky with the 32-=
bit=20
> test in that the 32-bit libc was being loaded for my insmod process at=20
> the same virtual memory address as for my C test program.
> > You need to do your copy_from_user() from within the context of the
> > program you try to access the memory from !
> > =A0=20
> Can't do that in the "real" code I'm developing, so I guess I'll need to=
=20
> use get_user_pages. =A0Hmmm . . . not quite as simple to use as=20
> copy_from_user, and I don't see any doc on it. =A0But at least I've found=
=20
> a couple examples in the kernel tree.

Are you sure that this has to run in kernel space? You may be able to
do the same thing with ptrace() from another user process, which is
normally a lot easier to do, especially if you're not familiar with all
the corner cases in powerpc linux memory management.

> > If you need to access another context than the current one, you then
> > need to use a different mechanism, such as get_user_pages(), though
> > beware that you can only do that for memory, not SPE local store or
> > register mappings.
> > =A0=20
> The "real" code I'm developing is targeted at POWER, not Cell.

Cell systems are compliant to the Power architecture and they run
the same software, so you should at least make sure you have error
handling in place to deal with an access of SPU local store pages
and don't cause random crashes.

	Arnd <><
