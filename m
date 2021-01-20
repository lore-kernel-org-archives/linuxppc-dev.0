Return-Path: <SRS0=bcc2=GX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D67CC433DB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Jan 2021 13:53:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5110A23340
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Jan 2021 13:53:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5110A23340
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DLRnK1ks7zDqhm
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Jan 2021 00:53:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=linux.vnet.ibm.com (client-ip=148.163.158.5;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=naveen.n.rao@linux.vnet.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256
 header.s=pp1 header.b=CPSMcAMA; dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DLRjp2kGlzDqgw
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jan 2021 00:50:18 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 10KDkjFG162570; Wed, 20 Jan 2021 08:50:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=WEhLmLicN/aMr1MDtwGFSlPTAANTGUiQRxKC9SWDsEA=;
 b=CPSMcAMAgVTYHAcvjnQuPJn29R9nRgYotaDTt+og0HjO+5qk/B7a/BczJuD6v6GfzMho
 +Ny+AsbnO1U5ZJEo27ocvWfdP61Jv1zMr4HQ4vddfnSJHzMnNyvBp9ktN7h8+mFdIOtX
 0w6UwgeP+HuNS8d+Ewp3xzrfO3Mctb9/kDvcbpGDoe//mgX7yYpA2aXkoatNG9PCr4RQ
 Z0lm51j/k2lF0gx894MX57W79zicnITaX0mskRyQlxSY9hHhyCl4z9XQlXvU9GSr1/d3
 I2/IGVeWHL7E/REo1EMbdD1Qaj3ijhOLPtIDc8lCnLApPhB4FXtgOUNx5CMrzteBA/u5 tg== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0b-001b2d01.pphosted.com with ESMTP id 366nq0g1w9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 Jan 2021 08:50:11 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10KDlwp4016648;
 Wed, 20 Jan 2021 13:50:09 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by ppma03ams.nl.ibm.com with ESMTP id 3668parny0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 Jan 2021 13:50:09 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 10KDo6vg42467794
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 Jan 2021 13:50:06 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3DB1BAE057;
 Wed, 20 Jan 2021 13:50:06 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C341DAE055;
 Wed, 20 Jan 2021 13:50:05 +0000 (GMT)
Received: from localhost (unknown [9.199.54.231])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 20 Jan 2021 13:50:05 +0000 (GMT)
Date: Wed, 20 Jan 2021 19:20:02 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Ananth N Mavinakayanahalli <ananth@linux.ibm.com>
Subject: Re: [PATCH v3] [PATCH] powerpc/sstep: Check ISA 3.0 instruction
 validity before emulation
Message-ID: <20210120135002.GA40@DESKTOP-TDPLP67.localdomain>
References: <161114113785.214433.12934683302522893921.stgit@thinktux.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161114113785.214433.12934683302522893921.stgit@thinktux.local>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343, 18.0.737
 definitions=2021-01-20_05:2021-01-20,
 2021-01-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=958
 priorityscore=1501 mlxscore=0 spamscore=0 clxscore=1011 malwarescore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 adultscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101200075
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
Cc: naveen.n.rao@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
 ravi.bangoria@linux.ibm.com, dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 2021/01/20 04:43PM, Ananth N Mavinakayanahalli wrote:
> We currently unconditionally try to emulate newer instructions on older
> Power versions that could cause issues. Gate it.
> 
> Signed-off-by: Ananth N Mavinakayanahalli <ananth@linux.ibm.com>
> ---
> 
> [v3] Addressed Naveen's comments on scv and addpcis
> [v2] Fixed description
> 
>  arch/powerpc/lib/sstep.c |   46 ++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 44 insertions(+), 2 deletions(-)

Reviewed-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

- Naveen

