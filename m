Return-Path: <SRS0=rnOA=M4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA7FC4338F
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Aug 2021 05:10:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 788596104F
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Aug 2021 05:10:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 788596104F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GgGrw0LNKz3djc
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Aug 2021 15:10:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.235.10; helo=pegase2.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GgGrX12hcz3cLG
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Aug 2021 15:10:04 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
 by localhost (Postfix) with ESMTP id 4GgGrT41rxz9sX5;
 Thu,  5 Aug 2021 07:10:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
 by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RK_JnrGWDhK7; Thu,  5 Aug 2021 07:10:01 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase2.c-s.fr (Postfix) with ESMTP id 4GgGrT31whz9sX3;
 Thu,  5 Aug 2021 07:10:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 4ED558B7AE;
 Thu,  5 Aug 2021 07:10:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id c2u6BzGfRwSQ; Thu,  5 Aug 2021 07:10:01 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id E8EA28B76A;
 Thu,  5 Aug 2021 07:10:00 +0200 (CEST)
Subject: Re: [PATCH v4 09/10] net/ps3_gelic: Add new routine gelic_work_to_card
To: Geoff Levand <geoff@infradead.org>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
References: <cover.1627068552.git.geoff@infradead.org>
 <5634f7c76a67345c9735e05b68228ea899a8bf9d.1627068552.git.geoff@infradead.org>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <b0ae0cf5-5ec3-6634-e67e-8a0f64e9065e@csgroup.eu>
Date: Thu, 5 Aug 2021 07:10:02 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <5634f7c76a67345c9735e05b68228ea899a8bf9d.1627068552.git.geoff@infradead.org>
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
> Add new helper routine gelic_work_to_card that converts a work_struct
> to a gelic_card.
> 
> Signed-off-by: Geoff Levand <geoff@infradead.org>

Commit 3ffdbef9f86f ("net/ps3_gelic: Add new routine gelic_work_to_card") has no obvious style 
problems and is ready for submission.


> ---
>   drivers/net/ethernet/toshiba/ps3_gelic_net.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/toshiba/ps3_gelic_net.c b/drivers/net/ethernet/toshiba/ps3_gelic_net.c
> index 60fcca5d20dd..42f4de9ad5fe 100644
> --- a/drivers/net/ethernet/toshiba/ps3_gelic_net.c
> +++ b/drivers/net/ethernet/toshiba/ps3_gelic_net.c
> @@ -1420,6 +1420,11 @@ static const struct ethtool_ops gelic_ether_ethtool_ops = {
>   	.set_link_ksettings = gelic_ether_set_link_ksettings,
>   };
>   
> +static struct gelic_card *gelic_work_to_card(struct work_struct *work)
> +{
> +	return container_of(work, struct gelic_card, tx_timeout_task);
> +}
> +
>   /**
>    * gelic_net_tx_timeout_task - task scheduled by the watchdog timeout
>    * function (to be called not under interrupt status)
> @@ -1429,8 +1434,7 @@ static const struct ethtool_ops gelic_ether_ethtool_ops = {
>    */
>   static void gelic_net_tx_timeout_task(struct work_struct *work)
>   {
> -	struct gelic_card *card =
> -		container_of(work, struct gelic_card, tx_timeout_task);
> +	struct gelic_card *card = gelic_work_to_card(work);
>   	struct net_device *netdev = card->netdev[GELIC_PORT_ETHERNET_0];
>   	struct device *dev = ctodev(card);
>   
> 
