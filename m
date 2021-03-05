Return-Path: <SRS0=c12Q=ID=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D0EC433E0
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Mar 2021 05:50:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40D8E65014
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Mar 2021 05:50:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40D8E65014
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DsGzN3D3zz3dD3
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Mar 2021 16:50:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DsGyx4P1Cz3cjS
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Mar 2021 16:49:41 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4DsGyk0kMkz9v0y8;
 Fri,  5 Mar 2021 06:49:34 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id rXh9-mUwBGuX; Fri,  5 Mar 2021 06:49:34 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4DsGyj70Ldz9v0y7;
 Fri,  5 Mar 2021 06:49:33 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 36CF68B78B;
 Fri,  5 Mar 2021 06:49:34 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id nNPIaJ4uIMZU; Fri,  5 Mar 2021 06:49:33 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 220958B78E;
 Fri,  5 Mar 2021 06:49:27 +0100 (CET)
Subject: Re: [PATCH] ibmvnic: remove excessive irqsave
To: angkery <angkery@163.com>, mpe@ellerman.id.au, benh@kernel.crashing.org,
 paulus@samba.org, drt@linux.ibm.com, ljp@linux.ibm.com,
 sukadev@linux.ibm.com, davem@davemloft.net, kuba@kernel.org
References: <20210305014350.1460-1-angkery@163.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <67215668-0850-a0f3-06e1-49db590b8fcc@csgroup.eu>
Date: Fri, 5 Mar 2021 06:49:14 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210305014350.1460-1-angkery@163.com>
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
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Junlin Yang <yangjunlin@yulong.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 05/03/2021 à 02:43, angkery a écrit :
> From: Junlin Yang <yangjunlin@yulong.com>
> 
> ibmvnic_remove locks multiple spinlocks while disabling interrupts:
> spin_lock_irqsave(&adapter->state_lock, flags);
> spin_lock_irqsave(&adapter->rwi_lock, flags);
> 
> there is no need for the second irqsave,since interrupts are disabled
> at that point, so remove the second irqsave:

The problème is not that there is no need. The problem is a lot more serious:
As reported by coccinella, the second _irqsave() overwrites the value saved in 'flags' by the first 
_irqsave, therefore when the second _irqrestore comes, the value in 'flags' is not valid, the value 
saved by the first _irqsave has been lost. This likely leads to IRQs remaining disabled, which is 
_THE_ problem really.

> spin_lock_irqsave(&adapter->state_lock, flags);
> spin_lock(&adapter->rwi_lock);
> 
> Generated by: ./scripts/coccinelle/locks/flags.cocci
> ./drivers/net/ethernet/ibm/ibmvnic.c:5413:1-18:
> ERROR: nested lock+irqsave that reuses flags from line 5404.
> 
> Signed-off-by: Junlin Yang <yangjunlin@yulong.com>
> ---
>   drivers/net/ethernet/ibm/ibmvnic.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
> index 2464c8a..a52668d 100644
> --- a/drivers/net/ethernet/ibm/ibmvnic.c
> +++ b/drivers/net/ethernet/ibm/ibmvnic.c
> @@ -5408,9 +5408,9 @@ static void ibmvnic_remove(struct vio_dev *dev)
>   	 * after setting state, so __ibmvnic_reset() which is called
>   	 * from the flush_work() below, can make progress.
>   	 */
> -	spin_lock_irqsave(&adapter->rwi_lock, flags);
> +	spin_lock(&adapter->rwi_lock);
>   	adapter->state = VNIC_REMOVING;
> -	spin_unlock_irqrestore(&adapter->rwi_lock, flags);
> +	spin_unlock(&adapter->rwi_lock);
>   
>   	spin_unlock_irqrestore(&adapter->state_lock, flags);
>   
> 
