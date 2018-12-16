Return-Path: <SRS0=MdcX=OZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89709C43387
	for <linuxppc-dev@archiver.kernel.org>; Sun, 16 Dec 2018 18:31:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCD9E217FA
	for <linuxppc-dev@archiver.kernel.org>; Sun, 16 Dec 2018 18:31:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYFTQ6vc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCD9E217FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43HtCB5F6rzDqd1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Dec 2018 05:31:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XYFTQ6vc";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::442; helo=mail-wr1-x442.google.com;
 envelope-from=chunkeey@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="XYFTQ6vc"; 
 dkim-atps=neutral
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Ht8S4ttJzDqWy
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Dec 2018 05:28:37 +1100 (AEDT)
Received: by mail-wr1-x442.google.com with SMTP id t6so9902396wrr.12
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 Dec 2018 10:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jRg3kjWvoi2TdXahZmWkdIb2kkNQMkqfQs6dghCzdbw=;
 b=XYFTQ6vcLSF4PLnw0l8OVYKvCErjzxjCbaQx8kSxSJM+6Bsvf8jlU/4aUmC+0uJk2H
 h+QOtKR3/CZOD5iQxNPD0pK0DiIrbYKuW12BatV8XmLRTkpvjGzJ23a438u1drsjKJrH
 +ARpbssu906cxrDZB8dNd1xNzvNcAyfNPR6i53ynh7z352niMmf75mLfz+sV+ueg9yP7
 4EhQ0bToF56tnbXr/jhHd/5H3COpJTEEGkaa6IC63VlbWTSzHfR/E3COyLhwFjYJydyN
 bifCklIl4nUrLVkXu3c0ea5PHP/shgTVriiC5IR8qq7Q/5C/HzZDzdxquXLywI2E51yX
 BNPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jRg3kjWvoi2TdXahZmWkdIb2kkNQMkqfQs6dghCzdbw=;
 b=RVLPsMq1sJS30XPCuW3HAlfZc61ZB497UGiIbF+PVmshGiQUeHbfJz/TcTHZgNpz0k
 vXRa0wrajJXa9LfRq+LfvrzR8rKObL4Ahi91fYnXmQfbNg8KFJ1ERPF6R2sYl9UZJwUS
 r2gAcV/ngWttjgUpClQdlb+3cq+62cYkjAxShk710CWfNgIjwspStWHm2SJ0qfTnFlq2
 CrcEmCtiKloOA7fHzLK6469jlHXs9l+JrtRpWaFb9BXVNdVq6dUkU1BqDonoK9UQr28r
 YenDwjyfWSH9StWnXVFNU92Zns3fMvF84BHOIdH/N2Rs+La79Ll23S/uFqfXGjtGlJAW
 dP2g==
X-Gm-Message-State: AA+aEWaoHqusoiXOWL8G410zCM2gYClsLBNZcCyN4KgowhOCajicCvfZ
 0eisCj+x+aClxSn5E2uGPGs=
X-Google-Smtp-Source: AFSGD/XSvJuKv/Urc4sjcpbM/OgQ9jcZZbYRWPBf9GWLQ/ZOcR7gcFCJEQ5AAayp6OZSrsxoSGrX+w==
X-Received: by 2002:adf:cd0e:: with SMTP id w14mr8822377wrm.218.1544984914099; 
 Sun, 16 Dec 2018 10:28:34 -0800 (PST)
Received: from debian64.daheim (p4FD09E54.dip0.t-ipconnect.de. [79.208.158.84])
 by smtp.gmail.com with ESMTPSA id l20sm27975455wrb.93.2018.12.16.10.28.33
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 16 Dec 2018 10:28:33 -0800 (PST)
Received: from localhost.daheim ([127.0.0.1] helo=debian64.localnet)
 by debian64.daheim with esmtp (Exim 4.91)
 (envelope-from <chunkeey@gmail.com>)
 id 1gYb9U-0008Ns-MD; Sun, 16 Dec 2018 19:28:32 +0100
From: Christian Lamparter <chunkeey@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 3/8] crypto4xx_core: don't abuse __dma_sync_page
Date: Sun, 16 Dec 2018 19:28:32 +0100
Message-ID: <2753567.GDuzzzdScT@debian64>
In-Reply-To: <20181216171951.31306-4-hch@lst.de>
References: <20181216171951.31306-1-hch@lst.de>
 <20181216171951.31306-4-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
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
Cc: David Miller <davem@davemloft.net>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sunday, December 16, 2018 6:19:46 PM CET Christoph Hellwig wrote:
> This function is internal to the DMA API implementation.  Instead use the
> DMA API to properly unmap.  Note that the DMA API usage in this driver
> is a disaster and urgently needs some work - it is missing all the unmaps,
> seems to do a secondary map where it looks like it should to a unmap
> in one place to work around cache coherency and the directions passed in
> seem to be partially wrong.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/crypto/amcc/crypto4xx_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/crypto/amcc/crypto4xx_core.c b/drivers/crypto/amcc/crypto4xx_core.c
> index 6eaec9ba0f68..63cb6956c948 100644
> --- a/drivers/crypto/amcc/crypto4xx_core.c
> +++ b/drivers/crypto/amcc/crypto4xx_core.c
> @@ -596,7 +596,7 @@ static void crypto4xx_aead_done(struct crypto4xx_device *dev,
>  					  pd->pd_ctl_len.bf.pkt_len,
>  					  dst);
>  	} else {
> -		__dma_sync_page(sg_page(dst), dst->offset, dst->length,
> +		dma_unmap_page(dev->core_dev->device, pd->dest, dst->length,
>  				DMA_FROM_DEVICE);
>  	}
>  
> 
Yeap, the crypto4xx is a real piece of work. However, ibm emac network driver
is even worse:
|/*
| * Lack of dma_unmap_???? calls is intentional.
| *
| * API-correct usage requires additional support state information to be
| * maintained for every RX and TX buffer descriptor (BD). Unfortunately, due to
| * EMAC design (e.g. TX buffer passed from network stack can be split into
| * several BDs, dma_map_single/dma_map_page can be used to map particular BD),
| * maintaining such information will add additional overhead.
| * Current DMA API implementation for 4xx processors only ensures cache coherency
| * and dma_unmap_???? routines are empty and are likely to stay this way.
| * I decided to omit dma_unmap_??? calls because I don't want to add additional
| * complexity just for the sake of following some abstract API, when it doesn't
| * add any real benefit to the driver. I understand that this decision maybe
| * controversial, but I really tried to make code API-correct and efficient
| * at the same time and didn't come up with code I liked :(.                --ebs
| */
<https://elixir.bootlin.com/linux/v4.20-rc6/source/drivers/net/ethernet/ibm/emac/core.c#L58>

Problem is, I can't really enable the DMA_DEBUG because every PPC4XX/APM82181
device I have is some sort of network appliance. So a proper test would require
to fix the emac driver first since DMA_DEBUG will disable itself.

Regards,
Christian

PS: Since it looks like you are located in Germany as well:
If you are interested (PM me), I could just mail you a "MyBook Live" 
NAS Kit (PCB, Shell, Screws). All you would need: a SATA 3,5" HDD and
a standard 12V PSU with a 5.5mm plug. I maintain a active OpenWrt port
for the device: 
http://downloads.openwrt.org/snapshots/targets/apm821xx/sata/


