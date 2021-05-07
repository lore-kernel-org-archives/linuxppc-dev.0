Return-Path: <SRS0=iVLG=KC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB9AC433ED
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 May 2021 15:37:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5959661476
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 May 2021 15:37:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5959661476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FcF2G56mBz307H
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 May 2021 01:37:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=GWEq3bdF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42a;
 helo=mail-pf1-x42a.google.com; envelope-from=andy.shevchenko@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=GWEq3bdF; dkim-atps=neutral
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FcF1n04BGz2yXc
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 May 2021 01:37:15 +1000 (AEST)
Received: by mail-pf1-x42a.google.com with SMTP id x188so7875921pfd.7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 May 2021 08:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=arEMVevpyfNHH/qKMg3yLIl1/YDAxyNNmu5V8KzMUSk=;
 b=GWEq3bdFqNNhtl5fHbSPpJ7yFRro9yFokHjw4eJm4xLLJazOMoKDaraWO1ULYGc0m7
 GjM80DiZd0zibt2JnV9oOudaFUhpl/Qs1vbzyzShMcBBn9N+AjzT4Yr+PmpmhaM4kwvF
 UHlPujwPbbQhCMHspQlGKDKAna0MuFJ4Zgqo7gaOxdo02ulwh02ojHGoeQqZBAb9rtUc
 q0sFvqD8Gn40aegbJJKFgliebJPJg0n6w8SRV6+B8bFN9Row/4f5uLhCKGy3aGg4OpmA
 wo59/4o1iPvfDpx6Q0POE9t56dGdgB4LDSW9xkknfPBEBha3CKrpADZW9SL087XOwrE8
 f/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=arEMVevpyfNHH/qKMg3yLIl1/YDAxyNNmu5V8KzMUSk=;
 b=DKN92ZkJKcFBODlvrhnXy1Izlfki8ZpfF98JmLARLrkb2rR08zKrrOI5llYcmJs/Zh
 SWEi938HRcpH07vN3zIQX5dZ3KoiRcC8/ub302khhnJpNukj7fhldQZzInflV78/wZ83
 UnEsUbaofkDdOurD+dQ0dwtq4wYZ/VU8W5MOetMbCcoHaw5u0tvXugOLTOK9SutsfyTJ
 P/m0KefMgOaacCITleEXq3xoIPyIhkr/EGOQg2+dWjupEm3Imh/wBA0eYLrBn8Aryfa1
 cpkqmiuFOVq9MmDbyO9J/jfdZAQiDEFNrShSM1Nn5o6FRwYPouBCByQsSP9Y/70Ihx8x
 6uRA==
X-Gm-Message-State: AOAM531wr3OlyKuEbVw2K8kWA8jSUFY+/VhvML3mz8dv4az0jPAixCBs
 CssVDb0PTO8rJ/dkhzQkvM7mg95xrd96NJywNBo=
X-Google-Smtp-Source: ABdhPJymffkPy/9Ej0f2meeRjcH9XIOQPO6hDH33U8Em3hMH2tQpFpejULIgrr6AUmXOnMKVfWzierHL1k3xkQJY2ss=
X-Received: by 2002:a62:e50f:0:b029:214:8e4a:ae46 with SMTP id
 n15-20020a62e50f0000b02902148e4aae46mr10872897pff.73.1620401832435; Fri, 07
 May 2021 08:37:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210507004047.4454-1-chris.packham@alliedtelesis.co.nz>
 <20210507004047.4454-4-chris.packham@alliedtelesis.co.nz>
 <CAHp75VcEzgKjOD6WQ1=YAwK_hhZr=XtcmXZL8rK78gb7iXDbDg@mail.gmail.com>
 <c4fa78e8f2c43da240c932618b87b34ba2d1d046.camel@infinera.com>
In-Reply-To: <c4fa78e8f2c43da240c932618b87b34ba2d1d046.camel@infinera.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 7 May 2021 18:36:56 +0300
Message-ID: <CAHp75Vcu-k=uzY_JYhtMp=Oe7fph3jH=t41pStUGc+bpSZeA3w@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] i2c: mpc: implement erratum A-004447 workaround
To: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, "wsa@kernel.org" <wsa@kernel.org>,
 "chris.packham@alliedtelesis.co.nz" <chris.packham@alliedtelesis.co.nz>,
 "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
 "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, May 7, 2021 at 5:52 PM Joakim Tjernlund
<Joakim.Tjernlund@infinera.com> wrote:
> On Fri, 2021-05-07 at 14:46 +0300, Andy Shevchenko wrote:
> > On Fri, May 7, 2021 at 3:40 AM Chris Packham
> > <chris.packham@alliedtelesis.co.nz> wrote:

...

> > So, now you may shrink it even further, i.e.
> >
> >        void __iomem *sr = i2c->base + MPC_I2C_SR;
> >        u8 val;
> >
> >        return readb_poll_timeout(sr, val, val & mask, 0, 100);
> >
>
> val looks uninitialised before use?

Nope.

Thinking about naming, perhaps

        void __iomem *addr = i2c->base + MPC_I2C_SR;
        u8 sr; // or leave as val?

        return readb_poll_timeout(addr, sr, sr & mask, 0, 100);

would be more clear.

-- 
With Best Regards,
Andy Shevchenko
