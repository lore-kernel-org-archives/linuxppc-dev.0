Return-Path: <linuxppc-dev+bounces-23933-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F927C44501
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2026 11:18:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwss55xDNz3cDd;
	Thu, 09 Jul 2026 21:18:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783595897;
	cv=none; b=V+S2zq37hMHOzmEyEYO+4QDUHP2p0+yR8icjL+NzDxsqrR746tjbbdBmjVoV82tg67VLSmvwYQfDgHh1GW2gt6HvAJZo8vzD7yyf428oD4elKeD5MaNk1NKBDrKB5UF7vlibVnMPQlxrPlFBQ8nvdTSCovnZBVnLHMECB14nNNcue7t8YxvOokitLm457l9Nmj7EDqmEXW0vY7M8IkN+u9XbKAMzODVTEOvwxomtVEmteN7zBdFQDCftpJ6hLHXfd7g011rggyvnmimr7bYLfBwphbPtbMz/8wYKbguIrXVENJiBlmjk+xAX68FkTEPH4dgNYU8ovreiCCCb0Rm3/g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783595897; c=relaxed/relaxed;
	bh=vihb0TqYNakYFNkvFgdqTcLu+5oolASwgMBC4TOzm2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nc5FdzH7lTFSZy3yJFkXfGHvruAgX4TflJ7ETUv+R3RIeYS7Cfj9qAVO0uLZMgrJBhygfhApWi5zaoc1EykSTIslsywpuM5j9Xhtd0bQ4eQpCZgkTJUaqADP3ZEtDVU8ghX3wEUg5RgmLyv6iu9TXrAN0dt7Ml7cT/UP4Ol0Vj87k+/aw31t9rjR8R5WLVP40p/8GoIpvG5s24ch4ttsxCoibG9QYzUj1UgpstotRKe0K7bTVGStdOPQRT8FhfcUVEm6NICD7UEjfaBmAMu5XYOoKAB+aOtMv6MlocTmuU9re4iCRHnlm3+1Gyze933j+bkzU9oIi7N33VA5kN2IAA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fyY0pNu1; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=E3Ce2nx8; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=philmd@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fyY0pNu1;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=E3Ce2nx8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=philmd@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwss44md4z3c6f
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 21:18:15 +1000 (AEST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669AxfrR1614613
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Jul 2026 11:18:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vihb0TqYNakYFNkvFgdqTcLu+5oolASwgMBC4TOzm2s=; b=fyY0pNu1SYakkEnc
	jiua1Bz59Z/HxTO6ZZj7/6VoWVtUtY1ICmo9H1Pd2QjrZWC8gJfOm9T5qkA9XEc9
	zZ/LvhTR9YL1D4FRKeeUPeBJzIH2ig7MkQc5n0wn0ncq5EOUUpyCj9xucWrHafNA
	Mhaf5VX3wvgWTqgyvze8xNYS1i224SoOljNif2MkoC4501PXlkZEU2tlj13tOCVF
	k1OcXw5rO9V9U6F4nqjFTDFlr4SsHrosvOnlojjBDdlvWI+//0MRkxof7+sUSdLM
	DMKQPcPOu2w9XU1PRa+80kn2vAWE27oY8QNhmoRslamfrHh0e5dTRzAtOzXXQfwX
	yQEHaQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9ug6kdv4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 11:18:13 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51a87ef9713so8501741cf.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 04:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783595889; x=1784200689; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vihb0TqYNakYFNkvFgdqTcLu+5oolASwgMBC4TOzm2s=;
        b=E3Ce2nx83zam17tw1Ae8KniAFxhAkAreKxWE6mb076lFyt7CygV0t8UvT0yPhSrIMX
         +T25IWcliY+fENEQ8i4cKVve/AUjBCEQnHS1FVqQZDbJky46s9DD1eG0sfsmLzL6Uxot
         b/9rdGCIE5TWmkKCx9Lzo4WVdVFeHBu3ztl7483Ih/CbaeNbOE2LF5xc95DUSv2NTvaR
         PTI1JJRi3niaUFnsAlTGfVpIGlD20P0qpsrMEiJr7ylyreTb74LoNa566SPxpKIY2Gsy
         XlPmYpufA9SQAsr+T8GP+ZTkcbwcW20MWPPDZt6ka/7NY2oli1kVR62CzRNwPn88MZ1N
         M+0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783595889; x=1784200689;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vihb0TqYNakYFNkvFgdqTcLu+5oolASwgMBC4TOzm2s=;
        b=DtzNuVVGOHpjannhfQo1RV8xiMYWvBlSaZZhvXhmQe0zkxVaWQ+gbRt7FXYEkbj/9d
         imSMqoAZSfMrGTmXic906IJZqQTvkyUjkRIrSQW3P8DJtQjC2V2JBAse4OetGezPUWbc
         xo3THkRTJx97KYA7XnYm0vQEd4YJrMPR2ZYiw2LhdW6EwvM0Gfr7tZsqxid7IxSay1Nv
         4XA/huV9BXkEDp7GQz8h6gn4qptEnuxsVxej/t8jkcDFaFe/C4YuiHF/1spkAQ1qR9fH
         woV6eCoAd07i6ukKadBAEj6F68qWS2zgl7reqzz4kgzCgmOtO+D0tO5GlFLKn1nOCzjw
         +8zg==
X-Forwarded-Encrypted: i=1; AHgh+RrSLVDLqSTgEl+Hy8sypiDpVr6YdTZt9Enp8IE95bnnmf0+pAI/ziou5nP90nfkIqiUUK7NZsok5Q/hCPg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxXbHxlDFQd8Qv6O28Vc+umat4DfACAIHLxxCwomJ82MLekcGz/
	kOqPmm5oaxyVyOShmNtJjIPd4jVFKpvaKWmXg7LRSI0U3gQ6BZW9D6zkoxIPEdqpGC+09lSiLKU
	/Eu9IuEU53Whhkxdq78R1tsHIkaXowSoQ5J8txNOS7dT9I5GzTPsUozVrwdXx8ll1ap97
X-Gm-Gg: AfdE7clyHppoNfBc+BErTRoXis/dEfzCaU5gbUsu17qtqiy7SjE2f46zQu4qkAlkJXP
	2D5JqILTQW5IrNO7vwfLEJSu4VWIOefvJ/x28Zhjy6aMSCUk8C+jgoLhxfwFaIvbkwdciabFjx4
	yc8JgOd4dUNod9hGCrWnhM9+3v7FNGkLSJYrmAUe7UH484xwOYCl0Ucc2QWhOZDFRouTvaieYLz
	Vd9aLxKgXhXafY0PlI2UX2XQ/X+jAQrewZqLG3Wb7OYQNNG0NbQXHUDS26r3ytMWYrF/PvXTG7N
	rPTxQL2hhrihLvSczTIRNodIH+2nsoYmXKCSFj93buW2JUGbRB8uqcwgzlf2K5A11ZqsofCpOd/
	S/JUWuZSlI4uVj1sOyMIBmBj6V+w5UDJ+QKMt5onh1/LB7BAgvmSAaAbTaIey9w==
X-Received: by 2002:ac8:5d06:0:b0:51c:98f:f282 with SMTP id d75a77b69052e-51c9b9c9812mr22454201cf.27.1783595888700;
        Thu, 09 Jul 2026 04:18:08 -0700 (PDT)
X-Received: by 2002:ac8:5d06:0:b0:51c:98f:f282 with SMTP id d75a77b69052e-51c9b9c9812mr22453591cf.27.1783595888214;
        Thu, 09 Jul 2026 04:18:08 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6d53absm53036115e9.6.2026.07.09.04.18.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 04:18:07 -0700 (PDT)
Message-ID: <e89995a7-0da5-4581-bce0-5dafc377e9b9@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 13:18:04 +0200
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
Subject: Re: [patch 08/18] x86/syscall: Use
 [syscall_]enter_from_user_mode_randomize_stack()
Content-Language: en-US
To: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Kees Cook <kees@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
        loongarch@lists.linux.dev, Paul Walmsley <pjw@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
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
 <20260707190254.079478122@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260707190254.079478122@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDEwOCBTYWx0ZWRfXyQgbaorzkb4s
 MFFepIS1tgtTK3q7R9GXHKpxZU+KJlAJJV/oOzWsdhptTMNM3r5GKjwg4Qz6rpMN+CvQjhT7ilW
 hpOwn8p0GzmYerQQs2dMEA/uqBIQpJw=
X-Proofpoint-GUID: 4V_1W9Iucxwsm-tzIsL1LNOWjWdXQVfF
X-Authority-Analysis: v=2.4 cv=cL3QdFeN c=1 sm=1 tr=0 ts=6a4f8375 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=wOAZ5We2mjvvK_q5lLMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: 4V_1W9Iucxwsm-tzIsL1LNOWjWdXQVfF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDEwOCBTYWx0ZWRfX/KnkTuUnU6dL
 Qd5111g/1G8yg8jpsjzpC8PAXqCQeEaWyGfiJmZlrSxaiyLRFkjs1aUC1nLN22PaF0La+PaWOok
 6iuq5cM2ROLYv5oBKO6mh/K/frCZAyX0XuPCX9WAe8Pv0P8M8x6GWRTrF1rrx5AuJBZ3VaunNQR
 WDi1rQWjFzkSpKT+SGpU5j1Rtu5uWIvtEwlgJhLe6eGGLdPbWnLo1xfveT7XdeTxLrmDiQCwVWF
 W82tC41gN7iBzI7h0s/A9uPmgf0zSr//f5iTtf9J3TIgvfvo+JC1kMEHgYp7DupjDAYyCZZfCVz
 vI1PGKbYoeYtO6EokNoljKHVKQP7i5CoCeyx3UeYcb1069DTmGCJfOZKPdObWCcQ1cRk8aosi9H
 uM9mjvzsxRloE+t9w2o+U99iJpLuJZyqO94zxldGIIxmblelDvxsw7HgCDAoGej2Oh9PIgNbunG
 +RrOcrEfvmQ7bKTIoDg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_02,2026-07-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090108

On 7/7/26 21:06, Thomas Gleixner wrote:
> These functions integrate the stack randomization.
> 
> syscall_enter_from_user_mode_randomize_stack() has the advantage that the
> randomization happens early right after enter_from_user_mode().
> 
> In both cases also the overhead of get/put_cpu_var() in
> add_random_kstack_offset() is avoided.
> 
> No functional change.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: x86@kernel.org
> ---
>   arch/x86/entry/syscall_32.c         |   19 +++++--------------
>   arch/x86/entry/syscall_64.c         |    3 +--
>   arch/x86/include/asm/entry-common.h |    1 -
>   3 files changed, 6 insertions(+), 17 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

