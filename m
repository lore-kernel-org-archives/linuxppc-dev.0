Return-Path: <linuxppc-dev+bounces-19405-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3A55F46C78
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Apr 2026 19:55:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fqKnM3NXzz2ySS;
	Tue, 07 Apr 2026 05:55:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775505335;
	cv=none; b=oQ7WWPicHC1ubh3vP1fAjrlb9hXiQ6Fr4YDgGq+0v7P6tXasDpwedUbeANKVa1h/Uq/IU7fdyMstlnHhx4AekE+Fk7+XvrL6epjY0RPiM5XOyTZFfW029suTlx9pc67JJQrrUyx2BybGaeSH4zj9hM8UJpBR3sB8BWs0mKRb7SqV1OG1dM8EPn0l6lAy2zNKP/+YK45SoCdT/vyVWW9AdI76Z5KdjO68UPe2iWvE5/8AiJkUiUBlTyGAJ3BDNhkjByBL7mkGwSvMSjk4YwtR0Ach1Caz31kWnJwyUMZiFniaKHc83ulNG6wkRGYJGTXLAfgb3xr0lWuKR2nwwkBLKw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775505335; c=relaxed/relaxed;
	bh=0tUd9BeLjceswPNauAQU18mD/3V/V6pMUOu6B8z8WBs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MqG12grqFrrF5aS2w31pLirgC3FmsE3fYxqib062OWG19hfZ09KNbhyniPx+06E6xNJLbXFCUgrF8MJ8i6+xE37goxC4wqADI36pbvi7gPRqE/7yhiEmbCXu/XF2RhiRstiKf+/l8gLSdoa1efqM0iWoEvnECt454aaPXDo3b9DVuAKRm9O+N9x25G/0L+OBGiGUGzgMgjQUAQ7YBxLwYhuwZ0q2u7addUmmx2mzk1YRfgpaPnItMRNsws28mFCN/QqLGWblTRMQaYVoCZMWFI9lLZ+796plfBJzYvKB6Wxu3YZgEui1YW/hOOyt6gcIZtTyC5/rbYZwBWrXV7pZJw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bfM4DGIV; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=aboorvad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bfM4DGIV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=aboorvad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fqKnL4JxSz2xHX
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Apr 2026 05:55:34 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 636IYkVg3869782;
	Mon, 6 Apr 2026 19:55:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0tUd9B
	eLjceswPNauAQU18mD/3V/V6pMUOu6B8z8WBs=; b=bfM4DGIV53QLNQx7T4jaQS
	4Pg6ErhfPTasfBBqCkrdELEZhTNe2rstNuZsSiVUj8e8hZJBdW8zxXTD5nFh9Hi4
	zx4xi+KeegeP0zYSzuaAczCTe4xFT/4WLS+kMXxInnDmVJoMfeKpFs/xWmPhxDmi
	kqu91P2VNif0/jOtMfvsFqP4qvDcUk/3V3aahccH44YZcD/jD3hYfXQjHfDhL2OL
	8mJRxotRDYovIHPgHuqFC3vTO7EeNq96JC4MXS3wW1+v8Gaek2Ojo5gx7buLiV8+
	J3jQKDnPh8E4PaJKpq/HkuIXAg/WZKKyDDURI3osm4s6vAnR6UIdnRabkHYX1mWA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4das2bynf7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Apr 2026 19:55:24 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 636EvJsH018529;
	Mon, 6 Apr 2026 19:55:23 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dbcysx32q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Apr 2026 19:55:23 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 636JtKFl34537750
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Apr 2026 19:55:20 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E438C20043;
	Mon,  6 Apr 2026 19:55:19 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4226E20040;
	Mon,  6 Apr 2026 19:55:17 +0000 (GMT)
Received: from aboo.ibm.com (unknown [9.43.87.37])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Apr 2026 19:55:17 +0000 (GMT)
Message-ID: <a351a1e79aeca661ad15f18c077d155bbabff563.camel@linux.ibm.com>
Subject: Re: [PATCH v2 1/2] powerpc/kdump: fix KASAN sanitization flag for
 core_$(BITS).o
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        Aditya Gupta	
 <adityag@linux.ibm.com>, Daniel Axtens <dja@axtens.net>,
        Hari Bathini	
 <hbathini@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Shivang Upadhyay
 <shivangu@linux.ibm.com>,
        "Ritesh Harjani (IBM)"	 <ritesh.list@gmail.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>, aboorvad@linux.ibm.com
Date: Tue, 07 Apr 2026 01:25:16 +0530
In-Reply-To: <20260403190123.1383198-1-sourabhjain@linux.ibm.com>
References: <20260403190123.1383198-1-sourabhjain@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
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
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: H7EsrUocxTZU86TPNp5260s1F0uaQNfo
X-Proofpoint-GUID: R3LFBTfCDvSdoyB1M20XZOJRNFE2ZmBs
X-Authority-Analysis: v=2.4 cv=U9qfzOru c=1 sm=1 tr=0 ts=69d40fac cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=JuTF4qcAAAAA:8 a=pGLkceISAAAA:8 a=ZSZbnnKFPOSW3gtc0DAA:9
 a=QEXdDO2ut3YA:10 a=WlT8qwTXB_Kj6um4hl3b:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDE5NCBTYWx0ZWRfX0PSIwCDSZuSV
 YsMfQARySkO8Ngk/XfizU31S71HkYJ36qBK0LCAXAVkksGUa7YORYc3piUWExhWQzFee5xjQR+E
 oIafnMYzvdoITVg3JSSt5/OMUjsedUHKvTOHydUJxUPdRka86BUTtl5l80hVV7gsVH6WOGPd8cy
 PcVaVqJKy3i97Xx2xQxY/7gA3eKKbBLLyP2ZmSboQ89NzdknfBNgTZHKRPaqY+efZScRM12ovZf
 9FVwCBRHXUQLyBVxUVCC6T2NBE4uJYIdeV/H7cUqetXkicTnYNG9TYS0twvZIA2rVYFsDl4Wybm
 uF6IOob1Pse0W4GMCFN6bn46FlNwjMymrryHUX8j7qkO/hppFL7ge8Fd2zbW337j2Bmc78DsKhr
 Q7dwA5KKvt8O8okbwXcHGk3fSRuLtqPp6/13CzL++KZr1F9y/SPasJU35WUSpOa+mmbOaN6uKqE
 92eF1kaSz+VeMVFY4GA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-06_04,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 clxscore=1015 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604060194

On Sat, 2026-04-04 at 00:31 +0530, Sourabh Jain wrote:
> KASAN instrumentation is intended to be disabled for the kexec core
> code, but the existing Makefile entry misses the object suffix. As a
> result, the flag is not applied correctly to core_$(BITS).o.
>=20
> So when KASAN is enabled, kexec_copy_flush and copy_segments in
> kexec/core_64.c are instrumented, which can result in accesses to
> shadow memory via normal address translation paths. Since these run
> with the MMU disabled, such accesses may trigger page faults
> (bad_page_fault) that cannot be handled in the kdump path, ultimately
> causing a hang and preventing the kdump kernel from booting. The same
> is true for kexec as well, since the same functions are used there.
>=20
> Update the entry to include the =E2=80=9C.o=E2=80=9D suffix so that KASAN
> instrumentation is properly disabled for this object file.
>=20
> Fixes: 2ab2d5794f14 ("powerpc/kasan: Disable address sanitization in
> kexec paths")
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Closes:
> https://lore.kernel.org/all/1dee8891-8bcc-46b4-93f3-fc3a774abd5b@linux.ib=
m.com/
> Cc: Aboorva Devarajan <aboorvad@linux.ibm.com>
> Cc: Aditya Gupta <adityag@linux.ibm.com>
> Cc: Daniel Axtens <dja@axtens.net>
> Cc: Hari Bathini <hbathini@linux.ibm.com>
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Shivang Upadhyay <shivangu@linux.ibm.com>
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Acked-by: Mahesh Salgaonkar <mahesh@linux.ibm.com>
> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> ---
> Changelog:
>=20
> v2:
> - Add Reviewed-by, Acked-by and Tested-by tags
> - No functional changes
> =C2=A0
> =C2=A0v1:
> =C2=A0
> https://lore.kernel.org/all/20260321053121.614022-1-sourabhjain@linux.
> ibm.com/
> ---
> =C2=A0arch/powerpc/kexec/Makefile | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/powerpc/kexec/Makefile
> b/arch/powerpc/kexec/Makefile
> index 470eb0453e17..ec7a0eed75dc 100644
> --- a/arch/powerpc/kexec/Makefile
> +++ b/arch/powerpc/kexec/Makefile
> @@ -16,4 +16,4 @@ GCOV_PROFILE_core_$(BITS).o :=3D n
> =C2=A0KCOV_INSTRUMENT_core_$(BITS).o :=3D n
> =C2=A0UBSAN_SANITIZE_core_$(BITS).o :=3D n
> =C2=A0KASAN_SANITIZE_core.o :=3D n
> -KASAN_SANITIZE_core_$(BITS) :=3D n
> +KASAN_SANITIZE_core_$(BITS).o :=3D n


With both the patches applied, kexec completes successfully with KASAN
enabled.

Reviewed-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
Tested-by: Aboorva Devarajan <aboorvad@linux.ibm.com>

Thanks,
Aboorva


