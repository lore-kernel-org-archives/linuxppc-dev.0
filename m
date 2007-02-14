Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0A42FDDDFE
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 02:40:53 +1100 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l1EFeoRD003260
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 10:40:50 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l1EFenRp519136
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 08:40:49 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l1EFejJC009179
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 08:40:45 -0700
Subject: Re: [PATCH 7/16] Early serial debug support for PPC44x
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Alan Modra <amodra@bigpond.net.au>
In-Reply-To: <20070214023846.GC8541@bubble.grove.modra.org>
References: <20070213061024.DA1ABDDD0C@ozlabs.org>
	<1171379087.4003.40.camel@zod.rchland.ibm.com>
	<20070214001622.GB11491@localhost.localdomain>
	<20070214010235.GB19430@crusty.rchland.ibm.com>
	<20070214010044.GG11491@localhost.localdomain>
	<20070214020012.GB8541@bubble.grove.modra.org>
	<20070214020251.GI11491@localhost.localdomain>
	<20070214023846.GC8541@bubble.grove.modra.org>
Content-Type: text/plain
Date: Wed, 14 Feb 2007 09:41:48 -0600
Message-Id: <1171467708.4003.92.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, dwg@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-02-14 at 13:08 +1030, Alan Modra wrote:
> > > 
> > > I would guess that this isn't a matter of how old the assembler is,
> > > but how the assembler was built.  If built on a 32-bit host with no
> > > 64-bit targets supported, then most internal assembler variables
> > > are 32-bit and 64-bit constants are not handled very well.
> > > 
> > > You probably should avoid 64-bit expressions on a 32-bit target.
> > 
> > Well, yes, but how.
> 
> No idea, but I haven't even looked at the code in question.  I'm just
> pointing out the toolchain limitation.  It sounds like what you've
> done requires that people build their binutils with
> --enable-64-bit-bfd or choose support for an extra 64-bit target,
> eg. --enable-targets=powerpc64-linux

Yes, that seems to be the case.  I built a powerpc64 cross toolchain
this morning and recompiled the kernel.  It worked just fine.

But I also think we want to avoid requiring that in peoples toolchains.
I'll see if we can't accomplish what we're trying to do some other way
without being too ugly.

josh
