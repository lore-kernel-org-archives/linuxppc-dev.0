Return-Path: <SRS0=j7bs=GP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F19C433DB
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Jan 2021 19:12:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 009E4230F9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Jan 2021 19:12:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 009E4230F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DFgDh2bHJzDr95
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Jan 2021 06:12:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::72e;
 helo=mail-qk1-x72e.google.com; envelope-from=natechancellor@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=Ph1/Gxgy; dkim-atps=neutral
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DFg9h4vtHzDqkc
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jan 2021 06:09:27 +1100 (AEDT)
Received: by mail-qk1-x72e.google.com with SMTP id w79so2892588qkb.5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2021 11:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=CPfEryF2bxPOdgxHkNjvHkSKCpA8G96wI04AOG3xMSg=;
 b=Ph1/Gxgy/41uF4BAAfVDKy7+imzx904TvEw+Eu/WblDKtQtdri1X4MDaStPM7awQ7I
 sOI/tgXlhTD39bLtKzCH3BBetYGzwkHWCn420dJExppM8vIn63xtrRpMg2cfcnmmhuKC
 rruw5KY6mTE53Wkxicns7eEBwcy2BPkue5zB0u3bN/gZOYSLNuHc94DIZoqWz4bdnCnm
 osZp+ndQyIlh3Zqfh8yn/oQgYOgWayRSBaeczRwJjpsm/qa1CI6ReZDOmnulR63X/ATQ
 fHCWmB74oiCx5teGkpmHMmgnXFa53TQVBafdSCGjtJk3YnEsf8id6sWiWMyADr+7fFrb
 f8dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=CPfEryF2bxPOdgxHkNjvHkSKCpA8G96wI04AOG3xMSg=;
 b=NCWGqXq+DfhhdGMJuFYlgVicD129EAYjMjPiNjv/Xor26zCxpYYa9if7Dh6CnRkNs5
 pYbhTDU1M4CgN/8mbOHQ6ZjD3R4nak8o2CKFCmw4kwSV3QsNIBzgmwOVXXxTHUoeIbtU
 CYvPGMJjJQZcKbW1q5r4+voEqqO41h3Cn4Rju0Hnu7hEfNx+SHRMGH0Mx8RyJoVR8n9x
 0vwwZe7Cfc6FdsTt4UzZwPWDpP5dlFt5dv/Ct8VXNT9bCyLa4Hdkhhjh7h7cZlSEOs7t
 a4lULSRyjhzRH2CqtJuQaz4NVfFrwjj0DmToBEvsAZJ7eRv5JmHMIlnYfnI0Q8ruEmil
 mokg==
X-Gm-Message-State: AOAM530OsC6Mc04b86pLAyDJ6Vi3Mbqn5kUiogEnf+I/YKDy5WWdOuZZ
 xn8YEB5KTu7sctNFyzAJ1eQ=
X-Google-Smtp-Source: ABdhPJzPgfw/zVoqhZTuXj+3LsvbWpph1NVpC1slqYO+oR5yTcVJwoUscYt3sisXvbLe7akxa/MdDg==
X-Received: by 2002:a05:620a:10a8:: with SMTP id
 h8mr821484qkk.315.1610478564017; 
 Tue, 12 Jan 2021 11:09:24 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
 by smtp.gmail.com with ESMTPSA id v4sm1629295qth.16.2021.01.12.11.09.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Jan 2021 11:09:23 -0800 (PST)
Date: Tue, 12 Jan 2021 12:09:21 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: imx-hdmi: Fix warning of the uninitialized
 variable ret
Message-ID: <20210112190921.GA3561911@ubuntu-m3-large-x86>
References: <1608115464-18710-1-git-send-email-shengjiu.wang@nxp.com>
 <20210112181949.GA3241630@ubuntu-m3-large-x86>
 <20210112184848.GG4646@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112184848.GG4646@sirena.org.uk>
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
 linuxppc-dev@lists.ozlabs.org, Shengjiu Wang <shengjiu.wang@nxp.com>,
 tiwai@suse.com, perex@perex.cz, nicoleotsuka@gmail.com, festevam@gmail.com,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Jan 12, 2021 at 06:48:48PM +0000, Mark Brown wrote:
> This is a random warning fix, why would you expect it to be sent as a
> bug fix?  This is the first indication I've seen that anyone is seeing
> it in mainline, in general the people who report and fix warnings are
> doing so based on -next and the patch seems to be from a month ago.  I
> don't have this in my inbox so I assume it's applied already or needs to
> be resubmitted anyway.

Well, I consider compiler warnings bugs. I have had plenty of my
compiler warning patches sent as bug fixes for an -rc. Furthermore, this
patch was sent three times by different people, that should give you some
indication that people are tripping over it.

https://lore.kernel.org/alsa-devel/X9NGQaF4pmK8oUAF@mwanda/
https://lore.kernel.org/alsa-devel/1608115464-18710-1-git-send-email-shengjiu.wang@nxp.com/
https://lore.kernel.org/alsa-devel/20201230154443.656997-1-arnd@kernel.org/

The first version was sent on December 11th, it looks like your pull for
5.11 went on the December 14th, then the second version was applied on
December 16th so I figured it might be destined for 5.11 but I could not
tell (your for-next branch is a merge of your for-5.11 and for-5.12):

https://lore.kernel.org/alsa-devel/160813397775.31838.8934909997692637790.b4-ty@kernel.org/

Cheers,
Nathan
