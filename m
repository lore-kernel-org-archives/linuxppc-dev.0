Return-Path: <linuxppc-dev+bounces-23935-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 577D0C44501
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2026 11:22:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwsy30Ps9z3by2;
	Thu, 09 Jul 2026 21:22:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783596155;
	cv=none; b=e0FoUCussiG6jmdaIY6R0KKAK2VqACjyAFtR08jkmWpkC3bLyOiQCJx9f0LXJLBtaHOQVrCQ1qVwr4Pv2H0jgVA4/PYXmLOY6kkZ09k8QRO+pSucgvKfXWeE8/HEbZmkDMhd+UH9Ji3F3o8nzX/c21Fa9GuEGU6DIysqONli3L3ew/AJ2uL6A50Npoq3eHazqf8Xr+aY13DI+ph25xZnXAcf4tEqT9CzBZH1Ai02xxkx1wusdevOR0CS04YsSq76qo15fElYJsE9t9SGhNvBBNJaGBczwSuzP7MTjk7ClOnhaWErY3ajPJgvKJ3wM9hgyyH+zS5WViq0wv90w67IXg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783596155; c=relaxed/relaxed;
	bh=GMTUKuNW7nHEjTmJYQtVLsm+lxP07KtZQHvvJ99eHNs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=S49T/Co0aj5/+lzwEiaICbl+unkz75/ZCLHxJUTSG4N3TAJKipykpeLI1OmS/w+S0dcowXIKtk+iL41zHbinrgWx7kYAW5KAwZBUmYTUAEH/IjlFcntiXFhVhXpImefgWhIJVQsbJ8r61/VTXB0hRnxgDNGgGDzAE1/+m7lSFsuj6yRV2CqHEiS5WRUx0vH2Ey5/UrbUxxGajQ7u/ga6qBEPUmUZG0bhxe7VqEob7VsU98sM0GROf5qAtmjK9NW448/Moa3nIAAtievDMewvOTGdf6gslMmX8EPc4uZD9wvnkpY8lqkH07Hety/fcW8LjG+IxguXAcqAA56KVG0uVQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jTI7fkXQ; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UGjqutTQ; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=philmd@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jTI7fkXQ;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UGjqutTQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=philmd@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwsy21hykz3bxl
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 21:22:33 +1000 (AEST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669AxEbX1396562
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Jul 2026 11:22:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GMTUKuNW7nHEjTmJYQtVLsm+lxP07KtZQHvvJ99eHNs=; b=jTI7fkXQl7cmfY8u
	/6bNS+Fwu0N0JYJjqKlpNE/bUkl2mhzeMCIy9YTKs/eoShIUpl8OQCJgxUcCe1Qs
	3cJw4qK9vv+hDmJX2IozRyra6X37WE8v8Vxl6bxaUL0j5/MLQKzhvIKs34reKXrh
	QWs1Vb41u8wIG/o9knrL4GgKq2/ZBNYGTwPnHTuT5u7jJ3EMLnaiRdEBXGlLErlS
	QMBDjPbvcSMQgesyK7qkf9Xbt4GVvlCDF7pU0Ep4e6tiqGpO14UiKVK+WJIifgMb
	eFDVUlYtLgbk+5e07s9PeDWnBLvsQTPHVnHxEKk6PFxWS/VH6saUNZqOsHQv410+
	3wCVHw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fa55vhkdr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 11:22:31 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c1d7886cdso16217281cf.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 04:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783596150; x=1784200950; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GMTUKuNW7nHEjTmJYQtVLsm+lxP07KtZQHvvJ99eHNs=;
        b=UGjqutTQZMvoss184K1m1DjMoiC1V9GnVocTY8AcuP3TQLF8u54g/9qwlQRnJjwaIg
         qKcKwLzM6VHGwODwWBcwrTXjJZUV0AkugpTyoAS3yh3uIYcL3owE1k0PfsTDxKLZsMSM
         lV2DuiOG6pd4fUFm/YFCeBbxZT3H2v/+ayxfWovXrUUv56CpNNQBqOqXo9uuCT5HMkFO
         595GtgG8mSGu5+awDguIIOgsz0pCSDpI9zTt1vP8y8WxUcYX0tXCKbrNCaRldCBXUYzn
         KvtiwVFWtG/sjkP65nzNWcrtwYihP87hqXvPYDJXEjr0wijpc+vBQwsa9tgHKZp9UuMy
         aI2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783596150; x=1784200950;
        h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GMTUKuNW7nHEjTmJYQtVLsm+lxP07KtZQHvvJ99eHNs=;
        b=oUbT2Gux3lOcxjuO1RZg+2mHvJEuACQyhm7H8xrv3MlDOOQcGOXbxPa+t93wSupCZw
         IJsgBSsHxHvDCzJDLSePMFYwv0iTsyAX6/0rs8y9KeYyDReDIYWMoxdYj0OAkn5skhBT
         XwiPNxlX7eNklG82+ORDgzcZ7RfIwX/a0CuCEBI9ntU1ViXD9HkFn09zRKR18xHCQ8r/
         McnlVrIFYT2MJGGd3wbyvYwECFCBDxXM0azPoHfWh+ZPVpW0f0uuUjC1juf04G+xem4q
         YMyrbfES+3uavsdDUiVFkjhHqhXwPX0tG0lhNCSm+RBy0A2bf4ffrETiV7jmeO2Wr2LE
         kqtg==
X-Forwarded-Encrypted: i=1; AHgh+Rq2/Cr3MUR847h7P/70MJciDgdC9XdnVqcQLzs8dOuDGkbz2yILjhukUSBShBjTJtqaxLd+DHpqtVJO0wI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxnromQxm8RnaykgSmzrIzu8DbJHFL8LkwELbvPxXLTPSJesrYE
	e0ZX1MnGCewRiwGGm9EGg8t+TglvGkydY0zmxOlWr9hna4TkdO7wN85uDNp1UAvfvLxW/Lqnnny
	T1Knf03gxWb+BaJDvshv1gzvd2dL4NOZWU17hVBF88tuSpIAgY/dfzVT5eR97z7wNccQy
X-Gm-Gg: AfdE7cnG9QFWumAC3HnibLbFGchOpKsYmDYwVnvCxvQIeYbuvE8LKEhQeqPwBr0cZKI
	3joOucn0sMfhLycmCzzZj43qWj3kTfJTC2s+5HL7v4hu4+AdtSwmyldCn5I6SSQF/4gxXU0IpQb
	TxT69c8QIN8IkTPoQRh8k7O7DX8TrB0bnb+cdethnaXVmhD3ZAsOI8Ys/+SYFgw8wF8qFQIEVWY
	D2LzoefcGNb7YkpNqAwNoxhMlpAInyvBmHBbjeA4+whwsmENUAVNfS4BVCmMpG70v9StHwSMWoq
	TYvwAK6DMZp66e4XOq6jXQM9ISbqh89zaHwQep8RXQsJXS9fGRvJR730td7paV7RVyAo67oymcB
	8pWGBKE7jMnmib/7xHw9U0CcAmfRH2xICrMAZrCBnORMbvsOQE28po4RsyBqw6Q==
X-Received: by 2002:ac8:58d4:0:b0:51a:8c86:bd4a with SMTP id d75a77b69052e-51c8b407e1cmr74987671cf.71.1783596150574;
        Thu, 09 Jul 2026 04:22:30 -0700 (PDT)
X-Received: by 2002:ac8:58d4:0:b0:51a:8c86:bd4a with SMTP id d75a77b69052e-51c8b407e1cmr74987351cf.71.1783596150195;
        Thu, 09 Jul 2026 04:22:30 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1e6ccsm50814277f8f.5.2026.07.09.04.22.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 04:22:29 -0700 (PDT)
Message-ID: <ea24e611-91e0-4397-a49c-1493966094f9@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 13:22:26 +0200
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
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
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
 <73b82749-2df3-4c12-bc2a-ff7628dc8292@oss.qualcomm.com>
In-Reply-To: <73b82749-2df3-4c12-bc2a-ff7628dc8292@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDEwOCBTYWx0ZWRfXxH3VQpJxYKvy
 yvTMMYIrho10FwugTto56iCHrNkRR3ir/5U/LRDewQQsqrLn7BmYSycgDsJ9xd03TjBGW0qzFHt
 8K19Z9bEuF77kSD/CU7KehbbkrFtv54o3BGEb1r+/l5Vj1TZPFi+wFKH8CW/Y4HYcD6kFnzvlXJ
 B9YIEdMOmC+ennyEauodZ0O+gFRYRhXCwLhl5PxhPm1bXt1UBixumwrtMqChPm+Xoh0QYsbHq/Z
 NL0DsC9iCTG4fA/XxmMfzyVtOp7SPQ0Y+O6+6TUK/W10zc0mPEmoO1ZTHHIcx9e9WsC+Jg+iumE
 Bt5i5gnYuOI85uELIETDhL8yYRWHvWAJFLNQfEpPadq18p8Hqn1gN8lEjF5r6mgG4Zg8/MoHE4H
 bBuvct8QDuxvI/rGgTiuj3MZ1CNMfc1778zC61pxWEG80CMp92mvN8MvGY+VmfcRI2gTeygDWE9
 C5ssyXMUEJoNXcfHWUw==
X-Authority-Analysis: v=2.4 cv=KfDidwYD c=1 sm=1 tr=0 ts=6a4f8477 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDEwOCBTYWx0ZWRfX7pArupkYT9mt
 dXc8yMmYjp9B/gCxR8R+btXWZmosWw+flnAz4bvz33cU8xLqp+vfb7i5wnDKqO8Fd3oqcJf4wb9
 RVJUiiUseKbSQm/duQ4NuGuzkxf7mpM=
X-Proofpoint-ORIG-GUID: h1EeZED3pIZQVNmjXuppZS6FiV5l7CE0
X-Proofpoint-GUID: h1EeZED3pIZQVNmjXuppZS6FiV5l7CE0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_02,2026-07-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090108

On 9/7/26 13:20, Philippe Mathieu-DaudÃ© wrote:
> On 7/7/26 21:06, Thomas Gleixner wrote:
>> rseq_syscall_enter_work() is invoked before the syscall number can be
>> modified. So there is no point in rereading it from pt_regs.
>>
>> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
>> ---
>>   include/linux/entry-common.h |    9 +++++----
>>   1 file changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


