Return-Path: <SRS0=wfsy=OA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34380C43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Nov 2018 10:47:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B03D92146F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Nov 2018 10:47:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B03D92146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 430K5d4lzSzF3G8
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Nov 2018 21:47:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 430K3Z3FdYzF3Fh
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Nov 2018 21:45:30 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 430K3P5wcTz9vF7K;
 Wed, 21 Nov 2018 11:45:21 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id anB1K_LhuOkF; Wed, 21 Nov 2018 11:45:21 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 430K3P5Pw8z9vF7R;
 Wed, 21 Nov 2018 11:45:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 67FAC8B808;
 Wed, 21 Nov 2018 11:45:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id lC8aQVMCjNZT; Wed, 21 Nov 2018 11:45:26 +0100 (CET)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 2F26F8B809;
 Wed, 21 Nov 2018 11:45:26 +0100 (CET)
Subject: Re: [PATCH 2/4] soc/fsl/qe: fix potential NULL pointer dereference in
 ucc_of_parse_tdm
To: Wen Yang <wen.yang99@zte.com.cn>, qiang.zhao@nxp.com
References: <1542786111-18648-1-git-send-email-wen.yang99@zte.com.cn>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <d69e7c77-e9fa-470a-db9f-ff9cd0476334@c-s.fr>
Date: Wed, 21 Nov 2018 11:45:26 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <1542786111-18648-1-git-send-email-wen.yang99@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
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
Cc: wang.yi59@zte.com.cn, zhong.weidong@zte.com.cn,
 linux-kernel@vger.kernel.org, leoyang.li@nxp.com,
 Julia Lawall <julia.lawall@lip6.fr>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 21/11/2018 à 08:41, Wen Yang a écrit :
> This patch fixes a possible null pointer dereference in
> ucc_of_parse_tdm, detected by the semantic patch
> deref_null.cocci, with the following warning:
> 
> ./drivers/soc/fsl/qe/qe_tdm.c:177:21-24: ERROR: pdev is NULL but dereferenced.
> 
> The following code has potential null pointer references:
>          pdev = of_find_device_by_node(np2);
>          if (!pdev) {
>                  ret = -EINVAL;
>                  pr_err("%pOFn: failed to lookup pdev\n", np2);
>                  of_node_put(np2);
>                  goto err_miss_siram_property;
>          }
> ...
> err_miss_siram_property:
>          devm_iounmap(&pdev->dev, utdm->si_regs);
> 
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> Reviewed-by: Tan Hu <tan.hu@zte.com.cn>
> CC: Julia Lawall <julia.lawall@lip6.fr>
> ---
>   drivers/soc/fsl/qe/qe_tdm.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/fsl/qe/qe_tdm.c b/drivers/soc/fsl/qe/qe_tdm.c
> index f78c346..166378b 100644
> --- a/drivers/soc/fsl/qe/qe_tdm.c
> +++ b/drivers/soc/fsl/qe/qe_tdm.c
> @@ -174,7 +174,8 @@ int ucc_of_parse_tdm(struct device_node *np, struct ucc_tdm *utdm,
>   	return ret;
>   
>   err_miss_siram_property:
> -	devm_iounmap(&pdev->dev, utdm->si_regs);
> +	if (pdev)
> +		devm_iounmap(&pdev->dev, utdm->si_regs);

You are just hiding the issue, not fixing it.

The problem is that pdev gets modified, so in any case that 
devm_iounmap() will fail even when the new pdev is valid, because the 
iomap was done with a different pdev.

Christophe



>   	return ret;
>   }
>   EXPORT_SYMBOL(ucc_of_parse_tdm);
> 
