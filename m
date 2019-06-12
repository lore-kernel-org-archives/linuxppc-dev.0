Return-Path: <SRS0=IyNZ=UL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922A9C31E46
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Jun 2019 05:47:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E731207E0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Jun 2019 05:47:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MMp6AnWD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E731207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45Nwqs5lqSzDr28
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Jun 2019 15:47:21 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45Nwnn4CcqzDqss
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jun 2019 15:45:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="MMp6AnWD"; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 45Nwnn3B4Qz8wWS
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jun 2019 15:45:33 +1000 (AEST)
Received: by ozlabs.org (Postfix)
 id 45Nwnn2vgkz9s9y; Wed, 12 Jun 2019 15:45:33 +1000 (AEST)
Authentication-Results: ozlabs.org; spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::d44; helo=mail-io1-xd44.google.com;
 envelope-from=oohall@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="MMp6AnWD"; 
 dkim-atps=neutral
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com
 [IPv6:2607:f8b0:4864:20::d44])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 45Nwnm3G7cz9s6w
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Jun 2019 15:45:31 +1000 (AEST)
Received: by mail-io1-xd44.google.com with SMTP id u19so11936076ior.9
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Jun 2019 22:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MEsvB5fyfvbyP3599I1p81WWc20wTxokr+RDfF0sbmk=;
 b=MMp6AnWDzd6KBcaZ05OJj4lxPNM4qSHKTHwrNpVrZ6ybQr2zPK2djNtQPFmTBjpyxx
 3zMDD1ABcGN/hggjsojOwF5gDw0N019Go6xCg+jQbC7QiDEBY5KDb8L7w52J7wk6djL7
 LevIYXcqmW6kumT1P6CdW1N6dlNJqSod/jQGwFyfrxO9KW3vg1O+AbvCxC9omfwpbJwx
 Dnu/RNlSn4zHBIhPOU5lxN6jS8ksoqnzLrUm1/ofe2JegPxv5OcJh4+TmeVXvmsYE0mh
 8fSnavXYZBZDpnWmzWzIOiaOrHny6a71h2HBLD95a417HOxtpPywxe2+A16PcESVS/06
 pheg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MEsvB5fyfvbyP3599I1p81WWc20wTxokr+RDfF0sbmk=;
 b=mGAR7O+H5v17xWp5Aq/9t6zpLPFkVb6LCAIx7/gCvCcicRPkAMvGYYXirW48iiPy4m
 6tMva3jpC40wd7NVozg9P+nJJV78B264JAFBwkIiNfC9vRQN9S+i66mfagFo7Kq1sO4h
 euWFC6YaJuFdCQZHmpOSW6p7ZiazJwZwBazk9GWM6H5Xzqa1/UmApPMX/7C7WNSefptC
 VpcMrt1CTok+aoZJ5lYaNtO6rKu7plFN7JP/wqzfjxRKLBhat6rQ7H/bCucoAfJ9lxeV
 xNE0VhkgKZ/A7OLVQ2cq6cw2+ke1R3YmO5f/INct1YsUSe4/nulGnTUSCdoUQeu0e0IM
 KzlA==
X-Gm-Message-State: APjAAAW6fqJeImP8dUVJhDAYXZQW5HdZEmHV0zO+DF+LYKgGTi25w/Xx
 zLPchwllQ4y5t+DTox/Zpyulxady0zNNu6Lz2H8=
X-Google-Smtp-Source: APXvYqyNZJk2JtmF9+zZry0oIFRzIeDg8CaNRuF7MiywyUo6BfIfixNhhb9KAbPbdN9/svG6rZSoslFGyGzak7gAUZE=
X-Received: by 2002:a5e:c70c:: with SMTP id f12mr31599418iop.293.1560318328476; 
 Tue, 11 Jun 2019 22:45:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190611092144.11194-1-oded.gabbay@gmail.com>
 <20190611095857.GB24058@kroah.com>
 <20190611151753.GA11404@infradead.org> <20190611152655.GA3972@kroah.com>
 <CAFCwf13A73AxKzaa7Dk3tU-1NDgTFs4+xCO2os7SuSyUHZ9Z3Q@mail.gmail.com>
 <CAFCwf134nTD4FM_9Q+THQ7ZAZzGxhs15O6EheaRJMqM5wxi+aA@mail.gmail.com>
 <ca81ca5d56a3a12db5a92f5cf9745763a86572e8.camel@kernel.crashing.org>
In-Reply-To: <ca81ca5d56a3a12db5a92f5cf9745763a86572e8.camel@kernel.crashing.org>
From: "Oliver O'Halloran" <oohall@gmail.com>
Date: Wed, 12 Jun 2019 15:45:17 +1000
Message-ID: <CAOSf1CFcYnhKf0EJkm+E5uHg4e=QYGe+vAUz_TjX-v6UsmNtFA@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] habanalabs: enable 64-bit DMA mask in POWER9
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
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
Cc: Oded Gabbay <oded.gabbay@gmail.com>, Russell Currey <ruscur@au1.ibm.com>,
 Greg KH <gregkh@linuxfoundation.org>,
 "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>, linuxppc-dev@ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Jun 12, 2019 at 8:54 AM Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> On Tue, 2019-06-11 at 20:22 +0300, Oded Gabbay wrote:
> >
> > > So, to summarize:
> > > If I call pci_set_dma_mask with 48, then it fails on POWER9. However,
> > > in runtime, I don't know if its POWER9 or not, so upon failure I will
> > > call it again with 32, which makes our device pretty much unusable.
> > > If I call pci_set_dma_mask with 64, and do the dedicated configuration
> > > in Goya's PCIe controller, then it won't work on x86-64, because bit
> > > 59 will be set and the host won't like it (I checked it). In addition,
> > > I might get addresses above 50 bits, which my device can't generate.
> > >
> > > I hope this makes things more clear. Now, please explain to me how I
> > > can call pci_set_dma_mask without any regard to whether I run on
> > > x86-64 or POWER9, considering what I wrote above ?
> > >
> > > Thanks,
> > > Oded
> >
> > Adding ppc mailing list.
>
> You can't. Your device is broken. Devices that don't support DMAing to
> the full 64-bit deserve to be added to the trash pile.
>
> As a result, getting it to work will require hacks. Some GPUs have
> similar issues and require similar hacks, it's unfortunate.
>
> Added a couple of guys on CC who might be able to help get those hacks
> right.

> It's still very fishy .. the idea is to detect the case where setting a
> 64-bit mask will give your system memory mapped at a fixed high address
> (1 << 59 in our case) and program that in your chip in the "Fixed high
> bits" register that you seem to have (also make sure it doesn't affect
> MSIs or it will break them).

Judging from the patch (https://lkml.org/lkml/2019/6/11/59) this is
what they're doing.

Also, are you sure about the MSI thing? The IODA3 spec says the only
important bits for a 64bit MSI are bits 61:60 (to hit the window) and
the lower bits that determine what IVE to use. Everything in between
is ignored so ORing in bit 59 shouldn't break anything.

> This will only work as long as all of the system memory can be
> addressed at an offset from that fixed address that itself fits your
> device addressing capabilities (50 bits in this case). It may or may
> not be the case but there's no way to check since the DMA mask logic
> won't really apply.
>
> You might want to consider fixing your HW in the next iteration... This
> is going to bite you when x86 increases the max physical memory for
> example, or on other architectures.

Yes, do this. The easiest way to avoid this sort of wierd hack is to
just design the PCIe interface to the spec in the first place.
