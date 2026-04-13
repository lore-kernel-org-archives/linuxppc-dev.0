Return-Path: <linuxppc-dev+bounces-19676-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D528EBFD30
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Apr 2026 10:11:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fvNV96Kcjz2yfl;
	Mon, 13 Apr 2026 20:11:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776075089;
	cv=none; b=eCSadW4G+mhaimYQVoAiEbehGQpGgq50Q73zwc5ajNoikEP5frZ2q2aovI6lTPhojhq0Sjs9v5SFHuhonW7c5Tb9EmTy2Tqj1IUBmvx38C6Pt4rARIo3pf+Xx+StbturkMn7mUEfmXhumrCniP8YJK4PHyDZDQWZBm0c4oDblS3BWegIp6J/Z7VTMZg4yuFrbC/EW89jyh43c1kSvHYMPWh5f7vB11UctUfKkj0aMWVGoTKuz8jt9aVDrB/XYDGwzYDXoqGiZofjqSEfthkwkZlCm43TEzWfMbA+3s58z5uhnKWyqadHIACLXl94HDbLIi6L5s95mPv8vr5GRc1Lnw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776075089; c=relaxed/relaxed;
	bh=AWDfc31HqOX7X7I9EB451LOTOynfK5gKa0CUNeVaAXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a2Pcd2crXwH+AgfqLAQf2VUzZGHcOP3tTMgBhKUYweis6IOafFDiaLq8y3mZVr/RQR42adiRenChNnsScWyOiR00KXFQHi4fahOOhoo1QPOKiczAa7G7tm3h1LJPGQQXw4qXXTuV6hblWNpzMg2DNxdoTX4BGPdHmLDAytmWEWsx35uY0BR/eaJeQyHIjy/ysOYq5gi1WGhKyaBBL8pQH9DNeSmNBL1NqtC/iq90KHM+eb1fAxO3psxvcyoDr4hAM2QpYT1zvknaDfgXq9A82fALr5RRI7H8xKYC0eIEt0tebfvJ40ntcnhv4skokwMn5GwNIa3TMb6PUuF0KBgk0w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dtoIgWwD; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mahesh@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dtoIgWwD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mahesh@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fvNV81mw3z2ySb
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Apr 2026 20:11:27 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63D0vT4x3430311;
	Mon, 13 Apr 2026 10:11:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:reply-to:subject:to; s=pp1; bh=AWDfc31HqOX7X7I9EB451
	LOTOynfK5gKa0CUNeVaAXU=; b=dtoIgWwDRm8irWjEDjG4JEgGChgfR7ubyDgc6
	FjYjL4pP4ry1kGgEVXoys+hM83E4V3kaCYD6ohi1MVzw1mHoqKninEtgtKAJZ8HX
	3qkgDcuYa1DqUSOeD/Iq7l6cfBzJlxI2ucMv8d5WUJF2PEc/1r4HibwzoeukFnE9
	Mu4p/n6/O5KrVRV2DoyEEUhzr6Q5ohcopMPUMNyuWdM6CXd0ywtJ0jT8fxvG8tRd
	mkywTNkataNWQXav2SqM81t5fcj9A81J2rPTSacXLVBgKqTRM6NRiIdyTzxGHUZ6
	HqOqvXcUfLqijCVPn6zh5GGiUl31KMg4f083/kXOxPM1CvhDA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dfcqexu3h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 10:11:10 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63D9JnEA004175;
	Mon, 13 Apr 2026 10:11:09 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg24k4k3r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 10:11:09 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63DAB5Bk52691238
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Apr 2026 10:11:05 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C541F2004F;
	Mon, 13 Apr 2026 10:11:05 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4654E20063;
	Mon, 13 Apr 2026 10:11:03 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.123.6.78])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 13 Apr 2026 10:11:03 +0000 (GMT)
Date: Mon, 13 Apr 2026 15:41:01 +0530
From: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
To: Shivang Upadhyay <shivangu@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, kees@kernel.org, tony.luck@intel.com,
        gpiccoli@igalia.com, ritesh.list@gmail.com, rppt@kernel.org,
        Hari Bathini <hbathini@linux.ibm.com>,
        Shirisha G <shirisha@linux.ibm.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>
Subject: Re: [PATCH v2] ppc/fadump: invoke kmsg_dump in fadump panic path
Message-ID: <ady_5OZe0t8AkFmM@linux.ibm.com>
Reply-To: mahesh@linux.ibm.com
References: <20260412113057.46090-1-shivangu@linux.ibm.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260412113057.46090-1-shivangu@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDA5NiBTYWx0ZWRfX4vAbFqFtr/TX
 gk3cBypSkJIvCUd6LxpxK/JrZYi7eIwgk3ujaunEs9Lm/3ODuIdr7CanqGneSGsDULJFwkoUYYI
 WDagmIJOa1KAnFHQ6E6uQZZesC41UaEfTRp7gm6eJX4yRO43bt/TgHrk/MauV8mqxO0QnSrQtao
 71rzOWKOC5ubcEgoeWqN96H+fsrox4vV7CqBfay3juhlQuIuXQbFt4jfACyyKQbMgcxr80w95rz
 Z2uUbaYqnoaBRGKHhPyjc/MzCy9ETJGX5+inEYW+ub2G4NkxgATaqpmySz0M6Cf9c6WOdJoQdCK
 T8303Yp0j1eyHReBVhXV/+UGUuLSkaSSFBZF5onHWjJPSJX6F5b6/nRjCfq0V09RxgWf9PqYEkO
 EePYEXps6UialenVDh0bZvScFuvVb2O6IkugIQq6NLuYFb0ae4R2TImG7GzWPSnHLqD+oP37ffb
 OwUVNpvDPO15p7IpJ4Q==
X-Proofpoint-GUID: B60NViVCc_7uerikIIw-TolAXwccSV9d
X-Proofpoint-ORIG-GUID: 7ar2RWTPLcEOZG4C2B4Gt9QJGO15uhhi
X-Authority-Analysis: v=2.4 cv=YemNIQRf c=1 sm=1 tr=0 ts=69dcc13e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=WMeMqPS48f8hHYZQQtcA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_02,2026-04-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1011
 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604130096

On 2026-04-12 17:00:57 Sun, Shivang Upadhyay wrote:
> fadump is registered in panic_notifier_list and gets triggered before
> kmsg_dump_desc() in the panic path. As a result, kmsg_dumpers such as
> pstore are not executed during fadump crashes.
> 
> This is problematic because pstore provides a critical fallback mechanism
> for crash analysis. When fadump fails to successfully reboot the system
> or capture a dump, pstore logs may be the only available information from
> the crashed kernel. Without invoking kmsg_dump_desc() in the fadump path,
> we lose this valuable diagnostic data.
> 
> Invoke kmsg_dump_desc() from the fadump panic handler, but only when
> fadump is actually registered (checked via should_fadump_crash()). This
> ensures kmsg_dumpers are called without duplicating the call that occurs
> later in panic() when fadump is not active.
> 
> The call is placed before crash_fadump() to ensure logs are captured
> before the system attempts to trigger the firmware-assisted dump.
> 
> Cc: Hari Bathini <hbathini@linux.ibm.com>
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Reported-by: Shirisha G <shirisha@linux.ibm.com>
> Suggested-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
> ---
> Changelog:
> 
> v2:
>   address comments from Sourabh, and sashikio-ai
>   added should_fadump_crash()
> 
> v1:
>   https://lore.kernel.org/all/20260407054341.308710-1-shivangu@linux.ibm.com/
> ---
>  arch/powerpc/kernel/setup-common.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
> index b1761909c23f..87afc8003a03 100644
> --- a/arch/powerpc/kernel/setup-common.c
> +++ b/arch/powerpc/kernel/setup-common.c
> @@ -68,6 +68,7 @@
>  #include <asm/kasan.h>
>  #include <asm/mce.h>
>  #include <asm/systemcfg.h>
> +#include <linux/kmsg_dump.h>
>  
>  #include "setup.h"
>  
> @@ -744,6 +745,13 @@ static int ppc_panic_fadump_handler(struct notifier_block *this,
>  	 */
>  	hard_irq_disable();
>  
> +	/*
> +	 * Invoke kmsg_dump (e.g., pstore) before crash_fadump() as fadump
> +	 * runs before panic()'s kmsg_dump_desc() call.
> +	 */
> +	if (should_fadump_crash())
> +		kmsg_dump_desc(KMSG_DUMP_PANIC, (char *)ptr);
> +

Looks good to me.

Reviewed-by: Mahesh Salgaonkar <mahesh@linux.ibm.com>

Thanks,
-Mahesh.
>  	/*
>  	 * If firmware-assisted dump has been registered then trigger
>  	 * its callback and let the firmware handles everything else.
> -- 
> 2.53.0
> 
> 

-- 
Mahesh J Salgaonkar

