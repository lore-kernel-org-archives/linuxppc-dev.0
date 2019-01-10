Return-Path: <SRS0=xr3w=PS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B29C43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 19:44:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB30E20879
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 19:44:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB30E20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43bGfn5y99zDqXb
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 06:44:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.167.193; helo=mail-oi1-f193.google.com;
 envelope-from=pku.leo@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=nxp.com
Received: from mail-oi1-f193.google.com (mail-oi1-f193.google.com
 [209.85.167.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43bGd30N8vzDqW9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2019 06:43:15 +1100 (AEDT)
Received: by mail-oi1-f193.google.com with SMTP id v6so10274787oif.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jan 2019 11:43:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sPgfEhYHHNB7vBHfMgCSXcBGQ+fLWI4pdLUmG15pdOo=;
 b=EHpOIuv6vC9TR9WYozfw4eU37fbI0P5RNO1GW4bxbS2jmKVyTCVazO3lQ2dvUX9NCg
 xqx6Ot3kRZG8jfMGJvMK0dczEfQzgI6LiuZUVk8Zda6xODL1eV9jlVY9tWoLeM21cN4X
 kYLHW8wumf1k++e+yG/9hBchfN7Qx8YU4COWY6ScRytdgSUNN/bAZZT9BY8A71gr3kMx
 Sh7Dt08fBTIBPTejao4IM8PMlH7M6Z6i2l3nQu6DYwYVANXuuC/Ewv0kklU7rGuntb6T
 egqjOXfn7FA7UZvm+OjAlkZbSEAs1QQw6sHGL8qXHff2pRa1Gr/OFxNuPfuNrkLaftzF
 +p0g==
X-Gm-Message-State: AJcUukdufHeSu78Xc/MPj8JsVGcS1qRtYU7dI7FL/lrWIus3X1wC+9XO
 5B67H+PNvTzQzKyU+aVuUSGvU7Wq
X-Google-Smtp-Source: ALg8bN5NH4WsPFFntXRfduOdUya0yNKHies5sUl9ZR9FCcr7eOIIWAXOExpxi+eeU6hnySARTB/8vQ==
X-Received: by 2002:aca:5117:: with SMTP id f23mr7583249oib.72.1547149393655; 
 Thu, 10 Jan 2019 11:43:13 -0800 (PST)
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com.
 [209.85.210.48])
 by smtp.gmail.com with ESMTPSA id d10sm32694312otl.62.2019.01.10.11.43.12
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 10 Jan 2019 11:43:13 -0800 (PST)
Received: by mail-ot1-f48.google.com with SMTP id u16so11018715otk.8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jan 2019 11:43:12 -0800 (PST)
X-Received: by 2002:a9d:2387:: with SMTP id t7mr7303236otb.68.1547149392367;
 Thu, 10 Jan 2019 11:43:12 -0800 (PST)
MIME-Version: 1.0
References: <1544170963-8386-1-git-send-email-hofrat@osadl.org>
 <98aba52405a63829ee79c775c8b749f8431f5d2a.camel@buserror.net>
 <20181222075944.GA26155@osadl.at>
In-Reply-To: <20181222075944.GA26155@osadl.at>
From: Li Yang <leoyang.li@nxp.com>
Date: Thu, 10 Jan 2019 13:43:01 -0600
X-Gmail-Original-Message-ID: <CADRPPNTeLH1ChyYgP3fwqkHLTYCcV48tY1W+91nufFJu+yFKrA@mail.gmail.com>
Message-ID: <CADRPPNTeLH1ChyYgP3fwqkHLTYCcV48tY1W+91nufFJu+yFKrA@mail.gmail.com>
Subject: Re: [PATCH] soc: fsl: guts: us devm_kstrdup_const() for RO data
To: Nicholas Mc Guire <der.herr@hofr.at>
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
Cc: Scott Wood <oss@buserror.net>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 lkml <linux-kernel@vger.kernel.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, Nicholas Mc Guire <hofrat@osadl.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, Dec 22, 2018 at 2:02 AM Nicholas Mc Guire <der.herr@hofr.at> wrote:
>
> On Fri, Dec 21, 2018 at 08:29:56PM -0600, Scott Wood wrote:
> > On Fri, 2018-12-07 at 09:22 +0100, Nicholas Mc Guire wrote:
> > > devm_kstrdup() may return NULL if internal allocation failed, but
> > > as  machine  is from the device tree, and thus RO, devm_kstrdup_const()
> > > can be used here, which will only copy the reference.
> >
> > Is it really going to only copy the reference?  That would require that
> > is_kernel_rodata(machine) be true, which it shouldn't be since it's not part
> > of the kernel image.
> >
> I had tried to figure out what is RO and what not but was not
> able to determine that - from the discussion it seemed that the
> assumption of RO is correct though I did not ask if it would
> satisfy is_kernel_rodata() so that explains the incorrect assertion.
> see https://lkml.org/lkml/2018/12/6/42
> So then the only option is to check the return and cleanup
> on allocation failure as the orriginal patch proposed.

Thanks for the good discussion. I will drop the previous patch. But
would it also be good to just have "soc_dev_attr.machine = machine"
directly?

Regards,
Leo
