Return-Path: <SRS0=68fk=DU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9723C433DF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Oct 2020 02:46:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9A9A20678
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Oct 2020 02:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eDNDAtaI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9A9A20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4C9Kgm5vkyzDqb1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Oct 2020 13:46:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::844;
 helo=mail-qt1-x844.google.com; envelope-from=shengjiu.wang@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=eDNDAtaI; dkim-atps=neutral
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C9KY947YvzDqSF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2020 13:40:58 +1100 (AEDT)
Received: by mail-qt1-x844.google.com with SMTP id m65so545305qte.11
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2020 19:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8UzLNMJoHU8HSzYatq3OymQ886/xpnDCfNyxud2dbvg=;
 b=eDNDAtaIOkTrkCQT5OpVtvF/qz069+8PKCvChRgPbX0q2zn94GU9dI57OcV9OFdPc+
 PKKaZzoThmZ3SY6GiVriiThlVkeXZUrPaImmThvJaOVNc58AmthvDY2xgTonHrqWZhHc
 wL0i28ECHuGUdLwkZE2FYEsBuKtEhjogt0mqNkUDeXeiiYRl4LF60h8lWgeL6gIe/62I
 Oa96ZjQBOWpkChWL3sx87yDHfnLhR4EJNY4hmcHX+yYl9MbatCgY/H398cgd5jS1e6Lw
 F/fRIn9J/FuK/TVRhxOEAgioCRbMSz5g15qq5BUHjTOuql1O10EL0CFMGoh+fJ05wWbK
 k42g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8UzLNMJoHU8HSzYatq3OymQ886/xpnDCfNyxud2dbvg=;
 b=mmOVVQGCeM+2FEynu2iYlc6MkQKvmMO7Z+eywpSNA9NuJgB5/4KiDX+TTT+UmoTrlT
 G17WUu6H4qAGaT16Ap+xyIbfRbnm7ZGixYU/nJxIBvvClI4I4pxGcE5YZ+h5KnaGRF/k
 hXAIyM4PyER/gL/95+655vH+lEQqsSlcBi+HGjV2E/DcC4YTbde68BPkaNeRzemEj0FL
 VLcsIbQmzRWBa0WiIuyrE2j3g0Dj6cUud3F9C+r2hbCaor+1PmkUIXNSh0BPTudFVVm0
 ZKML4d1/1c4oEEs4yChbgZNvhxp6ntv4GZPLOMaffN8pbn05fn5no0xtjvTe3rNOwpqO
 iJzA==
X-Gm-Message-State: AOAM533PfEmtdxEogBWkQIcEvD+w0/D/isB6EtEYAyWVbuEMKyR/apeP
 dFjSeouwWv4QQuRmfQiTV4F2G894ngiz/2w3IrM=
X-Google-Smtp-Source: ABdhPJwfW64NzIqBo8ICVJEOXbPnwJlOFIecdiLN2hRGt6Q5FcUk484wbQ1KiNyXGY1QZyXo7SRVoZd1qDn9KXBCnwI=
X-Received: by 2002:ac8:4d03:: with SMTP id w3mr13279186qtv.360.1602556854073; 
 Mon, 12 Oct 2020 19:40:54 -0700 (PDT)
MIME-Version: 1.0
References: <1602492582-3558-1-git-send-email-shengjiu.wang@nxp.com>
 <20201012190037.GB17643@Asurada-Nvidia>
In-Reply-To: <20201012190037.GB17643@Asurada-Nvidia>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Tue, 13 Oct 2020 10:40:43 +0800
Message-ID: <CAA+D8AP=c6p5_hdXP3uk5FaMPsW9cUif_gs9k-JQu48vifVvTw@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_spdif: Add support for higher sample rates
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
Cc: alsa-devel@alsa-project.org, Timur Tabi <timur@kernel.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 Shengjiu Wang <shengjiu.wang@nxp.com>, Takashi Iwai <tiwai@suse.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Oct 13, 2020 at 3:09 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> Hi Shengjiu,
>
> On Mon, Oct 12, 2020 at 04:49:42PM +0800, Shengjiu Wang wrote:
> > Add 88200Hz and 176400Hz sample rates support for TX.
> > Add 88200Hz, 176400Hz, 192000Hz sample rates support for RX.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
>
> Probably should put your own Signed-off at the bottom?

will update in v2.

>
> Anyway:
> Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
