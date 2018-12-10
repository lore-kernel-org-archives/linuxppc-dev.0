Return-Path: <SRS0=HYLD=OT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE6CAC04EB8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 17:07:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A79220821
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 17:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IG6frN4I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A79220821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43D8dn0b3mzDqsQ
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 04:07:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IG6frN4I";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::a33; helo=mail-vk1-xa33.google.com;
 envelope-from=rsalvaterra@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="IG6frN4I"; 
 dkim-atps=neutral
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com
 [IPv6:2607:f8b0:4864:20::a33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43D8Zk1k6ZzDqnr
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Dec 2018 04:05:01 +1100 (AEDT)
Received: by mail-vk1-xa33.google.com with SMTP id h128so2678441vkg.11
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Dec 2018 09:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=8d6hJDj9WYGcZt3sOxU9jJpzctdAC7KsWBf92Fbncno=;
 b=IG6frN4IFhlnXf7eyBGJBso/GIv3zt8BhHbMAXIo/2+8/FzmSnipAK4TOGUNbD/fbx
 ALGPxa1j0Sr5UuWMR4PtuPUsWivjAEG6H5JGFVLGCgi6pL9iVex/+a2xLXidzM+cazoU
 4jsCiJiD5MMi0ZSy6V2S4JdXIWH48qYyJB9pyO6n/UZSiz6cl9lflxv+LqEPPpUwYGnD
 OP834UdnBTkqgn4LqcYt3etoj9n4wtxlFs79+CIOU2LTvGH/U+i9A5hGYQm6NhpoTuq8
 4tjPkz80mwZL+pjiL8Gn7ocP47/Jj2eaVgixeRMLxU51FKIsvHuCNQR9moX3AQJsNEpW
 G8yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=8d6hJDj9WYGcZt3sOxU9jJpzctdAC7KsWBf92Fbncno=;
 b=CohzUWMzVbRQtadqxfFuR/+gCMbfcsedM2tRY1zoHKj3ocY1Dwhu/MRLWB3xjqo0rd
 84CGGw6M585SIolwIU/InTTONMw93i4jPVWRCUSLio1J2pDGW2Sr3nKiymW5+iKnuo6C
 2Tc7YE79wrRD0MymECGqFY/F/PpTHV4xjLtgJnpZ9o0eW4KOmIb/AoiYtRX9RUntSBD/
 E9KvzTO4fTVSWOPAFy9tGGGVrcYxav1ejHDcIBQTNdrRBssSRKlRrcEqg872wBQe/b0V
 +w1sireik7qIH688ra9He+fKt3ppm5kY5rpGJRGYs3b1EPKAxTVEGrh4GY8Fs/eL2xGm
 0E+A==
X-Gm-Message-State: AA+aEWb5LgQxNXtf0r97qbgrFnj8bKkwj3cduzRV2Ul8VgNsv5CaoTMc
 RogOzGoEHYEL3u6KMtIx9e/fN3BANYB9e1snJQ==
X-Google-Smtp-Source: AFSGD/XwD+ohLgnHVWDVpPif+ofSWFVZqhWkMcZLZLTLZ1xX5bP8T8LpKUW5pVPkDlxiOhTSZKX7OIonH6+NZYPeRkM=
X-Received: by 2002:a1f:4982:: with SMTP id w124mr5436394vka.4.1544461498701; 
 Mon, 10 Dec 2018 09:04:58 -0800 (PST)
MIME-Version: 1.0
References: <CALjTZvZzHSZ=s0W0Pd-MVd7OA0hYxu0LzsZ+GxYybXKoUQQR6Q@mail.gmail.com>
 <20181130103222.GA23393@lst.de>
 <CALjTZvZsk0qA+Yxu7S+8pfa5y6rpihnThrHiAKkZMWsdyC-tVg@mail.gmail.com>
 <42b1408cafe77ebac1b1ad909db237fe34e4d177.camel@kernel.crashing.org>
 <20181208171746.GB15228@lst.de>
In-Reply-To: <20181208171746.GB15228@lst.de>
From: Rui Salvaterra <rsalvaterra@gmail.com>
Date: Mon, 10 Dec 2018 17:04:46 +0000
Message-ID: <CALjTZvb4+Ox5Jdm-xwQuxMDz_ub=mHAgPLA4NgrVNZTmUZwhnQ@mail.gmail.com>
Subject: Re: use generic DMA mapping code in powerpc V4
To: hch@lst.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, 8 Dec 2018 at 17:17, Christoph Hellwig <hch@lst.de> wrote:
>
> On Sun, Dec 02, 2018 at 05:11:02PM +1100, Benjamin Herrenschmidt wrote:
> > Talking of which ... Christoph, not sure if we can do something about
> > this at the DMA API level or keep hacks but some adapters such as the
> > nVidia GPUs have a HW hack we can use to work around their limitations
> > in that case.
> >
> > They have a register that can program a fixed value for the top bits
> > that they don't support.
> >
> > This works fine for any linear mapping with an offset, provided they
> > can program the offset in that register and they have enough DMA range
> > to cover all memory from that offset.
> >
> > I can probably get the info about this from them so we can exploit it
> > in nouveau.
>
> I think we can expose the direct mapping offset if people care enough,
> we just have to be very careful designing the API.  I'll happily leave
> that to those that actually want to use it, but I'll gladly help
> reviewing it.

Hi, Christoph and Ben,

It just came to my mind (and this is most likely a stupid question,
but still)=E2=80=A6 Is there any possibility of these changes having an
(positive) effect on the long-standing problem of Power Mac machines
with AGP graphics cards (which have to be limited to PCI transfers,
otherwise they'll hang, due to coherence issues)? If so, I have a G4
machine where I'd gladly test them.

Thanks,

Rui
