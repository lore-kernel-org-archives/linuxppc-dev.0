Return-Path: <linuxppc-dev+bounces-17866-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F1F4F55105
	for <linuxppc-dev@archiver.kernel.org>; Sat,  7 Mar 2026 20:13:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fSvcC5tj9z2xjQ;
	Sun, 08 Mar 2026 07:13:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772914427;
	cv=none; b=f3Ar3uKqIWo6RtLbNS7Asbdg8a9Ao8wqNeR30sSbndxRW68uFwqBAy7L9ABYt6WGLhrdcQJt4w/c3yTk0j8sI24QLJh/qcw0IX+lOB/7m5jSpGmK0rkux1709u3kkWRn5BP8wE+97NNAYVnrk+qhksGKIy9DwLHn+kDqCkQHFK/BRJzWwo1QIanOURcpCfOda5GdLr9MuBl17+tYJd0qh4venvba+yYoOdJD8nQwaUdu+5EQwQW+Qphtws+JJg7bWlRXKpny8tHrk5HH9fn+irjT6UjQqSl8JCJhatKSYAuF4Ldf/E2jvgN/wYl/lNa87jxNX9xUCVv7/kDVS+GBOA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772914427; c=relaxed/relaxed;
	bh=4yvLD11mVPllejxn3NL15m3qrDROut4e9teeeZ3ia3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dCIjVtSxVCdaFyU38uTS23/r51K512PRGM0eyFOFpHQ4i0cb2gVF6H7hysvp89srHDWgmGznQRh2XYK1+zgzKLYRoyxoFUmGgLlTAnYN9t07L3/AQHdXZotm6lE8aTgg4Abt1fZAybKemuzmj4VfN7T9K4GHS1apx/+47jmepOxtSELwPOvRP8819R7sUw/U/I/j5wUs6wdIpxVFUZtW0wPBEd7J2QaWnrYoTtIZk9eRctxlA6SrmLTXT3ZB/DARXy1g8I5XRejSsxye07S0bSyuztXtWhlfEz0j2lYuWq+boA9Sbtiyn+/fJeW5umKZgTwW3YFg3L8dqC4gai1e8Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=P+UI2JAF; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=adityag@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=P+UI2JAF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=adityag@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fSvcC0hj6z2xYk
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Mar 2026 07:13:46 +1100 (AEDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 627K9Co32843874;
	Sat, 7 Mar 2026 20:13:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=4yvLD11mVPllejxn3NL15m3qrDROut
	4e9teeeZ3ia3Q=; b=P+UI2JAFYXyztr0GQviq+R6yHEIV/AAUi+wL/0J6LYnAwf
	yVTRHgKcgwTSzi53FzdssTne0N6F+oWsSki9e3BuDtS5h6GGjr77V6LKM7HMXmn8
	zl1X1GZpCZ8eYHBypGRI0XiCSIwLb+BHbyMncm+a8ibEJ9QAYLQ4wBJIaAgUp/pX
	g56OBIoOfy/NXGYg/PaKgd2EJu+S7S4CKujsiancIUPai4M/ByUOeLQvBbHE4rIn
	d89/WWZOBd+3Kna1A7x9nykzm3NCBlJO8rU8+BtN03RN2np6PsqalcxXfcGNiULi
	yA9l2a53QT6guRX0svx0JhszTuyha4gF1WKHh3Rw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcuy1vf6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 07 Mar 2026 20:13:39 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 627JcKqd010299;
	Sat, 7 Mar 2026 20:13:38 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cmc6kmk7c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 07 Mar 2026 20:13:38 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 627KDYvn17105392
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 7 Mar 2026 20:13:34 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 36A7720049;
	Sat,  7 Mar 2026 20:13:34 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CECC920040;
	Sat,  7 Mar 2026 20:13:30 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown [9.124.213.84])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sat,  7 Mar 2026 20:13:30 +0000 (GMT)
Date: Sun, 8 Mar 2026 01:43:28 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: hbathini@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        mahesh@linux.ibm.com, mpe@ellerman.id.au, ritesh.list@gmail.com,
        shivangu@linux.ibm.com
Subject: Re: [PATCH v2 2/2] powerpc/crash: Update backup region offset in
 elfcorehdr on memory hotplug
Message-ID: <aayGKtxLIn02Gm08@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20260307052102.944952-3-sourabhjain@linux.ibm.com>
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260307052102.944952-3-sourabhjain@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=EK4LElZC c=1 sm=1 tr=0 ts=69ac86f3 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=FEn-MK4_rbdEeUw7hVsA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA3MDE5MCBTYWx0ZWRfX9f2HwwkHzoFH
 I59Pm7UMyIbJHkMAGr4hkjxfQG6BVHSrTrBfrSxcVGWBc5SlvnrTxfopAyLxzCh+oSvyEWi2x+I
 pTU0x5GBRvKjifrgepXjpo0Nc5flivivWKP4qPd5ZEppMNsWvKz1UTwOyGi+gIHJ9QgHNVKKcUn
 1zPznhfFOlhT/kfNAGpIrQtkTjAzqPZkc2DEwWKmlg3ZIOyJkbV9nJb/muFloOhSsC3v9nDIQ2i
 VzHIij+Cym1cW5jXSGOl/IQmSZAh6oNZlfMuvlueMg8MPOSr1NqUlbw+HBGC0IqochsdzJXPOqm
 1SfY5HXRayFuOlKk7lM60nzZoWx9p9ad4k1jScTdBxDL0DKozes1YvtX444AzylzhgxMmLKnFLO
 6KFfUlsofZ/xe+rtYUaeM2GW8UFz+pouq2PqdGTLyLlExIA98/bBPrLOShT07JDIAsfnhoN+68A
 14EQo6PD/DE6tHxnK4A==
X-Proofpoint-GUID: qRG8J4chwLGFiRvFXxP8kfaSNjuJsFFW
X-Proofpoint-ORIG-GUID: nJCqpkMrXKHDbrjYpdiUWO2eqqWn-TfL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-07_06,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 clxscore=1011
 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603070190

On 26/03/07 10:50AM, Sourabh Jain wrote:
> <...snip...>
>
> +#ifdef CONFIG_CRASH_DUMP
> +/**
> + * sync_backup_region_phdr - synchronize backup region offset between
> + *			    kexec image and ELF core header.
> + * @image: Kexec image.
> + * @ehdr: ELF core header.
> + * @phdr_to_kimage: If true, read the offset from the ELF program header
> + *		    and update the kimage backup region. If false, update
> + *		    the ELF program header offset from the kimage backup
> + *		    region.

nit: if sending a v4, can we add a comment in 'phdr_to_kimage' description that
it is true in case of kexec_load and false in kexec_file_load, or maybe a
different name for the boolean eg 'use_phdr_offset' or simply 'is_kexec_load' ?

fwiw, part of the commit description mentions problem already fixed by patch 1

Looks good. Tested in pseries qemu.

Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>

Thanks,
- Aditya G


