Return-Path: <linuxppc-dev+bounces-28626-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 415F8CA5FA5
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Oct 2026 04:18:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hwJYn5NmVz2y2Z;
	Thu, 01 Oct 2026 14:18:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790828301;
	cv=none; b=YUI5cFSdYAtsCkc3EA8kuDEQSLsUgxhmLvUPAqQhxqDYzo4TqzdnQWieoBpY6v6iypc3aiLQh8apmybp6eXutAdXW7zE0QY68nfjDsvvm0jytnuaSa78l5q8omNEKcbb7vIix8jNSqbt9d2I8ljUkFoSqHVyieebNF4j4TnfEWj+dHNb5n209JTRW7i/qpX9RfYraa68Jb4JZ3GStCa7mFzZXUPlEjzUIH4rpa/btDqbG6GOcvj9RzB7V9IB4FbVHYSjL64rSlNwfcpMwE8t/iQmEU8iGo9JcYayWPtbY3psry7Jm4WA2bEgYU6K+eK5/oyTPLkUayQUhfZwTtXvoA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790828301; c=relaxed/relaxed;
	bh=FdL7tDG7uCk24aByg41uFFGTsoB8/++risqRDX1I7Hg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EXUN2wAvQWvbpKUpMLHw43VBCQODq+Y9GHTzJsC4Q4kbEk4sZDpLSXjyDCTGaW+MNPzLRNySA2RGQDse0FpsDUSEbyskoEq43JtO5NERt8uH76GkgTWgDlsZCQvCHANU0cTjgJgV+B3LHmzOzE7jWWLLTDxEHandcLKNq6Q7B6E/INxUVBsGqpqfObWHOi3IKFELQGju3x1taBINr/BtB3FsU7fJBiHZ0ijIMV4w1pqVnyvZ1BOCA7zYNknOeKl81ZiNjv04o4ZPrhxheicdZXKI3Cev39Hz07RBwsuTDn1GcEERmya1RPXrGj66bGDwawphEIOXMaHH6RBzORMiSw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=tBc87Fs5; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=tBc87Fs5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hwJYm6Vxnz2xsW
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Oct 2026 14:18:20 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69145PG6756232;
	Thu, 1 Oct 2026 04:18:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=FdL7tD
	G7uCk24aByg41uFFGTsoB8/++risqRDX1I7Hg=; b=tBc87Fs5YPyOoeXWJzZUth
	4gqupaIEq3yzhdGP8ji31leotjoLupP/0gWmUsu4tY/xNJRJVLa8Vf5mwpGyly5p
	3vw4iS2DO8ZB37axFILtJUyZjpal3TM5w1ApN30pAOP5s8htnkhFtU92YiiucQDP
	yY3Z9qr0RjYj1Gzw+T7xWNW1Fa3Nr3O3XW9IN1Gpd82JScUmzOvDKztk7CLI722r
	p5f6p/N/qFicwyD+p+7FkUxWzRhYf37ZIdMEEM0dsz0KV/Sd0dT4BwapHAwQwxca
	XXCUjOIYNpjswlVvim/Qi119W5OUDjTiVJRImH2B5fXke5houiSLILgmzY+XVxFg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5j5h6y0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 04:18:05 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6913lURJ306122;
	Thu, 1 Oct 2026 04:18:04 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h0hfpf2fd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 04:18:04 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6914I3GM9372168
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Oct 2026 04:18:04 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C042758043;
	Thu,  1 Oct 2026 04:18:03 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B7EB658059;
	Thu,  1 Oct 2026 04:17:58 +0000 (GMT)
Received: from [9.123.8.83] (unknown [9.123.8.83])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 Oct 2026 04:17:58 +0000 (GMT)
Message-ID: <9af9f47d-b99e-46d4-bb6c-06d28b037a34@linux.ibm.com>
Date: Thu, 1 Oct 2026 09:47:56 +0530
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
Subject: Re: [PATCH v3 09/11] powerpc/papr_scm: Return the string length from
 the sysfs show functions
To: Kees Cook <kees@kernel.org>, Bill Wendling <morbo@google.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
        linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Shivaprasad G Bhat
 <sbhat@linux.ibm.com>,
        Thorsten Blum <blum@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>, nikitash.mariiaw@gmail.com,
        Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20260930235231.out.387-kees@kernel.org>
 <20260930235247.157921-9-kees@kernel.org>
Content-Language: en-US
From: Madhavan Srinivasan <maddy@linux.ibm.com>
In-Reply-To: <20260930235247.157921-9-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDAxNiBTYWx0ZWRfX6FsMoRD4CcsF
 6vSCZe6HpN3lttd6FWuf1EcxP+QvtROnkvjBgKTgHeqagH5md1URabZGny8amSX5YgqOUTWHskt
 y6D4Ulhs2QbhMvPIX15+pFG41szuWbg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDAxNiBTYWx0ZWRfX1rZ+6AhcJBIv
 GmZZtmcZl1Pgw6hyxMC7cxo7/5MWt0MFg6n1EN0YXuKhHzZYy1ioyjUjoDnu5/tNZYbibffvUoc
 u6r/dTofzrlKdpk2494mLCwvA/AMkUdHCHRbJLHWlGaKa6ZSRnjsY2WTUGwrfbYbnjdgyPPOCvl
 RMavMUWmKAxXjFsCCBQTmEpR3CRMZ5nGHI1gCpIf3EpEbqGcx4z69TkbmC+4nXIlxjvZJ+DjcvK
 k0mUIBjXEAMRo3msDFPbgqt9P71V2tHXTGm28hfjbjftuYmhWlYR9nUy2NR54ErtOrpy06dkzGa
 kknctgD5BsYZVi2DJqILw7bgiE0iNmQY6QAlawLuRkplpVK+/i07QSoJJ7g00JziGBF0w8BmPro
 dPbAY0vhnPafYeEbvReGp4cdZE61F63J0x3vWhdwW2U9M3R6lTp0AA/cawzykmVL8DEayHOl7y8
 pP8gS2uBQU5HnOfqhNQ==
X-Proofpoint-GUID: VGbzrGZZBKGE2sx6cZHjFeLt9an1RaHv
X-Authority-Analysis: v=2.4 cv=RKcmjIi+ c=1 sm=1 tr=0 ts=6abddefe cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=QyXUC8HyAAAA:8
 a=VwQbUJbxAAAA:8 a=_Rns151wsaknvw-dtMgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ukRtnVfRL8ufVcKHebXtglGLxoRaJDZh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010016


On 10/1/26 5:22 AM, Kees Cook wrote:
> perf_stats_show() and flags_show() build their output with a seq_buf
> and return seq_buf_used(), which may include the trailing NUL byte
> when the seq_buf has overflowed. Use seq_buf_strlen() instead.
>
> Build tested ARCH=powerpc ppc64_defconfig with GCC powerpc64-linux-gnu
> 16.1.0:
> arch/powerpc/platforms/pseries/papr_scm.o
>
> Assisted-by: LLM
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
>   arch/powerpc/platforms/pseries/papr_scm.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
> index 75da96c08cdd..b03cfd8528f5 100644
> --- a/arch/powerpc/platforms/pseries/papr_scm.c
> +++ b/arch/powerpc/platforms/pseries/papr_scm.c
> @@ -1108,7 +1108,7 @@ static ssize_t perf_stats_show(struct device *dev,
>   
>   free_stats:
>   	kfree(stats);
> -	return rc ? rc : (ssize_t)seq_buf_used(&s);
> +	return rc ?: (ssize_t)seq_buf_strlen(&s);
>   }
>   static DEVICE_ATTR_ADMIN_RO(perf_stats);
>   
> @@ -1150,7 +1150,7 @@ static ssize_t flags_show(struct device *dev,
>   	if (seq_buf_used(&s))

this can also be seq_buf_strlen instead

>   		seq_buf_printf(&s, "\n");
>   
> -	return seq_buf_used(&s);
> +	return seq_buf_strlen(&s);
>   }
>   DEVICE_ATTR_RO(flags);
>   

