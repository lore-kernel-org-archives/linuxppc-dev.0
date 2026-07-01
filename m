Return-Path: <linuxppc-dev+bounces-23305-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C80FC43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jul 2026 12:23:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqzgy03b6z2yYq;
	Wed, 01 Jul 2026 22:23:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782892301;
	cv=none; b=V0X7TnAMNHhHHVWSEfqY3I1/T/79MF8WaoKk23LzhYaaYFrDs2l8ZrfI/ESV+jgocMXMwN7Db4FDOfK8VLEGUEljmPDosL5oNnRhpso5FDWV/v+5wrBYoVzG08v06Xujs1J94/8GNoO3RTVQU+xZonW52LxriQqxsxWKe7aXB5asQe7A39y/gFCOrtL+yIQRkrkkUlh37unPvGtC29ee3TbicWm/zRm6+BF4c8eNj4HUzKeQj0H7Goun+x9d+4iQpuOkoPjV8sq9lPyY/Asmgd37kQtsI5YTyVOr8KI84yqmtRGzQku32ChMBD0ENQHJEPH7ndxD8lzZ9LionEGDNw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782892301; c=relaxed/relaxed;
	bh=T5Hajlt0GSOifEEgLYuCorRENs6/gAytzHqsua8a2iM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DbznJ2CLnyCtSlGYvcZNhE1O4heqt9kkKbW/DwQoYdWWbSku4jo7E6wB7jeH8Hi09lyjqTc4qpn14LH+YBY/xoWyyNT5NSjfM8pjk4uD2FkRTGsJIRiNHPEOwO+JJHeOPLlxMl30w3v9Nj8K1pFZnAVkYSstEa2WxjUXpHMYdRscYSldpnVrf7Fd5ILySqVgkHAY5sUBd/yyk/ZshN34Qp4ic+O8TRW3wIX2h59WmqmajH6SS30eIMzONsglms5hTO/5YR0vhCpADykgipMbLk9o9RIy2ji4f/jxMseyWY6yYJI0wV4SM7YamJXC6LPrZPfATEP1Ecdpnvktf5iavA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CHrmkNT/; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jrzQss3y; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=philmd@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CHrmkNT/;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jrzQss3y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=philmd@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqsfN4TdLz2xHK
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 17:51:40 +1000 (AEST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6615lWKZ066024
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Jul 2026 07:51:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	T5Hajlt0GSOifEEgLYuCorRENs6/gAytzHqsua8a2iM=; b=CHrmkNT/8n82uDku
	5W/oxi04FrcTejUH736a5SP/Dy+IdwMaKBBx4VlX/kzWSVybP0ERM9fwN3EW28be
	nxp8N4flgNS8xHjUTYPB0hTXFaFH0K3VbYIjfdwVSGYa/kU2s/6l6B4vn/4eD77n
	8CN7VAuJMdRMXbZ1MI2Ql1w4vPnltoAe7CUmD/W7PdPwfFcnNFXzV9SXm2tbEaRU
	9U6CncWN1oDCGNXO3xt8q4o/xS5QJ3DTPoUXCms7wc9lreP4eMDOBSVgUt+BUGSN
	FY9IflqNWjSL0RY00wl2hBKCFMky8dE0xbgHmdI2nti6WFzd0HvmcwxhMCHOFHDv
	DFT4ag==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4jtqk0mh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 07:51:38 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92e623b0e95so37829985a.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 00:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782892297; x=1783497097; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T5Hajlt0GSOifEEgLYuCorRENs6/gAytzHqsua8a2iM=;
        b=jrzQss3ytEuuu4OUFfNP8guGSEiKlUIlTU1Cha/MOyy302md1j9omz+AYcw+a3hgxA
         8hhqhCUH3YSsn5z6NvLHhwrDVLy1lAMmWVB++HjOItORLPiWeioP+xMN1oMISvZBTiQD
         vWn41MgizBfAo4psebij7D3A59ca1GMjihFC/eiweNZHej1eWENwvS/sOUu4qsrw36DQ
         4yQzlXinOPTtPtms+LUHI1V6wk/df3VdONpC1gpeQabOtp4XDvWj6rINdDkaQ490BL6y
         XpSr/aL/SIM2A1C3xz6VbY/JtABqUpMW9NuD2J3zRS7VAPsNrAun9KWdxTfFvBvtT26P
         gybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782892297; x=1783497097;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T5Hajlt0GSOifEEgLYuCorRENs6/gAytzHqsua8a2iM=;
        b=lq3V0Q3G8Oa+FOFFeHpXjN1ujfKjmff0YGYP43DqvwUDEKkMuBb8Gmeff8H+G52GCc
         xUAwCrMqxzkf4fofVajjVFVaQFC4DIUAbdsEwxUqMyprbeddq/m48iev3I9rpDry4kfv
         UUvS/X8LAeHRbyQdi4wSSBKlJXqSwCnEO5IMU++/oJQc4u140EF5cHppBoDNZ/Id6FGa
         eWNss7hoouZemC4UgOPq+qd1g1tbC30gtEQEYMsDOrvlh0LsW1qwMnNCyr7+qP/sGwjf
         27gxJo09Q/qtkpt3tRuyqyRQChpRAE8YHVIpVRavPORS1vSvCw53v6zmal5RWaJd+tgD
         36GA==
X-Forwarded-Encrypted: i=1; AFNElJ9tCQQW/t1HZhU+Y8rlpWG2WfJ6HmQpyBnBqwVT83Rr9d5yUpKTDwlkzJK7vJKk6Bg7Vugh2RlpXsZ+t6Q=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxXX3KZzbdO67yzQvinREhfLMiuc2kWFTBpV1LJRkbvs5RvZM+g
	nH6JwJoUSXYW5Ew66oO0wJxtf6ZSklTB+nAa/g0vYVX+5wS/IfePkqZGxQTvUtoyNRru2KOnltj
	/rj0PDEovf9HbuezKRNIOhZLy1g1S6UUxke+Ry+f+YU8djIy+gLEtdNGNXa41gAMOcCzu
X-Gm-Gg: AfdE7cn6TMdipgUS1zWf8x0jLHR4v00a/0vrlI2b1i0YU2GNk4lJ1b0dncfPqQ7SzTk
	AphIkuJ6xt3LPmsqOBlmc1Ryqzt9BrroVUxmpLFPgNkHL5fuHcWES4yEsyQm8NS9elTy9a1N0fl
	yuDcvnwUyMiVtZ7LTyQ4FOfBnM9lrK6+NuKxCRZZ6SBl5G6hn3iRwd7mPrJjq4lFIZqVhBOFJRM
	OVo46qkJqk3yNu8utjgj06CHPUd5NrygJZILB9v0/Khs4bIyDB209niBoh8K6u6k/kMlTtBUJt2
	csS8LVY/35obdK0BILnoKaU7S98nG7j1FyRKjddQV2Q1RQDVP4OxpR7LZ+D5JuWVDaFKI+29MeS
	9fB6LepSFZDu+6BYIiALETbmVHqOdGeCJOkJoC+zuYJuDIgSgrhXtqZZM3+yGvQ==
X-Received: by 2002:a05:620a:2a08:b0:92b:6805:eaed with SMTP id af79cd13be357-92e785233cfmr72406085a.74.1782892297537;
        Wed, 01 Jul 2026 00:51:37 -0700 (PDT)
X-Received: by 2002:a05:620a:2a08:b0:92b:6805:eaed with SMTP id af79cd13be357-92e785233cfmr72401385a.74.1782892297051;
        Wed, 01 Jul 2026 00:51:37 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1288d6a3e8sm228444966b.19.2026.07.01.00.51.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 00:51:36 -0700 (PDT)
Message-ID: <7b5b211d-bbf1-42ea-9b1d-f8dfe744841c@oss.qualcomm.com>
Date: Wed, 1 Jul 2026 09:51:33 +0200
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
Subject: Re: [PATCH v2 9/9] vdso/gettimeofday: Verify COMPAT_32BIT_TIME
 interactions
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
 <20260630-vdso-compat_32bit_time-v2-9-520d194640dd@linutronix.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260630-vdso-compat_32bit_time-v2-9-520d194640dd@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: c6Xc2WQeVd2-ZtQ_hFU2MzcLInGKRMqT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDA3NyBTYWx0ZWRfX6K1TXsoZuHF5
 EWm6xWWJZmw7dIVGJq4qeT3YA15lXXBOAwRK01Mks+tn5iHp5cj2WdIsi5gtVU13eLq8KRV39ex
 DOaGSOzDXu+WWelVLcR9nW8OIt3RwBsbFBxoDd4mQOGvFpHQiq56VNynnjqFOI+EaCfqnADMBEY
 IrApC6tbKXyxiAN/9HrihpfJFOlncoyAS/cOCeE+ccv9B3s2PCT16zoggPecMfXRgOTlX5L/I3o
 2wbEZXV7AePfnkd4SA8TO1LpMpPzNfsARqP36OovLpBoUSQed0VO8ZXHTP4DodNPX1Fsf2GZJPk
 RLcyBy+cw2E/KoyEQYyACGTPjS6MwMD8Rw0tpPGWipnq65mCzrvd11iwlsOknVQx3vJ6NeDZnqi
 ZIJHprkSfgUs6n2ECDxRzxxIka0cFPW2A6jyzw19JkQZ7JYw9eh5nELH/pnYij+yFPnQNz2eqDP
 ktUjW/BJkfV9Lwz0YWw==
X-Proofpoint-GUID: c6Xc2WQeVd2-ZtQ_hFU2MzcLInGKRMqT
X-Authority-Analysis: v=2.4 cv=LIZWhpW9 c=1 sm=1 tr=0 ts=6a44c70a cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=gC1PrsFcNpCBvASTUOwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDA3NyBTYWx0ZWRfX7HRcbZEj2Ei+
 tSGH1DMdNL6QT0V/Pk0TyE1yyGx5Dxag/Z+9Nj95yZow7w3HHkXT7K5Frrx6z3ccMud8hI72LQz
 ULNrccBfOO2aBcnfgoyB+TBPjqYsezg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607010077

On 30/6/26 09:38, Thomas WeiÃschuh wrote:
> If CONFIG_COMPAT_32BIT_TIME is disabled then the vDSO should not
> provide any 32-bit time related functionality.
> 
> Add some build-time validations to make sure the architecture-specific
> glue satisfies this requirement.
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> ---
>   lib/vdso/gettimeofday.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

