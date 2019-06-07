Return-Path: <SRS0=OFQA=UG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9946FC2BCA1
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Jun 2019 22:07:55 +0000 (UTC)
Received: from lists.ozlabs.org (unknown [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7125212F5
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Jun 2019 22:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQ8X5t7S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7125212F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45LGqX2yp2zDr2j
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Jun 2019 08:07:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::644; helo=mail-pl1-x644.google.com;
 envelope-from=nicoleotsuka@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="eQ8X5t7S"; 
 dkim-atps=neutral
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45LGmc50y9zDqh3
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Jun 2019 08:05:20 +1000 (AEST)
Received: by mail-pl1-x644.google.com with SMTP id g9so1314383plm.6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Jun 2019 15:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=C3WCTEPJuMhnDtyj4nCQQWf8hst+6hFcFTW9HCjkuQc=;
 b=eQ8X5t7ShcbHZ2iAaeihT56yVGm93DJwoGdLe+RAL+T33ZJeM5dpHTBSOFHnV6exd2
 McjPg9HRK4VzL2d97TDKLdk4cgN6l4tkjv6zJgwUwj1poxqn1D4faGt9f0dgLEJvD4kI
 nlj2hFdkXuXE9V6dflG5xHbpe+pelkqjFJDVStQgh4TZr8C3CXVWdShiPtMOmz92io3F
 G/7PZiS1LCcwJLyHB6DMjE+r1mSTqQMSaVXt4uniH3d8iUxxoPLLsGtjpKOqkzsTcqbY
 izGdDivK3ySoKFH5HXbVfJ1MkBO+mwjFUh9lObsesRKIEoo/4P5NBkxPi/L9gGPIPE7F
 GoDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=C3WCTEPJuMhnDtyj4nCQQWf8hst+6hFcFTW9HCjkuQc=;
 b=r/CIEHZtQrsiJVc5UpNlOIPuwBrSlAmVp9agstA02k9LmBIgJ2p2tuS/QU5r1JAz/Z
 UXfflOWr1v2WipyP4Z4t+fkyzTfVKyyAzkCHhppez9JnU6uLfcjvhREEnvfOyAVo2CcE
 2r+wq3ZfPnErrIHCBPBHUcgGK5+ttexrDnnspmT7SHw2syMGPMoDX+y/PemR0SVVWUaK
 6jn/p0TxBDq2tzi5c+JqacAZ5XTMimLAvSFX3zS2IFqgvFq5dQKJYnw+ZqOzWNqXlVvt
 ielCdVJy9XSCJwJhQgK9dKOkn27RZ7vPnaaJylVv6g23faDJnlBe/BFpqKxgqw29Dd9I
 VaEQ==
X-Gm-Message-State: APjAAAWPDfMv+Q19MBT4J/2fky00MGxnVIt09BlpQxPk4Naw5w449r/2
 nk87aqDVxxZf57AKDay1upw=
X-Google-Smtp-Source: APXvYqw79sGEGu7vaJbDLnMprFiFeHzfXZWGcQnVHInNP3xeYbkjRgBIAgRsCI7J7qswMroRiib5FA==
X-Received: by 2002:a17:902:6ac6:: with SMTP id
 i6mr44253449plt.233.1559945116817; 
 Fri, 07 Jun 2019 15:05:16 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id d3sm3843748pfa.176.2019.06.07.15.05.15
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 07 Jun 2019 15:05:16 -0700 (PDT)
Date: Fri, 7 Jun 2019 15:05:18 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC/RFT PATCH] Revert "ASoC: fsl_esai: ETDR and TX0~5 registers
 are non volatile"
Message-ID: <20190607220517.GA3824@Asurada-Nvidia.nvidia.com>
References: <20190606230105.4385-1-nicoleotsuka@gmail.com>
 <20190607111244.GE2456@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607111244.GE2456@sirena.org.uk>
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
 linuxppc-dev@lists.ozlabs.org, shengjiu.wang@nxp.com, tiwai@suse.com,
 lgirdwood@gmail.com, perex@perex.cz, festevam@gmail.com,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hello Mark,

On Fri, Jun 07, 2019 at 12:12:44PM +0100, Mark Brown wrote:
> On Thu, Jun 06, 2019 at 04:01:05PM -0700, Nicolin Chen wrote:
> > This reverts commit 8973112aa41b8ad956a5b47f2fe17bc2a5cf2645.
> 
> Please use subject lines matching the style for the subsystem.  This
> makes it easier for people to identify relevant patches.
> 
> > 1) Though ETDR and TX0~5 are not volatile but write-only registers,
> >    they should not be cached either. According to the definition of
> >    "volatile_reg", one should be put in the volatile list if it can
> >    not be cached.
> 
> There's no problem with caching write only registers, having a cache
> allows one to do read/modify/write cycles on them and can help with
> debugging.  The original reason we had cache code in ASoC was for write
> only devices.

Maybe because my paragraph doesn't state it clearly -- it's nothing
wrong with regmap caching write-only registers; but it caching data
registers would potentially cause dirty data or channel swap/shift.
So the reason (1) here is "cannot cached" == "should be volatile".

I will revise the commit message for review and fix the subject.

Thank you
Nicolin
