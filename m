Return-Path: <linuxppc-dev+bounces-23306-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 693B1C43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jul 2026 12:23:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqzhS0wNhz2xPb;
	Wed, 01 Jul 2026 22:23:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782894311;
	cv=none; b=njl0J/WPpTINkAo+U92eiOcDXeWNHOvreO4EaBwBCL8lWQ2MOcqpFbXmQV4Sqd2OKeUFQoUukjnxMtWOJdSgNgIgTG/6wVTVJvT7wDPw395MIowWLIGXTwMpDip68qKXt5mT0Zw4IdcmN7Ip9vTIjlHcbxYPlq+rKQiVhDn/9cZtXSAE3+sWMm7ntQ8tOrqYrgQ1eVzG1jpxn8Yz5bxrhyRWxp4iI1upG/n53vVSGw2GVFyDR38tS4dVXomLMcWS1WvL+QrDrT4pTuOuhDMlUBuv4NG6VUJZxPiXoN6tNugMofabCCDGhB7Yz7mLlYMWc0Oxdupht7FnHXr1Vl0+QA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782894311; c=relaxed/relaxed;
	bh=dEWtdTAHqA8hd6AGc7LBd9M+QPf+f5oKuJGFwhYdbIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Il6PoMjFMRRoxJ0ar93e8RCqkCyYCOS7gxs8HrVmcgb69l+MRrISp54BJxqPgdiZCD5GYFbGX4/X6z2m97xH8SGFFBKf6tJgXgvloZe5pHk2Uto3x5Zg9FtAwcUtV/EEux2/5asfjZQy6nO3PNsNkH12XQZMI9to3aw9NgEsJPUqqBeNp18rSLExyCSJvdqgYGUtXPdVVwuXUwTNixoCjSEvXay0Na+7y3DDv4MgYqwWOySlZSDbvTK9lpB3o5o7XlNWWtg90ttAcnMyUReiIgp14i3pEMzWMdsrNlbNHDiFB/RVhKJS6MjI5CVXtoNxU7G1WWKKseqoZAgYcF8YtA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WY2RJu67; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TfICAp4b; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=philmd@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WY2RJu67;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TfICAp4b;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=philmd@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqtP12HZYz2xHK
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 18:25:07 +1000 (AEST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6615lRZ4065862
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Jul 2026 07:47:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dEWtdTAHqA8hd6AGc7LBd9M+QPf+f5oKuJGFwhYdbIM=; b=WY2RJu67VLHvQJ32
	1OKJlZNJIXAJByudwZGbrQA9uRqrVfY/ixF77iI5yzwHe+hZBxp6KvNFcezUD24P
	PEvh54vbLG4Hegu9YXgz9DwuBxjAfz/Gpesnd2/UgmZc3kG768ZU+xyK5wjti5e9
	qavcXa6+3jBA+ZWUmFO0GxjlSfnl+HzYPgSFfdECy/A/P2KbtTdOCDL1LhPDVVeB
	rnf82+KAtN/ztk0Db+esChQG0Pm0WJX5o+dYEexsbZCYm+6RsySEC/W3NsrDz/Ux
	JFNknuOMWBn4e+0SebBjqK9NxtbhImI8oCFmyZMHA4q+lvbyykjW9gNB685Ddrh4
	VkCH8g==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4jtqk037-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 07:47:47 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92d1cae5939so47502985a.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 00:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782892066; x=1783496866; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dEWtdTAHqA8hd6AGc7LBd9M+QPf+f5oKuJGFwhYdbIM=;
        b=TfICAp4b2aEKBASEwBpnXrHeRa0SP635gVY+qT6dkyEqItWeQxmSp06Zk/AlA/4Oot
         +3y29qq2UWu4lPbqGwQZgu7HX64BigOSPAKbbE9ru+WclRHEHb+AqpDboutDL/q2cnRa
         WplbZzXDrVPADFzcNszCZ9jj93nbiDDU7+PlooCJFtYCkHqVAfLY0t7cOVDQL6wm/jHv
         H0dK0It61alqxeH1a8wLxBYnbYwIQ8b3Npefr8MdjeBlBwxPxUYzzmyNdX7SU4F4gtVZ
         3qURVGn4brHgsoa33Q+t1HUpOIDcIMVBJoUlg6odQwj+oyNe/FEZIaBj0FbCTRHYyav+
         Y8rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782892066; x=1783496866;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dEWtdTAHqA8hd6AGc7LBd9M+QPf+f5oKuJGFwhYdbIM=;
        b=niFm/WWERuJc4PcKXiWdIhr4Z6DHb5Wz0GZyKzPpouXXjHCq7mphcVWgumNAvNY3iM
         gMS6vn8mf+TC2MlwGW5pWThuW7JO7ehWt9DIvQVs9O+zFCYxjzzKzWhHtEeo64lfIux8
         zwdnT0vmIG61qoi8eOD4oSklyvOYCaDA+JRpWSBozlFOdewt5633w1cfs1ZPsS6YfUWE
         r9BgnAc5/riUNkDtQ3iKqGAXsbUtWkBd3gnsTQpYSLeu0qo/0V+syFQC9WecSSS96/Fw
         pl56AFMD+MkbHHvZL03ATOeB7TR/xiHqFfJ6gZ+vg1s4C6kFCHcJmyGkNsGdzImjQnBV
         Ftiw==
X-Forwarded-Encrypted: i=1; AFNElJ979ieN3/w9fgyyqsqvnRY2fU8FNQWH2uA0JkpNo+dnIXssqnj1SSQZmBSIZJsanjZi/TIkUYHybw5oETs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxpd84o4XrwnaRQVg78LpXI93HBQ23Ss6O3ynDO67dCHvHbWeH5
	aXaiP72kWILftaDVC6jA1tUlS4EE6NKtMn82mODwQlHHIyACHw3zd56xUL7VqDEuEUwhSX4CYis
	gsghe0B5qlU383rENDINrR/paAJzzHmhlLnEctYd0k5TYDmp+EWOdJDQ1Y4G2Jaa1yRRS
X-Gm-Gg: AfdE7ckoNwJMboM9gDnjpPsfNwrFG/sWJhbG+T9Cp+76XTtkYmi9ytSg56DQJo5hAn+
	22HGevqPae4u5AQpvICCiqw+ulgBRbDxfRzVBnQCqlF9jNZbGHJ056pOVmVpzzQBqIgQwc6az10
	j2yMQMNhFVp8yZbc59SQ/qZSxXvdYduKE9SRWAoWMgFu8Us9onYvbTOpA4QrSy13O3BZtOsbLOo
	p91mfNIEuUbjhQ/ZOBMkG+RIHT5vVTSVuzUALG7vW2dylC5Csq6KwV4Fh+vSu6Cph+PNFwt2J4j
	mmu/jCczHuaGecbxOkUHVQhwEC2f1AHwdZ0g5EbLebvFlajJ4X/zotPiuTrNzUIaWw2rp5TkYft
	zdyqgcZDVCMmJggpyoagWYV3n3zQhvb1lMMZjnnR3QHDCfgjE84wLQWl3LZoDIg==
X-Received: by 2002:a05:620a:370c:b0:92a:c203:471e with SMTP id af79cd13be357-92e781dd674mr78276685a.9.1782892066409;
        Wed, 01 Jul 2026 00:47:46 -0700 (PDT)
X-Received: by 2002:a05:620a:370c:b0:92a:c203:471e with SMTP id af79cd13be357-92e781dd674mr78272185a.9.1782892065821;
        Wed, 01 Jul 2026 00:47:45 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be82fd71sm77510895e9.15.2026.07.01.00.47.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 00:47:42 -0700 (PDT)
Message-ID: <0d210cc9-5565-47e9-904f-3e8dbd910d6f@oss.qualcomm.com>
Date: Wed, 1 Jul 2026 09:47:32 +0200
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
Subject: Re: [PATCH v2 2/9] vdso/gettimeofday: Validate system call existence
 for time() and gettimeofday()
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
 <20260630-vdso-compat_32bit_time-v2-2-520d194640dd@linutronix.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260630-vdso-compat_32bit_time-v2-2-520d194640dd@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: zg1l5Sw53sGQGlTHoo14O-zn-1jn6-GK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDA3NyBTYWx0ZWRfX5WvrlIcIa/v6
 w/qqSwWjU53qMHcHMX4Eex8XLeenWeOB/CNC0NAX9L0e/zKWkL6HlZQa1le+NovccF6Vay60PT6
 ZEGIC5PDL7/v9HMNtvo9I/e4TnY02VMDJL2tD5npcUHmIuO0fJylO2LS3s7sT1Hz6RqsBCq8RGs
 uuHBOwolgr+18KB4uGdEOAmd7s1NH3B9oENypyYS85jmcvH8ggXmQ2tqFZY5Ve4Tx8L6jZCGQFU
 ICBCdhifszVjAKIgiSAy9j3cf4XBHUitKGxWxDNZOXpfrV2ZFzcJAq3yVSAbVNv05I8pEN2xtq4
 qJUODipXKmJlBCedv2UHRhF8gp7MxwJTD7GpQy2JWMqert2wiV5MY4uCIYcyw8mjstSQFHmXEdB
 B1uC0SzSqwhn4/JzidEWiLuSoK1hMTFmSrZQXV2HiVsTH4lEFMbrKr00KDasGQ/+xiJGBNYwjEj
 czpYulCwP0WIqzB8ztw==
X-Proofpoint-GUID: zg1l5Sw53sGQGlTHoo14O-zn-1jn6-GK
X-Authority-Analysis: v=2.4 cv=LIZWhpW9 c=1 sm=1 tr=0 ts=6a44c623 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=nV7M3V7dV4ZlPVs255YA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDA3NyBTYWx0ZWRfX2fR23rL318EP
 /OoQFOHmQvT9Zbg0mf1xTuI8eQFmO/BD+e1aflD6vdUhtEKYeUHS897piUy0M6mkKcKz57l9fnI
 3Ok8Rwx3QILPxXcT1mEEmZUhPbOBv2k=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 clxscore=1011 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607010077

On 30/6/26 09:38, Thomas WeiÃschuh wrote:
> Not all architectures have the system calls for time() and
> gettimeofday(). When the system call is missing, the vDSO function
> should also not be present.
> 
> Validate that.
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> ---
>   lib/vdso/gettimeofday.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

