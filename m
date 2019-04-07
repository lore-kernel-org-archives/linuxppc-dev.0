Return-Path: <SRS0=YAae=SJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11FF3C10F0E
	for <linuxppc-dev@archiver.kernel.org>; Sun,  7 Apr 2019 06:18:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 467E220B1F
	for <linuxppc-dev@archiver.kernel.org>; Sun,  7 Apr 2019 06:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="lEPkkgTC";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="lEPkkgTC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 467E220B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44cNfg6t9bzDqSR
	for <linuxppc-dev@archiver.kernel.org>; Sun,  7 Apr 2019 16:18:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=codeaurora.org
 (client-ip=198.145.29.96; helo=smtp.codeaurora.org;
 envelope-from=mojha@codeaurora.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=codeaurora.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=codeaurora.org header.i=@codeaurora.org
 header.b="lEPkkgTC"; 
 dkim=pass (1024-bit key) header.d=codeaurora.org header.i=@codeaurora.org
 header.b="lEPkkgTC"; dkim-atps=neutral
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44cNd204fPzDqN7
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  7 Apr 2019 16:17:25 +1000 (AEST)
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id A892A60A4E; Sun,  7 Apr 2019 06:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1554617842;
 bh=lF5ZZpsM09cy4kzAr7ABnAwV4eIOLHbBq8F9ftKmf0U=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=lEPkkgTCBt2J1cqGdWrZGcSN/0wmBN7omL31Wl3zLfHcCYBuvTjtC+5bOi7gBFQh6
 sNeN6366WKwo4hypEpBGfqTyv3fZhI8NTv7Qn+RSPQ52RW6+xLstFQ6Qf4gkxHEA4u
 AxwJ0eQX65fbhK8s/HhMUF6by92muVeVsZhyR95A=
Received: from [10.79.171.6]
 (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: mojha@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id A9E1D6044E;
 Sun,  7 Apr 2019 06:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1554617842;
 bh=lF5ZZpsM09cy4kzAr7ABnAwV4eIOLHbBq8F9ftKmf0U=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=lEPkkgTCBt2J1cqGdWrZGcSN/0wmBN7omL31Wl3zLfHcCYBuvTjtC+5bOi7gBFQh6
 sNeN6366WKwo4hypEpBGfqTyv3fZhI8NTv7Qn+RSPQ52RW6+xLstFQ6Qf4gkxHEA4u
 AxwJ0eQX65fbhK8s/HhMUF6by92muVeVsZhyR95A=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A9E1D6044E
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] powerpc/pseries/pmem: fix a set but not used value
To: Qian Cai <cai@lca.pw>, mpe@ellerman.id.au, benh@kernel.crashing.org,
 paulus@samba.org
References: <20190407015447.39292-1-cai@lca.pw>
From: Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <c4b9aff8-ea32-0adb-f1c0-ea418643f442@codeaurora.org>
Date: Sun, 7 Apr 2019 11:47:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190407015447.39292-1-cai@lca.pw>
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
Cc: linuxppc-dev@lists.ozlabs.org, oohall@gmail.com,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


On 4/7/2019 7:24 AM, Qian Cai wrote:
> The commit 4c5d87db4978 ("powerpc/pseries: PAPR persistent memory
> support") set a local variable "count" in dlpar_hp_pmem() but never
> use it.
>
> arch/powerpc/platforms/pseries/pmem.c: In function 'dlpar_hp_pmem':
> arch/powerpc/platforms/pseries/pmem.c:109:6: warning: variable 'count'
> set but not used [-Wunused-but-set-variable]
>
> Signed-off-by: Qian Cai <cai@lca.pw>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh
> ---
>   arch/powerpc/platforms/pseries/pmem.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/platforms/pseries/pmem.c b/arch/powerpc/platforms/pseries/pmem.c
> index 27f0a915c8a9..f860a897a9e0 100644
> --- a/arch/powerpc/platforms/pseries/pmem.c
> +++ b/arch/powerpc/platforms/pseries/pmem.c
> @@ -106,7 +106,7 @@ static ssize_t pmem_drc_remove_node(u32 drc_index)
>   
>   int dlpar_hp_pmem(struct pseries_hp_errorlog *hp_elog)
>   {
> -	u32 count, drc_index;
> +	u32 drc_index;
>   	int rc;
>   
>   	/* slim chance, but we might get a hotplug event while booting */
> @@ -123,7 +123,6 @@ int dlpar_hp_pmem(struct pseries_hp_errorlog *hp_elog)
>   		return -EINVAL;
>   	}
>   
> -	count = hp_elog->_drc_u.drc_count;
>   	drc_index = hp_elog->_drc_u.drc_index;
>   
>   	lock_device_hotplug();
