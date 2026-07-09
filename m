Return-Path: <linuxppc-dev+bounces-23926-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3582DC43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2026 11:13:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwslC2Rdxz3cDd;
	Thu, 09 Jul 2026 21:13:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783595591;
	cv=none; b=AkQ7kKWxauV0f+2to+IYy8NRH3nFzv1hPR1S6YD64lcBPllwr6V+K/EB4hiYu4F6felDUQTV7nJ4HiyTm6vrU4kBuGuYz5XvvCo8XpHp89U34egPfr/1u94gEpcsNyuq8i7Zsrna2cEfTXU1MoHnHLcaQDGms7vgd6HDYuGSS/Pwh5t9g4y5TqQV9E4MNT9q/IS7OP/vMFVjUV1ZFWKU72/ZFsCWHMM2LTUvWEZAajnvutsG/FxVfIQNAS+mXljwWr7iW+UzR6fPYz5cnNFy/5KAG4VkkUgcfnL0qgCsRCuNfVRyVnW0gAUaZXFpA0GWP9ZiHHNtSLNCJXfSSNaqdw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783595591; c=relaxed/relaxed;
	bh=Tx1kSZXz579iItxHsi1/8Nt3maK8vpLohSpfVXF4Ysw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dL/Ngbc9PUuITSm8FL74rAMlq7e5zvWYHM/61rIjZXj78FIJwfqyHJepSI6TEmN5ogwAAAhXmBmfX8kgOv3HUXet4rcsE+AHpzSoVQm/TQPT9SBCByh8dlsj5qTFsbW1b479biSGfN8NHPneg8vm25KGlDALrCNAa3SnjYNQOeaYybm+9AMweaB1+A63JBq0WToyGQVmkxiEsruamDfLv5RAovnZBGOVPeAV6Zsaz9QviQG7elH06bah77ykSsqS0rhdy6WQ92XWC5VcJUxeYQTqNivMS/mnV9rYLdyjtHMJ0T4qWL0w4I/Z+AkDBFfch+57xhmZPoYg9igCk8V8/A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jqvWJK8P; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jfS1e0nC; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=philmd@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jqvWJK8P;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jfS1e0nC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=philmd@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwsl91vcjz3c6f
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 21:13:06 +1000 (AEST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669AxZdX1619434
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Jul 2026 11:13:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Tx1kSZXz579iItxHsi1/8Nt3maK8vpLohSpfVXF4Ysw=; b=jqvWJK8PLEi8s+Po
	PkAhOcF1EZ0TGn8umnL5kgryJ/tFquXm2xFzKz63mEvAAckXJG2v/bBhmyd/J+vv
	w606gHPQkOOhu8auM9bbQnd68PLYN5DhMVRn/TQO3SYM9ZXEOEAB8F2FTaHvyyzL
	/gj6GXZOaZ7Kqn5MccKMlGU9Y/8NaD7WUS1XOInbClq4x0wSv71WFJfHopsmfL88
	joRiOO1NBxKuiVXV4p/tSPunQ9pAf4nwUwhwVoGhXqa2d3YUXy3NiFuuL84Sr5z0
	sFBM3VIfsHX5R32LvKrkWCid7sj7it6qPECFAQp6EaOHyXV68SwSVXRcZbVTi1ag
	vIF6OQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9sqsbx0r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 11:13:03 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c19493ac2so11226451cf.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 04:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783595583; x=1784200383; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Tx1kSZXz579iItxHsi1/8Nt3maK8vpLohSpfVXF4Ysw=;
        b=jfS1e0nC3zEK+pvYVd0Dv2tsbPZB3BmYxydo9vWUXD6xyoD5vZVOk1GLmQW4Bb66KZ
         x3frb1ySWuvGMm9r77ZXwZR5XP0zuBwsVLdsASd3gsTmFjp3fi5qCFIh8EY9Epnp42zC
         MC86Vs7YoIUBcV/CUaGlutLOJjhiT2/L8BjwZVGCIap/2FcxdlYYi3LuZ5WpGHnGeN6S
         EpSggfi4si5/EBXo/NlmvqGBMG8YChDoQBwQQZIlAY+YATmfnDe5GkA+6qcAczHoA6KZ
         5AfEHaccViSAT5GGV1YjwXCQzNkTXeSINiSjK63kp9uMMCXjL3nZyFVe3SimL8XRvdea
         EFiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783595583; x=1784200383;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tx1kSZXz579iItxHsi1/8Nt3maK8vpLohSpfVXF4Ysw=;
        b=bmt/SbYz5TwbLByFjb0DVWP/7HODGG6kjkwG5i19/U2v04O5zU6eLFhOVBgGKbR5GM
         Yl2WKUR7YrFYHqqkCIjwMkbUfEWX8Vt1VQHCj1Fq/qrJqLDC6T1lTYF9yfc2uBgVMNV+
         s497i6sbT6cCL0ZHAdCG9P6/72ZXaY+QsWFqvR8zStAuM/Rk+Z97V7TALIXMtADum71u
         F0cPKjDsBPx5Of1URGO1NuV+Pdz1d9cXZ13tdk/IpeuUmGxEaOAFRDobA+Hf8+4cZ7tO
         p4yIhB/jwoQAGGptEXUEtiRb3z/ZsreAQN4aaBhxXEGqlmi2aQmUe/CamdvFNcbzhPr5
         Ndaw==
X-Forwarded-Encrypted: i=1; AHgh+Rp1UaOV1Li5dJdmBLNC/XzP/ZFCw/D5nNP+XCei15olCA/gRZyCd44pUVzce0VAs7KgXp+76k6iDd4D58o=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyYPFWa6PBkNADP6POI8MIudHyVc40NHbHkeTxFQA3bROF+4s5N
	G6m9G5fRO3CVBpQTKH1K6IYYr9fzTnTeVzX/5TpGf0JauciWrPF1mti69E7qNdO720vn3s3u02c
	gM/e3TFNAbzrgGroPWsm/NvGyKGcX87N3qCx26nQOikvAC38M3QgrMLdNSC7kvAdUBJqw
X-Gm-Gg: AfdE7cmi0aYtAcpnxUlEFShE7/rmHyL3slMYNMHmcLbX1XYJ40p7tLSd6c6hU1756Nu
	HD3wp/6ZB8BcvJBJLA/3rf1iO8odAFfFv0HR+dxnJ5qiyNtRuA8CKn3CxJ2YK0pG5/a/S1QOAKc
	7vWMRcj9CC/ZHQpLlGkW4yMmKEcKSJ+yz+9ou8LtLOvBlQohpo36yZ3sossKggcJ2VXPlONfry5
	S3MuG4MR6O6slQdZ7P6LckJvLDVl8VJvQ65eBb9nikc6WJe7Vv6bkT3rFj2YT8tnBR2i0m4NW/P
	LghxhFxXqMV8tBumiDJb09hVYDfoITE4G18m+4mZSjZ0aFvMVK4xBxzwMjM25xWsrx0YFcnA03o
	0KpqU9oz9CvzgWU0vj4ROGp1HeRduYX291jSxEFdTFXq0AvzGbaVfVzWziCA3eg==
X-Received: by 2002:ac8:7d14:0:b0:517:61d5:2f7b with SMTP id d75a77b69052e-51c8b4d596amr63974501cf.56.1783595582885;
        Thu, 09 Jul 2026 04:13:02 -0700 (PDT)
X-Received: by 2002:ac8:7d14:0:b0:517:61d5:2f7b with SMTP id d75a77b69052e-51c8b4d596amr63973951cf.56.1783595582395;
        Thu, 09 Jul 2026 04:13:02 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0f213e8sm48543085f8f.34.2026.07.09.04.12.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 04:13:01 -0700 (PDT)
Message-ID: <835e2f62-3b66-45d4-a614-dc2198a715ad@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 13:12:57 +0200
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
Subject: Re: [patch 01/18] powerpc: Move stack randomization after
 syscall_enter_from_user_mode()
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
 <20260707190253.718191130@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260707190253.718191130@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDEwOCBTYWx0ZWRfX0f0GqQladXo/
 KYHMcYBzjeYAAOv7fSKDqqYgj0Y3x1FE86hHrR2+O3SYYkuvfJOE9lCc1VFABGzriy5xHtusBYU
 uLHyuxKU8LdH+w1n5Mg9+wO656f83CY=
X-Proofpoint-GUID: wteAD99PIEytwFIzg1XJeiTiGwtwVrM-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDEwOCBTYWx0ZWRfX3qrAh7wQy4AC
 zAU8QqmpIyLvp3aqmLQ48JvxDlBHbcitvIYS+px9BHUkSXXisrdVw0A2nIzJtHV5GEt8/BirADx
 B0sFxMqOrqDIPge0AfJYx1X1jFhX/VKkhUQIp7fRyhFLaK+TxhfR4ycQg4sjBAIfHGXO6neCi5G
 yPtDsiVRc6qmE6ftRlHS23NDYz4HzKRp3CLNij0xW1NnFQb+3SQigv5SwrZEWLeJBFYG8mD9uvj
 bqXSkIhuViNfEygGj0GhNWxjl5S3rRcaqO5RXP+JBTw4srOGaAayEkX0gfqql4phg0v2YIvem2L
 5Xg1U+XNe4L+gHXmlXnYAYOWq+3mnHsxZ56cCs4gyJlGrKwADrzZI0CtG+9dUWRqKKv+5CDkNSM
 jnLs0WDR/KJzRP3rapM6VcBIhbDZbHDfTgmBEvUMp6bzmQAwlYES30YVvLTm8WW8ZgpF9Zwfwfo
 H3s9rV5BmFwlAKi7PrQ==
X-Authority-Analysis: v=2.4 cv=Sv2gLvO0 c=1 sm=1 tr=0 ts=6a4f823f cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=voM4FWlXAAAA:8 a=EUspDBNiAAAA:8
 a=63ny2n9c4_t8xnV3ltYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-ORIG-GUID: wteAD99PIEytwFIzg1XJeiTiGwtwVrM-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_02,2026-07-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090108

On 7/7/26 21:05, Thomas Gleixner wrote:
> add_random_kstack_offset() is invoked before syscall_enter_from_user_mode()
> establishes state. That's wrong because add_random_kstack_offset() calls
> into instrumentable code.
> 
> Move it after syscall_enter_from_user_mode() to ensure that state is
> correctly established.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> ---
>   arch/powerpc/kernel/syscall.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/arch/powerpc/kernel/syscall.c
> +++ b/arch/powerpc/kernel/syscall.c
> @@ -19,8 +19,8 @@ notrace long system_call_exception(struc
>   	long ret;
>   	syscall_fn f;
>   
> -	add_random_kstack_offset();
>   	r0 = syscall_enter_from_user_mode(regs, r0);
> +	add_random_kstack_offset();
>   
>   	if (unlikely(r0 >= NR_syscalls)) {
>   		if (unlikely(trap_is_unsupported_scv(regs))) {
> 
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

