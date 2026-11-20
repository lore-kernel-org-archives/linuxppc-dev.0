Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236FE606A33A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Nov 2026 07:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=e1tqSNmw
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jW6h96FlZz2yQl;
	Fri, 20 Nov 2026 18:40:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795160441;
	cv=none; b=iORTNU91YowSS7ludRCf1UYE8ObJrzrG6DM6kGsBH9rG9v14eq8WAUOebioNHPbHXZciDuuTErriwyr35qNns6hvIECq6sTRtvRwV3zAveZ1SsMgLNBD/qYX9RzLoehHkruJtbgaOoQu7WHMpNwZxbvSFZt7nj5Kj0VJ/j/c8zMICaboEkLt7FaQHwwjXPP7FO7+9wQm+Kgt48cef8VS5JPuxkGiM2PGn0/Anyls2dCTHDkrwHIVgLhoHnaBBpcZ29CxYO6580Bpzp3Mhwq5UNf5jQx6UeNIeYL31Nfm4udDiAnbg5El5TCmverrukhoc3WNZXDmn3b2/jFf0j1Fmg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795160441; c=relaxed/relaxed;
	bh=vXp0hy8i8EssNCH31fRKL6Cul/GRpRbRIXs/wnt65A4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C15Q+I6rsKq2ZLfxtAEO1KaEK7CZxCsHZQUO9yqZEOVt1YAMSFFBPQfZ6rWmsWcltEnPXmrVI54zJbm5jBo9s8tjnZO60L/MNxLULk1xwm1f8yPWQhzcgSMoRkvQOG7rLXetmJy3Pgz87aB0gmUV8MdvQ0uPP6+E3kkCnR1L9QJaoiaxvZ9HbKnTgyMMLKEIwkiWv3an3jouiM947bvEcZjnaWYnaMUAq7MT2eWO7pL8FagtubSYwAny2EJp9KiMz7lpKDKkmjPn6tWyqYlaw7jAuQT5B/80Oz6tQLJBeJrB0u4j0czfVy03EovtofI+qrrMYhaDv/U+H2cyW5T1lg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=e1tqSNmw; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=e1tqSNmw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jW6h914fbz2yDm
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2026 18:40:40 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AK3ueHL2135766;
	Fri, 20 Nov 2026 07:40:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vXp0hy
	8i8EssNCH31fRKL6Cul/GRpRbRIXs/wnt65A4=; b=e1tqSNmwaAyrwlg7gcza7q
	Hf/bjdZ/M1Zh86wnv9omHpFDmOASN/zFaiQrsvouF15IyHwBEdGvo8OLA5XjDU7s
	I32v83laDSFO7b8QxIQpJNvFR13k997IdChv6Hk6J/Y8pMRZ5liVys8YgW2xRjW4
	7OUD6G3kW6nMu6TbYzUbFfJLi7Vmu1w4qLvMS+8Xf/+0lKNGB5NVY3l8o4OEbGKs
	QyvXYiq885NR7zELusiGEMJKvFcvlF2Pw3ojgjLixbP0fqYznOkN26ayoRfy0UKG
	sR/P6LOyNuunsLKoUhuNLixO8zniSlcJFCL2vqAIa6rN0KHEUn5ApEKdeVA5ujZA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105npwc8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 20 Nov 2026 07:40:31 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AK7CEZd600861;
	Fri, 20 Nov 2026 07:40:31 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j1bb5jugr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Nov 2026 07:40:28 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AK7eOuv15728976
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Nov 2026 07:40:24 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ACB882004F;
	Fri, 20 Nov 2026 07:40:24 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1DF1420040;
	Fri, 20 Nov 2026 07:40:21 +0000 (GMT)
Received: from [9.124.218.70] (unknown [9.124.218.70])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 20 Nov 2026 07:40:20 +0000 (GMT)
Message-ID: <32518152-863e-4ce0-831b-d4d69caa491b@linux.ibm.com>
Date: Fri, 20 Nov 2026 13:10:20 +0530
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/5] powerpc: Add RTAS based error injection support
 for pSeries
To: tasmiya <tasmiya@linux.ibm.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Timothy Pearson <tpearson@raptorengineering.com>,
        Alex Williamson <alex@shazbot.org>
Cc: sourabhjain@linux.ibm.com, Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <chleroy@kernel.org>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, sbhat@linux.ibm.com,
        harshpb@linux.ibm.com
References: <20261023073642.59657-1-nnmlinux@linux.ibm.com>
 <b6a7ba26-e3f1-4dfe-a429-8dd3379e665a@linux.ibm.com>
Content-Language: en-US
From: Narayana Murty N <nnmlinux@linux.ibm.com>
In-Reply-To: <b6a7ba26-e3f1-4dfe-a429-8dd3379e665a@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDAyOSBTYWx0ZWRfXy7B1r++FB5Fw
 ZojBzibZI6xckz2pppZAq1PSuh63OHyb9HReryXRpPZEKVauZF5lW08Bq54wK+8m1oEkb6mBiop
 ahj5tBGcD8vlwsISV/OLaSCYCLwL6E9u53zk4lk4ZmC0Eu1+mKnIAtM9tmHQVINgEf3VjjOuylv
 R+qAlsNHteO1J1tfGNHaHC1bk5W9Ez3Ti5tK2Jyhk9tE3SS4htSJYzVt3itGLvVVGcj9CwGF9Iu
 ZkkeJu9brPGg+qmzfus4yiiBoTc7+SPxkQxH8tX08wBXSks5LcbyZyKnlUzocQ5b4WPjLo0umiS
 MGBqXOwC4CjMcH5N1YRj680R0Ot91b74WKuhl9qe3eTx+7FI5zf82e3FULJyIa2s+JUl6nOK2XO
 P7YmmfT3iSQ0+WkyekELhdDdDI7sRBO8Yn2+RK9FXNe55ogNZBupaGmtQeDiFwNE9yWAc+Q5TO2
 bW6dM+9A9WBqdlK4cig==
X-Authority-Analysis: v=2.4 cv=HN9WhYtv c=1 sm=1 tr=0 ts=6afff970 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=16zvxxa8fA1V9JArBYkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: H97DVM_Yt6Ct0DG7o4Vqy7xcnja9aFNR
X-Proofpoint-ORIG-GUID: Gn4MdoIDlrOUk-tbAyCDtKSYwoCw11-9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDAyOSBTYWx0ZWRfX8T2SDEwp9hDw
 5+//8Os6yPD7YKmIGLa2jWuilP/rM/bKSaycfi3ipo/3XJweBAGZbvQD5W15qOt5kYlJ7mGNI7N
 ULQ2+cHYAeonhxoaBI4f3pDvsbT0Y2s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_02,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200029
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tasmiya,

On 11/11/26 12:51 AM, tasmiya wrote:
> Greetings,
> 
> I have tested this patch on my KVM guest environment. I am able to 
> inject EEH errors from host console as well as on guest console using 
> location code for a VFIO passthrough device.
> 
> Tested-by: Tasmiya Nalatwad <tasmiya@linux.ibm.com>
> Reported-by: Tasmiya Nalatwad <tasmiya@linux.ibm.com>
> 
> 
Thanks for testing both host and guest error injection paths.

I'm addressing the review comments and will post v7 with some
code restructuring. It would be helpful if you could retest
the next revision as well.
> 
> Thank you
> Tasmiya

Thanks,
Narayana Murty


