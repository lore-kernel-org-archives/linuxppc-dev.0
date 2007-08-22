Return-Path: <npiggin@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C9310DDEEB
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Aug 2007 14:05:11 +1000 (EST)
Date: Wed, 22 Aug 2007 06:05:04 +0200
From: Nick Piggin <npiggin@suse.de>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [patch 1/2] powerpc: rmb fix
Message-ID: <20070822040504.GC26374@wotan.suse.de>
References: <20070821021143.GB2909@wotan.suse.de>
	<46CB37D4.2080609@austin.ibm.com>
	<d9f43b5c31fde5851a7af1d0f36eb134@kernel.crashing.org>
	<20070822031506.GA26374@wotan.suse.de>
	<1afbd9c8892724e484f29532802a3405@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1afbd9c8892724e484f29532802a3405@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 22, 2007 at 05:33:16AM +0200, Segher Boessenkool wrote:
> >>The I/O accessor functions enforce the necessary ordering
> >>already I believe.
> >
> >Hmm, I never followed those discussions last year about IO ordering, 
> >and
> >I can't see where (if) it was documented anywhere :(
> 
> The comments in system.h weren't updated with the last fix, I think.
> 
> >It appears that legacy code is handled by defining the old IO 
> >accessors to
> >be completely ordered, and introducing new __raw_ variants that are not
> >(OTOH, it seems like other architectures are implementing __raw prefix 
> >as
> >inorder unless there is a _relaxed postfix).
> 
> __raw_XX() is for platform code only, which can do the needed
> barriers without having to use the heavy hammer like everything
> else unfortunately does.


npiggin@nick:~/usr/src/linux-2.6/drivers> egrep '__raw_(write|read)' -r * | wc -l
685

 
> >Drivers are definitely using these __raw_ accessors, and from a quick
> >look, they do appear to be hoping that *mb() is going to order access 
> >for
> >them.
> 
> Which drivers?

There are maybe a dozen that use the raw accessors, and use non-smp_
memory barriers. I just looked at drivers/video/tgafb.c, which
indeed appears to intermix them.
