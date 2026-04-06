Return-Path: <linuxppc-dev+bounces-19404-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20DD0F46C78
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Apr 2026 19:53:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fqKlN1s0Zz2ySS;
	Tue, 07 Apr 2026 05:53:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775505232;
	cv=none; b=WZWAwdKmixsV7lmvq2OYEXqCpEbaip7MmPRjfWNqq9LlIArZMSFgbgTNESBIH3w2HvObRnbR+jyU/H2YDkOQzJRvsDa5J220ibKQ3mljF2uH1fq5ADr//e4h5sVvibKqqbdo7ZFOpFCZxIfjQ/bBjIurDmKRB/8HOURIJq5j7zrl1e6BTNpdz1ZuR+1lH4qPHvbIsTURsAzGRU/kUGsfEwE83xaElXbRNUTWJ/eGprt+hRGLjRSKL96apbzP6h6v6M1H08gK9XDmdRVRiYPwP7TJaNcxVF2YtEa86XXDTMlYIH9ukpIf21agUkoLrxpoOcgxqvpwJJO//LygGSlGxA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775505232; c=relaxed/relaxed;
	bh=aTKkmDEFhEVBniuORXfs+iM4bx6wEJqO8LgGWEoLiA4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GwFnFiRj+jUFHht+C/wsa4YS35YHzM1603jn0vnXBbY+5/0VwVj4jmEVg48hPnd/CeAVobXW8U+FGnu/HcRezC8obdgjluMeAZ1iNMR9Ny6suP9hHOZbwTuIHJZmJSB+EQF16NwMbwtU5Q4zXbkjvumD5G+EoRlqtYQ4fvt5l6V+17PkZ9u+rvYRNvjhisRH5nWqueQ5tbl5E3jpIdrmpqFBQ/o/f8rfQseDoks9RkJQx7pk2P3QBJ++MsNiuB5tUsDjsRAUxAK91541vysFLuKu5n8NLk36X00887qMTch0FCZupHWtOZLAd8TkqdXrjAkTrM1fHh8IjXDGKIA0sQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Efdgo5Yr; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=aboorvad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Efdgo5Yr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=aboorvad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fqKlM0PbBz2xHX
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Apr 2026 05:53:50 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 636DJSNS2900047;
	Mon, 6 Apr 2026 19:53:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=aTKkmD
	EFhEVBniuORXfs+iM4bx6wEJqO8LgGWEoLiA4=; b=Efdgo5YrehCdroVdhpD4tu
	98Jtj4CAU3pJSlf4QhyY/U8RiUy3NBbOyBenSwV8FoaPWCwx/gfn7X/FZ4ayshdA
	yKQtqvnKhKlhOGbNb/VseY3ddlXfqy/KppBYwVKsYPQTjSS1F+3l4UdqXPAQSaCj
	VR5GY0TaTMLNb8JmQhQpRSSP4U3O8Y32RQvCDyky9r+hWeO+UnuaDp9s8dzgZUI/
	fMQJ35nuwoKRvm2xmP/uue118Ty2db9C0yl1pC6veZZcA4lJCqBhOLl8I/6CEwJq
	LmuaVWc5b1bP8d9c+zZYhIZjxz0Gp2CEWlOTJJhj8fQWJT5ciiPME+4Oer+1Foxw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dat520aaj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Apr 2026 19:53:39 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 636HW26S006447;
	Mon, 6 Apr 2026 19:53:39 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dbfp1nqct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Apr 2026 19:53:38 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 636JrZU215270350
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Apr 2026 19:53:35 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EEA1120040;
	Mon,  6 Apr 2026 19:53:34 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 653DC20043;
	Mon,  6 Apr 2026 19:53:32 +0000 (GMT)
Received: from aboo.ibm.com (unknown [9.43.87.37])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Apr 2026 19:53:32 +0000 (GMT)
Message-ID: <3d49964eb097dfd396249241e648d2d758090f5e.camel@linux.ibm.com>
Subject: Re: [PATCH v2 2/2] powerpc/vmx: avoid KASAN instrumentation in
 enter_vmx_ops() for kexec
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Aditya Gupta <adityag@linux.ibm.com>, Daniel Axtens <dja@axtens.net>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Madhavan Srinivasan
 <maddy@linux.ibm.com>,
        Mahesh Salgaonkar	 <mahesh@linux.ibm.com>,
        Michael
 Ellerman <mpe@ellerman.id.au>,
        "Ritesh Harjani (IBM)"
 <ritesh.list@gmail.com>,
        Shivang Upadhyay <shivangu@linux.ibm.com>,
        Venkat
 Rao Bagalkote	 <venkat88@linux.ibm.com>
Date: Tue, 07 Apr 2026 01:23:31 +0530
In-Reply-To: <20260403190123.1383198-2-sourabhjain@linux.ibm.com>
References: <20260403190123.1383198-1-sourabhjain@linux.ibm.com>
	 <20260403190123.1383198-2-sourabhjain@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=J6anLQnS c=1 sm=1 tr=0 ts=69d40f44 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=JuTF4qcAAAAA:8 a=pGLkceISAAAA:8 a=Tu477qHDl0IyjR2CGvcA:9
 a=QEXdDO2ut3YA:10 a=WlT8qwTXB_Kj6um4hl3b:22
X-Proofpoint-GUID: UUrzmgsSKP20h05XRSnWSq5MRV0EkbHp
X-Proofpoint-ORIG-GUID: zCyAKxXLFWq3DR_QvWTbRe9rLPACteqH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDE5NCBTYWx0ZWRfX8r+rOR1hSu0d
 RppCxOKSQ/dcFGMNp4rJ7UZ2ueuEcmvg0zxgW+1D8071Yx+kWvoe4itxh1DuOpd814KmmX/9kGS
 L++KsFsQeORX5e9InoQ58A2u7SXQS2jzeLqJxIeaYTxdk4swZF4NZ+clLwL3uKGUBqRBGGoOX46
 AyTm0THoT31Az3uC6YTjGnY1xbczkPKn9DYUJaOPCifDMEkHY1uCjryPm2Qyg9rQEP/MdZfSWC3
 abWmkrPMA07ykHgO1Gce6J/kDSBuUSCnnxq3sqthLMbYLviNdeXYDiNHKwb1ZZ3WjP9IA/idmbd
 3fNenKdV5CWkUeXfIdCMAD1OYtylmX7tZoxGvzJDungWosfM2VvlREF+GXucBV76uKDnsYSsH5W
 I+aqxzZnJfeNpQDlefvtLtQWkPvBbnhpJ9dEEDMc3cZRtyCNGtYsidnI6vThopjQ29sJcCCzuRE
 T+FIcuHPLnglL0jRJSQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-06_04,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 clxscore=1011
 impostorscore=0 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604060194

On Sat, 2026-04-04 at 00:31 +0530, Sourabh Jain wrote:
> The kexec sequence invokes enter_vmx_ops() via copy_page() with the MMU
> disabled. In this context, code must not rely on normal virtual address
> translations or trigger page faults.
>=20
> With KASAN enabled, functions get instrumented and may access shadow
> memory using regular address translation. When executed with the MMU
> off, this can lead to page faults (bad_page_fault) from which the
> kernel cannot recover in the kexec path, resulting in a hang.
>=20
> The kexec path sets preempt_count to HARDIRQ_OFFSET before entering
> the MMU-off copy sequence.
>=20
> current_thread_info()->preempt_count =3D HARDIRQ_OFFSET
> =C2=A0 kexec_sequence(..., copy_with_mmu_off =3D 1)
> =C2=A0=C2=A0=C2=A0 -> kexec_copy_flush(image)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 copy_segments()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -> copy_page=
(dest, addr)
> 	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bl enter_vmx_ops()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (in_interrupt())
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0
> 	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 beq .Lnonvmx_copy
>=20
> Since kexec sets preempt_count to HARDIRQ_OFFSET, in_interrupt()
> evaluates to true and enter_vmx_ops() returns early.
>=20
> As in_interrupt() (and preempt_count()) are always inlined, mark
> enter_vmx_ops() with __no_sanitize_address to avoid KASAN
> instrumentation and shadow memory access with MMU disabled, helping
> kexec boot fine with KASAN enabled.
>=20
> Cc: Aditya Gupta <adityag@linux.ibm.com>
> Cc: Daniel Axtens <dja@axtens.net>
> Cc: Hari Bathini <hbathini@linux.ibm.com>
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Cc: Shivang Upadhyay <shivangu@linux.ibm.com>
> Cc: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Reported-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> ---
> Changelog:
>=20
> v2:
> - Remove __no_sanitize_address from exit_vmx_ops
> - Add a comment explaining that marking only enter_vmx_ops
> =C2=A0 with __no_sanitize_address is sufficient for kexec to
> =C2=A0 function properly with KASAN enabled
>=20
> v1:
> https://lore.kernel.org/all/20260321053121.614022-1-sourabhjain@linux.ibm=
.com/
> ---
> =C2=A0arch/powerpc/lib/vmx-helper.c | 9 ++++++++-
> =C2=A01 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/powerpc/lib/vmx-helper.c b/arch/powerpc/lib/vmx-helper.=
c
> index 554b248002b4..57e897b60db8 100644
> --- a/arch/powerpc/lib/vmx-helper.c
> +++ b/arch/powerpc/lib/vmx-helper.c
> @@ -52,7 +52,14 @@ int exit_vmx_usercopy(void)
> =C2=A0}
> =C2=A0EXPORT_SYMBOL(exit_vmx_usercopy);
> =C2=A0
> -int enter_vmx_ops(void)
> +/*
> + * Can be called from kexec copy_page() path with MMU off. The kexec
> + * code sets preempt_count to HARDIRQ_OFFSET so we return early here.
> + * Since in_interrupt() is always inline, __no_sanitize_address on this
> + * function is sufficient to avoid KASAN shadow memory accesses in real
> + * mode.
> + */
> +int __no_sanitize_address enter_vmx_ops(void)
> =C2=A0{
> =C2=A0	if (in_interrupt())
> =C2=A0		return 0;


Without these patches, when KASAN is enabled, I observe a hang during kexec=
 boot on
pseries (PowerVM):

[ 3459.012617][ T4209] kexec_core: Starting new kernel
[ 3459.012814][ T4209] kexec: waiting for cpu 1 (physical 1) to enter 2 sta=
te
[ 3459.016236][ T4209] kexec: waiting for cpu 11 (physical 11) to enter 2 s=
tate
[ 3459.016287][ T4209] kexec: waiting for cpu 12 (physical 12) to enter 2 s=
tate
[ 3459.016380][ T4209] kexec: waiting for cpu 13 (physical 13) to enter 2 s=
tate
[ 3459.016418][ T4209] kexec: waiting for cpu 14 (physical 14) to enter 2 s=
tate
[ 3459.016444][ T4209] kexec: waiting for cpu 15 (physical 15) to enter 2 s=
tate
[ 3459.016462][ T4209] kexec: waiting for cpu 18 (physical 18) to enter 2 s=
tate
[ 3459.271929][ T4209] kexec: Starting switchover sequence.
[system hangs here and no further progress]

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

With both the patches applied, kexec completes successfully with KASAN enab=
led.

Reviewed-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
Tested-by: Aboorva Devarajan <aboorvad@linux.ibm.com>

Thanks,
Aboorva


