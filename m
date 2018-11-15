Return-Path: <SRS0=6gsd=N2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9388DC43441
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 11:12:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10AFE21780
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 11:12:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10AFE21780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42wdxs0FtmzF3bJ
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 22:12:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=abdhalee@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42wdvg6CpVzF3dD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2018 22:10:55 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wAFB9Z7L092983
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2018 06:10:52 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ns59xxnuf-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2018 06:10:52 -0500
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <abdhalee@linux.vnet.ibm.com>;
 Thu, 15 Nov 2018 11:10:51 -0000
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
 by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 15 Nov 2018 11:10:48 -0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
 [9.57.199.107])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wAFBAlGP38141998
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 15 Nov 2018 11:10:48 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D627012405E;
 Thu, 15 Nov 2018 11:10:47 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A1B77124054;
 Thu, 15 Nov 2018 11:10:45 +0000 (GMT)
Received: from [9.77.208.181] (unknown [9.77.208.181])
 by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu, 15 Nov 2018 11:10:45 +0000 (GMT)
Subject: Re: [mainline][ppc][bnx2x] watchdog: CPU 80 self-detected hard
 LOCKUP @ opal_interrupt+0x28/0x70 when module load/unload
From: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
To: Oliver <oohall@gmail.com>
Date: Thu, 15 Nov 2018 16:40:43 +0530
In-Reply-To: <1537784366.26347.15.camel@abdul.in.ibm.com>
References: <1537779408.26347.9.camel@abdul.in.ibm.com>
 <CAOSf1CHX0PnVQSrW+t=4vA2ZyVDpU_5B_OUg_arwsuDbcDTzOw@mail.gmail.com>
 <1537784366.26347.15.camel@abdul.in.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18111511-2213-0000-0000-000003180B10
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010054; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01117759; UDB=6.00579781; IPR=6.00897866; 
 MB=3.00024175; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-15 11:10:49
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111511-2214-0000-0000-00005C42D783
Message-Id: <1542280243.15177.2.camel@abdul>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-11-15_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811150102
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
Cc: manvanth <manvanth@linux.vnet.ibm.com>, sim <sim@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 maurosr <maurosr@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 2018-09-24 at 15:49 +0530, Abdul Haleem wrote:
> On Mon, 2018-09-24 at 19:35 +1000, Oliver wrote:
> > On Mon, Sep 24, 2018 at 6:56 PM, Abdul Haleem
> > <abdhalee@linux.vnet.ibm.com> wrote:
> > > Greeting's
> > >
> > > bnx2x module load/unload test results in continuous hard LOCKUP trace on
> > > my powerpc bare-metal running mainline 4.19.0-rc4 kernel
> > >
> > > the instruction address points to:
> > >
> > > 0xc00000000009d048 is in opal_interrupt
> > > (arch/powerpc/platforms/powernv/opal-irqchip.c:133).
> > > 128
> > > 129     static irqreturn_t opal_interrupt(int irq, void *data)
> > > 130     {
> > > 131             __be64 events;
> > > 132
> > > 133             opal_handle_interrupt(virq_to_hw(irq), &events);
> > > 134             last_outstanding_events = be64_to_cpu(events);
> > > 135             if (opal_have_pending_events())
> > > 136                     opal_wake_poller();
> > > 137
> > >
> > > trace:
> > > bnx2x 0008:01:00.3 enP8p1s0f3: renamed from eth0
> > > bnx2x 0008:01:00.3 enP8p1s0f3: using MSI-X  IRQs: sp 297  fp[0] 299 ... fp[7] 306
> > > bnx2x 0008:01:00.2 enP8p1s0f2: NIC Link is Up, 1000 Mbps full duplex, Flow control: none
> > > bnx2x 0008:01:00.3 enP8p1s0f3: NIC Link is Up, 1000 Mbps full duplex, Flow control: none
> > > bnx2x: QLogic 5771x/578xx 10/20-Gigabit Ethernet Driver bnx2x 1.712.30-0 (2014/02/10)
> > > bnx2x 0008:01:00.0: msix capability found
> > > bnx2x 0008:01:00.0: Using 64-bit DMA iommu bypass
> > > bnx2x 0008:01:00.0: part number 0-0-0-0
> > > bnx2x 0008:01:00.0: 32.000 Gb/s available PCIe bandwidth (5 GT/s x8 link)
> > > bnx2x 0008:01:00.0 enP8p1s0f0: renamed from eth0
> > > bnx2x 0008:01:00.1: msix capability found
> > > bnx2x 0008:01:00.1: Using 64-bit DMA iommu bypass
> > > bnx2x 0008:01:00.1: part number 0-0-0-0
> > > bnx2x 0008:01:00.0 enP8p1s0f0: using MSI-X  IRQs: sp 267  fp[0] 269 ... fp[7] 276
> > > bnx2x 0008:01:00.0 enP8p1s0f0: NIC Link is Up, 10000 Mbps full duplex, Flow control: ON - receive & transmit
> > > bnx2x 0008:01:00.1: 32.000 Gb/s available PCIe bandwidth (5 GT/s x8 link)
> > > bnx2x 0008:01:00.1 enP8p1s0f1: renamed from eth0
> > > bnx2x 0008:01:00.2: msix capability found
> > > bnx2x 0008:01:00.2: Using 64-bit DMA iommu bypass
> > > bnx2x 0008:01:00.2: part number 0-0-0-0
> > > bnx2x 0008:01:00.1 enP8p1s0f1: using MSI-X  IRQs: sp 277  fp[0] 279 ... fp[7] 286
> > > bnx2x 0008:01:00.1 enP8p1s0f1: NIC Link is Up, 10000 Mbps full duplex, Flow control: ON - receive & transmit
> > 
> > 
> > > watchdog: CPU 80 self-detected hard LOCKUP @ opal_interrupt+0x28/0x70
> > > watchdog: CPU 80 TB:980794111093, last heartbeat TB:973959617200 (13348ms ago)
> > 
> > Ouch, 13 seconds in OPAL. Looks like we trip the hard lockup detector
> > once the thread comes back into the kernel so we're not completely
> > stuck. At a guess there's some contention on a lock in OPAL due to the
> > bind/unbind loop, but i'm not sure why that would be happening.
> > 
> > Can you give us a copy of the OPAL log? /sys/firmware/opal/msglog)
> 
> Oliver, thanks for looking into this, I have sent a private mail (file
> was 1MB) with logs attached.
> 

Oliver, any luck on the logs given.

Warnings also show up on 4.20.0-rc2-next-20181114

-- 
Regard's

Abdul Haleem
IBM Linux Technology Centre



