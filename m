Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y3VF63jstzDr8P
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Sep 2017 21:48:25 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id e69so1192252pfg.4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Sep 2017 04:48:25 -0700 (PDT)
Message-ID: <1506685639.7352.0.camel@gmail.com>
Subject: Re: [PATCH] powerpc/livepatch: Fix livepatch stack access
From: Balbir Singh <bsingharora@gmail.com>
To: "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>, Kamalesh Babulal
 <kamalesh@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Date: Fri, 29 Sep 2017 21:47:19 +1000
In-Reply-To: <20170920111108.wptb7ifdbqk4ndvm@naverao1-tp.localdomain>
References: <1505902791-26383-1-git-send-email-kamalesh@linux.vnet.ibm.com>
 <20170920111108.wptb7ifdbqk4ndvm@naverao1-tp.localdomain>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-09-20 at 16:41 +0530, Naveen N . Rao wrote:
> On 2017/09/20 03:49PM, Kamalesh Babulal wrote:
> > While running stress test with livepatch module loaded, kernel
> > bug was triggered.
> > 
> > cpu 0x5: Vector: 400 (Instruction Access) at [c0000000eb9d3b60]
> >     pc: c0000000eb9d3e30
> >     lr: c0000000eb9d3e30
> >     sp: c0000000eb9d3de0
> >    msr: 800000001280b033
> >   current = 0xc0000000dbd38700
> >   paca    = 0xc00000000fe01400   softe: 0        irq_happened: 0x01
> >     pid   = 8618, comm = make
> > Linux version 4.13.0+ (root@ubuntu) (gcc version 6.3.0 20170406 (Ubuntu 6.3.0-12ubuntu2)) #1 SMP Wed Sep 13 03:49:27 EDT 2017
> > 
> > 5:mon> t
> > [c0000000eb9d3de0] c0000000eb9d3e30 (unreliable)
> > [c0000000eb9d3e30] c000000000008ab4 hardware_interrupt_common+0x114/0x120
> >  --- Exception: 501 (Hardware Interrupt) at c000000000053040 livepatch_handler+0x4c/0x74
> > [c0000000eb9d4120] 0000000057ac6e9d (unreliable)
> > [d0000000089d9f78] 2e0965747962382e
> > SP (965747962342e09) is in userspace
> > 
> > When an interrupt is served in between the livepatch_handler execution,
> > there are chances of the livepatch_stack/task task getting corrupted.
> > 
> >                     CPU 1
> >                  =============
> > Task A                          Interrupt Handler
> > =========                       =================
> > livepatch_handler:
> >  mr r0, r1
> >  ld r1, TI_livepatch_sp(r12)
> >                                 hardware_interrupt_common
> >                                 |_do_IRQ
> >                                   |_ call_do_irq:
> >                                         mflr r0
> >                                         std  r0,16(r1)
> >                                         stdu r1,THREAD_SIZE-STACK_FRAME_OVERHEAD(r4)
> >                                             ...
> > lis r2, STACK_END_MAGIC@h
> > ori r2, r2, STACK_END_MAGIC@l
> > ld  r12, -8(r1)      <- livepatch stack is corrupted.
> > 
> > Fix the corruption by using r11 register for livepatch stack manipulation,
> > instead of shuffling task stack and livepatch stack into r1 register.
> > Using r11 register also avoids disabling/enabling irq's while setting
> > up the livepatch stack.
> > 
> > Signed-off-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
> > Cc: Balbir Singh <bsingharora@gmail.com>
> > Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> > Cc: linuxppc-dev@lists.ozlabs.org
> > ---
> >  arch/powerpc/kernel/trace/ftrace_64_mprofile.S | 45 +++++++++-----------------
> >  1 file changed, 15 insertions(+), 30 deletions(-)
> 
> Reviewed-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Reviewed-by: Balbir Singh <bsingharora@gmail.com>
