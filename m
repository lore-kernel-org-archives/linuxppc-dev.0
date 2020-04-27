Return-Path: <SRS0=vPFq=6L=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF90C54FD0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Apr 2020 07:01:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8B792075B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Apr 2020 07:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IL2IJv0C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8B792075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 499bL351hMzDqcW
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Apr 2020 17:01:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1044;
 helo=mail-pj1-x1044.google.com; envelope-from=nicoleotsuka@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=IL2IJv0C; dkim-atps=neutral
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com
 [IPv6:2607:f8b0:4864:20::1044])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 499bHj5PRSzDqSt
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2020 16:59:45 +1000 (AEST)
Received: by mail-pj1-x1044.google.com with SMTP id a7so7056809pju.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Apr 2020 23:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=WNj7owPD+ZbRnStugkoSGfUDDLECau6V6cMguxLHseM=;
 b=IL2IJv0CwAvaTDLiqlc/43W1WRn+mgpJHcQ8lcGu5IP5LESVReGp34dPTQGf6e0LZa
 3rCwR8nNmXOAEkd7Qzy7NviBN1004OJr8Pb5pMjqmfp3qpJihUZhwd7nyTcdErdOInIe
 uT/acoJunK3/lzcWSYlr70GlAd1cL4+5aQRsO6ogXJBgfPAl7j9pz2uqOwVdBWbYe0q6
 lbHRELStH3w+8HvL6IraAq8odymfgvcnvKnG15I3pwiOqF/UTkx28z5RWu01Jb8zRX6u
 8N7Ya3TKyfDwMXJcwDdk6fA1JUwRLmFDLFLl41eCmhPhg6qDStbEFse06rD8j62TGsit
 h9Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=WNj7owPD+ZbRnStugkoSGfUDDLECau6V6cMguxLHseM=;
 b=txiajBNjB6BqP6UfQVI9l0TtU7mNvBFUFC3WVQ9sw0mkwGxdUgRNqCvp1cNYOAAIgw
 C2/kWsilbOhXvHTHO48PyhUNHDHCZQ2egsAbm4NyXTIiQCUrZNh2VoLcw71P72GWZMlw
 h0soSss4J96eOdGWCaDnBmLap4TYdraTzreu3UzbA540amDm8P6XzIFLLzZq9mgVwtUX
 03BqWUeQZpe6/z/2mLAyAkVveANqMmw9kNutj1jLdhQX2xHu0LxpO2gkkWr6wE3tyhBF
 SWEJXMCQvyuASC3SGC1tM7udk1ABqlwrlbIl9r4C470HGT8R130N1IgArVMjDYa7Xq+r
 KfUQ==
X-Gm-Message-State: AGi0PubDpP8WWmbqXjbfnz6dH5WQBLeFpEhXxRGSnaitcU4enveD/sJg
 NbcH1BggOS/9+74Gjipm240=
X-Google-Smtp-Source: APiQypK642idgdGmw8QuDMMdid04wPSy9FsGffFOvsU2o0XwcfqVKE56jYsP/DglCL+LJ7YRbhEZMA==
X-Received: by 2002:a17:902:9895:: with SMTP id
 s21mr249837plp.158.1587970781619; 
 Sun, 26 Apr 2020 23:59:41 -0700 (PDT)
Received: from Asurada (c-73-162-191-63.hsd1.ca.comcast.net. [73.162.191.63])
 by smtp.gmail.com with ESMTPSA id
 h9sm11317108pfo.129.2020.04.26.23.59.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 26 Apr 2020 23:59:41 -0700 (PDT)
Date: Sun, 26 Apr 2020 23:59:34 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH v2] ASoC: fsl_esai: Disable exception interrupt before
 scheduling tasklet
Message-ID: <20200427065934.GA2236@Asurada>
References: <a8f2ad955aac9e52587beedc1133b3efbe746895.1587968824.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8f2ad955aac9e52587beedc1133b3efbe746895.1587968824.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
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

On Mon, Apr 27, 2020 at 02:23:21PM +0800, Shengjiu Wang wrote:
> Disable exception interrupt before scheduling tasklet, otherwise if
> the tasklet isn't handled immediately, there will be endless xrun
> interrupt.
> 
> Fixes: 7ccafa2b3879 ("ASoC: fsl_esai: recover the channel swap after xrun")
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
