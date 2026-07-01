Return-Path: <linuxppc-dev+bounces-23302-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F747C44502
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jul 2026 12:22:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqzg82gm7z2xKh;
	Wed, 01 Jul 2026 22:22:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782892172;
	cv=none; b=R7dneaGi2BF0joUxAc8k3XxDOZKwY5sJyNTZu7iTqoAoXcwA68Sb+B3Bcr20qORbHVgiGJ80sqrYWpKJkSl65r5+wEQ83zwo8Iq20Ibbix6wFDIb47GruRS+c2m0pN6LL0NjN09xKvntAuI9mJ3lxFBk6pkxya6zyN0hoBCB9dw/UQr6r49FNH5E+QhdJVwTwGLhgojr9GWcK+IT+kFbGvEbxdt1CQpHN90Pxj6FCNedLViVx9xXLzA5sT6xEPum982C9/MlXru4nBlizd74frq2fDs88diq9NoFVBofE95Zx75wG8odH0f/zGgYSaSxy4wj6e6a/kOwKBjjAJZSQg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782892172; c=relaxed/relaxed;
	bh=ioxIwjR0AL117kzFBXybF7cfhe6hx+h5iZJxh8s87XU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lLQBMzjyETu2wK/ltapbnziRfxhSrxmTyP6rFFQZvjB8O/gGgHyG6N0VxNGNRs+IaZlW1ptm3RitNR3C2wmHiJmc1VviWVEVAPvX1+Audk4Jw4yYpoc61i3dftyPT4vZP9X+SqzuWNzVGQSoli3cdumU4BL0FogaIJesR7GBEPm/9QKt7OW/CKIGwqfSBpL1eSxSpmd569ToZVDgMXmz9DVv7TMGhw+VPpgtiVZzNXGs47ji+BBzzan4yZt+1iL+F3KNH6ErBfYtH5NZhoK/m+WK2Ctw754aSTBQeNpUMcsUl38B66V/4X3dNnWQOn8B27BEw8mKK6QbMP7Hn4Fu1w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nXxgkaw2; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HtSlnWkk; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=philmd@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nXxgkaw2;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HtSlnWkk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=philmd@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqsbt4zB4z2xHK
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 17:49:29 +1000 (AEST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6615lXxv137155
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Jul 2026 07:49:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ioxIwjR0AL117kzFBXybF7cfhe6hx+h5iZJxh8s87XU=; b=nXxgkaw2mzHJ/1IS
	1rf4VfEZDPDNc4qpaQP8bdnXeePd/fo2H05mnI25TgyeX6YBFWKYHAhIkZcTKDCC
	d8z7l8KKPmnhxxzUwNaEXJ9Ni5P1JIiI2aWruoIZMD+ZEsePMccKTIPdgDeDevFi
	yrs/DGuzA4yQhLp1OM0a6l8f2O/n6aTqDRZcXMoWxJSzzHj8gIYH5bFsGnn3QUSf
	at7oOMd7Z+9vF7IO2YV8r63ADuq3z+zUikqIeYEa7HXj/kakGmyZPINV16bfDemz
	u39XkDRnAIeOkZYiMLIiAuXKaX/w2/KYDjGdNnAu7Kcei2t1Uph3dxbbdVb4pxgh
	Dj6kfw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4h0auhrt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 07:49:26 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e53b8a302so35682485a.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 00:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782892166; x=1783496966; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ioxIwjR0AL117kzFBXybF7cfhe6hx+h5iZJxh8s87XU=;
        b=HtSlnWkkfDSFtkPytWyxZ5L1EZcSk+bAY6C5/QZnAIs/gCg7nL6R43AL0iomjDd4NR
         TMFGYbn+tnvEG1FQ9VuQQyfRKq9YqhiT1k8YGZI38vYdKUMz/A2b+D2mqtED5tcK0VD/
         Ojs0EcMObjKZ3asdLM4Fl+EX4Se7j8PBtWp83xP92Y78zcRQvHdTbah/MIFkprYRBgl3
         WXJGrQp/CF0eNt4O1057nL2PCRcMGBxv9Eys0EoWHkI10p7vPLhWDL5Ssn8QGOdOn7/s
         uEKMKLL0MdhPSyk6GFF+SL27U36C8skm1zPMHG1UsyoQCKZvkruxZfBBDNbnwA+ffHgX
         QtHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782892166; x=1783496966;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ioxIwjR0AL117kzFBXybF7cfhe6hx+h5iZJxh8s87XU=;
        b=MU5TeTwjaTspwjOBk7PoMVTKxljb8rrHu1EeMCE2YEUbkMvwN7z7dJ1PkgWOGmd+NQ
         khkkUY1w19JjnWKtEIpwTFbIAN7iexGMEWHNlq+IcxC/DXMIahRO/Opnctu8c9zdBAXR
         finjUlxxHEp7hMq6T0NU5yvaM9jycCEMWJEOGLH1Pmo+uNwdTfwjrb2YJ2EIHlWYycIr
         C6SlcMCtoQvjCJXQ8RVzXsE9F8FuqqWPAJGQ4MiB5TDp8WhJG/We859tumkI/2D45N6j
         +0e6t2IeeUWXQJZsU4qxsq+xvBtA+Kefhum06r/GgyMZDn+7fHj4q1iwhw4/g9HirkdW
         Z0Cg==
X-Forwarded-Encrypted: i=1; AFNElJ9guhHo9TabtG9f/ab8d60zYDsirvMVISsr4jQHSxH0L3pMtEmqQqKG5ClyARcEHQKPSL2M119SjoYYqX0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw9sKIgl6wE9u3xuusQdC1ZwB/G9bfwgMeuvCEoaQ5X9ae2Vs9e
	LD2unaXq0oHAsWNMuV0gVntL858ZGHqj5HD3/saejr0XbGgVNN5iKZq8+k6fjGoWVxwiY9KbjA0
	Zv0Xhtx65nqomTOKidI3JB3mCF+vHXOb+qg7IU6Un7oSJq4/mhgXbP1NWSb0vyIZjzuM6
X-Gm-Gg: AfdE7cn0E2iKud8ys++Axk6j/Qs76QUUkQGs9pxqRtfsZTSI7awAc2g0rtlArzQVdvd
	QfXtzeYnBYCBt20kh5Gx8FH9z7EBsGLkE7Wj5P13P7+Mc+2jW/9q+uZJssdEACvzl5vTAAmzGw+
	dJYhtoCeajCBa//9othNU+EzI/A2sy5vnVUQnljy+3EdTf6EzqojCHSh6m+4SKMvw1EADsEjfin
	P5TOn0zWQjgKylAydLkjr1CrZEa3QZqqg6Ln0de9RmKPZ4KJy7wO2VMJRDvkX0vZVuNsxDfrPHZ
	cOc2RweVYiU9G0KvKTsIN5ff1itKlHVRQnY6x6Fu/kSQ9wBbb1X6TQO+WG/x76vDEZCGDcgRoV1
	9vWN/0geU9zxzdTPR4FKs6rH9lgDTmN8dOcM/e61XIhBdVuPqFLRi57PhMb3Vmw==
X-Received: by 2002:a05:620a:2b42:b0:92e:600d:b9ea with SMTP id af79cd13be357-92e78224b5amr72107285a.21.1782892166364;
        Wed, 01 Jul 2026 00:49:26 -0700 (PDT)
X-Received: by 2002:a05:620a:2b42:b0:92e:600d:b9ea with SMTP id af79cd13be357-92e78224b5amr72104585a.21.1782892165851;
        Wed, 01 Jul 2026 00:49:25 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4756797a8besm15540687f8f.35.2026.07.01.00.49.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 00:49:19 -0700 (PDT)
Message-ID: <1df42f13-229e-465c-a5ce-40ea3bd93e8b@oss.qualcomm.com>
Date: Wed, 1 Jul 2026 09:49:16 +0200
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/9] arm64: vdso32: Respect COMPAT_32BIT_TIME
Content-Language: en-US
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-mips@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        sparclinux@vger.kernel.org
References: <20260630-vdso-compat_32bit_time-v2-0-520d194640dd@linutronix.de>
 <20260630-vdso-compat_32bit_time-v2-4-520d194640dd@linutronix.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260630-vdso-compat_32bit_time-v2-4-520d194640dd@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=OuF/DS/t c=1 sm=1 tr=0 ts=6a44c686 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=gC1PrsFcNpCBvASTUOwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: jz80hIKmDFflvANHE28ScFgw8YRH70PP
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDA3NyBTYWx0ZWRfXw3EWqQHjoblO
 5hi2v/VVIQ0K9bo20xyd6avSbZo6VerrD+TgXd8IqT2XgpFvJgwffm0hLzBdwTMpK0icUUQvPJn
 gOAVtPf1A5NtzIw7a2N2UIGvrLxLlsU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDA3NyBTYWx0ZWRfX5lS+m8iUVMQA
 u/M6ENbvOmrpsVO6Pw4MlXP+DSl9VKKo3BBWKUJEjR8y0FSNwmc2c0GVB5xL+vw2lGXgOymwEt5
 U3lhw4Qyu9bDQXc4KC8ICPDkQDcUAtbNRmtyNVsbFmmZy8/i1bg5W4mPzP/N/XtN/8PzSgVW+ta
 HQQO2wnMXc/O/ByFaQRksnYn6ARpGkviStC0RcEhSVx3+5987F9v+BzxEy4ISFIt/OGBTYZNzgy
 nA0UWO6MrWqF1MLNdm793PemZo8jXuZZj4szhGVzktVxWTMY0NqBM4Khziy+ViY8m2Pi4dhwj59
 lO+yYz2+AlPoPONPnWuSZ2JCWw9Bli8vfeDg6DymKlKZ3uMAZxhfVOxaD1rb7z0erFHWr08RMop
 lT6y00jRKU4VNy25M6hzHYSh02YAsfCgyFZ4aIgpcZ63xHusgSa6X7eAUN4te3ohTLIyy2IVPHv
 H6CTtmkpWbM0n4a+hFg==
X-Proofpoint-GUID: jz80hIKmDFflvANHE28ScFgw8YRH70PP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 adultscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010077

On 30/6/26 09:38, Thomas WeiÃschuh wrote:
> If CONFIG_COMPAT_32BIT_TIME is disabled then the vDSO should not
> provide any 32-bit time related functionality. This is the intended
> effect of the kconfig option and also the fallback system calls would
> also not be implemented.
> 
> Currently the kconfig option does not affect the gettimeofday() syscall,
> so also keep that in the vDSO.
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> ---
>   arch/arm64/kernel/vdso32/vdso.lds.S      |  2 ++
>   arch/arm64/kernel/vdso32/vgettimeofday.c | 14 ++++++++------
>   2 files changed, 10 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

