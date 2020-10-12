Return-Path: <SRS0=fZjV=DT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675C1C43457
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Oct 2020 19:11:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F1A9214DB
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Oct 2020 19:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9GVLTZc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F1A9214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4C97ZQ6jZ8zDqdk
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Oct 2020 06:11:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::643;
 helo=mail-pl1-x643.google.com; envelope-from=nicoleotsuka@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=b9GVLTZc; dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C97Vy4PZJzDqNr
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2020 06:08:26 +1100 (AEDT)
Received: by mail-pl1-x643.google.com with SMTP id y1so5611586plp.6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2020 12:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=zW/ankKb/VemIvdGEdb5qHcmtQbdYR++io0wzUbX+nA=;
 b=b9GVLTZcD8hI5Pa0lYQpQysftTjixmM5ALJCTVZvP5J6ZHy41IBA9DS+ExAop9sM59
 /LI3g52m0l+5VzqiQoyp/GweRshZlzeOPSbmksxJs4frRcBz563P7Hec6N+xDpK8wq+d
 8xnCF3fbAxMWBnCbEkJvn0BBQoFar7dwIhn8ikDQXXO6Vm48qVc2p2zBMDfvrYB1pBvd
 8PHewJl4Z3+FanYnqYBnnSJSz8LkIn2FLP6yvyON8BXeiu/kOnbn/7M7p8zzIz3APhND
 KQDqJ4CgOxP2NtEakj4BLHA+jT1Fo6XhGwquEEKFbUb19sahC8pEf5jRxYeEzDJSBFqt
 SoBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=zW/ankKb/VemIvdGEdb5qHcmtQbdYR++io0wzUbX+nA=;
 b=SDAq9bNoKuq85uQYoBWooMgQIe0zA//4FsBqV7UC0aquuAyiXeFuhEZNDfhgorH2qG
 7c2WW9LudMof4QBcbXr4S2ub22iFnZZAzPdzLtNEDx3UIUl0yUNYdGRNiSR3lAUMpak2
 EOVTdbOIqrv5GB4/K7/Ap5qHs2G6q6C3e1bXkIDzHBCmzjG758qS7+f5KKAQTwPVZ01h
 fuG2yzoqFJQ8OJbf72+j9wYtAm6sGAP4wEwwe+Od2JkwyFlNtna1hWmFFshCAdaYzap0
 e85Rq3kU0pXCzTzLZGDHpIiAl0cOoGmhLhXPGtAVr0Gj6M2Qmsg2Uey8m5DqtdXdC+ZP
 VqWg==
X-Gm-Message-State: AOAM530QAh9HB5psF2D76hL/uA3++CR5SaUvS3KVX8R6NIxjfjjghPOp
 mOmWgNaKLAMQH4AiKoDFzF4=
X-Google-Smtp-Source: ABdhPJz+f2A+tX5w9xGTOqmWei3lNZIF6S21G/3LO8dmNxWD06QmSquO6fSjKsvwO4qBcjZBFkHdiw==
X-Received: by 2002:a17:902:6845:b029:d4:d1d5:2139 with SMTP id
 f5-20020a1709026845b02900d4d1d52139mr9524779pln.53.1602529701706; 
 Mon, 12 Oct 2020 12:08:21 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id r6sm16945719pfg.85.2020.10.12.12.08.20
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 12 Oct 2020 12:08:21 -0700 (PDT)
Date: Mon, 12 Oct 2020 12:00:38 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_spdif: Add support for higher sample rates
Message-ID: <20201012190037.GB17643@Asurada-Nvidia>
References: <1602492582-3558-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1602492582-3558-1-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
Cc: alsa-devel@alsa-project.org, timur@kernel.org, Xiubo.Lee@gmail.com,
 linuxppc-dev@lists.ozlabs.org, tiwai@suse.com, perex@perex.cz,
 broonie@kernel.org, festevam@gmail.com, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Shengjiu,

On Mon, Oct 12, 2020 at 04:49:42PM +0800, Shengjiu Wang wrote:
> Add 88200Hz and 176400Hz sample rates support for TX.
> Add 88200Hz, 176400Hz, 192000Hz sample rates support for RX.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>

Probably should put your own Signed-off at the bottom?

Anyway:
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
