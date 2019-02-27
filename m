Return-Path: <SRS0=o5MI=RC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4233C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 02:24:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34FF5218CD
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 02:24:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34FF5218CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 448KJ741q1zDqLh
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 13:24:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=stewart@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 448KGG1fkjzDqKy
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Feb 2019 13:22:44 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1R2HAdn043459
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2019 21:22:39 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2qwf8kp9bk-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2019 21:22:39 -0500
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.ibm.com>;
 Wed, 27 Feb 2019 02:22:38 -0000
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
 by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 27 Feb 2019 02:22:36 -0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x1R2MZaZ24051772
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 27 Feb 2019 02:22:35 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 15F9FAC067;
 Wed, 27 Feb 2019 02:22:35 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1DE7CAC062;
 Wed, 27 Feb 2019 02:22:34 +0000 (GMT)
Received: from birb.localdomain (unknown [9.102.35.114])
 by b01ledav006.gho.pok.ibm.com (Postfix) with SMTP;
 Wed, 27 Feb 2019 02:22:33 +0000 (GMT)
Received: by birb.localdomain (Postfix, from userid 1000)
 id EF45A4EC65C; Wed, 27 Feb 2019 13:22:27 +1100 (AEDT)
From: Stewart Smith <stewart@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/powernv: move OPAL call wrapper tracing and
 interrupt handling to C
In-Reply-To: <20190226093035.7176-1-npiggin@gmail.com>
References: <20190226093035.7176-1-npiggin@gmail.com>
Date: Wed, 27 Feb 2019 13:22:27 +1100
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19022702-0060-0000-0000-00000312D9ED
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010671; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01166899; UDB=6.00609567; IPR=6.00947504; 
 MB=3.00025757; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-27 02:22:37
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022702-0061-0000-0000-000048702276
Message-Id: <87lg22t1gc.fsf@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-27_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=2
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=2
 clxscore=1015 lowpriorityscore=0 mlxscore=2 impostorscore=0
 mlxlogscore=170 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902270014
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
Cc: Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Nicholas Piggin <npiggin@gmail.com> writes:
> The OPAL call wrapper gets interrupt disabling wrong. It disables
> interrupts just by clearing MSR[EE], which has two problems:
>
> - It doesn't call into the IRQ tracing subsystem, which means tracing
>   across OPAL calls does not always notice IRQs have been disabled.
>
> - It doesn't go through the IRQ soft-mask code, which causes a minor
>   bug. MSR[EE] can not be restored by saving the MSR then clearing
>   MSR[EE], because a racing interrupt while soft-masked could clear
>   MSR[EE] between the two steps. This can cause MSR[EE] to be
>   incorrectly enabled when the OPAL call returns. Fortunately that
>   should only result in another masked interrupt being taken to
>   disable MSR[EE] again, but it's a bit sloppy.
>
> The existing code also saves MSR to PACA, which is not re-entrant if
> there is a nested OPAL call from different MSR contexts, which can
> happen these days with SRESET interrupts on bare metal.
>
> To fix these issues, move the tracing and IRQ handling code to C, and
> call into asm just for the low level call when everything is ready to
> go. Save the MSR on stack rather than PACA.
>
> Performance cost is kept to a minimum with a few optimisations:
>
> - The endian switch upon return is combined with the MSR restore,
>   which avoids an expensive context synchronizing operation for LE
>   kernels. This makes up for the additional mtmsrd to enable
>   interrupts with local_irq_enable().
>
> - blr is now used to return from the opal_* functions that are called
>   as C functions, to avoid link stack corruption. This requires a
>   skiboot fix as well to keep the call stack balanced.
>
> A NULL call is more costly after this, (410ns->430ns on POWER9), but
> OPAL calls are generally not performance critical at this scale.

At least with this patch we can start to better measure things, and
that's a big plus. Also, When I get to start worrying about <1ms OPAL
calls, I think we can revisit optimising this path :)


-- 
Stewart Smith
OPAL Architect, IBM.

