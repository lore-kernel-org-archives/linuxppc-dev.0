Return-Path: <SRS0=+mMX=Q3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E699C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 06:06:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B3B321773
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 06:06:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B3B321773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4446Y60lRKzDqGc
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 17:06:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=akshay.adiga@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4446WD2z7tzDqBr
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Feb 2019 17:04:24 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1K5s5xg011483
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Feb 2019 01:04:21 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2qrxqd5346-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Feb 2019 01:04:21 -0500
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <akshay.adiga@linux.vnet.ibm.com>;
 Wed, 20 Feb 2019 06:04:19 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 20 Feb 2019 06:04:17 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x1K64GDt26673188
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 20 Feb 2019 06:04:16 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5887911C05B;
 Wed, 20 Feb 2019 06:04:16 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 09AA311C050;
 Wed, 20 Feb 2019 06:04:14 +0000 (GMT)
Received: from aks.ibm (unknown [9.85.70.128])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Wed, 20 Feb 2019 06:04:13 +0000 (GMT)
Date: Wed, 20 Feb 2019 11:34:11 +0530
From: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] powerpc/powernv/idle: Restore IAMR after idle
References: <20190206062837.26917-1-ruscur@russell.cc>
 <1549515373.con208q1rq.astroid@bobo.none>
 <87o97njdjg.fsf@concordia.ellerman.id.au>
 <1550549702.xfczazszdw.astroid@bobo.none>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1550549702.xfczazszdw.astroid@bobo.none>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
x-cbid: 19022006-4275-0000-0000-000003119AF1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022006-4276-0000-0000-0000381FC928
Message-Id: <20190220060353.GA21952@aks.ibm>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-20_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=846 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902200042
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Feb 19, 2019 at 02:21:04PM +1000, Nicholas Piggin wrote:
> Michael Ellerman's on February 8, 2019 11:04 am:
> > Nicholas Piggin <npiggin@gmail.com> writes:
> >> Russell Currey's on February 6, 2019 4:28 pm:
> >>> Without restoring the IAMR after idle, execution prevention on POWER9
> >>> with Radix MMU is overwritten and the kernel can freely execute userspace without
> >>> faulting.
> >>> 
> >>> This is necessary when returning from any stop state that modifies user
> >>> state, as well as hypervisor state.
> >>> 
> >>> To test how this fails without this patch, load the lkdtm driver and
> >>> do the following:
> >>> 
> >>>    echo EXEC_USERSPACE > /sys/kernel/debug/provoke-crash/DIRECT
> >>> 
> >>> which won't fault, then boot the kernel with powersave=off, where it
> >>> will fault.  Applying this patch will fix this.
> >>> 
> >>> Fixes: 3b10d0095a1e ("powerpc/mm/radix: Prevent kernel execution of user
> >>> space")
> >>> Cc: <stable@vger.kernel.org>
> >>> Signed-off-by: Russell Currey <ruscur@russell.cc>
> >>
> >> Good catch and debugging. This really should be a quirk, we don't want 
> >> to have to restore this thing on a thread switch.
> > 
> > I'm not sure I follow. We don't context switch it on Radix, but we do
> > on hash if pkeys are enabled.
> 
> Badly worded, I mean a hardware quirk. It should follow thread
> switches. Still, avoiding it for the no-loss case is better than
> nothing. We can just revisit it as an optimization if future
> hardware does not require the restore.

Apparently, the POWER9 Processor User’s Manual v2.0 documents that
IAMR can be lost, and that is not just the end.

Pasting excerpt from "Section 23.5.9.2 State Loss and Restoration,Page 309"

  On the POWER9 core, the only state that can be lost for
  Stop levels less than four, when PSSCR[ESL] = ‘1’ are the
  following SPRs: CR, FPSCR, VSCR, XER, DSCR, AMR, IAMR, UAMOR,
  AMOR, DAWR, DAWRX.

My observation is that AMOR is being used in kernel as of today
and AMOR is also lost (recreated in similar scenarios where
IAMR is lost).

