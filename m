Return-Path: <SRS0=6gsd=N2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B10E5C43441
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 14:19:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38B4F2145D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 14:19:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38B4F2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42wk4m6cS6zF3fr
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Nov 2018 01:19:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=abdhalee@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42wk2b0xpSzF3bs
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Nov 2018 01:17:10 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wAFEEc1h187925
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2018 09:17:07 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ns8puwaq7-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2018 09:17:06 -0500
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <abdhalee@linux.vnet.ibm.com>;
 Thu, 15 Nov 2018 14:17:06 -0000
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
 by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 15 Nov 2018 14:17:05 -0000
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wAFEH4ss25624668
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 15 Nov 2018 14:17:04 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4BD4CC6057;
 Thu, 15 Nov 2018 14:17:04 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 56597C6059;
 Thu, 15 Nov 2018 14:17:00 +0000 (GMT)
Received: from [9.77.208.181] (unknown [9.77.208.181])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
 Thu, 15 Nov 2018 14:17:00 +0000 (GMT)
Subject: Re: [mainline][ppc][bnx2x] watchdog: CPU 80 self-detected hard
 LOCKUP @ opal_interrupt+0x28/0x70 when module load/unload
From: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
To: Oliver <oohall@gmail.com>
Date: Thu, 15 Nov 2018 19:46:58 +0530
In-Reply-To: <1542280243.15177.2.camel@abdul>
References: <1537779408.26347.9.camel@abdul.in.ibm.com>
 <CAOSf1CHX0PnVQSrW+t=4vA2ZyVDpU_5B_OUg_arwsuDbcDTzOw@mail.gmail.com>
 <1537784366.26347.15.camel@abdul.in.ibm.com>
 <1542280243.15177.2.camel@abdul>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18111514-8235-0000-0000-00000E285FB8
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010055; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01117821; UDB=6.00579819; IPR=6.00897928; 
 MB=3.00024178; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-15 14:17:05
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111514-8236-0000-0000-0000435E1D63
Message-Id: <1542291418.15177.3.camel@abdul>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-11-15_09:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811150127
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, sim <sim@linux.vnet.ibm.com>,
 manvanth <manvanth@linux.vnet.ibm.com>, maurosr <maurosr@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 2018-11-15 at 16:40 +0530, Abdul Haleem wrote:
> On Mon, 2018-09-24 at 15:49 +0530, Abdul Haleem wrote:
> > On Mon, 2018-09-24 at 19:35 +1000, Oliver wrote:
> > > On Mon, Sep 24, 2018 at 6:56 PM, Abdul Haleem
> > > <abdhalee@linux.vnet.ibm.com> wrote:
> > > > Greeting's
> > > >
> > > > bnx2x module load/unload test results in continuous hard LOCKUP trace on
> > > > my powerpc bare-metal running mainline 4.19.0-rc4 kernel
> > > >
> > > > the instruction address points to:
> > > >
> > > > 0xc00000000009d048 is in opal_interrupt
> > > > (arch/powerpc/platforms/powernv/opal-irqchip.c:133).
> > > > 128
> > > > 129     static irqreturn_t opal_interrupt(int irq, void *data)
> > > > 130     {
> > > > 131             __be64 events;
> > > > 132
> > > > 133             opal_handle_interrupt(virq_to_hw(irq), &events);
> > > > 134             last_outstanding_events = be64_to_cpu(events);
> > > > 135             if (opal_have_pending_events())
> > > > 136                     opal_wake_poller();
> > > > 137
> > > >
> > > > trace:
> > > > bnx2x 0008:01:00.3 enP8p1s0f3: renamed from eth0
> > > > bnx2x 0008:01:00.3 enP8p1s0f3: using MSI-X  IRQs: sp 297  fp[0] 299 ... fp[7] 306
> > > > bnx2x 0008:01:00.2 enP8p1s0f2: NIC Link is Up, 1000 Mbps full duplex, Flow control: none
> > > > bnx2x 0008:01:00.3 enP8p1s0f3: NIC Link is Up, 1000 Mbps full duplex, Flow control: none
> > > > bnx2x: QLogic 5771x/578xx 10/20-Gigabit Ethernet Driver bnx2x 1.712.30-0 (2014/02/10)
> > > > bnx2x 0008:01:00.0: msix capability found
> > > > bnx2x 0008:01:00.0: Using 64-bit DMA iommu bypass
> > > > bnx2x 0008:01:00.0: part number 0-0-0-0
> > > > bnx2x 0008:01:00.0: 32.000 Gb/s available PCIe bandwidth (5 GT/s x8 link)
> > > > bnx2x 0008:01:00.0 enP8p1s0f0: renamed from eth0
> > > > bnx2x 0008:01:00.1: msix capability found
> > > > bnx2x 0008:01:00.1: Using 64-bit DMA iommu bypass
> > > > bnx2x 0008:01:00.1: part number 0-0-0-0
> > > > bnx2x 0008:01:00.0 enP8p1s0f0: using MSI-X  IRQs: sp 267  fp[0] 269 ... fp[7] 276
> > > > bnx2x 0008:01:00.0 enP8p1s0f0: NIC Link is Up, 10000 Mbps full duplex, Flow control: ON - receive & transmit
> > > > bnx2x 0008:01:00.1: 32.000 Gb/s available PCIe bandwidth (5 GT/s x8 link)
> > > > bnx2x 0008:01:00.1 enP8p1s0f1: renamed from eth0
> > > > bnx2x 0008:01:00.2: msix capability found
> > > > bnx2x 0008:01:00.2: Using 64-bit DMA iommu bypass
> > > > bnx2x 0008:01:00.2: part number 0-0-0-0
> > > > bnx2x 0008:01:00.1 enP8p1s0f1: using MSI-X  IRQs: sp 277  fp[0] 279 ... fp[7] 286
> > > > bnx2x 0008:01:00.1 enP8p1s0f1: NIC Link is Up, 10000 Mbps full duplex, Flow control: ON - receive & transmit
> > > 
> > > 
> > > > watchdog: CPU 80 self-detected hard LOCKUP @ opal_interrupt+0x28/0x70
> > > > watchdog: CPU 80 TB:980794111093, last heartbeat TB:973959617200 (13348ms ago)
> > > 
> > > Ouch, 13 seconds in OPAL. Looks like we trip the hard lockup detector
> > > once the thread comes back into the kernel so we're not completely
> > > stuck. At a guess there's some contention on a lock in OPAL due to the
> > > bind/unbind loop, but i'm not sure why that would be happening.
> > > 
> > > Can you give us a copy of the OPAL log? /sys/firmware/opal/msglog)
> > 
> > Oliver, thanks for looking into this, I have sent a private mail (file
> > was 1MB) with logs attached.
> > 
> 
> Oliver, any luck on the logs given.
> 
> Warnings also show up on 4.20.0-rc2-next-20181114

We have a patch fix available https://patchwork.ozlabs.org/patch/998054/

It fixed the problem.

-- 
Regard's

Abdul Haleem
IBM Linux Technology Centre



