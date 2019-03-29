Return-Path: <SRS0=YrVw=SA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 678A8C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 21:31:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D38EF218A2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 21:31:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ewsK2G44";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jgo2nrPx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D38EF218A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44WFKs6NCKzDqV2
	for <linuxppc-dev@archiver.kernel.org>; Sat, 30 Mar 2019 08:31:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=codeaurora.org
 (client-ip=198.145.29.96; helo=smtp.codeaurora.org;
 envelope-from=mojha@codeaurora.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=codeaurora.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=codeaurora.org header.i=@codeaurora.org
 header.b="ewsK2G44"; 
 dkim=pass (1024-bit key) header.d=codeaurora.org header.i=@codeaurora.org
 header.b="jgo2nrPx"; dkim-atps=neutral
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44WFJ03jLgzDqQc
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Mar 2019 08:29:51 +1100 (AEDT)
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
 id 849736087D; Fri, 29 Mar 2019 21:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1553894989;
 bh=J0wz0I+Iwv9SmSNn3kJ+vHfOj5hN3rY1UZMX4khmb2M=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=ewsK2G44sa5xNhsuzwc6MdXbxJWuUVnMpIozLJdw2QIkfV/ltXtQY50GWplGDhcFn
 8LytQNy4KtuLFskJkoXwtwniTHm8eHShyJW5xfICvcTwq73ekvKj+z31gaHGCSJMgJ
 szJ1AnFmkemrvMnvlbbhz2wGk2wW7fK48cHOL7Tc=
Received: from [10.79.168.116]
 (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: mojha@smtp.codeaurora.org)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 5D25E6087D;
 Fri, 29 Mar 2019 21:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
 s=default; t=1553894987;
 bh=J0wz0I+Iwv9SmSNn3kJ+vHfOj5hN3rY1UZMX4khmb2M=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=jgo2nrPxNy2z5n/R157FwpwImkF4CXzELhQmMMnVWgGUEOB2Y5avzr3l/xzhP/OTR
 OvJhsuzqGNcKJlAxloc6hschIXP+QgwcTX97N31xHoreRR2Sbnv1uuQdWfd79FLbAP
 rWEY5k38vpLUkCRYgmDKeYvFQNfQyxENiI+AaSbk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5D25E6087D
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH -next] ocxl: remove set but not used variables 'tid' and
 'lpid'
To: Yue Haibing <yuehaibing@huawei.com>, fbarrat@linux.ibm.com,
 andrew.donnellan@au1.ibm.com, arnd@arndb.de, gregkh@linuxfoundation.org
References: <20190329154456.27152-1-yuehaibing@huawei.com>
From: Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <b30655eb-dcd1-16b2-78a0-6886ceb9ef3d@codeaurora.org>
Date: Sat, 30 Mar 2019 02:59:38 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190329154456.27152-1-yuehaibing@huawei.com>
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


On 3/29/2019 9:14 PM, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
>
> Fixes gcc '-Wunused-but-set-variable' warning:
>
> drivers/misc/ocxl/link.c: In function 'xsl_fault_handler':
> drivers/misc/ocxl/link.c:187:17: warning: variable 'tid' set but not used [-Wunused-but-set-variable]
> drivers/misc/ocxl/link.c:187:6: warning: variable 'lpid' set but not used [-Wunused-but-set-variable]
>
> They are never used and can be removed.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh
> ---
>   drivers/misc/ocxl/link.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/misc/ocxl/link.c b/drivers/misc/ocxl/link.c
> index d50b861..3be07e9 100644
> --- a/drivers/misc/ocxl/link.c
> +++ b/drivers/misc/ocxl/link.c
> @@ -184,7 +184,7 @@ static irqreturn_t xsl_fault_handler(int irq, void *data)
>   	u64 dsisr, dar, pe_handle;
>   	struct pe_data *pe_data;
>   	struct ocxl_process_element *pe;
> -	int lpid, pid, tid;
> +	int pid;
>   	bool schedule = false;
>   
>   	read_irq(spa, &dsisr, &dar, &pe_handle);
> @@ -192,9 +192,7 @@ static irqreturn_t xsl_fault_handler(int irq, void *data)
>   
>   	WARN_ON(pe_handle > SPA_PE_MASK);
>   	pe = spa->spa_mem + pe_handle;
> -	lpid = be32_to_cpu(pe->lpid);
>   	pid = be32_to_cpu(pe->pid);
> -	tid = be32_to_cpu(pe->tid);
>   	/* We could be reading all null values here if the PE is being
>   	 * removed while an interrupt kicks in. It's not supposed to
>   	 * happen if the driver notified the AFU to terminate the
