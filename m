Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 51787DDF0A
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 00:01:39 +1000 (EST)
Subject: Re: [PATCH] [POWERPC] Improve (in|out)_beXX() asm code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Trent Piepho <tpiepho@freescale.com>
In-Reply-To: <Pine.LNX.4.64.0805201535290.7453@t2.domain.actdsltmp>
References: <1211316025-29069-1-git-send-email-tpiepho@freescale.com>
	<1211318219.8297.177.camel@pasglop> <483344C0.3020703@freescale.com>
	<20080520231516.76b924a2@core> <4833524C.3040207@freescale.com>
	<Pine.LNX.4.64.0805201535290.7453@t2.domain.actdsltmp>
Content-Type: text/plain
Date: Wed, 21 May 2008 10:01:22 -0400
Message-Id: <1211378482.8297.193.camel@pasglop>
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 2008-05-20 at 15:55 -0700, Trent Piepho wrote:
> here doesn't appear to be any barriers to use for coherent dma other than
> mb() and wmb().
> 
> Correct me if I'm wrong, but I think the sync isn't actually _required_ (by
> memory-barriers.txt's definitions), and it would be enough to use eieio,
> except there is code that doesn't use mmiowb() between I/O access and
> unlocking.
> 
> So, as I understand it, the minimum needed is eieio.  To provide strict
> ordering w.r.t. spin locks without using mmiowb(), you need sync.  To provide
> strict ordering w.r.t. normal memory, you need sync and a compiler barrier.
> 
> Right now no archs provide the last option.  powerpc is currently the middle
> option.  I don't know if anything uses the first option, maybe alpha?  I'm
> almost certain x86 is the middle option (the first isn't possible, the arch
> already has more ordering than that), which is probably why powerpc used that
> option and not the first.

I don't have time for that now. Can you dig into the archives ? The
whole thing has been discussed at lenght already.

Ben.
