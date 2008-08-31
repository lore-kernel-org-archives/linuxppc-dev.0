Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 43E2CDDE1D
	for <linuxppc-dev@ozlabs.org>; Sun, 31 Aug 2008 18:22:46 +1000 (EST)
Subject: Re: [PATCH v2] POWERPC: Allow 32-bit pgtable code to support
	36-bit physical
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20080830162435.GA30519@ld0162-tx32.am.freescale.net>
References: <1219876690-21163-1-git-send-email-becky.bruce@freescale.com>
	<48B5E6B7.3000903@freescale.com>
	<C16F93B0-766C-43E8-B4B5-40BC0FEE298F@freescale.com>
	<48B6CD32.2040308@freescale.com>
	<4DA58F0E-BBE8-4547-80AF-A890BACC79E7@freescale.com>
	<1219963322.13162.366.camel@pasglop>
	<20080830162435.GA30519@ld0162-tx32.am.freescale.net>
Content-Type: text/plain
Date: Sun, 31 Aug 2008 18:22:13 +1000
Message-Id: <1220170933.13162.387.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2008-08-30 at 11:24 -0500, Scott Wood wrote:
> On Fri, Aug 29, 2008 at 08:42:01AM +1000, Benjamin Herrenschmidt wrote:
> > For the non-SMP case, I think it should be possible to optimize it. The
> > only thing that can happen at interrupt time is hashing of kernel or
> > vmalloc/ioremap pages, which shouldn't compete with set_pte on those
> > pages, so there would be no access races there, but I may be missing
> > something as it's the morning and I about just woke up :-)
> 
> Is that still true with preemptible kernels?

Those shouldn't be an issue as long as we can't preempt while holding a
spinlock and we do hold the pte lock on any modification... Of course,
-rt is a different matter.

Ben.
