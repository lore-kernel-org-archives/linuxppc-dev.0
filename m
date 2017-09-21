Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xyXH06X8HzDqT0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Sep 2017 20:02:52 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Cc: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>,
 "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/livepatch: Fix livepatch stack access
In-Reply-To: <1505902791-26383-1-git-send-email-kamalesh@linux.vnet.ibm.com>
References: <1505902791-26383-1-git-send-email-kamalesh@linux.vnet.ibm.com>
Date: Thu, 21 Sep 2017 20:02:52 +1000
Message-ID: <87d16kcqsz.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Kamalesh Babulal <kamalesh@linux.vnet.ibm.com> writes:

> While running stress test with livepatch module loaded, kernel
> bug was triggered.
>
> cpu 0x5: Vector: 400 (Instruction Access) at [c0000000eb9d3b60]
>     pc: c0000000eb9d3e30
>     lr: c0000000eb9d3e30
>     sp: c0000000eb9d3de0
>    msr: 800000001280b033
>   current = 0xc0000000dbd38700
>   paca    = 0xc00000000fe01400   softe: 0        irq_happened: 0x01
>     pid   = 8618, comm = make
> Linux version 4.13.0+ (root@ubuntu) (gcc version 6.3.0 20170406 (Ubuntu 6.3.0-12ubuntu2)) #1 SMP Wed Sep 13 03:49:27 EDT 2017
>
> 5:mon> t
> [c0000000eb9d3de0] c0000000eb9d3e30 (unreliable)
> [c0000000eb9d3e30] c000000000008ab4 hardware_interrupt_common+0x114/0x120
>  --- Exception: 501 (Hardware Interrupt) at c000000000053040 livepatch_handler+0x4c/0x74
> [c0000000eb9d4120] 0000000057ac6e9d (unreliable)
> [d0000000089d9f78] 2e0965747962382e
> SP (965747962342e09) is in userspace
>
> When an interrupt is served in between the livepatch_handler execution,
> there are chances of the livepatch_stack/task task getting corrupted.

Ouch. That's pretty broken by me.

> Fix the corruption by using r11 register for livepatch stack manipulation,
> instead of shuffling task stack and livepatch stack into r1 register.
> Using r11 register also avoids disabling/enabling irq's while setting
> up the livepatch stack.

I'm trying to think if there's some reason I didn't use r11. But I can't
remember anything specific. I suspect I just didn't check the ABI
closely enough, and knew I could use r0 and r12 so stuck with them.

cheers
