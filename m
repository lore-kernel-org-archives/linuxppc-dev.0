Return-Path: <SRS0=DRoX=MN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F48FC43143
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 22:48:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEDCB2089A
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 22:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="va/8npVA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEDCB2089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42PHWg4M0GzF3Cd
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 08:48:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=infradead.org header.i=@infradead.org header.b="va/8npVA";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1231::1; helo=merlin.infradead.org;
 envelope-from=geoff@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42PHRt5nNYzF3DZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Oct 2018 08:45:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HI5boBEuYWYlX+LQwyl8mS8lUYBwgX5dnwVtwXmAXQw=; b=va/8npVA7b7y4PSAc2WBkU4+Ij
 gycy7IfcdCSaKcHw7Qaqp0CD1ZX9fnSH/jL4z52BfqRGfFLSoMrgE1XEder1jHdxEDKuQTi8G/W0c
 UXqd5NM5IGyNOCrSa6PnT5fGJSKXkvzb0IK4oBRJEPN2/j9Fg+gjg6U6Dy2lPZqZCMZP07UTRc/cX
 aakAJr02FzQmwm3CPeLAYTqeJtIEsf+7BGRxx3rcdarYjUblkHQOQMY8SilBgpsDXzQt17+I6hRkP
 56p8q/DnpbX0/3yNzkrjB2SQOQRNzI5qJf/3UJyQ9E3QcwPbxaltHFVI3KEvTU0GaBnCiBw3ep2GO
 UaTjgZKQ==;
Received: from 50-233-148-155-static.hfc.comcastbusiness.net ([50.233.148.155]
 helo=[10.18.6.178])
 by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1g76wG-0001Qz-OI; Mon, 01 Oct 2018 22:45:17 +0000
Subject: Re: [PATCH] powerpc: signedness bug in update_flash_db()
To: Dan Carpenter <dan.carpenter@oracle.com>,
 Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
References: <20181001164458.GB29197@mwanda>
From: Geoff Levand <geoff@infradead.org>
Message-ID: <eddd842a-3754-9db6-9d10-aecd5ad42b4d@infradead.org>
Date: Mon, 1 Oct 2018 15:45:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181001164458.GB29197@mwanda>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: kernel-janitors@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 10/01/2018 09:44 AM, Dan Carpenter wrote:
> The "count < sizeof(struct os_area_db)" comparison is type promoted to
> size_t so negative values of "count" are treated as very high values and
> we accidentally return success instead of a negative error code.
> 
> This doesn't really change runtime much but it fixes a static checker
> warning.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> diff --git a/arch/powerpc/platforms/ps3/os-area.c b/arch/powerpc/platforms/ps3/os-area.c
> index cdbfc5cfd6f3..f5387ad82279 100644
> --- a/arch/powerpc/platforms/ps3/os-area.c
> +++ b/arch/powerpc/platforms/ps3/os-area.c
> @@ -664,7 +664,7 @@ static int update_flash_db(void)
>  	db_set_64(db, &os_area_db_id_rtc_diff, saved_params.rtc_diff);
>  
>  	count = os_area_flash_write(db, sizeof(struct os_area_db), pos);
> -	if (count < sizeof(struct os_area_db)) {
> +	if (count < 0 || count < sizeof(struct os_area_db)) {
>  		pr_debug("%s: os_area_flash_write failed %zd\n", __func__,
>  			 count);
>  		error = count < 0 ? count : -EIO;
> 

Seems OK.

Acked-by: Geoff Levand <geoff@infradead.org>

