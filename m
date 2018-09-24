Return-Path: <abdhalee@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42JgDR1RWXzF1Rl
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Sep 2018 20:19:34 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8OAFCkY085232
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Sep 2018 06:19:32 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2mpuchxmr4-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Sep 2018 06:19:31 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <abdhalee@linux.vnet.ibm.com>;
 Mon, 24 Sep 2018 04:19:31 -0600
Subject: Re: [mainline][ppc][bnx2x] watchdog: CPU 80 self-detected hard
 LOCKUP @ opal_interrupt+0x28/0x70 when module load/unload
From: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
To: Oliver <oohall@gmail.com>
Cc: manvanth <manvanth@linux.vnet.ibm.com>, sim <sim@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, maurosr
 <maurosr@linux.vnet.ibm.com>
Date: Mon, 24 Sep 2018 15:49:26 +0530
In-Reply-To: <CAOSf1CHX0PnVQSrW+t=4vA2ZyVDpU_5B_OUg_arwsuDbcDTzOw@mail.gmail.com>
References: <1537779408.26347.9.camel@abdul.in.ibm.com>
 <CAOSf1CHX0PnVQSrW+t=4vA2ZyVDpU_5B_OUg_arwsuDbcDTzOw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1537784366.26347.15.camel@abdul.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-09-24 at 19:35 +1000, Oliver wrote:
> On Mon, Sep 24, 2018 at 6:56 PM, Abdul Haleem
> <abdhalee@linux.vnet.ibm.com> wrote:
> > Greeting's
> >
> > bnx2x module load/unload test results in continuous hard LOCKUP trace on
> > my powerpc bare-metal running mainline 4.19.0-rc4 kernel
> >
> > the instruction address points to:
> >
> > 0xc00000000009d048 is in opal_interrupt
> > (arch/powerpc/platforms/powernv/opal-irqchip.c:133).
> > 128
> > 129     static irqreturn_t opal_interrupt(int irq, void *data)
> > 130     {
> > 131             __be64 events;
> > 132
> > 133             opal_handle_interrupt(virq_to_hw(irq), &events);
> > 134             last_outstanding_events = be64_to_cpu(events);
> > 135             if (opal_have_pending_events())
> > 136                     opal_wake_poller();
> > 137
> >
> > trace:
> > bnx2x 0008:01:00.3 enP8p1s0f3: renamed from eth0
> > bnx2x 0008:01:00.3 enP8p1s0f3: using MSI-X  IRQs: sp 297  fp[0] 299 ... fp[7] 306
> > bnx2x 0008:01:00.2 enP8p1s0f2: NIC Link is Up, 1000 Mbps full duplex, Flow control: none
> > bnx2x 0008:01:00.3 enP8p1s0f3: NIC Link is Up, 1000 Mbps full duplex, Flow control: none
> > bnx2x: QLogic 5771x/578xx 10/20-Gigabit Ethernet Driver bnx2x 1.712.30-0 (2014/02/10)
> > bnx2x 0008:01:00.0: msix capability found
> > bnx2x 0008:01:00.0: Using 64-bit DMA iommu bypass
> > bnx2x 0008:01:00.0: part number 0-0-0-0
> > bnx2x 0008:01:00.0: 32.000 Gb/s available PCIe bandwidth (5 GT/s x8 link)
> > bnx2x 0008:01:00.0 enP8p1s0f0: renamed from eth0
> > bnx2x 0008:01:00.1: msix capability found
> > bnx2x 0008:01:00.1: Using 64-bit DMA iommu bypass
> > bnx2x 0008:01:00.1: part number 0-0-0-0
> > bnx2x 0008:01:00.0 enP8p1s0f0: using MSI-X  IRQs: sp 267  fp[0] 269 ... fp[7] 276
> > bnx2x 0008:01:00.0 enP8p1s0f0: NIC Link is Up, 10000 Mbps full duplex, Flow control: ON - receive & transmit
> > bnx2x 0008:01:00.1: 32.000 Gb/s available PCIe bandwidth (5 GT/s x8 link)
> > bnx2x 0008:01:00.1 enP8p1s0f1: renamed from eth0
> > bnx2x 0008:01:00.2: msix capability found
> > bnx2x 0008:01:00.2: Using 64-bit DMA iommu bypass
> > bnx2x 0008:01:00.2: part number 0-0-0-0
> > bnx2x 0008:01:00.1 enP8p1s0f1: using MSI-X  IRQs: sp 277  fp[0] 279 ... fp[7] 286
> > bnx2x 0008:01:00.1 enP8p1s0f1: NIC Link is Up, 10000 Mbps full duplex, Flow control: ON - receive & transmit
> 
> 
> > watchdog: CPU 80 self-detected hard LOCKUP @ opal_interrupt+0x28/0x70
> > watchdog: CPU 80 TB:980794111093, last heartbeat TB:973959617200 (13348ms ago)
> 
> Ouch, 13 seconds in OPAL. Looks like we trip the hard lockup detector
> once the thread comes back into the kernel so we're not completely
> stuck. At a guess there's some contention on a lock in OPAL due to the
> bind/unbind loop, but i'm not sure why that would be happening.
> 
> Can you give us a copy of the OPAL log? /sys/firmware/opal/msglog)

Oliver, thanks for looking into this, I have sent a private mail (file
was 1MB) with logs attached.

-- 
Regard's

Abdul Haleem
IBM Linux Technology Centre
