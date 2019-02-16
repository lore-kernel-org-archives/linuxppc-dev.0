Return-Path: <SRS0=Luu/=QX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EEBDC43381
	for <linuxppc-dev@archiver.kernel.org>; Sat, 16 Feb 2019 13:21:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A761420643
	for <linuxppc-dev@archiver.kernel.org>; Sat, 16 Feb 2019 13:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDLIavNZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A761420643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 441rP67040zDq7F
	for <linuxppc-dev@archiver.kernel.org>; Sun, 17 Feb 2019 00:21:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::342; helo=mail-ot1-x342.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="BDLIavNZ"; 
 dkim-atps=neutral
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 441rMH5BB7zDqY0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Feb 2019 00:19:36 +1100 (AEDT)
Received: by mail-ot1-x342.google.com with SMTP id z19so21289798otm.2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Feb 2019 05:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XIQeF0ZV91ae2+GvncfySYJ9A0ommFllTFRRU9aFW/E=;
 b=BDLIavNZ+GDUbK9SkTKEUxitOwhQeBMXojnzRMnqLPZTZ8ASear80mXLZVlkGvp/yt
 7n2upY9EUcIJ2aU8i/D4vCYXTF1zGoHbIEsNlidP29ERec+JQz4d9LZer1c/AQ/7f/9L
 YdPREhlENYQGI6/mjhUWpcA3KU+CBV4qt2t9JoZlwWN4hJRy7bYE0cSVhzbnQAyuOFkQ
 8CMXRDwJchgzUXt219mSWFeVnBe4UCEa6yVor0VP0xeFF08fgrkKsUvelnoopzGOLLZP
 S+ViM9I4g7KdEcHdFf7BwE1gNV1ugzfbafzBlKvVUfI6r/zdo3rOxB7RPYgOV6N673T/
 j1VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XIQeF0ZV91ae2+GvncfySYJ9A0ommFllTFRRU9aFW/E=;
 b=HCXTByR+iN6wDskuH7lGV5VpeRGlLxa51xBmor5BTx4a4JnCCKtscPGrDqtx3UIAWo
 Wg+SdX/ZxG5qHkYcjZwRKseP61YsagLpeYB8hkjRexLGgJh8wg2AnPbdaQ+o0fYQGcWP
 cRzcjDAFyO7/hVw5QOZjroh2oGP928+FD66F945G2yDNo2H2XhyfsKJZGMSGKfItZ7ay
 z0NeGvbyWxTtUPdKeXo4l+XYPc8LzeoJjWH84fJJcj4OZ3fKuq0YicJior1prh6xpu5k
 qBiYKsbY3C6/isgA1n71pFsCXMmUvGK/ySOUVBqiKHO0RASu7/7uBFJtGV+nN5I8/6U5
 Y9GQ==
X-Gm-Message-State: AHQUAuZ7ZU6uS6DN2smomvUSv8lWyLFMlXY/977MZRCP0wIE4Bd5f6sc
 qmafGvH3GLp1P1qP8TXhEQsjsgNy7pKNoL07eRE=
X-Google-Smtp-Source: AHgI3IaHgqKGNKnLtf+wxln+c/AgKex7wLhrNNyk+Hlax8hjWhHrrAiehj6ggyLvUQ82SjZexa/uiQCeyTfUk18cA8U=
X-Received: by 2002:a9d:72c6:: with SMTP id d6mr8867422otk.78.1550323173453;
 Sat, 16 Feb 2019 05:19:33 -0800 (PST)
MIME-Version: 1.0
References: <1550228637-5675-1-git-send-email-shengjiu.wang@nxp.com>
In-Reply-To: <1550228637-5675-1-git-send-email-shengjiu.wang@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 16 Feb 2019 11:19:23 -0200
Message-ID: <CAOMZO5ALVAhmBrM_e_2LnzfyhSLPQbe4hsdXAtUMZkQL3YXQHg@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_esai: fix register setting issue in RIGHT_J mode
To: "S.j. Wang" <shengjiu.wang@nxp.com>
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
Cc: "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "timur@kernel.org" <timur@kernel.org>,
 "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Shengjiu,

On Fri, Feb 15, 2019 at 9:04 AM S.j. Wang <shengjiu.wang@nxp.com> wrote:
>
> The ESAI_xCR_xWA is xCR's bit, not the xCCR's bit, driver set it to
> wrong register, correct it.
>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>

Please add a Fixes tag and Cc stable.

Also, it seems that Mark Brown is not on Cc. Please Cc him in v2.

Thanks
