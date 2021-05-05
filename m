Return-Path: <SRS0=ixLW=KA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24340C433B4
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 May 2021 02:56:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65DF8610A6
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 May 2021 02:56:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65DF8610A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FZhDR6rBBz30FQ
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 May 2021 12:56:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=lIgKa1HO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=nathanl@linux.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256
 header.s=pp1 header.b=lIgKa1HO; dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FZhCq5NZ4z2yYm
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 May 2021 12:55:35 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 1452WeB3120406; Tue, 4 May 2021 22:55:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=hQLIs70fKAb6SylArL2supuTd1NKNWjUF3DsIc5DUwc=;
 b=lIgKa1HOaXTNrWNqgsjiR/TdG0fNtkKcKUCD77I4tMZdiSkhhaxDjnvhfEvwsTt9jkXH
 B5fyp4Lh1bB7KHrgOps3C42lH9inR1yKEEV2INJEPgeMDZHF54lX0VFZ5I5YVDzRQ1Ex
 bMQ9c825PJx3Bodzu8+f5OkTX/H7dit9G4ur/Fnd54DqAe3nN8u943Mkpiicwo6mM3Tg
 c5VMS63AspDkJtbz0SRH20cCCjEzPzzIdevbdzb9cVtw1WvEmlQFAJ0bhK1hZ9WDF6cj
 iAdWQDuwSnBsHmmasCF+KIlOhdY0IKqAn/PcXNQu6g/uX5PHPmteSJreaJRe8Hzh7UJ0 jA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 38bj550vde-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 May 2021 22:55:28 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1452dJ9m161722;
 Tue, 4 May 2021 22:55:28 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0a-001b2d01.pphosted.com with ESMTP id 38bj550vd7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 May 2021 22:55:28 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 1452qWXv009590;
 Wed, 5 May 2021 02:55:27 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com
 (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
 by ppma03dal.us.ibm.com with ESMTP id 38bee89q19-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 May 2021 02:55:27 +0000
Received: from b03ledav001.gho.boulder.ibm.com
 (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
 by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 1452tQlh27525592
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 5 May 2021 02:55:26 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 710A06E04E;
 Wed,  5 May 2021 02:55:26 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 391796E054;
 Wed,  5 May 2021 02:55:26 +0000 (GMT)
Received: from localhost (unknown [9.211.126.236])
 by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed,  5 May 2021 02:55:26 +0000 (GMT)
From: Nathan Lynch <nathanl@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 1/2] powerpc/64s: Fix crashes when toggling stf barrier
In-Reply-To: <87zgx999pi.fsf@mpe.ellerman.id.au>
References: <20210504134250.890401-1-mpe@ellerman.id.au>
 <878s4uf79w.fsf@linux.ibm.com> <87zgx999pi.fsf@mpe.ellerman.id.au>
Date: Tue, 04 May 2021 21:55:25 -0500
Message-ID: <875yzxga8y.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fm2ZWYwLlJMS3ruswrYFj0n14lcnFrvP
X-Proofpoint-ORIG-GUID: XrtdxIA-Y__V2XAGnxsVuQII1jcvtRzt
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-05-05_01:2021-05-04,
 2021-05-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=999 clxscore=1015 suspectscore=0 mlxscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2105050017
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
Cc: linuxppc-dev@lists.ozlabs.org, anton@samba.org, npiggin@gmail.com,
 dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Michael Ellerman <mpe@ellerman.id.au> writes:
> Nathan Lynch <nathanl@linux.ibm.com> writes:
>> post_mobility_fixup() does cpus_read_unlock() before calling
>> pseries_setup_security_mitigations(), I think that will need to be
>> changed?
>
> I don't think so.
>
> I'm using stop_machine_cpuslocked() but that's because I'm a goose and
> forgot to switch to stop_machine() after I reworked the code to not take
> cpus_read_lock() by hand. I really shouldn't send patches after 11pm.
>
> I don't think it's important to keep the cpus lock held from where we
> take it in post_mobility_fixup(). If some CPUs come or go between there
> and here that's fine.

Yes, agreed.
