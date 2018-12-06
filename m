Return-Path: <SRS0=TW6C=OP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0169EC04EB8
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 13:50:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6816F20672
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 13:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0uEHwq8N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6816F20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 439cSR1ztGzDqN7
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 00:50:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="0uEHwq8N";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=robh@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="0uEHwq8N"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 439c5l2xpMzDqWr
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Dec 2018 00:34:35 +1100 (AEDT)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com
 [209.85.160.171])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4BD3C20892
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Dec 2018 13:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544103273;
 bh=/brkj+bZc9NrR3D3W5uJBwFGEeeZyiyeMAwTVS7zWB4=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=0uEHwq8N6kkKyL21e2wU1H4xbS32augUKuzU1A51NQWB0oHsMgQP8AgBctPjF1peA
 EUiaAWiUNc/HhFRLolTHlI+lx+fFALJDIe3yTYvAixYuxubqNVhCcQQFdJ8gXnkv0q
 rxG4nG/ZQzYB6npp0lFwlTjq4GvKGxeBkWMtQVzc=
Received: by mail-qt1-f171.google.com with SMTP id z16so504926qtq.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Dec 2018 05:34:33 -0800 (PST)
X-Gm-Message-State: AA+aEWbj+wnwidW237cBbFHHpp0lXPAxnDzRBts4vPuZ15rCFamd2qHC
 5xmy5SkjD5TTGbjRVzz9lhnfycRabYy5sAy+Eg==
X-Google-Smtp-Source: AFSGD/WMz6HaJ2c71Al6DS/WkKTMkdi1Wm/kJ9g79viEeAYh9z4otUggX3MLhuBcAD7eSuW4e6BiXEkYUkNgaGDianU=
X-Received: by 2002:a0c:9e05:: with SMTP id p5mr27099210qve.246.1544103272519; 
 Thu, 06 Dec 2018 05:34:32 -0800 (PST)
MIME-Version: 1.0
References: <20181205195050.4759-33-robh@kernel.org>
 <CAGoOwPReuEgzgYng0YeffgejVKPcoQinnNeFu_f2QBgs5daGdg@mail.gmail.com>
In-Reply-To: <CAGoOwPReuEgzgYng0YeffgejVKPcoQinnNeFu_f2QBgs5daGdg@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 6 Dec 2018 07:34:18 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJiQnQ0PgQz-G=Cj0-cEffMDx0H8vR7wjB25qwRWo-xRw@mail.gmail.com>
Message-ID: <CAL_JsqJiQnQ0PgQz-G=Cj0-cEffMDx0H8vR7wjB25qwRWo-xRw@mail.gmail.com>
Subject: Re: [PATCH] ASoC: Use of_node_name_eq for node name comparisons
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
Cc: devicetree@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>,
 Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Mark Brown <broonie@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>,
 Jaroslav Kysela <perex@perex.cz>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Dec 5, 2018 at 7:53 PM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> Hi Rob,
>
> On Thu, Dec 6, 2018 at 3:51 AM Rob Herring <robh@kernel.org> wrote:
> >
> > Convert string compares of DT node names to use of_node_name_eq helper
> > instead. This removes direct access to the node name pointer.
> >
> > For the FSL ASoC card, the full node names appear to be "ssi", "esai",
> > and "sai", so there's not any reason to use strstr and of_node_name_eq
>
> I am not quite sure about the replacement of strstr.
> IIRC, a node name in fsl dts might appear to be "ssi@xxxx".

That will work fine. Unit-addresses are not part of the node name for
the comparison.

> I am currently out of town so cannot verify the patch.
>
> Fabio, would it be possible for you to run a boot test?
>
> Thanks
> Nicolin
