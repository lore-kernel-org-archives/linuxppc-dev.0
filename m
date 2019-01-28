Return-Path: <SRS0=7Eaw=QE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97414C282C8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jan 2019 09:50:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17B6621736
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jan 2019 09:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="TjCK3q1j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17B6621736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43p4d50QR3zDqGB
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jan 2019 20:50:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="TjCK3q1j"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43p4Zw4gxDzDq5c
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jan 2019 20:48:55 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43p4Zj59l4z9tyWj;
 Mon, 28 Jan 2019 10:48:45 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=TjCK3q1j; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id tOsduWZm3f3M; Mon, 28 Jan 2019 10:48:45 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43p4Zj2ZBNz9tyWq;
 Mon, 28 Jan 2019 10:48:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1548668925; bh=3ja51NZNj/j6tJujxhuxzZ+yPYmDdaBnp+GWigGHQVo=;
 h=Subject:To:References:From:Date:In-Reply-To:From;
 b=TjCK3q1jr1dDbdMbVJH0EkxzzKIqlHM6FBGE/tY+4mi320+ql8vsZP10NzhPEpUrv
 7l5mebign0fc0a6Jd/iCUKZID6+4NJtqoLZzKleeRurX9RzTSzoD10yLAiC6y/DxlL
 kT+7UYLO8rqwHD9mGDbG3cZw9dFbzRAwDJFjlDLw=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id A986A8B796;
 Mon, 28 Jan 2019 10:48:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id MvAOLsdafckI; Mon, 28 Jan 2019 10:48:51 +0100 (CET)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 77D848B79A;
 Mon, 28 Jan 2019 10:48:51 +0100 (CET)
Subject: Re: [PATCH] ucc_geth: Reset BQL queue when stopping device
To: Mathias Thore <mathias.thore@infinera.com>, leoyang.li@nxp.com,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 david.gounaris@infinera.com, joakim.tjernlund@infinera.com
References: <20190128090747.15851-1-mathias.thore@infinera.com>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <6bc7e64a-b91a-cb6e-ed65-5e412cef3a76@c-s.fr>
Date: Mon, 28 Jan 2019 10:48:52 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190128090747.15851-1-mathias.thore@infinera.com>
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi,

Le 28/01/2019 à 10:07, Mathias Thore a écrit :
> After a timeout event caused by for example a broadcast storm, when
> the MAC and PHY are reset, the BQL TX queue needs to be reset as
> well. Otherwise, the device will exhibit severe performance issues
> even after the storm has ended.

What are the symptomns ?

Is this reset needed on any network driver in that case, or is it 
something particular for the ucc_geth ?
For instance, the freescale fs_enet doesn't have that reset. Should it 
have it too ?

Christophe

> 
> Co-authored-by: David Gounaris <david.gounaris@infinera.com>
> Signed-off-by: Mathias Thore <mathias.thore@infinera.com>
> ---
>   drivers/net/ethernet/freescale/ucc_geth.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/freescale/ucc_geth.c b/drivers/net/ethernet/freescale/ucc_geth.c
> index c3d539e209ed..eb3e65e8868f 100644
> --- a/drivers/net/ethernet/freescale/ucc_geth.c
> +++ b/drivers/net/ethernet/freescale/ucc_geth.c
> @@ -1879,6 +1879,8 @@ static void ucc_geth_free_tx(struct ucc_geth_private *ugeth)
>   	u16 i, j;
>   	u8 __iomem *bd;
>   
> +	netdev_reset_queue(ugeth->ndev);
> +
>   	ug_info = ugeth->ug_info;
>   	uf_info = &ug_info->uf_info;
>   
> 
