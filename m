Return-Path: <SRS0=TW6C=OP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF859C04EB8
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 19:41:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5739020868
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 19:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qn9iTtt0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5739020868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 439mF32JhCzDqxb
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 06:41:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="qn9iTtt0";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=robh@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="qn9iTtt0"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 439mBB1L8VzDqtt
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Dec 2018 06:38:58 +1100 (AEDT)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com
 [209.85.160.171])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D8FC0214DA
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Dec 2018 19:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544125136;
 bh=R15F2uQ3pXQCp7bVIOuAth3P/jfGbhBVk+KMwmpfWB0=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=qn9iTtt0raOx10iGEVlD4bAKxMmC6tRyMD3t2TPHW8unn7KLrLjaoSuyLMEWXWRmK
 RUjogClJhhm6zEzmLhigVgq1F63l1ZywAXJRxk96Dbkr7MvfaYerzZBpm33AyDx+ZA
 2VsBi8JCU3mZYoS5P4GVIYZb9r1j9yyhJKSunoec=
Received: by mail-qt1-f171.google.com with SMTP id z16so1906001qtq.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Dec 2018 11:38:55 -0800 (PST)
X-Gm-Message-State: AA+aEWbEZzpjYtE6C/QO3tYqaT25kPGoLuhegBzvSP7pNNs6hh3UYoYK
 S5ZsYvNct7XmIbguAbEkaFhg6fJGy/Uy/ogPtQ==
X-Google-Smtp-Source: AFSGD/XfapvVxtgRCg5w8FKOyzy07I+hnLoDVXwvjcbTigNHC8acVEaq0cWkWQbnEk++xrOO7b1rywtLrTjH7jfXDwc=
X-Received: by 2002:a0c:f212:: with SMTP id h18mr29147928qvk.106.1544125135017; 
 Thu, 06 Dec 2018 11:38:55 -0800 (PST)
MIME-Version: 1.0
References: <20181203213223.16986-1-robh@kernel.org>
 <20181203213223.16986-27-robh@kernel.org>
 <20181204144822.uqonsto45u7ysdu5@verge.net.au>
 <CAMuHMdV5brJyAmP0Bj7Bp7wruLNM1tSWkj_AyN5HCx4vdg-nrg@mail.gmail.com>
 <CAL_JsqJX9eb58piavQayXM5j5GXxsGxmy93m5oRKtghMFvkhuA@mail.gmail.com>
 <20181205194419.p6u56h57yk63xshj@verge.net.au>
In-Reply-To: <20181205194419.p6u56h57yk63xshj@verge.net.au>
From: Rob Herring <robh@kernel.org>
Date: Thu, 6 Dec 2018 13:38:42 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKHwYhHSb7GNFgOtBCqEeMshbRnU+0ONe_yW8OOiRC=SA@mail.gmail.com>
Message-ID: <CAL_JsqKHwYhHSb7GNFgOtBCqEeMshbRnU+0ONe_yW8OOiRC=SA@mail.gmail.com>
Subject: Re: [PATCH v2 26/34] dt-bindings: arm: Convert Renesas board/soc
 bindings to json-schema
To: Simon Horman <horms@verge.net.au>
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Kumar Gala <kumar.gala@linaro.org>, Grant Likely <grant.likely@arm.com>,
 Sean Hudson <darknighte@darknighte.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "open list:MEDIA DRIVERS FOR RENESAS - FCP"
 <linux-renesas-soc@vger.kernel.org>, ARM-SoC Maintainers <arm@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Frank Rowand <frowand.list@gmail.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Dec 5, 2018 at 1:44 PM Simon Horman <horms@verge.net.au> wrote:
>
> On Tue, Dec 04, 2018 at 09:08:57AM -0600, Rob Herring wrote:
> > On Tue, Dec 4, 2018 at 8:57 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > >
> > > Hi Simon,
> > >
> > > On Tue, Dec 4, 2018 at 3:48 PM Simon Horman <horms@verge.net.au> wrote:
> > > > On Mon, Dec 03, 2018 at 03:32:15PM -0600, Rob Herring wrote:
> > > > > Convert Renesas SoC bindings to DT schema format using json-schema.
> > > > >
> > > > > Cc: Simon Horman <horms@verge.net.au>
> > > > > Cc: Magnus Damm <magnus.damm@gmail.com>
> > > > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > > > Cc: linux-renesas-soc@vger.kernel.org
> > > > > Cc: devicetree@vger.kernel.org
> > > > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > > > ---
> > > > >  .../devicetree/bindings/arm/shmobile.txt      | 151 ------------
> > > > >  .../devicetree/bindings/arm/shmobile.yaml     | 218 ++++++++++++++++++
> > > > >  2 files changed, 218 insertions(+), 151 deletions(-)
> > > > >  delete mode 100644 Documentation/devicetree/bindings/arm/shmobile.txt
> > > > >  create mode 100644 Documentation/devicetree/bindings/arm/shmobile.yaml
> > > >
> > > > Hi Rob,
> > > >
> > > > what is this based on? I get a conflict when applying the .txt change
> > > > and if I knew the base for this patch it would be rather easy to work
> > > > out what has changed.
> >
> > 4.20-rc2
> >
> > > >
> > > > Also, should we do an s/shmobile.txt/shmobile.yaml/ in MAINTAINERS?
> >
> > Yes. Though it was pointed out that get_maintainers.pl can pull emails
> > out of this file. We'd need to get that to work by default though.
> >
> > > Probably even s/shmobile.yaml/renesas.yaml/, while at it?
> >
> > Sure, if that's what you all want.
>
> How about this?

LGTM

> From: Rob Herring <robh@kernel.org>
> Subject: [PATCH v2.1] dt-bindings: arm: Convert Renesas board/soc bindings to
>  json-schema
>
> Convert Renesas SoC bindings to DT schema format using json-schema.
>
> v2.1 [Simon Horman]
> - rebased on renesas-devel-20181204-v4.20-rc5
>   + Added r8a7744 development platform and SoM
>   + Correct RZ/G2E part number
> - Update MAINTAINERS
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  Documentation/devicetree/bindings/arm/renesas.yaml | 228 +++++++++++++++++++++
>  Documentation/devicetree/bindings/arm/shmobile.txt | 155 --------------
>  MAINTAINERS                                        |   4 +-
>  3 files changed, 230 insertions(+), 157 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/renesas.yaml
>  delete mode 100644 Documentation/devicetree/bindings/arm/shmobile.txt
