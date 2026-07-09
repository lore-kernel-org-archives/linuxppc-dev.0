Return-Path: <linuxppc-dev+bounces-23934-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 158C4C44501
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2026 11:20:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwsw35fqpz3bxl;
	Thu, 09 Jul 2026 21:20:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783596051;
	cv=none; b=SxDgSOhKqNkuw1z3HBfjj2EBJrIIPPb2IIyz52Hw74nuG5MfknHX3i45PIy8HqaiZSfVruh6T1WJ2hUclK2V38EBx3d6SXMEt2uIBdU2B86Eg8c+oea4suCQcsIAMwiYmv9Lnp1fvr0FNol0AjKGHI8LmfaEc5zfhsBDMuWhjrWsIRgxRzx3Hgn/t8SQ5bV0hEaG1hhYAdlZUtIuf9RdyUNfIWhw9fpbH2a84xArMh08axhDYT3Qpxfh2TQs9K2hBbZjlyr3VXQu8gywj05SjrsvYgQntEHS2beMbpJZ9fjUJlSVBL554Ol8su0GBYvOJL8aNn2ndghYsMxaWEUeWA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783596051; c=relaxed/relaxed;
	bh=E2VXUkO/1Nfb5542An87XlKwD9GRDm4PLC6Ooi7YQSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZpnVK5mER5FVBGlIMuLzMtU/FhIUCrD0uB6ye6Z8SajeojHaAEeIytPfNgPmv4XTN8x3xLUpKLZaNWdBCA3gHQxdY3oWX8Dpx0CNtXnIJylhnhOp7ALjQxvikBu/5Qv2cmi6qq24Sb7rXUH5H4nNBhx0X7lx7p+AmoVqYSn4eZtLP1V0PIeXhG9HaScIuY/bvheUVvGgvyhwXnoki2NBWwYQZD45FUZ6z3Jq7IlT5C+6C9bU+3MIRjmqB6WvjbzFYFEovYpcovUr/a61kkLF+vshYft+FABgGQfxl/IVCuVMZMXUEoHSqS/vfpxEhhoSgb4GQchHWgZdKdu9KglAgg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iOWfjmK8; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CVey2eot; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=philmd@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iOWfjmK8;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CVey2eot;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=philmd@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwsw275NSz3bxf
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 21:20:50 +1000 (AEST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669AwrVW1470041
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Jul 2026 11:20:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	E2VXUkO/1Nfb5542An87XlKwD9GRDm4PLC6Ooi7YQSk=; b=iOWfjmK8f8Y+DVJW
	EcnBVbRqoFetWpR+MvbIm0rNsCYEYiCVdv/jb+r7ZZuAst5pdACVTyVPX1hk4M4R
	UloW32yrnx0br0O0OZPBTsUXsGcPSz6fo0b7Z9SsSAlawkneGV3knPcGuKS4ecbQ
	qUgL7kJ1kZwezKuA1OHch6fG0wR/9IjoD0gaRXopgi656DtKQN7lmNG5nDcMpELo
	+2tydKrnvkk1mYPsPWN5nD/hRUDpTxejd9pRgo55t5XyFzKGEVSWfHJeObs1qXCX
	o+wuU7kKSC/wnWW5kZ8U0x7Pvu4fl9GPrm5rLmSBf6RmcKnNqHf8RgkEBJ09ZjsD
	t7y3cw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9v4u3gw8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 11:20:48 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c01ff996dso17579651cf.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 04:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783596047; x=1784200847; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=E2VXUkO/1Nfb5542An87XlKwD9GRDm4PLC6Ooi7YQSk=;
        b=CVey2eotOpbkRW79LCbG0nh73WipUrLWaWvs1w4ARMqlKmXSHmDx26ix+E53m98zFh
         Hfida3y14baqIXXFGttNujddz6i5jdv9otDFQQX+CDPdC390QVOE9n4Pb0QhGV5aTQZQ
         2DWdVyNhbn2jy7Uteb8wL/+iZgspnbn5Gy4huihio1QPCcOfFQ14zz+oHqduyOpybA2g
         yxW5Qkc8vduIokPGRR4IFWLGEmgF0i1vOoIPGroAIgI6M0au0ysdStltFiEZ5PfcM5E8
         ntpiIw7gv4sZe1aGO3DcoUGXGqwOOzX7warQMXObLXoiTuyFr3uN6zRCHT4fO/D3IqU5
         i7IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783596047; x=1784200847;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E2VXUkO/1Nfb5542An87XlKwD9GRDm4PLC6Ooi7YQSk=;
        b=bB1FF1OAsdr/8ehr/Q3KoQXx1fiFVCRogghMQ1T+avRx9DOON7a+FjjBoIAuyWpZw1
         pjHvA3ZcmX0m0VXAXuMyB+lM/N/jFK6jvrqlDgjA3ejBHmDfrTmt1S9h7dcwiaU5m6Z6
         nDE0dyUyeh/jZaz/XZCLav2ianLXNebrbu1LpTwJCWorR8JChQ1mYnbehMMdkvRaaZT+
         6NiEMPSWJS0LCDEJCqeSd1r2pp00NjMt8fgcKBP2inz+vLSxT//tv5hhhRlmN+qJcBhs
         gEaMUB7YDwwhcdcN6cANCC6JL0V8GExCfQWI9cGVTzgLHEgVaZmF21545s1kCU3xlO/+
         Q7rA==
X-Forwarded-Encrypted: i=1; AHgh+RphZE9O95trQsuuht9wLlyY/9/gWZBfT5HS1KPoCNavUHCK0SLTyCftgYGDv3YYxe3IjWjJGF9S2wW6+H4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxYnmpSXKcpD1OYBkEylCj9B31jQnh3G2Bv6BdQYDLDgtV5V5sx
	DwZN6c9ZRSpmf1gEjgi0dhAkUD+SGD/VQsY+9AW/zTMydpeVyS7FwNR5aT1ElrxXf5MoDVHENUR
	vvqKYQYX3hum2Sh3z9mJkGugysDNZEaxlhM2q+uZZrCSEPYtyTVP2/cqOdSgrPWBw08KK
X-Gm-Gg: AfdE7cnME+n2aIZjUNUruXGxz6F/gQSOY5u/QGQU0u4qu2/Y9CmQf6QdLc0kF6OULTP
	5NxlU9ll8xIku7/4XY0TEoi89Zhtcp1VYsfyByF2LtV4qXiLQQDk7cAe0iwrEYJobS6eDJ4SMuD
	FQ8+/8bFHMCJX5Zw/PdBmRBDi0Q6wyBN9SVh9/Kx/NsgRt7nG4mD26yDD1+NGLfVR4soNkbG5qT
	MNIA5idx0zj/hqasEoFwbokC4fBpKfAoZK4NnnXu193r5k5mvX0OHeF2gcllp/NnaPI4qe7/VFY
	PJIKibLR0M7XkUcTtKLqoo0MB/5zbZTS+UjG0DclqBXu7155XCn2024/KzanSm0bqUoDOIkPx4q
	NgDRtjjI1rMMZpI7pN1+Nb8HarXLMkVkK0gtp/TztdgUbmW0YdGcIT9S3NOdZqA==
X-Received: by 2002:a05:622a:251:b0:50b:4491:a2cf with SMTP id d75a77b69052e-51c8b30365emr71754611cf.27.1783596047549;
        Thu, 09 Jul 2026 04:20:47 -0700 (PDT)
X-Received: by 2002:a05:622a:251:b0:50b:4491:a2cf with SMTP id d75a77b69052e-51c8b30365emr71754181cf.27.1783596047072;
        Thu, 09 Jul 2026 04:20:47 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69acd1d32c6sm1861799a12.31.2026.07.09.04.20.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 04:20:46 -0700 (PDT)
Message-ID: <73b82749-2df3-4c12-bc2a-ff7628dc8292@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 13:20:43 +0200
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
Subject: Re: [patch 10/18] entry: Use syscall number instead of rereading it
Content-Language: en-US
To: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Kees Cook <kees@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
        loongarch@lists.linux.dev, Paul Walmsley <pjw@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        x86@kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Jinjie Ruan <ruanjinjie@huawei.com>, Andy Lutomirski <luto@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>, Guo Ren <guoren@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Helge Deller
 <deller@gmx.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Richard Weinberger <richard@nod.at>, Chris Zankel <chris@zankel.net>,
        linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-um@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>,
        Will Deacon <will@kernel.org>, Brian Cain <bcain@kernel.org>,
        Michal Simek <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org,
        linux-openrisc@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org,
        =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
References: <20260707181957.433213175@kernel.org>
 <20260707190254.181086755@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260707190254.181086755@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDEwOCBTYWx0ZWRfX04wJRLiHUiZd
 mVC3Tn+X50f8e4rUXeh0eJbwGQkoFW+RJtss0vSiNhpCYxaYOIwzyZIN6AQ7S1qZs17sDaaDyC+
 dWQa7pfg/6Ud2u2LGEqLJAq+O5nDU80=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDEwOCBTYWx0ZWRfX9T+RMZMHurqP
 JRcALcoioZ4iwnYv60bTtXMHcuCxqczGbz31lDYJFm2LRiyVfm5vIMu44CB0t3GDOBfmI9Xf4w5
 IrFfIhecoDb4l+hm4ULK1crAKJclHhDCEyuLLyLutR515FuFYzime4TdcdjMVCVXk1pGjd3+vaZ
 k9iav2s80ftANE2Qm7543Xf8YDYYYEXNpnOcdDyDWmGTCpQvyh68TtHUpn2n7DIcoQp5Iw4aggu
 dEPSVWNTG0LtS2oBADpREpXYQoI7uppmYRT2zToFlOMKa5kAmNI6U/Gp9hXzurq/8IjGcHD83kA
 NL9iRXKlaOVh/EPAJw3TTRrlb4h/YSyLqR+Y/7WN6Rnaehjm+U2AYM3IAD+D0DXNe7H9ub2pXAH
 zqKxUMBD5REwv332OQWWf6XZiRHByl6fwpGxYwxqwEsT1fqmFM1zbC7mTDmO3KQLCrU82JtNbjL
 L0CdAUaGkRr5/geJrnw==
X-Proofpoint-GUID: jW82WXXawG5XPiwcXsaXYi3fqw-vo40J
X-Proofpoint-ORIG-GUID: jW82WXXawG5XPiwcXsaXYi3fqw-vo40J
X-Authority-Analysis: v=2.4 cv=QoVuG1yd c=1 sm=1 tr=0 ts=6a4f8410 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=uucGcSui7XbmpEV0VHgA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_02,2026-07-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 adultscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 phishscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090108

On 7/7/26 21:06, Thomas Gleixner wrote:
> rseq_syscall_enter_work() is invoked before the syscall number can be
> modified. So there is no point in rereading it from pt_regs.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> ---
>   include/linux/entry-common.h |    9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)



