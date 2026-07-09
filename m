Return-Path: <linuxppc-dev+bounces-23929-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 471CBC44507
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2026 11:16:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwspW5hNFz3brM;
	Thu, 09 Jul 2026 21:16:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783595763;
	cv=none; b=n96N0FryZ1FxWIfirilHL+Sj+/c6kpzaZDPi1Rv4gU6L0k0Lx6/LUw8S9W9iW57TALyU+gs5Y2InJeKfUgXuycueqgCNs/12oBZ06658z91FQw/VdFpxvQ9OZvZN+K6sk5SasPTc6OHojnJxeWuDc45LKP7u7rZD5bhDfHPsmIPqIzcm89X+SDLyEnMQmZ73Ytt708bu0oMXBHi3iiRAisGUoblIqIgGFdRp7DNnL9TxjXh52z6yvJTUdowy45qzoJnIbKg1PhAZKvpZsx0YAPi4QO/4wYp2bSxFLI7h3S6p1PGB6NKd6NNBAI89nlovyga8NoxgjTwP4M94Lq77dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783595763; c=relaxed/relaxed;
	bh=Y/QNMVWz2zbU62zSNYrI+1kG+0GMg+VxTcjcEiOFHtg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F1bu1zYizkGgeNLc43Cb8JN0HNIyRASSeEXzOqEvGECqNgZ5qrnWpBrMHE22zqWIwV/mrfBRcpHZS89yjX7JrnipzmefgroU5ZMBTAXNtqnChdOk9QUTSe9OJKm4bSU0ns7Ej2ZeBUGE6exrpEyDWUfajyZh30r7tsWqgcpGmv2FFdXdEKcQrV6j7pOvCe/Jhx3rRfxeldsm342D/dobYta3OrpxZ/CkvYZ+FWQdChU4BbCHT4N4kAxpfiTaAwZkKggK/LVJpfKoIJD3/pwqHDEgu9TRTSnf4hY7w5fmAHXQuVbCYfBhRTnsefeu26EurQU08ecpgDgnJ+GmIO5XiA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ULLpdAqj; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Hvlu5Ga0; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=philmd@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ULLpdAqj;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Hvlu5Ga0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=philmd@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwspV59qBz2xJT
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 21:16:02 +1000 (AEST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669Ax57N1570841
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Jul 2026 11:15:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Y/QNMVWz2zbU62zSNYrI+1kG+0GMg+VxTcjcEiOFHtg=; b=ULLpdAqjhcPbhl+a
	9wkFVF2/lY0nTNUibaezE3oRQ6lteQ4HDVcOfqHDE7vtflCsPuubuaBt22suHv5C
	J/GboNexxusvk46SeLD4YSCgJibhGpTyBp7Ew2CmZmE5Kc85FL5xmUGbwX2SNRRm
	AUKTk+C5LBwuGwFJB3/1RH6SX3HPCEtPeI30OoMKGubID5ux/F8g5HbF1COPW79s
	OzhxWi76MMCFcorNKYBBg01ItlLF46P4rAQRFOMzzGhz1/Bz8zCwIh87EUtM9Vze
	DADpxILacbIASbBx5FZNfW6HGEmYrVnOynweeKBYk1Yd0I8v8nqfQQ/58XsDZx94
	8Wm00w==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9rq348jp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 11:15:59 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c1852a86fso11474351cf.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 04:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783595759; x=1784200559; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y/QNMVWz2zbU62zSNYrI+1kG+0GMg+VxTcjcEiOFHtg=;
        b=Hvlu5Ga0Xjn0ArmkVY0WfNncizADGueBJ57zraONZxloB4AhTRISzdJK5vDVfM7DfF
         PNaWNREPmvlAt01fTOMtFKu3ioIji2eOTAPq/RzwxtZZsXgTm/+xt986Kr9F9x2XO622
         8SuqVXtJjB32h7+IzsZI7HqjMqljsOv0BjmjitzeS2VAHVJmhc+nDpC97ncfFlcSx2jR
         KhLrqTTmEfJ+DxKzch1q1vEWupBTSjU8R1hJQhjI+NqPzaC0d3QF5pon6chSG+FQ3lYP
         TsYJbS5madc9I2MbRT59XOO8MSqfPeCm84TKM7iWXtWq9cWPAeZO8yS2nkriV5SuUGAr
         BGBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783595759; x=1784200559;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y/QNMVWz2zbU62zSNYrI+1kG+0GMg+VxTcjcEiOFHtg=;
        b=KkRr9KuJWAin/CWwL22zB3PwCJxPRQIRd1Swbb9wQT9fZdTU/b18pab4iIGk2vg8ZP
         01DXtQ6wdSNK+UCv4dihE2Wfl1Hp/80q8NjLCC7lpatnwjk1srO0eOrhHXmYnDGfwLwZ
         e8u9G7f7lp1As79CQZ1OSA/RZ9fr6SpkDl5mSto4ZC6BXO8cT6aiLY+Ou1BFmkQ+Mu6A
         O9168/ABfgKa73OOxXP6rx5PGol5yLwABWxAzVdM7AOdbJdJQEzpfzBtnhlmQLFuJ/ZM
         95TidTtUHA0LmxhnIIWEECiB/8TRZMydnXxlIHvi1eNVPb4m//1zmo5b0tCmpoNx67/j
         nsUw==
X-Forwarded-Encrypted: i=1; AHgh+Rqoy6CDaYw0vIpS0wrp1sY6bb9IRpvoyZUGB0c/zzGrEfOI9A8dssxHt6r13YacTb6TlH3ZgSlAxpAbKVU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzZQAbFnlXUJkn+3CTiIqq4TimNWbFl2EJJhGxW2HUxisP8y3eN
	EGTzILSOey05TDjZXHzN/g1P6+XpikNHH9sXBTU/79u13JjCVo8xwl+tLGOsI9bGbh5VtoXe/IE
	Y2A6lOlMg3NeA7JtiKG3HcJFyxTuBJyWoTMmRJHYYMBqoseGdn4lJlmVEJEvN38VmBlup
X-Gm-Gg: AfdE7ckO9VmaVBPDceXp9tJSm4EkZrBwYK1UcUxrv+McTAPeTCh8GwQKZ382/pZar4y
	GxohMR1Cwk1gBfXRzv7fOsXX+nhw0DBXPIpyNUMkrk1IZp8oc5nNcqVHRPelKHvKH19SHyNPqmj
	sHVwBxDoDO57ZmTjoQ/aM/4EH+K0d56QpKJnC6uZ05gCmkUMdtHfZpuaT/rhqhc1F6xY+Gw7fcI
	itzl2PFt74QalPqjMH0B1jHVejvE9LOO6ZXUI2cWzWGKHt4tv24d6SUiqcuK/QgYyb/YtVQj450
	i0A8+UEyOZVBXeONeLeffNPjwJdlHdarBcThqgJTnFySSQi0kWjGB740G0xEcgER1l32MVHhdLv
	MhqTuZ0b1xYJs7yoc9BJmTld8iQ1tMtbqnyleJKmHSXxSIKp6EKdVfHBgC5xPgQ==
X-Received: by 2002:a05:622a:1113:b0:51c:1b3d:fe62 with SMTP id d75a77b69052e-51c8b2dbe87mr68191441cf.28.1783595759077;
        Thu, 09 Jul 2026 04:15:59 -0700 (PDT)
X-Received: by 2002:a05:622a:1113:b0:51c:1b3d:fe62 with SMTP id d75a77b69052e-51c8b2dbe87mr68191231cf.28.1783595758685;
        Thu, 09 Jul 2026 04:15:58 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa039b126sm50274140f8f.24.2026.07.09.04.15.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 04:15:57 -0700 (PDT)
Message-ID: <cf26fe68-5a8d-4d6e-b9f9-d69faa8a6012@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 13:15:55 +0200
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
Subject: Re: [patch 04/18] loongarch/syscall: Use
 syscall_enter_from_user_mode_randomize_stack()
Content-Language: en-US
To: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Huacai Chen
 <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
        Michael Ellerman <mpe@ellerman.id.au>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Kees Cook <kees@kernel.org>, Paul Walmsley <pjw@kernel.org>,
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
 <20260707190253.865955911@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260707190253.865955911@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: kO1HfRp0hpbwOIVjRZ_JYIAKRUsfhslq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDEwOCBTYWx0ZWRfXwrw0fp+RUfGH
 YztSgsBZ8usFhoQHij/7g5JulnUhCsZHPUUXxE4jyWj5rjWxq5cEEaMlzoIIWovGcEWlXKSCARM
 n03rMw5GS1RBxR60SDjQhgyjSSmlW6KmKT/UhLqS0Oap6p2omu3CAw1ZHyWUBCGGSajdQMWqoV/
 VS55oCPdoWFU1iojoXrT94wMHVa7R286uAtiHNppg+jgE7HEGwq9Agpio3w+kYXTFL7/WJyrGh7
 Aaz8+8GD76vErqd+AhV/aRqRgVXUH0yAKKSU8FyNXHEy/K2tkcDLYS5KSWOmODBXrlif0uFCZAy
 Svu5Z5Z7CJb+4ecib+WNUdzfbH7ol5DaGHKxH0LIxolDoZ/NdEuICndoeWerlk5UU+yiS/S4Z1K
 u/N93U9nPaKeWq6RT6TnvVaHggPd4esarZ/+LmLNvCXIY1QgOzilsPyp8D93tDFLaGmLhgLpBuI
 JIJxKEciM5Rmhqh5pIQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDEwOCBTYWx0ZWRfX93a8aPCKvVnL
 ewsOHQTcBlB4Ft31z486lCQ4dfDkK/MuelWFTIeF3tLeGGLf6yvnVUOVRA9iTu9B8peco47rej3
 703B4hFdxoyo1Th/WVZt9ir0WfsCBGc=
X-Authority-Analysis: v=2.4 cv=PYPPQChd c=1 sm=1 tr=0 ts=6a4f82ef cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=DoJJhcVa48uSEvU2-xUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: kO1HfRp0hpbwOIVjRZ_JYIAKRUsfhslq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_02,2026-07-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607090108

On 7/7/26 21:06, Thomas Gleixner wrote:
> syscall_enter_from_user_mode_randomize_stack() replaces
> syscall_enter_from_user_mode() and the subsequent invocation of
> add_random_kstack_offset().
> 
> The advantage is that it applies the stack randomization right after
> enter_from_user_mode() and thereby avoids the overhead of get/put_cpu_var()
> as that code is invoked with interrupts disabled.
> 
> No functional change.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: loongarch@lists.linux.dev
> ---
>   arch/loongarch/kernel/syscall.c |    5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


