Return-Path: <SRS0=nxP5=37=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC275C352A3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Feb 2020 12:22:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B1AF20714
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Feb 2020 12:22:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="JDvmOMq5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B1AF20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48H23204mlzDq8g
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Feb 2020 23:22:22 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48H1vB54yqzDqM7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Feb 2020 23:15:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=JDvmOMq5; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 48H1v86MR5z9sRR;
 Tue, 11 Feb 2020 23:15:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1581423333;
 bh=nfIHWvxD1KXgZayLaDPdRduSASGIy1jBmLpNhsQMQOY=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=JDvmOMq5dj0TejzEIA8r2RgJbIu9D2vCzDwraAhiTwJnRHu+4JU3h1Z4qhb0w0oy+
 /eNplDF/yYViIH/K9rUeZQioSaSCo//Wj/6XVovSgHX5UkjGk/aFGNAB0NUelHGDRa
 GdMdhkjjQ2dlrho8aJMvfgnCQUoaiN2YThiFF3XZDQtBGqpQAi0bVXxz15JAd4/Ir/
 2siNeAUWm6TGTRqBfTT2FU44rdRGcFNSYF/EDRxmbPbczzus73uLVnrUYhFzgrOy+o
 qCrj5ZtMsWG5T6T3DRgcmNZQeR/8XcOOtJqnlJRV3y8jKDP0XkatSSrslValrN0Z7t
 241iD3ZC1xbBg==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH RESEND] macintosh: convert to i2c_new_scanned_device
In-Reply-To: <20200210170401.5357-1-wsa+renesas@sang-engineering.com>
References: <20200210170401.5357-1-wsa+renesas@sang-engineering.com>
Date: Tue, 11 Feb 2020 23:15:17 +1100
Message-ID: <87ftfhz5ey.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Wolfram Sang <wsa+renesas@sang-engineering.com> writes:
> Move from the deprecated i2c_new_probed_device() to the new
> i2c_new_scanned_device(). No functional change for this driver because
> it doesn't check the return code anyhow.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>
> I can take this via I2C tree if this makes things easier...

Yes please. Sorry I missed it before.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers

>  drivers/macintosh/therm_windtunnel.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/macintosh/therm_windtunnel.c b/drivers/macintosh/therm_windtunnel.c
> index 8c744578122a..f15fec5e1cb6 100644
> --- a/drivers/macintosh/therm_windtunnel.c
> +++ b/drivers/macintosh/therm_windtunnel.c
> @@ -321,10 +321,10 @@ do_attach( struct i2c_adapter *adapter )
>  
>  		memset(&info, 0, sizeof(struct i2c_board_info));
>  		strlcpy(info.type, "therm_ds1775", I2C_NAME_SIZE);
> -		i2c_new_probed_device(adapter, &info, scan_ds1775, NULL);
> +		i2c_new_scanned_device(adapter, &info, scan_ds1775, NULL);
>  
>  		strlcpy(info.type, "therm_adm1030", I2C_NAME_SIZE);
> -		i2c_new_probed_device(adapter, &info, scan_adm1030, NULL);
> +		i2c_new_scanned_device(adapter, &info, scan_adm1030, NULL);
>  
>  		if( x.thermostat && x.fan ) {
>  			x.running = 1;
> -- 
> 2.20.1
