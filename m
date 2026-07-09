Return-Path: <linuxppc-dev+bounces-23931-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 364CCC44507
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2026 11:17:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwsqc5MYVz3cJr;
	Thu, 09 Jul 2026 21:17:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783595820;
	cv=none; b=P2BJkTF90trSAD2qtsQLFeol+pQDJNvkjPn/5omu9dnwnhNfEgRs3PDSEP427rZAhypF0ug6iTS1a/AeFDyBG5bzYLIoJGN+oVyF/1E5j75QagfyDwpfH5f1Kvwg9F0ANaT1J68Wn+5mMCfwexYMMe1r9uysHWtQ/hfqLHpOeI2/XfyagtO5PE0ytpxpBLCqphMGZDhS66EgMRp9T1yes6nrXvVF3AVLKyZQbUPmmZkjAIHUK1xFBHajtDKtv9XzMnm8JlyUEJy9QMMeyA4o/DzKUrVbGQsEMS8UeFuzo/JX0Yz20eQRvJHm+HmIapT5y/C3hk+ieonFm0SArBiHww==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783595820; c=relaxed/relaxed;
	bh=OP+BLCmg7XOu9OIoY1nTg278DC95imbUOhUvbiFMd6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S5ykOQCjazhRtwOO4E6E8FFNxpT9YC/agJOSKyPFG23sdsDrXIMYuln9A61y1J8oAxw/SSFoFvoEBHxt9atL0V9HneGXnWNVkXfxolFae8k+SXvwO//GlCUTQ7ylkgVTGPTWL5iZE9gDL5d+dBdROUYSZCbsGhidvnpQCGxdjUjA3ZG0AmSP07CjCI7puLzQLWh8geyQTAPZ6UR5MzbUrLxK6vCXbY6QLLRDRtwvT4M97Nil1IDRq/xiFP4QEw9rCB7e9BkP0evyqa8HdELt9tzASuCjE0Q2P+msmcrmlBk79ZTwd89WrAve8aIufYBqfRunTt/Od00SRhnHVPUfCg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bZBcJAam; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NjvRaNSr; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=philmd@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bZBcJAam;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NjvRaNSr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=philmd@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwsqZ6vmyz3cJl
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 21:16:58 +1000 (AEST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669Awttq1614070
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Jul 2026 11:16:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OP+BLCmg7XOu9OIoY1nTg278DC95imbUOhUvbiFMd6M=; b=bZBcJAam+ibbXFwx
	fYme4cr8sBqjGZ8/bhY813m3zZdemgRcv+ZZn5hEkMKaS7vw0Lsk0C+lZaMW/4N7
	48Ti3b9W5djrMW6C6sRvr/fRMwvlr3Xwdk0O8mST92o98b2JRkz34WzfXmdlRdyc
	+GNzKHdNyJRx4XFA9Y/FW2dL+68kjj0jsC9rEzLvB9U2wtPREHvCZncHnjBH0nco
	DqfIf8EOVkC/PQXn3R9FFwNfO+c4fAiAxBDB9r3vKIUe0k0qjSg4thZ00H8jr+97
	7VzXtBysfy4u+kGoa711kKXXJoacuD/Fbabaj49b91/ZVeI4dz7AgvccLaeW9YDn
	oHnuIA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fa418hsw6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 11:16:56 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c2af04aeeso10817471cf.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 04:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783595816; x=1784200616; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OP+BLCmg7XOu9OIoY1nTg278DC95imbUOhUvbiFMd6M=;
        b=NjvRaNSr2CgoylwDrydWvGTb9AUbE9WipLh6PTR3Q/iHefX+VRSPZNxdYUAr3qmDuw
         jteutPETigX97gylO82UWcV27oQB87TjMfVLtEw0NZ7IXsBINX/FHp3WLK+pe1cjqMeS
         Sz8uqbYvskvshWe9Jhri+5CkGatyt6ojdVbzipxkinhWkHV7WybWPH6QfLfhOU17k0Eo
         r46rImQeYaeiDLnuoMJB5cShadrzKsi9+dxv94AnZUSalE/k7w2jg3QdQFISFJeidzLE
         b3Kj5Zvm1XyR8uqeP80nDxrhQDvjfp9PrGMmDBXAQawoSaBQDNp6z2Hei6FE0UUb49Lq
         ysvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783595816; x=1784200616;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OP+BLCmg7XOu9OIoY1nTg278DC95imbUOhUvbiFMd6M=;
        b=f8V/QhwqhEgvo72Xvcq81B588exL+rJHACdgBq4CQieWcEVoLkxOx/m7SQgTMLjmXx
         ZB83D/eJFqtHXlViA+hYEfN3k4dAzFhlksZvnd/fZvAICmbQAque7fUTw1mgdt5sKl9D
         o1oG5y2SzYK3p4nTN4PzEsB6prqiA2fc724DrNAAh8aAXIDjPkeWrhoJ9wiU+SPxTOIt
         Vbblh1mqN4IijpDWQ7amyCWE7TG2wbyJSsVYeti5Ef1CQS8fdv3siMYOVRlVNhNNnDtt
         vPq4zpBVEFFUnoU6pk/tNauJgpVkLzL4bcYRiZ30saE4zo8sjkg5ND1z/YHw/JR5E9wm
         joBQ==
X-Forwarded-Encrypted: i=1; AHgh+RrphdqOlzptxn77ZQSy3fbl1qtq+MWju+Laex6J3DYnUZ+1N66aosP92NoRZyZ1LMB4z+aEPmKDaV+4EaI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz3ilD0BMJJ+72UeA8IF69Lh7D7qDvl+RUbvJ6HjvMiyaJ7bIfn
	2YsLImyR1iZJ90opxpONwqRlPWSa3BWHcOiOgrKT676mfXaxpOOgbYUonkSHRKPp5bn5VXQ3fo/
	Eae1uUd47ygC7iNL3o1MPckaGm3vOfDjeHdkigWWcWD2rz7fJyyzZ7nkvd3Uu30kOhsp0
X-Gm-Gg: AfdE7ckNKt64cgSZNLSSVpyjjPkQBb1UGCNL9fk7coL28d2tTNdVotuLOlr7tnXQyV7
	PaT7dSdZvfdYVTjgFCzyeNDLtp0skcbrZTZ2r4XFyDVyfm4eoaMAxYm3KdJnBd53hfwYOoEJFgv
	Ck0VFPR4W/yfVD5xriZy0IbvoggZMT2Qb++coQ+TjugzKbQgYaiCmdaFppVnUr88mbCjvk4Hm8K
	+URbTaOrbZ3xD9NGqNXymSXzu3+uHZMERUwcgXWKmBSJbJmnC0ToVpneJbqpg9E56fCVFJCpV4O
	Wvc9SfxOAqQ2NRb7aHbT56hOmcsbTtW2y0jn+8B0SOTw1sbhUidbyXPPY/EwHllK2sIAeimZVPW
	5k21k7oL63f2Dh4MeVv6xvcpRU+JFNOS9uL4ZQTuY3o9XeWeEN8TnKxkVoXZTqQ==
X-Received: by 2002:a05:622a:1cce:b0:51c:558:cbbd with SMTP id d75a77b69052e-51c9ba21545mr21236621cf.41.1783595815673;
        Thu, 09 Jul 2026 04:16:55 -0700 (PDT)
X-Received: by 2002:a05:622a:1cce:b0:51c:558:cbbd with SMTP id d75a77b69052e-51c9ba21545mr21236071cf.41.1783595815288;
        Thu, 09 Jul 2026 04:16:55 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d8410sm51612968f8f.15.2026.07.09.04.16.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 04:16:54 -0700 (PDT)
Message-ID: <b2ca1416-e2c1-46ac-8a26-ce671c76883f@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 13:16:51 +0200
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
Subject: Re: [patch 06/18] riscv/syscall: Use
 syscall_enter_from_user_mode_randomize_stack()
Content-Language: en-US
To: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Paul Walmsley <pjw@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Kees Cook <kees@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
        loongarch@lists.linux.dev, Sven Schnelle <svens@linux.ibm.com>,
        linux-s390@vger.kernel.org, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
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
 <20260707190253.974626922@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260707190253.974626922@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=UI3t2ify c=1 sm=1 tr=0 ts=6a4f8328 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=_O3DOGVWAAAA:8 a=JfrnYn6hAAAA:8 a=EUspDBNiAAAA:8
 a=DoJJhcVa48uSEvU2-xUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=2TKV-7w1aU1AVAwN0oqT:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDEwOCBTYWx0ZWRfX/7NJDpwZuBpQ
 bd+ToZ2zMDnuqxv0rT+0a8Gi1Eg6AQtGbLLZqeUlrAEU39vlW5cgBR2b7g6gnpqWELO55lt8gc3
 0i8KUAH5Zuzm7HRmxnG4z36Pu7LiNhWYiHQ8ibeotaaQGPHV7akQHGWAlVRf1v8zGIPeQDoImtB
 awMUqEmthet9T/FbiU1AwkzoJxl+3sZXaJVUaIyjS4TftWM2qwCORcWL0c5WEMx17M7FoK1+F2J
 Qp2fGJdRsc8jf8OupctEdrS95N49sjOkqj2vEnq/XL8oLGzBoRh9JixNv6Sfs0Joo8m80gfXeWp
 mHDS2xZuvj63x7zuhdiMBtn+tDC7HlMnr6qstelC/Yi1Un9aGIq8X+ND+JvObIQHRPX3UFhlKCM
 oysEJ98UFFJ+FUMrKbBVyQXvNOjJfFlMnsuzq3Rxj697qutHEbT3COKJWSTXB+7B8w8+tnxI/qb
 g7VVQ6kvqywG2hqMLpw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDEwOCBTYWx0ZWRfX1hB0UW2uFAlk
 jXFBIQkovnc47JBbcQp95P0K9zN9eDmtPAjR+X0ReF/GnE1Mmyw/Q32W3rMZapsEmCYR8UB6IWG
 RprUgnVy0nEsvFwoiT2lS2524/W7xpQ=
X-Proofpoint-GUID: bJeZtTyl2T-dRYjVq9yFk-H4tuT5uXyl
X-Proofpoint-ORIG-GUID: bJeZtTyl2T-dRYjVq9yFk-H4tuT5uXyl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_02,2026-07-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090108

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
> Cc: Paul Walmsley <pjw@kernel.org>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: linux-riscv@lists.infradead.org
> ---
>   arch/riscv/kernel/traps.c |    5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

