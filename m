Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xxxrS0cKzzDqBd
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Sep 2017 21:11:19 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8KBB22A077589
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Sep 2017 07:11:17 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2d3mf8t9tg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Sep 2017 07:11:17 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 20 Sep 2017 21:11:14 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v8KBBCFS40829086
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Sep 2017 21:11:12 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v8KBB41f031974
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Sep 2017 21:11:04 +1000
Date: Wed, 20 Sep 2017 16:41:08 +0530
From: "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Balbir Singh <bsingharora@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/livepatch: Fix livepatch stack access
References: <1505902791-26383-1-git-send-email-kamalesh@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1505902791-26383-1-git-send-email-kamalesh@linux.vnet.ibm.com>
Message-Id: <20170920111108.wptb7ifdbqk4ndvm@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/09/20 03:49PM, Kamalesh Babulal wrote:
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
> 
>                     CPU 1
>                  =============
> Task A                          Interrupt Handler
> =========                       =================
> livepatch_handler:
>  mr r0, r1
>  ld r1, TI_livepatch_sp(r12)
>                                 hardware_interrupt_common
>                                 |_do_IRQ
>                                   |_ call_do_irq:
>                                         mflr r0
>                                         std  r0,16(r1)
>                                         stdu r1,THREAD_SIZE-STACK_FRAME_OVERHEAD(r4)
>                                             ...
> lis r2, STACK_END_MAGIC@h
> ori r2, r2, STACK_END_MAGIC@l
> ld  r12, -8(r1)      <- livepatch stack is corrupted.
> 
> Fix the corruption by using r11 register for livepatch stack manipulation,
> instead of shuffling task stack and livepatch stack into r1 register.
> Using r11 register also avoids disabling/enabling irq's while setting
> up the livepatch stack.
> 
> Signed-off-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
> Cc: Balbir Singh <bsingharora@gmail.com>
> Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> ---
>  arch/powerpc/kernel/trace/ftrace_64_mprofile.S | 45 +++++++++-----------------
>  1 file changed, 15 insertions(+), 30 deletions(-)

Reviewed-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>


- Naveen
