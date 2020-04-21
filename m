Return-Path: <SRS0=D6Rn=6F=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 938A0C54FD0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Apr 2020 10:54:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE7F520679
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Apr 2020 10:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOzRVb4R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE7F520679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4960nJ05HhzDqrm
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Apr 2020 20:54:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::f41;
 helo=mail-qv1-xf41.google.com; envelope-from=shengjiu.wang@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=OOzRVb4R; dkim-atps=neutral
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com
 [IPv6:2607:f8b0:4864:20::f41])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4960kM5Gx1zDql6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2020 20:51:53 +1000 (AEST)
Received: by mail-qv1-xf41.google.com with SMTP id fb4so6271427qvb.7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2020 03:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ivbFUkwRL9S7N1wT7PKkBXOsZsaEcUNHKgJGMoPGLUE=;
 b=OOzRVb4RfJPdYn4zpXtOEhyi979GugRYT98eayitSgigmRN7GGovTmLYdlPS6gENC7
 eyJC1JWayXcESfs32HRksxLNTDphXS9fVFCMcfvS7Eyj/FDcpBXP+MMNhvt2Z9fbkmt4
 5nW+MavhMgBAqGwwB5gEee5Rep+J1L5gCEmyPW+TwaZneNL4L8fmrF74tNgClC80QnyO
 UylThTlptOWK3nNpMymBJopquDsk1lfiqU1lSyaOWdY0BomJdlfgugcZbcznAACmecku
 rPrFPph1m2QjfJqcuk6gORLIB1dVJJWvVUq28TRJjOVHbO3Pnlf1J1zX12M575sZGbbB
 NtKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ivbFUkwRL9S7N1wT7PKkBXOsZsaEcUNHKgJGMoPGLUE=;
 b=K310l7dsY1RgJ/LjKkAAXipxDFT/GKGsP/jgH9EFlgqc8QPfCR7D5yRgm8T/qoWbHs
 ntfwxsUn6urYmcEarn7VVBLiTaik02m+HLR8afY60DtXeJV84l0D9yxnNxsaiI1HdQ7X
 kSkdJThoLOPTdiMkTQaSeTsnrbryLHn1rec0Wpdtj8zpQGMW93sCnTILOdELw8ub5O7x
 kYGz2eKlR4MEaiumHBzLlooKJ5SyAsnL25FodKh6fY0fZ1CyLoQp7DelN54l7fwLNaXU
 hQo3UEFRp92nmVDRQsx7fi+c0TGI/rRyX9dxmnxu7tPe1Zsjco2XvXKQDA0a0MHKds3C
 QIxA==
X-Gm-Message-State: AGi0PuYpKlH98jnWQnzkVMqEmmP8R991gSlB1SOaR0bWPBeZiD54lI/+
 ZKu7fWoBgyi5oLbzGm0luYt7DXmBGVi8kbi/6rw=
X-Google-Smtp-Source: APiQypJwJ2uOOAPfmeM5nJfx+WsYkHo/Ya0/fvk6XSZOAthRD5GU8swYyAKAdYf6f9Qx1lIW0rGPP6tS1dPTrjZa4Ek=
X-Received: by 2002:ad4:4e65:: with SMTP id ec5mr10315478qvb.32.1587466310751; 
 Tue, 21 Apr 2020 03:51:50 -0700 (PDT)
MIME-Version: 1.0
References: <1587458483-2166-1-git-send-email-shengjiu.wang@nxp.com>
 <20200421095139.GA4540@sirena.org.uk>
In-Reply-To: <20200421095139.GA4540@sirena.org.uk>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Tue, 21 Apr 2020 18:51:39 +0800
Message-ID: <CAA+D8APjn7FrOvYRiTorfSyswm7G5SMcegnJm9sKB8EQKDMgFg@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_esai: Remove expensive print in irq handler
To: Mark Brown <broonie@kernel.org>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Timur Tabi <timur@kernel.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 Shengjiu Wang <shengjiu.wang@nxp.com>, Takashi Iwai <tiwai@suse.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Nicolin Chen <nicoleotsuka@gmail.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi

On Tue, Apr 21, 2020 at 5:53 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Apr 21, 2020 at 04:41:23PM +0800, Shengjiu Wang wrote:
> > Use dev_dbg instead of dev_err in irq handler, the dev_err
> > is expensive, we don't need the message to be printed everytime,
> > which is almost a debug option.
>
> >       if (esr & ESAI_ESR_RFF_MASK)
> > -             dev_warn(&pdev->dev, "isr: Receiving overrun\n");
> > +             dev_dbg(&pdev->dev, "isr: Receiving overrun\n");
> >
> >       if (esr & ESAI_ESR_TFE_MASK)
> > -             dev_warn(&pdev->dev, "isr: Transmission underrun\n");
> > +             dev_dbg(&pdev->dev, "isr: Transmission underrun\n");
>
> These are error messages which would suggest a problem that'd lead to
> data corruption, it seems bad not to try to flag that to the user -
> surely we've got bigger problems than performance if this happens?
> Perhaps convert to a ratelimited print if the issue is that when errors
> happen they happen a lot?

Thanks for review, I will rethink about this.

best regards
wang shengjiu
