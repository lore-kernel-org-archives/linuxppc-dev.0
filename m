Return-Path: <linuxppc-dev+bounces-23932-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02F11C43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2026 11:17:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwsr45LdKz3bxf;
	Thu, 09 Jul 2026 21:17:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783595844;
	cv=none; b=F5EQyQ/BJddtmgVZhxt65R4FxegfCSDIIVMOXQHvhNWJjYPYJhiLX2+FTgH5yVe6Rpi9Nai3Y0EGpL3cI4vMYKynC4pFBU2IuBwD1kt1T8KP0K+0owxafdT8mKpFpJi2YDObmN7AEyTW1fbwYfWvgbMEniinZCCQRa9LFQHRXrwhrPb6KDBmLjtOPNQG49id8eDz72btKV9r/xP/CPyfv55jV+k/vTkpe/jtvY4CymKIFiZFjkXVUF0jli77XfeBy4bOARBpvtvL5VL27/49AL2Q0+WxD07SDbdcGgmWQXv2qlbtRfG37ygqxzX9nI1Q9kvLVGhXJqhZ7859j0cZVw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783595844; c=relaxed/relaxed;
	bh=6mSNoqY3wyokI6LMIu3gKte85FSyTicRshSy0RusydY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NjsxSC5G4SIHl0OvF8Hp8at1Cn10NHme7NaHDrD6RPKtuDBce5kFqDz2JaPlLV5DgUJ29kKre9Qa7VDiHbeDNj3V3QkfO6y4a7hggAkZtEXowyH2qRwZiz9iyxWF310qxL97acmO7t6pIV69OrOD9ZQP9T/UvewKGz9cmXLO7/2g+9RtKhT7O+0oiVapditv/Gz00/9+61CW45Odqr2qyoOFTsCHorVGhIvBlMca+0pgJ7HqDBjaI/k013904V58xVQU3yi+BFAQZ0j9lFE6Y78KGU5o2hgipeU6uRyLk+rxkEnWtRSzKlsvWyR8bJJrjMxUIGfiPg9ZLXeWDbj+Jg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=L5+SzP63; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=F3C+NMFn; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=philmd@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=L5+SzP63;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=F3C+NMFn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=philmd@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwsr40D0tz3bx5
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 21:17:23 +1000 (AEST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669AxSlf1604316
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Jul 2026 11:17:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6mSNoqY3wyokI6LMIu3gKte85FSyTicRshSy0RusydY=; b=L5+SzP63bgPAWhp4
	W0cUVg2l9n9I+4k0Akz43rpejx4oS0/IbbWAmLMXE7C9F37E36sY/GsXk3zuJt0e
	7WRl8xWn74pDgWLAKB7VqpUweKGfDHpjZadrDE/thxVaWuDjHJ729famrINqKMDx
	0upb87A5cv2e3e9cOgTo/VDABpH4Tf/6q96s0WSa2IFCTqdWIxx3GVEJhdklhdir
	gMzNGoVv54cFMR8lTrj5sNzMMQDcUrBjV8bPTBpznG6YMJOrkgy1v18t2RPVEfx/
	2v3dDdCotvg9oshrPidheW6ip0HZ0YECDQHkCxRsQPUi1HLjdw3FRE6oVFrVR41W
	qvGWIw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fa6p3s7ec-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 11:17:22 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c1a97644aso12208691cf.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 04:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783595841; x=1784200641; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6mSNoqY3wyokI6LMIu3gKte85FSyTicRshSy0RusydY=;
        b=F3C+NMFnqaX8lX3tshjIKB+w242i4BBLnVpl7jOfAa9T7gHrdYAqbsKRbHjYnpEZH0
         PLEvqlrH+OZJHp4IrH1ItjDvYKlbc8OGPMYR7lwy+H21LvBI5jFf5KsfOumX7sY+nHa1
         2lhqeZwkaPNseX7Sl8r76YRDJv7TdV/TEQXAzT1MRIIhlzpKAJu5H/qIGl2hcv+Y102h
         dk7CmcSHxKtbnmibpfAFZzjV5ySoQnlAdnOYcSN5blzqIPZWGhc3zvBa1hDDfLqOhYIo
         3bhnn+IvHlWcvEwxm67Gyaz1SrETcDTVjpyLYzb9R0kUOkh5vdQH6nk0IWKFeZh6ZN5b
         xLIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783595841; x=1784200641;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6mSNoqY3wyokI6LMIu3gKte85FSyTicRshSy0RusydY=;
        b=Q7Xy9Kxs+VGVoZQ9Ub6Uy7QhNdHVHPpYkeP9M2czfs5/TJ01fl76IgYqhOdhH0mXK8
         QOxPsMycs4Ckb0yWUUGZKWBKIEvfYnCk8FyiM6JGgjuOm+kfnGJ9Dv8gMn6E3hhKLKXW
         wr0nh+2lJL6f2LxQzEp52DR6PJUkdvBpCczDaBIKA515X8i4cpMkzwVFhQiIeGrDlG6r
         GDQq+g7r5zVBJdoJBW6+5IQviGtFD/0Y5XC/NLs6HtfpIxxweEvsHwJvQ/qIF8xct64h
         1hoB/XcQRTBcliATtZ6DyZWxt8bMef0YoY8sn1dyEwuBNjkpfYCw+1gjfHD52naBoSfT
         Q6bw==
X-Forwarded-Encrypted: i=1; AHgh+RrCXpYNcdq1tYYAE4i2YMSvuj4UKTEEaU1pJymAc+m/In8kVYK0re0clZRjbEeruwv5RFopSR7QJ9Bv0v4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxi0DMD/qxESLsXjHNPsc9sUoAXr2VMbV9Hkqw4pMxKzsmukRJt
	qdlucKXLWid38AMPyvyI5OrOKMYxHB/PjQipzZAWdLsJ+Q2Os7IqvvHfsmqxwzA73WzQ3ClYW36
	0ym4PXx9xlGqZQ19xETsUibLCIsBVUZizKXAa7G35xfe71ruDzir/xKu+I3ra4orPPIAD
X-Gm-Gg: AfdE7cnNT7PaHV9kjPxS58geFitMfNAlAIO37nD+9B4sxYYTLlp5snLYXDw0yuyjgz9
	F+MxplaIXV6DRJIjD8wWwpAQOWL+0cO+QwIKK/Qs7uPn8yGEK2wgIGDQQZtQgBz5BDABQF5fYrR
	j4WDUDxY90h+ZOPRF24Bv3xkGM6A2TpujOd1yb6KnX5TjSPtTpfDVdKjj87XAmdVke5jPBmDwdU
	VLPoPC8tLQipPSgc475T+oc/A87SDCylsfqNsDOaB1x8N161QGMEzvoTekQoEfnhhnSrSo0iBC6
	qLWiUd3GewN3lD2ZNIh4IWx2yA4qH+D52QkmMr6e9gxIrnQR/AxDM//Mjn/gcLTe+o9181G9qfe
	c0sJa+MxkrJRxMUxffnI7sms7MnCgWryvTH4ETj6W19uWVt+0WIGsYiPbueumLA==
X-Received: by 2002:a05:622a:c86:b0:51c:7b11:41b2 with SMTP id d75a77b69052e-51c8b51c97cmr72541891cf.78.1783595841175;
        Thu, 09 Jul 2026 04:17:21 -0700 (PDT)
X-Received: by 2002:a05:622a:c86:b0:51c:7b11:41b2 with SMTP id d75a77b69052e-51c8b51c97cmr72541381cf.78.1783595840774;
        Thu, 09 Jul 2026 04:17:20 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6cccfdsm54034235e9.1.2026.07.09.04.17.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 04:17:20 -0700 (PDT)
Message-ID: <8d15c107-30b1-48df-9e69-a7e8520f4e36@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 13:17:17 +0200
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
Subject: Re: [patch 07/18] s390/syscall: Use
 enter_from_user_mode_randomize_stack()
Content-Language: en-US
To: Jinjie Ruan <ruanjinjie@huawei.com>, Thomas Gleixner <tglx@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Sven Schnelle
 <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Kees Cook <kees@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
        loongarch@lists.linux.dev, Paul Walmsley <pjw@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
        x86@kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Andy Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
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
 <20260707190254.030598804@kernel.org>
 <499eca86-8def-4044-8b69-8f290528e10f@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <499eca86-8def-4044-8b69-8f290528e10f@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: MM9fqYi4AbpgLhKK1cJ5vGJslhCoGLpa
X-Proofpoint-GUID: MM9fqYi4AbpgLhKK1cJ5vGJslhCoGLpa
X-Authority-Analysis: v=2.4 cv=TPh1jVla c=1 sm=1 tr=0 ts=6a4f8342 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=LfsA7Cq2GQzuzbZ-N0YA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDEwOCBTYWx0ZWRfX+mUJOqkbGVzf
 Os9OQMyfQ8aA65DzK2MqYlc+rd2U9AF8LVpRUrH9GCmNUIDcVQTY+UbP8g7e50bgPUHKa3g8CO9
 WFCmyslN+mer8tQlXIrJvmOOeEzntXk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDEwOCBTYWx0ZWRfX1k5S9lWdPKqs
 b17oiwYjPBlqgM4U2HMb4AOjM4G8Qr4889Sobe9j/TuzrTtXF/w1/bwWWJe28KUsXxXVHAqnbU+
 FF2FRgOm+54y40h2ACVuYBDd35sa68igWseNsfJpnSRvahWQndhfppVG6BwAJFk6ZxgjRSg++Sn
 61FvNJQd/5ZTgK+DDgJi0H/RCXkdEUUh1QdBv7QWD1PH+Rjks2j8urU7709WlIOccnLAK8NtICH
 e+kiSVNCyaKkbMhGxbcciq7uOeC9QDVtjOTKRNlMUBt9nbtrSAFAx8qkDvPPd3JFkZ2L42AERfj
 xX1vPbD9lXkAog67e+wWF8h/ArUBe6Xzve13UBPlkuLq8ZzjIPoS/yym0bwD0GtcYe0HQVTWRlF
 V40s2dcQkNkSZc+bPTk3O+om/Qy+vok46m3HkjcPYQ3RSF7pSbMiMwHDuINNVpTgqyk2Fi3mdj4
 siXHOGJTsixP9yDkxFQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_02,2026-07-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090108

On 9/7/26 04:46, Jinjie Ruan wrote:
> 
> 
> On 7/8/2026 3:06 AM, Thomas Gleixner wrote:
>> enter_from_user_mode_randomize_stack() replaces enter_from_user_mode() and
>> the subsequent invocation of add_random_kstack_offset_irqsoff().
>>
>> As a bonus this avoids the overhead of get/put_cpu_var() in
>> add_random_kstack_offset().
>>
>> No functional change.
>>
>> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
>> Cc: Sven Schnelle <svens@linux.ibm.com>
>> Cc: linux-s390@vger.kernel.org
>> ---
>>   arch/s390/kernel/syscall.c |    4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> --- a/arch/s390/kernel/syscall.c
>> +++ b/arch/s390/kernel/syscall.c
>> @@ -97,8 +97,8 @@ void noinstr __do_syscall(struct pt_regs
>>   {
>>   	unsigned long nr;
>>   
>> -	enter_from_user_mode(regs);
>> -	add_random_kstack_offset();
>> +	enter_from_user_mode_randomize_stack(regs);
> 
> The #include <linux/randomize_kstack.h> can be removed.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


