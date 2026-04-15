Return-Path: <linuxppc-dev+bounces-19748-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B024FA0C28
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Apr 2026 04:41:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fwT4c647xz2xc8;
	Wed, 15 Apr 2026 14:41:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776228096;
	cv=none; b=TKdImWKpDx1QjV7UZQe79zTnIfKQL0IL4ok+EFJUtyAsdIoDY2AsubCdgwP91KvlPoJ4/m1/iZj4nAhudNQatMNYmYBGQjQggKzv9z5kOxBnHPOpI/NpXtyZEkHIvqoxWv6E+rxQMnW3YOWjV3306gZdawLb6g+TQzPhhplGB0nXpPHWJwDsAk46pB3z/Z8CjJcFszLO6Ra9jPg95nVL4azS+pSsaIEJ2TXabWdbOTTr/HFfQu0g3fdjBy+CLXdg0HdXDb7xYacaSnw2l88LYFsR1MWL7l0XY0oxUxfcz+IBa8hxahy/9PpWifGbxuX0xCceiyT+vGy1hD/V96dlyg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776228096; c=relaxed/relaxed;
	bh=SlXVWEDwM3MxJBKrS8GwnOlBHVkSM0XuaX2fOdWoAkQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=DYYfl/GbqNZm0cCEoNyjAtzCI2RlEz01g106uZqCsHOdoRUbo8q8TryS6y6tJm8XpGM3GPL8KcPJzTqvYmo3r5ibA7A2RCsuVNhsw3NiMMc6YswszEQzVld0fVcPIwjrCFJW54wYc4nlDPiJDJyrGysVdsEe4QGRdIHVSqaxIk3qmIjlEiUQxeoIHRd58lWeHbUJEhHB1kWhdlaOt070YKnnawYpiT4qhFrtHFzmt/0zpVgoJXH+Rwri9NG+VbaZTPdCm2g+cX/tsye6SYW+AUHs6OP9PS29WZSKHCP58tWASKwg3JL3Q1oUYCVy9DTRqqd7NlrshLrmfY7M8l8iVg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Uli8ofuw; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=shirisha@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Uli8ofuw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=shirisha@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fwT4b3kjDz2xS3
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2026 14:41:34 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63F3qqMx1860603;
	Wed, 15 Apr 2026 04:41:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=SlXVWE
	DwM3MxJBKrS8GwnOlBHVkSM0XuaX2fOdWoAkQ=; b=Uli8ofuwWMlU6UMu5+CFhp
	KfyD68ePINV1IWdFybu5RIp+tMESUS3VuECoLy/FEkUEvCCwp8ZVI+cKxSRy9VgN
	KlVyVoaB8ZOQeC/qzzllW+aCZ+ucM7ubvpWotDsFefGRvwqw9dkZhiw6LQMkRNBz
	4dP3JiEM3wQxevD7FyB3X0/3Req/IpOUbvDaXzaHhRYb44AL4dIx0V11X0cJ1Wtx
	W4uh8Am3mEQluF6DRXsQqSa1haoq1CyzcTRoTXd8l5ez6xbkz78GzFI6Iuve02sv
	+Y1jSgfw54xw4OzML3CwOLgS2i6Dp0RmT0NowPbwWiSklgu2eWUH5M/NUfQ3dDWw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89pdyvw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Apr 2026 04:41:14 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63ENCxrD025809;
	Wed, 15 Apr 2026 04:41:14 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dg3b1mepu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Apr 2026 04:41:14 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63F4fAqx28574186
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Apr 2026 04:41:10 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 97BA320040;
	Wed, 15 Apr 2026 04:41:10 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0CDB720043;
	Wed, 15 Apr 2026 04:41:07 +0000 (GMT)
Received: from li-d12addcc-2792-11b2-a85c-bd8df30615ab.ibm.com (unknown [9.43.92.110])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 15 Apr 2026 04:41:06 +0000 (GMT)
Message-ID: <94c902b07348fc8f406590c923387a532db4b7c6.camel@linux.ibm.com>
Subject: Re: [PATCH v2] ppc/fadump: invoke kmsg_dump in fadump panic path
From: Shirisha ganta <shirisha@linux.ibm.com>
To: Shivang Upadhyay <shivangu@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, kees@kernel.org, tony.luck@intel.com,
        gpiccoli@igalia.com, ritesh.list@gmail.com, rppt@kernel.org,
        Hari Bathini
 <hbathini@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>
Date: Wed, 15 Apr 2026 10:11:05 +0530
In-Reply-To: <20260412113057.46090-1-shivangu@linux.ibm.com>
References: <20260412113057.46090-1-shivangu@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-26.el8_10) 
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
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 68ROyXmkRqmFLvjzxpK4EqU-2elquNs3
X-Proofpoint-ORIG-GUID: _-vnYKujRhQ-vj7A0pf_FN45EzjgBhh7
X-Authority-Analysis: v=2.4 cv=WbE8rUhX c=1 sm=1 tr=0 ts=69df16eb cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=kTg7Ve40sHeub7HmClsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDAzNyBTYWx0ZWRfX50sGbHGiW6Ua
 fHLTNb3kTBNQG3Pp+UM+YRTHILxgbpg1ps8hASaYGq2Ve2DAYK7LoZbqFJwW6pCkCrVhnyxeDcG
 G8TurZrUXz6C2/YSOF8Ab2Db9VEEjpZshvffi6SmDG+EF/cFygaZvw+FQUl9zIm+C2WW7bDSMSb
 8ECxNbPRnqWKbWizZRDlmdGtagveIB4iN51WfMB98Pm1TKF4wIg0pt0CtdGK86M2H43TeFA/1co
 N17rcNCEpzNEC4G8kXDuAErXJfCcCdTt+Qtr5GpOI53qw2f4mt8yAQAy81goGw2czsoFAY5wSbq
 j1CtoZzX6Gsh90Wv4cmsiqDEGgNqQ4dPlxYINCacedSL8LnPc+WOg7TPpcnlsrSIHRE4E509/pt
 ZfqCPUWhq/hGyGzVXl41TeFP7PqDHCesIKiWxZ+n5jI9+2CLs9tpVOledQz69eaqA2rv05qBBia
 MXxfcC6J8uoauuXet3Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_04,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 spamscore=0 clxscore=1011
 phishscore=0 impostorscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604150037

On Sun, 2026-04-12 at 17:00 +0530, Shivang Upadhyay wrote:
> fadump is registered in panic_notifier_list and gets triggered before
> kmsg_dump_desc() in the panic path. As a result, kmsg_dumpers such as
> pstore are not executed during fadump crashes.
> 
> This is problematic because pstore provides a critical fallback
> mechanism
> for crash analysis. When fadump fails to successfully reboot the
> system
> or capture a dump, pstore logs may be the only available information
> from
> the crashed kernel. Without invoking kmsg_dump_desc() in the fadump
> path,
> we lose this valuable diagnostic data.
> 
> Invoke kmsg_dump_desc() from the fadump panic handler, but only when
> fadump is actually registered (checked via should_fadump_crash()).
> This
> ensures kmsg_dumpers are called without duplicating the call that
> occurs
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

Hi,
Tested this patch and dmesg-nvram file under /sys/fs/pstore is
getting updated with this patch after triggering dump with fadump

without this patch:
# ls -ltrh
total 0
-r--r--r--. 1 root root 6.5K Apr  2 06:22 dmesg-nvram-1
-r--r--r--. 1 root root 2.6K Apr 15 00:07 powerpc-common-nvram-6
-r--r--r--. 1 root root 2.1K Apr 15 00:07 rtas-nvram-1
-r--r--r--. 1 root root  688 Apr 15 00:07 powerpc-ofw-nvram-5

With this patch:
# ls -ltrh
total 0
-r--r--r--. 1 root root 6.4K Apr 15
00:36 dmesg-nvram-1
-r--r--r--. 1 root root 2.6K Apr 15 00:37 powerpc-
common-nvram-6
-r--r--r--. 1 root root 2.1K Apr 15 00:37 rtas-nvram-1
-r-
-r--r--. 1 root root  688 Apr 15 00:37 powerpc-ofw-nvram-5


Please add
below tag
Tested-by: Shirisha G <shirisha@linux.ibm.com>
> Changelog:
> 
> v2:
>   address comments from Sourabh, and sashikio-ai
>   added should_fadump_crash()
> 
> v1:
>   
> https://lore.kernel.org/all/20260407054341.308710-1-shivangu@linux.ibm.com/
> ---
>  arch/powerpc/kernel/setup-common.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/setup-common.c
> b/arch/powerpc/kernel/setup-common.c
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
> @@ -744,6 +745,13 @@ static int ppc_panic_fadump_handler(struct
> notifier_block *this,
>  	 */
>  	hard_irq_disable();
>  
> +	/*
> +	 * Invoke kmsg_dump (e.g., pstore) before crash_fadump() as
> fadump
> +	 * runs before panic()'s kmsg_dump_desc() call.
> +	 */
> +	if (should_fadump_crash())
> +		kmsg_dump_desc(KMSG_DUMP_PANIC, (char *)ptr);
> +
>  	/*
>  	 * If firmware-assisted dump has been registered then trigger
>  	 * its callback and let the firmware handles everything else.


