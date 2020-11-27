Return-Path: <SRS0=TXb4=FB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65776C5519F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Nov 2020 19:42:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C934624101
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Nov 2020 19:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pdVVZsKG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C934624101
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CjQ5J57P0zDsyL
	for <linuxppc-dev@archiver.kernel.org>; Sat, 28 Nov 2020 06:42:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=geoff@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=casper.20170209 header.b=pdVVZsKG; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CjQ284YCVzDsP3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Nov 2020 06:40:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=HDO0lvB/IW2WP8pQ3K4owXxOcixVsZDPop/IlMZ+VGg=; b=pdVVZsKGy8oWg3LV4u68OoiqBv
 i07JyFoeprOcDOSTRpMonapR2i3o3Wc2zxWlVYtJ52ZUWee874IW6h7Az152vLR1WF88VxirV1VCk
 8nbhscfPGw9VG9Y7Ie37+VERNfWS5BnD4hVAi6PvdBA2v9KKsif5WMvjHcLNK8+8S9v1TJaZ49+t2
 tnqK4UnYVoHM6iwWSLjByXNQix3lbecR5rIkOLBlVqWUlX216A9fxXjngAAZXo9qP5L7Hoik5MfpR
 Ux7pouaR+R0psAhj1L/Sl2dFy+M1F+ZkaHWSF6TKZKavBb33KEYAV22yzH8vbtu9A9jfVQ+6Msei3
 FKPAmgrg==;
Received: from [2602:306:c5a2:a380:9e7b:efff:fe40:2b26]
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kijb0-0005cz-HC; Fri, 27 Nov 2020 19:39:54 +0000
Subject: Re: [PATCH] ALSA: ppc: remove redundant checks in PS3 driver probe
To: Leonard Goehrs <l.goehrs@pengutronix.de>, u.kleine-koenig@pengutronix.de, 
 perex@perex.cz, tiwai@suse.com, mpe@ellerman.id.au
References: <20201127094547.4zcyeycfrriitkqx@pengutronix.de>
 <20201127152259.1470079-1-l.goehrs@pengutronix.de>
From: Geoff Levand <geoff@infradead.org>
Message-ID: <4b84b78f-1173-c357-da3e-02c9c347aa61@infradead.org>
Date: Fri, 27 Nov 2020 11:39:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201127152259.1470079-1-l.goehrs@pengutronix.de>
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
Cc: alsa-devel@alsa-project.org, paulus@samba.org, kernel@pengutronix.de,
 Geert Uytterhoeven <geert@linux-m68k.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 11/27/20 7:22 AM, Leonard Goehrs wrote:
> The check for the FW_FEATURE_PS3_LV1 firmware feature is already performed
> in ps3_system_bus_init() before registering the driver. So if the probe
> function is actually used, this feature is already known to be available.
> 
> The check for the match id is also superfluous; the condition is always
> true because the bus' match function (ps3_system_bus_match()) only
> considers this driver for devices having:
> dev->match_id == snd_ps3_bus_driver_info.match_id.
> 
> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Leonard Goehrs <l.goehrs@pengutronix.de>

Seems OK with v5.9 on PS3.

Tested by: Geoff Levand <geoff@infradead.org>


