Return-Path: <erik@dd.nec.com.au>
Received: from ns2.nec.com.au (ns2.nec.com.au [147.76.180.2])
	by ozlabs.org (Postfix) with ESMTP id BDD23DDF68
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Jun 2007 18:07:39 +1000 (EST)
Received: from smtp1.nec.com.au (unknown [172.31.8.18])
	by ns2.nec.com.au (Postfix) with ESMTP
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Jun 2007 17:37:21 +1000 (EST)
Received: from bohr.dd.nec.com.au (bohr.dd.nec.com.au [172.31.20.11])
	by deer.dd.nec.com.au (8.12.5/8.12.5/Debian-1) with ESMTP id
	l5S7ZHwX014904
	for <linuxppc-embedded@ozlabs.org>; Thu, 28 Jun 2007 17:35:17 +1000
Received: from dvalin ([172.31.20.70])
	by bohr.dd.nec.com.au (8.12.3/8.12.3/Debian-7.1) with ESMTP id
	l5S7ZGil026053
	for <linuxppc-embedded@ozlabs.org>; Thu, 28 Jun 2007 17:35:16 +1000
Date: Thu, 28 Jun 2007 17:44:30 +1000
To: linuxppc-embedded@ozlabs.org
Subject: Re: ARCH=ppc or ARCH=powerpc
Message-ID: <20070628074430.GC8794@dd.nec.com.au>
References: <F795765B112E7344AF36AA911279641502D1A42C@xmb-sjc-212.amer.cisco.com>
	<2DD9CF30-5127-4EC1-8D8E-BC6552A832AE@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2DD9CF30-5127-4EC1-8D8E-BC6552A832AE@kernel.crashing.org>
From: erik@dd.nec.com.au (Erik Christiansen)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Jun 27, 2007 at 08:20:28PM -0500, Kumar Gala wrote:
> On Jun 27, 2007, at 4:41 PM, Bizhan Gholikhamseh ((bgholikh)) wrote:
> > Here are my questions:
> > 1- Should I use ARCH=ppc or ARCH=powerpc to build the kernel?
> 
> Move to ARCH=powerpc.

Would that advice be specific to the MPC8541E?
Encountering a kernel build error with ARCH=ppc, after configuring as much as
possible for MPC8248, I've just tried ARCH=powerpc on linux-2.6.21.5, with this
slightly scary result:

>>>
  There is no help available for this kernel option.            
  Symbol: EMBEDDED6xx [=n]                                     
  Prompt: Embedded 6xx/7xx/7xxx-based board                   
    Defined at arch/powerpc/Kconfig:384                      
    Depends on: <choice> && PPC32 && (BROKEN || BROKEN_ON_SMP) 
    Location:                                                 
      -> Platform support                                    
        -> Machine type (<choice> [=y])
<<<

(Note: MPC8248 fits in the 6xx group, architecturally, AFAICT.)

At least I can apply a patch (missing from current kernels), to
fix the immediate MPC8248 problem in ARCH=ppc.

For my case then, ARCH=ppc seems to offer more promise.

Erik
(At this early stage, trying to figure which way is up. :-)
