Return-Path: <shawnxjin@gmail.com>
Received: from rproxy.gmail.com (rproxy.gmail.com [64.233.170.197])
	by ozlabs.org (Postfix) with ESMTP id A80E167A86
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Jan 2005 05:05:37 +1100 (EST)
Received: by rproxy.gmail.com with SMTP id 1so278591rny
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Jan 2005 10:05:33 -0800 (PST)
Message-ID: <c3d0340b0501271005409166e6@mail.gmail.com>
Date: Thu, 27 Jan 2005 10:05:33 -0800
From: Shawn Jin <shawnxjin@gmail.com>
To: linuxppc <linuxppc-dev@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Relocating interrupt vectors in ppc440?
Reply-To: Shawn Jin <shawnxjin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

Do interrupt vectors locate at low addresses physically in ppc440?
>From the processor's user manual I understand that the base address of
interrupt vectors actually can be anywhere, set by IVPR. Also from
head_44x.S I found the following comments

/*
 * The Book E MMUs are always on so we don't need to handle
 * interrupts in real mode as with previous PPC processors. In
 * this case we handle interrupts in the kernel virtual address
 * space.
 *
 * Interrupt vectors are dynamically placed relative to the
 * interrupt prefix as determined by the address of interrupt_base.
 * The interrupt vectors offsets are programmed using the labels
 * for each interrupt vector entry.
 *
 */

The address of interrupt_base is 0xc0000224 in the image I built,
which is a virtual address from kernel point of view. What's the
corresponding physical address? Is it my SDRAM's physical base address
+ 0x224 (the offset)?

Assumed that the interrupt vectors locate at the low address space
physically and given that there is 2GB SDRAM shared by two ppc440
cores, can one of linux kernels run at the top of 1GB space? This
means the interrupt vectors for this copy need to move to upper 1GB.
Each core runs a copy of linux kernel independently.

Any ideas about relocating interupt vectors in ppc440?

Thanks a lot.
-Shawn.
