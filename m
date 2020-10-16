Return-Path: <SRS0=n4ep=DX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153CEC433E7
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Oct 2020 23:15:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4931620878
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Oct 2020 23:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="YX9YE4pr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4931620878
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CChp16MGkzDr3h
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Oct 2020 10:15:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=googlemail.com (client-ip=2a00:1450:4864:20::544;
 helo=mail-ed1-x544.google.com;
 envelope-from=martin.blumenstingl@googlemail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none)
 header.from=googlemail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=googlemail.com header.i=@googlemail.com
 header.a=rsa-sha256 header.s=20161025 header.b=YX9YE4pr; 
 dkim-atps=neutral
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com
 [IPv6:2a00:1450:4864:20::544])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CCdWD2z9KzDqwr
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Oct 2020 07:47:20 +1100 (AEDT)
Received: by mail-ed1-x544.google.com with SMTP id p13so3842297edi.7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2020 13:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cM0Y06ICfSsoQ7UyBgP3+N66oWYmNuuTL9tZcHXPGCQ=;
 b=YX9YE4prYIppUA6bWnjFZ1SlFrt/2+Clwt/Y2HOaFsDQzC62RsyOpLMDHdZRq05zfT
 oI/clGG8Wwp2uI3zODlg24vIR8B/Htq8McDYf1W7QK3oGDMpWznzASoFSXWHrH01hjDt
 9XeAgl969QeMhMjdXEfAEqQaPDHxl/FTduIQvEeC4cnXu5e1kiWb/4hD9M41+uVV4cfe
 5H3xhmf8eHN0rg93ykx/fi1xUJpSXfnawqwK+EblahRFKhuHpDMu1dcksPXMovgNM1DQ
 fYO6fnu/GvwZsfRs2OdOMn3qipwnLIl6sZsuRxGMwuzH17TOHn5w7AdnOe24CHKjHgoF
 ZQdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cM0Y06ICfSsoQ7UyBgP3+N66oWYmNuuTL9tZcHXPGCQ=;
 b=MFK9r9Q+jFhcis08Tdrv2hnAEGrFXIVSU8i3jZ+Imx3yylW8JQOGX1c6NFjdQkHces
 VeDYBpA+1BoiqefiWj2w0Gjv9LSU+DyLCBKiScBRGamTmAq8+DerruweW5KqOUwoOFxj
 9DK/FJzdy86+oIsCHiMmIfAcj92l1LNtt8M5DhmN3Uy4s3Bm0MjyrB0vgME5Fh4SYHjp
 kV6c8487DaFY/06CUwehR88hLbGEyCl2q5HCk3wmHcMgKJvYHplUesOy06Y2Vno4Nbkv
 lev7EUqaN1MZyNnjbJLl7s3UjiXlvx/QAlth5UIxph1/kGmScb9FUxKXPbsI725CscRV
 VFxg==
X-Gm-Message-State: AOAM531ARn7ryx5GW6wFdL72/UUhWcoymxP5HZ1sAz9ki5ysIFhz5pJZ
 1V9yeoQj4r+AQuqYVZv7630Shm48txe44JP2BXg=
X-Google-Smtp-Source: ABdhPJyY7U/2059vdl/trPuz5QmTks+M1tCJlzB3pZYDFJT8/0Yi++X7QL+PvBI+5qrHrP47VENdS6ZsuDkZG+Z/RX4=
X-Received: by 2002:aa7:d690:: with SMTP id d16mr6142313edr.301.1602881233657; 
 Fri, 16 Oct 2020 13:47:13 -0700 (PDT)
MIME-Version: 1.0
References: <20201014101402.18271-1-Sergey.Semin@baikalelectronics.ru>
 <20201014101402.18271-16-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20201014101402.18271-16-Sergey.Semin@baikalelectronics.ru>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Fri, 16 Oct 2020 22:47:02 +0200
Message-ID: <CAFBinCCRobE1kQhUrh3oorQTKcQZwYEJ_MaHRtr=f=sYFCoD8g@mail.gmail.com>
Subject: Re: [PATCH 15/20] dt-bindings: usb: meson-g12a-usb: Validate
 DWC2/DWC3 sub-nodes
To: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sat, 17 Oct 2020 10:12:34 +1100
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
Cc: Neil Armstrong <narmstrong@baylibre.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>,
 Andy Gross <agross@kernel.org>, linux-snps-arc@lists.infradead.org,
 devicetree@vger.kernel.org, Mathias Nyman <mathias.nyman@intel.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
 Rob Herring <robh+dt@kernel.org>, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>,
 Felipe Balbi <balbi@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 linux-usb@vger.kernel.org, linux-mips@vger.kernel.org,
 Serge Semin <fancer.lancer@gmail.com>, linux-kernel@vger.kernel.org,
 Manu Gautam <mgautam@codeaurora.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Oct 14, 2020 at 12:14 PM Serge Semin
<Sergey.Semin@baikalelectronics.ru> wrote:
>
> Amlogic G12A USB DT sub-nodes are supposed to be compatible with the
> generic DWC USB2 and USB3 devices. Since now we've got DT schemas for
> both of the later IP cores let's make sure that the Amlogic G12A USB
> DT nodes are fully evaluated including the DWC sub-nodes.
>
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
