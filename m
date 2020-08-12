Return-Path: <SRS0=klx1=BW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76DBCC433E0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Aug 2020 13:48:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FA77206B2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Aug 2020 13:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XkMajsPf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FA77206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BRWJ15ZwszDqkP
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Aug 2020 23:48:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5;
 helo=mx0b-001b2d01.pphosted.com; envelope-from=nathanl@linux.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256
 header.s=pp1 header.b=XkMajsPf; dkim-atps=neutral
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BRWFS3STFzDqkD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2020 23:46:20 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 07CDXuTK003085; Wed, 12 Aug 2020 09:46:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=fISzb0ucN1t8qRQQjANCni2U1tYtcZYHeYXUH6vNezI=;
 b=XkMajsPfMzcL0viypLJYqFm3XWyC9J4LFzuMsYWFlY6kyHaeJHwr/LN7THyKgwCTZ79Q
 /R65ZxUij8lPlhlKTMy+lDgKZdeRAhqVV8N4hd0aLGolFV/2JxpgKXKFgPRWOppS5nbE
 FoOWxHP1U3MTZLVN2+h+G8fQZBexVZAQd/l2F/O4yONggiCXKlJmc+bA54nsW+vaSSCn
 TOxJ0ehVkT6sdFB6fmvIh/7oX3hmea73wmywkDxpRW9ELUqa9AeoWrl/bjiztZ6wyHmq
 SO6zWaMWmXn4c3TohzVdNIbRo9aM6PZlcxTFWWlpgV6Lt2gKuq5Vf4vaPjhHQEdzdh7q nA== 
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com
 [169.55.91.170])
 by mx0a-001b2d01.pphosted.com with ESMTP id 32v6r7s8d9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Aug 2020 09:46:13 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
 by ppma02wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07CDjw4x026754;
 Wed, 12 Aug 2020 13:46:12 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by ppma02wdc.us.ibm.com with ESMTP id 32skp99vyd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Aug 2020 13:46:12 +0000
Received: from b03ledav001.gho.boulder.ibm.com
 (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 07CDk8Qr27001110
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Aug 2020 13:46:08 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E5D8F6E052;
 Wed, 12 Aug 2020 13:46:10 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A82236E050;
 Wed, 12 Aug 2020 13:46:10 +0000 (GMT)
Received: from localhost (unknown [9.65.223.18])
 by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed, 12 Aug 2020 13:46:10 +0000 (GMT)
From: Nathan Lynch <nathanl@linux.ibm.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] powerpc/pseries: explicitly reschedule during
 drmem_lmb list traversal
In-Reply-To: <c39976ce-a95c-a9cb-d119-d272b8de2f28@csgroup.eu>
References: <20200812012005.1919255-1-nathanl@linux.ibm.com>
 <c39976ce-a95c-a9cb-d119-d272b8de2f28@csgroup.eu>
Date: Wed, 12 Aug 2020 08:46:10 -0500
Message-ID: <878sekyo2l.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-08-12_05:2020-08-11,
 2020-08-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=1 adultscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 bulkscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008120092
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
Cc: tyreld@linux.ibm.com, cheloha@linux.ibm.com, ldufour@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Christophe,

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
>> +static inline struct drmem_lmb *drmem_lmb_next(struct drmem_lmb *lmb)
>> +{
>> +	const unsigned int resched_interval = 20;
>> +
>> +	BUG_ON(lmb < drmem_info->lmbs);
>> +	BUG_ON(lmb >= drmem_info->lmbs + drmem_info->n_lmbs);
>
> BUG_ON() shall be avoided unless absolutely necessary.
> Wouldn't WARN_ON() together with an early return be enough ?

Not sure what a sensible early return behavior would be. If the iterator
doesn't advance the pointer the behavior will be a hang.

BUG_ON a bounds-check failure is appropriate here; many users of this
API will corrupt memory otherwise.

>> +
>> +	if ((lmb - drmem_info->lmbs) % resched_interval == 0)
>> +		cond_resched();
>
> Do you need something that precise ? Can't you use 16 or 32 and use a 
> logical AND instead of a MODULO ?

Eh if you're executing in this code you've already lost with respect to
performance considerations at this level, see the discussion on v1. I'll
use 16 since I'm going to reroll the patch though.

> And what garanties that lmb is always an element of a table based at 
> drmem_info->lmbs ?

Well, that's its only intended use right now. There should not be any
other arrays of drmem_lmb objects, and I hope we don't gain any.


> What about:
>
> static inline struct drmem_lmb *drmem_lmb_next(struct drmem_lmb *lmb, 
> struct drmem_lmb *start)
> {
> 	const unsigned int resched_interval = 16;
>
> 	if ((++lmb - start) & resched_interval == 0)
                           ^^^
Did you mean '%' here? The bitwise AND doesn't do what I want.

Otherwise, making drmem_lmb_next() more general by adding a 'start'
argument could ease refactoring to come, so I'll do that.
