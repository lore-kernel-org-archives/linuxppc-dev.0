Return-Path: <SRS0=PqhP=FG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE58C64E7C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Dec 2020 19:50:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88EE222201
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Dec 2020 19:50:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88EE222201
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CmV1k5v84zDr8g
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Dec 2020 06:50:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1044;
 helo=mail-pj1-x1044.google.com; envelope-from=nicoleotsuka@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=onJj8ipS; dkim-atps=neutral
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com
 [IPv6:2607:f8b0:4864:20::1044])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CmTzf04zhzDr6w
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Dec 2020 06:48:28 +1100 (AEDT)
Received: by mail-pj1-x1044.google.com with SMTP id r9so1610355pjl.5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Dec 2020 11:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=dnQQ0ZO/6p33z1swbZoImrPF097nMjWL47oIMo++/1Y=;
 b=onJj8ipStbxkxO1WMW4vx6wNj6v6na0K0VYBNmFQ/TgoUyd1X+QuhKWOM9Q2hUY4uH
 PI37PA+QRy74rDEnFaGWxAzDOBo/WwymM51gZXXQOIeAvykEhSD9kByS6NDbeDQOB0gB
 dlSeHl0n0tNFnc/5e9QnxMwqAgMeviGwIfyu1tYVbluA5Ss8u/LWXKPoAaERlFD6mzv6
 y0iRo9mnNUd1x93YRZ/L1vC1OMPIef0qOKvWcNYnRo7seGzgbAUkxIabKOFy7bf+dKKu
 reBPVovWJfqqzr4y5seDB6W6wi5zyl6DyaNJ9ZUbn3blZQP7AEpNJYLMolGv8hzQiGdQ
 UItA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=dnQQ0ZO/6p33z1swbZoImrPF097nMjWL47oIMo++/1Y=;
 b=LArT8vVv+fdt2dI9UEW0R576+chQHSfGgjWvkXEQfXQz6c3qDzpc2EsXEOf0+PsXxX
 IL5KTEonzkgenR+5bjsoCt7VhrjKqK6ap16QTlmG5vy6q+L6BB3vqKTTpo0ISeN3H8AR
 Xf774kwNfG41g/X2rOP4lq9no+HWMH6LEVbKuetOknlKcwrcrA/ElA1iUZNskQPrqo3e
 U4HwxvPnDBEuVhqZjF+Sv2+CPgFJiW+BDN7ADktJhB+RWenJshjjadohYNN7QwoKGC8e
 N2RQec8xHP7kq9+cS6E1nDkyKIneNbZeXH6tSjSs7sfsJb5OSDDubVfNQXQzpUzJCtFj
 hGKA==
X-Gm-Message-State: AOAM531WxeNAWozZ1gkQUrDhy/4FOspkjF1npLS3wZgEe4r805NOZdzP
 OcaAwZLp4A0ppi3+w/f63WQ=
X-Google-Smtp-Source: ABdhPJynOsl/9mtFMTtbS3krXbaXRE8MqaHaMr7m3r88/8eYsCbneJHJzz+ir6n8gXwRYSd8V2dkSg==
X-Received: by 2002:a17:902:ee53:b029:da:4c68:2795 with SMTP id
 19-20020a170902ee53b02900da4c682795mr4119802plo.7.1606938505659; 
 Wed, 02 Dec 2020 11:48:25 -0800 (PST)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id i10sm547720pfk.206.2020.12.02.11.48.24
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 02 Dec 2020 11:48:25 -0800 (PST)
Date: Wed, 2 Dec 2020 11:45:31 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH 1/2] ASoC: fsl-asoc-card: Add support for si476x codec
Message-ID: <20201202194530.GA1498@Asurada-Nvidia>
References: <1606708668-28786-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1606708668-28786-1-git-send-email-shengjiu.wang@nxp.com>
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
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, timur@kernel.org,
 Xiubo.Lee@gmail.com, linuxppc-dev@lists.ozlabs.org, tiwai@suse.com,
 lgirdwood@gmail.com, robh+dt@kernel.org, perex@perex.cz, broonie@kernel.org,
 festevam@gmail.com, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Nov 30, 2020 at 11:57:47AM +0800, Shengjiu Wang wrote:
> The si476x codec is used for FM radio function on i.MX6
> auto board, it only supports recording function.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
