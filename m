Return-Path: <tglx@linutronix.de>
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 51AE2B7D05
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Feb 2010 02:31:56 +1100 (EST)
Date: Thu, 18 Feb 2010 16:31:48 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [patch 00/15] powerpc: raw_spinlock conversions
In-Reply-To: <alpine.LRH.2.00.1002181341150.25717@mink.sonytel.be>
Message-ID: <alpine.LFD.2.00.1002181625490.2811@localhost.localdomain>
References: <20100218121904.620984825@linutronix.de>
	<alpine.LRH.2.00.1002181341150.25717@mink.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 18 Feb 2010, Geert Uytterhoeven wrote:

> On Thu, 18 Feb 2010, Thomas Gleixner wrote:
> > the following patch series is from preempt-rt. It converts the locks
> > which need to be real spinlocks in -rt to raw_spinlocks.
> 
> None of the patch descriptions mention why the locks need to be real
> spinlocks in -rt. So can you please elaborate?

Sorry, forgot that there are people who do not share that particular
flavour of crazy.

The locks are protecting low level hardware access (mostly interrupt
hardware, tlb control, et.c) and need to be taken in hard interrupt
context, exception handlers or irq disabled regions. Therefor they can
not be converted to "sleeping spinlocks" like we do for the the bulk
of the spinlocks in the kernel. We annotate those locks by converting
them to raw_spinlocks. In mainline there is no difference between
spinlock and raw_spinlock; spinlock is simply using the raw_spinlock
implementation. In RT we keep raw_spinlocks as real spinlocks and
convert spinlocks to the sleeping variant.

Hope that helps.

     tglx
