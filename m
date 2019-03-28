Return-Path: <SRS0=U6gC=R7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C2EC43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Mar 2019 06:47:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5010220700
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Mar 2019 06:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="az5K5PI5";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JvWBn4nP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5010220700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44VFmQ4cDnzDqNT
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Mar 2019 17:47:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=codeaurora.org
 (client-ip=198.145.29.96; helo=smtp.codeaurora.org;
 envelope-from=mojha@codeaurora.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=codeaurora.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=codeaurora.org header.i=@codeaurora.org
 header.b="az5K5PI5"; 
 dkim=pass (1024-bit key) header.d=codeaurora.org header.i=@codeaurora.org
 header.b="JvWBn4nP"; dkim-atps=neutral
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44VFkg3MbYzDqNT
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Mar 2019 17:46:02 +1100 (AEDT)
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 0DDF86079C; Thu, 28 Mar 2019 06:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1553755561;
 bh=47bmnSigqol8Jggj4w+wPd+sqe8XXTSQCycP1p9Sh9o=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=az5K5PI5hPIURomd4dGJ3VVstlQSkAWGCt5CQtlyMxuBs8HbbMdXsXrgjsv7jVksk
 lcs3qYpczOkNK1T8dPSH2X+yYk4jXRRWAeEcXzwdIn7mLU1ckC3vzn4pN5k5X40k8F
 kvHxlxL9+wgt0WHMy9X/HjWmD83ff1F2kFnoN8hI=
Received: from [10.204.79.83]
 (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: mojha@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 0678560237;
 Thu, 28 Mar 2019 06:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1553755560;
 bh=47bmnSigqol8Jggj4w+wPd+sqe8XXTSQCycP1p9Sh9o=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=JvWBn4nPQN7cBDZrdJfAT1Hz9IpZnLm4ZdXrcPGs9RPsv2f9kJO5y9lLu2YusJB+U
 X+aBAqVrSYrsCWrBWcMnLciTNxhEoCz1C67kAxdhDclwxcLDbzVaq2C+ljLinD2Tks
 OXhujmCmh5UhE5UwpmOOkVSyEhO3g2uOuaf6Dd48=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0678560237
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] arch/powerpc: Remove duplicate headers
To: jagdsh.linux@gmail.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, npiggin@gmail.com, hristophe.leroy@c-s.fr,
 arnd@arndb.de, anton@ozlabs.org, paul.burton@mips.com, mikey@neuling.org,
 akpm@linux-foundation.org, mwb@linux.vnet.ibm.com
References: <1553345455-32085-1-git-send-email-jagdsh.linux@gmail.com>
From: Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <39b75391-1c80-c205-a253-8390811bdcac@codeaurora.org>
Date: Thu, 28 Mar 2019 12:15:48 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1553345455-32085-1-git-send-email-jagdsh.linux@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


On 3/23/2019 6:20 PM, jagdsh.linux@gmail.com wrote:
> From: Jagadeesh Pagadala <jagdsh.linux@gmail.com>
>
> Remove duplicate headers which are included twice.
>
> Signed-off-by: Jagadeesh Pagadala <jagdsh.linux@gmail.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

-Mukesh
> ---
>   arch/powerpc/kernel/time.c       | 1 -
>   arch/powerpc/lib/code-patching.c | 1 -
>   arch/powerpc/mm/numa.c           | 1 -
>   3 files changed, 3 deletions(-)
>
> diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
> index bc0503e..6ef3247 100644
> --- a/arch/powerpc/kernel/time.c
> +++ b/arch/powerpc/kernel/time.c
> @@ -43,7 +43,6 @@
>   #include <linux/timex.h>
>   #include <linux/kernel_stat.h>
>   #include <linux/time.h>
> -#include <linux/clockchips.h>
>   #include <linux/init.h>
>   #include <linux/profile.h>
>   #include <linux/cpu.h>
> diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
> index 506413a..587ff97 100644
> --- a/arch/powerpc/lib/code-patching.c
> +++ b/arch/powerpc/lib/code-patching.c
> @@ -15,7 +15,6 @@
>   #include <linux/cpuhotplug.h>
>   #include <linux/slab.h>
>   #include <linux/uaccess.h>
> -#include <linux/kprobes.h>
>   
>   #include <asm/pgtable.h>
>   #include <asm/tlbflush.h>
> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> index f976676..f3ee0e1 100644
> --- a/arch/powerpc/mm/numa.c
> +++ b/arch/powerpc/mm/numa.c
> @@ -32,7 +32,6 @@
>   #include <asm/sparsemem.h>
>   #include <asm/prom.h>
>   #include <asm/smp.h>
> -#include <asm/cputhreads.h>
>   #include <asm/topology.h>
>   #include <asm/firmware.h>
>   #include <asm/paca.h>
