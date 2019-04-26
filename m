Return-Path: <SRS0=ImKy=S4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FCB8C43219
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 05:21:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A018B208C3
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 05:21:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dDGVnEVV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A018B208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44r2TC1P19zDqfd
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 15:21:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::542; helo=mail-ed1-x542.google.com;
 envelope-from=daniel.baluta@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="dDGVnEVV"; 
 dkim-atps=neutral
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com
 [IPv6:2a00:1450:4864:20::542])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44r2RP62GFzDqdd
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2019 15:19:29 +1000 (AEST)
Received: by mail-ed1-x542.google.com with SMTP id l25so2043963eda.9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2019 22:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EkKGDznBbBFdZirc3jAzxYvo3XCrpzWTjeLOR2RWDaI=;
 b=dDGVnEVV15F6OJ8thkEsN9JsCEo1VAtAMLxKxQGe5+5s6CDTooHBEE75QPq/Y/9J8Z
 7wUjXyWnn5i+bvagOtqwUYB3wuI7s/RjXgyF/PrOnIXFbopBGkz3ypMwtGj3gXodq77e
 ZVkO6bOP07iU02WczIvc8Ek88kSi2nFh1hx6xtXWoO4bDZZonW5SF6Xbj4UhJFajHw0B
 KesRMb/f8JIKoQpqMPvo7SKB3fb7TMCW4lKtkhOEshIHVChfQgwHejh+KS0G1DslF87L
 WZQU8wkrrQByLeVJJf7lZoDH55l8ecrDlpL4GoY1hIsbevbbkURKubdDqCw0tSv+lvIK
 4wRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EkKGDznBbBFdZirc3jAzxYvo3XCrpzWTjeLOR2RWDaI=;
 b=ZYd7BdC7HyDpN5+OVHs292H+Q9ulHKHV6NF5hNeAz5hoobtEu+t1NxW6V/2Svb1QOY
 VyidbNpB/sjzGHmeI9rPNmrGV3w+52kxxNJO7W2EEXNsYdC6T7Wp89FAx2fusNAsfuQY
 uHEUjzGiQcoObWHxaD4JItv2sp1et84uj2W0BkgKS/f6+O9i2JVla2Fd0bPCrDzgzX9n
 s+zrDIpfnZOn3NzzOluU/LP83wRksrW+k3QjrSWvOzw8ZAyxAjH1mIEL/IScgGc0RV65
 ZwWVyk9cmKb8lUNs2dA6byiAD4odKqJwBymBZiGutSpLGPp0rGnFduH8YBIFL0yPBGeQ
 nspA==
X-Gm-Message-State: APjAAAX5kMkntqTCKNM4OjpXyR4zi/bM+lFzyy/jo3bjs6krFSnPdsfZ
 TX8xO9Xmkzm2mtumca5drbugY6PbDchOz73gNX0=
X-Google-Smtp-Source: APXvYqxA5MOoF7ycT3gfeurT4M7GtKkFTTOZe8vYmvKHKfa2/cDIQLOGVZXgWfGBxaJ11AT56XVqwW3/PkaRxPYmlfs=
X-Received: by 2002:a50:a3c2:: with SMTP id t2mr26702934edb.46.1556255965508; 
 Thu, 25 Apr 2019 22:19:25 -0700 (PDT)
MIME-Version: 1.0
References: <1556248850-3748-1-git-send-email-nicoleotsuka@gmail.com>
In-Reply-To: <1556248850-3748-1-git-send-email-nicoleotsuka@gmail.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Fri, 26 Apr 2019 08:19:14 +0300
Message-ID: <CAEnQRZCV7mnBmUFiC2pVz4ndo6a0L1eF8pAuiOO5OBTayXt=SA@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl_sai: Add missing return 0 in
 remove()
To: Nicolin Chen <nicoleotsuka@gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: sfr@canb.auug.org.au, Linux-ALSA <alsa-devel@alsa-project.org>,
 Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, Liam Girdwood <lgirdwood@gmail.com>,
 Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
 Fabio Estevam <festevam@gmail.com>, Daniel Baluta <daniel.baluta@nxp.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Apr 26, 2019 at 6:22 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> Build warning being reported:
>     sound/soc/fsl/fsl_sai.c: In function 'fsl_sai_remove':
>     sound/soc/fsl/fsl_sai.c:921:1: warning: no return statement in
>     function returning non-void [-Wreturn-type]
>
> So this patch just adds a "return 0" to fix it.
>
> Fixes: 812ad463e089 ("ASoC: fsl_sai: Add support for runtime pm")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>

Thanks Nicolin!

> ---
>  sound/soc/fsl/fsl_sai.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index 26c27dc..8593269 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -918,6 +918,8 @@ static int fsl_sai_probe(struct platform_device *pdev)
>  static int fsl_sai_remove(struct platform_device *pdev)
>  {
>         pm_runtime_disable(&pdev->dev);
> +
> +       return 0;
>  }
>
>  static const struct of_device_id fsl_sai_ids[] = {
> --
> 2.7.4
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
