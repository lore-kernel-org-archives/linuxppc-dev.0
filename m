Return-Path: <SRS0=5gV/=VW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01222C7618B
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Jul 2019 06:02:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CDC920856
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Jul 2019 06:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ucy7l0PI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CDC920856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45vM7D5pj4zDqQ0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Jul 2019 16:02:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::441; helo=mail-wr1-x441.google.com;
 envelope-from=daniel.baluta@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="ucy7l0PI"; 
 dkim-atps=neutral
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45vM4x57ZnzDqHW
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jul 2019 16:00:17 +1000 (AEST)
Received: by mail-wr1-x441.google.com with SMTP id c2so46088369wrm.8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jul 2019 23:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qwJcmk5yiFlme1u00/d80HZseBmnYpsKoUulVK5QiqA=;
 b=ucy7l0PIIgkVo6/HBTwEDgLsRwwNI/lHafiIlrF8pPx7QPRJllYj0UOJJMhSd7jP8U
 ytYcFqO1GLhsEkK1yF12onQ5WPdq4tyGgROGVIBwcIVzRNsInv64PHIK8d3xRK1R9qWd
 gaAm5kNOsy2Wvp6AcpDlYFC07uW8JmWj8mw3vuys/hM0wWxJXx0KS7eWKCOwkeFrkRjk
 K6wY1G7XP/LqsRqt4TAcHWSSFJiOSQFt+jh8KDBCbPhocAtic193G1R638pZcv9Yt+WM
 dvLt6KH6BF48BHGOlRqvqBqxdXnMXorYX5qOvN0vaWqYn2bsdu/RKqQZPwmzl45tljMD
 HDcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qwJcmk5yiFlme1u00/d80HZseBmnYpsKoUulVK5QiqA=;
 b=b+C+Uw8LvPLdkGOb3sJskAavPQBI31bIC0xCXgAXFRqeoFwW/q6hkfNFsuWc2MYs5j
 8Sly/KTbcHyBK7WMbTCIi653nsFzQyb9tm77S5NEz2j3de8YdjaMOG5gzABzV+qW+A0S
 8WD4tBXIAK/UGnBfPMqw8HhKWa9dSXtLUq9Vp8mOTL1OwtHPhE9Crjk6nJeqmH0lLV3k
 5LIBthQdAOexUUKCfGiKA7wb2rlOFikqDQWnPUupK/HDp02HuPKs+jNtjNPEW4FUzhJq
 Dz5cqryMtSLmDAipTqH++dLy65nC6GgkPDfGI2sROkJWZ2zUZX/4lUc0IB//8Ja68z3i
 d5Zg==
X-Gm-Message-State: APjAAAWQCnC8GdX1Rjpr068AeDasyja5cN1Z5a93TFltZFVRVe1t6AL6
 rV2SpSLUGV0+CGAoc+njDOTr95EIfwT77nEG2Q4=
X-Google-Smtp-Source: APXvYqzMQe4AbvN+dLqV0ii4ui6djRNNceKLvVW0FznYpmDPAHgEgKVrzpvWCeklkVcneU/eivkYc+c51aZguQ7gVQU=
X-Received: by 2002:adf:db46:: with SMTP id f6mr41138857wrj.212.1564034412867; 
 Wed, 24 Jul 2019 23:00:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190722124833.28757-1-daniel.baluta@nxp.com>
 <20190722124833.28757-2-daniel.baluta@nxp.com>
 <20190724223422.GA6859@Asurada-Nvidia.nvidia.com>
In-Reply-To: <20190724223422.GA6859@Asurada-Nvidia.nvidia.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Thu, 25 Jul 2019 09:00:01 +0300
Message-ID: <CAEnQRZDtAwAWn+fEWcfiXROc+X5bhwdas=R=JdizcfPjyFSv0A@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH 01/10] ASoC: fsl_sai: add of_match data
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>,
 Fabio Estevam <festevam@gmail.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, Timur Tabi <timur@kernel.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Daniel Baluta <daniel.baluta@nxp.com>,
 "S.j. Wang" <shengjiu.wang@nxp.com>,
 "Angus Ainslie \(Purism\)" <angus@akkea.ca>, Takashi Iwai <tiwai@suse.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Mark Brown <broonie@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 Viorel Suman <viorel.suman@nxp.com>, linuxppc-dev@lists.ozlabs.org,
 Lucas Stach <l.stach@pengutronix.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Jul 25, 2019 at 1:34 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> On Mon, Jul 22, 2019 at 03:48:24PM +0300, Daniel Baluta wrote:
> > From: Lucas Stach <l.stach@pengutronix.de>
> >
> > New revisions of the SAI IP block have even more differences that need
> > be taken into account by the driver. To avoid sprinking compatible
> > checks all over the driver move the current differences into of_match_data.
> >
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
>
> Looks like Mark has applied this already? If so, should probably
> drop applied ones and rebase the remaining patches for a resend.

Yes 1/10 and 2/10 were already applied. Will drop them from next version.
