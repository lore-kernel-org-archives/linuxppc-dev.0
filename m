Return-Path: <SRS0=rnOA=M4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24160C4338F
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Aug 2021 05:08:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4E6B6104F
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Aug 2021 05:08:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B4E6B6104F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GgGqD3Q6yz3dYM
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Aug 2021 15:08:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.235.10; helo=pegase2.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GgGpt004Yz3bY0
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Aug 2021 15:08:37 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
 by localhost (Postfix) with ESMTP id 4GgGpp6YtZz9sX1;
 Thu,  5 Aug 2021 07:08:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
 by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EUV2T3z4V6Op; Thu,  5 Aug 2021 07:08:34 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase2.c-s.fr (Postfix) with ESMTP id 4GgGpp5bkQz9sWW;
 Thu,  5 Aug 2021 07:08:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 9A6B38B7AE;
 Thu,  5 Aug 2021 07:08:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id PZ660VRD4lYy; Thu,  5 Aug 2021 07:08:34 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 349BC8B76A;
 Thu,  5 Aug 2021 07:08:34 +0200 (CEST)
Subject: Re: [PATCH v4 06/10] net/ps3_gelic: Cleanup debug code
To: Geoff Levand <geoff@infradead.org>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
References: <cover.1627068552.git.geoff@infradead.org>
 <8421aa2c148d840b11b7115208e5276017999c2a.1627068552.git.geoff@infradead.org>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <4b004fab-bf60-3e77-54f0-f2598ef81396@csgroup.eu>
Date: Thu, 5 Aug 2021 07:08:35 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <8421aa2c148d840b11b7115208e5276017999c2a.1627068552.git.geoff@infradead.org>
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
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 23/07/2021 à 22:31, Geoff Levand a écrit :
> In an effort to make the PS3 gelic driver easier to maintain, change the
> gelic_card_enable_rxdmac routine to use the optimizer to remove
> debug code.
> 
> Signed-off-by: Geoff Levand <geoff@infradead.org>


WARNING:VSPRINTF_SPECIFIER_PX: Using vsprintf specifier '%px' potentially exposes the kernel memory 
layout, if you don't really need the address please consider using '%p'.
#38: FILE: drivers/net/ethernet/toshiba/ps3_gelic_net.c:171:
+		dev_err(dev, "%s:%d: head=%px\n", __func__, __LINE__,
+			card->rx_chain.head);


NOTE: For some of the reported defects, checkpatch may be able to
       mechanically convert to the typical style using --fix or --fix-inplace.

Commit 65f38d9720ac ("net/ps3_gelic: Cleanup debug code") has style problems, please review.

NOTE: Ignored message types: ARCH_INCLUDE_LINUX BIT_MACRO COMPARISON_TO_NULL DT_SPLIT_BINDING_PATCH 
EMAIL_SUBJECT FILE_PATH_CHANGES GLOBAL_INITIALISERS LINE_SPACING MULTIPLE_ASSIGNMENTS


> ---
>   drivers/net/ethernet/toshiba/ps3_gelic_net.c | 19 +++++++++----------
>   1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/ethernet/toshiba/ps3_gelic_net.c b/drivers/net/ethernet/toshiba/ps3_gelic_net.c
> index 54e50ad9e629..85fc1915c8be 100644
> --- a/drivers/net/ethernet/toshiba/ps3_gelic_net.c
> +++ b/drivers/net/ethernet/toshiba/ps3_gelic_net.c
> @@ -162,17 +162,16 @@ static void gelic_card_enable_rxdmac(struct gelic_card *card)
>   	struct device *dev = ctodev(card);
>   	int status;
>   
> -#ifdef DEBUG
> -	if (gelic_descr_get_status(card->rx_chain.head) !=
> -	    GELIC_DESCR_DMA_CARDOWNED) {
> -		printk(KERN_ERR "%s: status=%x\n", __func__,
> -		       be32_to_cpu(card->rx_chain.head->dmac_cmd_status));
> -		printk(KERN_ERR "%s: nextphy=%x\n", __func__,
> -		       be32_to_cpu(card->rx_chain.head->hw_regs.next_descr_addr));
> -		printk(KERN_ERR "%s: head=%p\n", __func__,
> -		       card->rx_chain.head);
> +	if (__is_defined(DEBUG) && (gelic_descr_get_status(card->rx_chain.head)
> +			!= GELIC_DESCR_DMA_CARDOWNED)) {
> +		dev_err(dev, "%s:%d: status=%x\n", __func__, __LINE__,
> +			be32_to_cpu(card->rx_chain.head->hw_regs.dmac_cmd_status));
> +		dev_err(dev, "%s:%d: nextphy=%x\n", __func__, __LINE__,
> +			be32_to_cpu(card->rx_chain.head->hw_regs.next_descr_addr));
> +		dev_err(dev, "%s:%d: head=%px\n", __func__, __LINE__,
> +			card->rx_chain.head);
>   	}
> -#endif
> +
>   	status = lv1_net_start_rx_dma(bus_id(card), dev_id(card),
>   		card->rx_chain.head->link.cpu_addr, 0);
>   
> 
