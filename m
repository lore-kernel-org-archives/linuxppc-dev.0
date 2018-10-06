Return-Path: <SRS0=wZlq=MS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD32C64EB8
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Oct 2018 09:22:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71C5620644
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Oct 2018 09:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BNFRaC7W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71C5620644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42S1Ns4RH7zF3cK
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Oct 2018 19:22:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BNFRaC7W";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::52b; helo=mail-ed1-x52b.google.com;
 envelope-from=raziebe@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="BNFRaC7W"; 
 dkim-atps=neutral
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42S1L92sBxzDrTQ
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Oct 2018 19:20:00 +1000 (AEST)
Received: by mail-ed1-x52b.google.com with SMTP id b7-v6so7023567edd.9
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 06 Oct 2018 02:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=sy96uoXMwPa+JcCZZrdPw6RSX+2+4of+Nt+57JsnX4I=;
 b=BNFRaC7W6uE4X1lOKD8Dh68dN7ppwieFSDTeyi0+pMdwTfOmoCmAfbdV06AMnXHV9J
 029qKlB9eBhbcxs1U6j8rX/v63ShfC36rd3aB9kVKDxLC4VDSe4Dgu7g4pyJcmLjPvcM
 fqZUZxQ76LV3h9i7BYZmBv0A5uHxCFzHuCAlXBVbKSQrQcTeJFp0xVkkBp25GI8Es2ES
 8dgP3Trjwanad6CRgixjtmjZCNloI1eT1BKG8jhlIm3OvSN+t8EL2mwJ53/9pdyn3yjc
 pzuzAlkOcLueWARbF1sATCkFTe5KGnAIIKBsQF3QO2WgG1NIta+SD9cUbTOwL9GN9ViC
 IXvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sy96uoXMwPa+JcCZZrdPw6RSX+2+4of+Nt+57JsnX4I=;
 b=HTM6KWx7MWq/lSWAq5DRghkh3jgY7WR3W+5FoF7dJNNscmeNq+5TAf2CMUbvMiWw6b
 XmXggffkvoR3+M3rQwy/MNfM8eJhAQqMJrLoUmDuxbgBLGvzzzojQ3+KK07TOUNeJxeZ
 BwAm8kpDDabZZcXJnid1OXg1fK/STr8yj1SrM1aBgrMH45/A2Dl+Dau3IvtLx8e5AnlW
 i4HXk80vPK9WlhYSQ7ES13i5FWNVWTd2c2VHE1+80p1WO9jKZOL3oArE67Nd+9DYtotz
 UcvBhl44FJ5tEyGH/kh9O36uBbX8ArusLKo3Orwk/xrN42M1CuJdZi31qusjz1ZPkyg0
 nnoA==
X-Gm-Message-State: ABuFfohF6JTpH/Tx+U73mJ/qurledKltGoPVR/Io/uNaVMjLvMbYtY8h
 KOGFpICOlZEtj1CZN0SkKPhe5+coXCNWnPLpnrU=
X-Google-Smtp-Source: ACcGV61tp5cFLo69avPT2AvyLHmOG73IlcKsR9IKFuq5TPUTnTXs/vE0PtOOBMHhHGHjq624z6E8K+THlPb0y4wKkQI=
X-Received: by 2002:a50:ae45:: with SMTP id
 c63-v6mr18818588edd.239.1538817597114; 
 Sat, 06 Oct 2018 02:19:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAPB=Z-rEoVWFFDBS_XhuOQyL+YxR8jScSAAQfO1X-n_Lbm=StA@mail.gmail.com>
 <87sh1nk70y.fsf@concordia.ellerman.id.au>
 <CAPB=Z-pLCkXcsAXD5YWt5pwPzFzJrdZsdDye_bZjE0-ea-Ur6A@mail.gmail.com>
 <20181004101640.t3o7v73fcipsjg3k@lt-gp.iram.es>
In-Reply-To: <20181004101640.t3o7v73fcipsjg3k@lt-gp.iram.es>
From: Raz <raziebe@gmail.com>
Date: Sat, 6 Oct 2018 12:19:45 +0300
Message-ID: <CAPB=Z-pW6FWEp=0PgphCo-mAh9pPgt0frjz_MkPp6YHuhX3-pQ@mail.gmail.com>
Subject: Re: Looking for architecture papers
To: paubert@iram.es
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hey
How does HVSC works ?
I looked in the code and LoPAR documentation. It looks like there is
vector called
system_call_pSeries ( at 0xc00 ) that is supposed to be called when we
invoke HVSC from kernel
mode.
Now, I wrote a NULL call HSVC and patched the exceptions-64s.S to
return RFID immediately.
This does not work.
Would you be so kind to explain how HVSC works ?
thank you








On Thu, Oct 4, 2018 at 1:16 PM Gabriel Paubert <paubert@iram.es> wrote:
>
> On Thu, Oct 04, 2018 at 10:41:13AM +0300, Raz wrote:
> > Frankly, the more I read the more perplexed I get. For example,
> > according to BOOK III-S, chapter 3,
> > the MSR bits are differ from the ones described in
> > arch/powerpc/include/asm/reg.h.
> > Bit zero, is LE, but in the book it is 64-bit mode.
>
> Just a problem of bit order definitions: IBM hardware definitions use
> big-endian bit ordering, where bit 0 is the most significant bit.
>
> >
> > Would someone be kind to explain what I do not understand?
> >
> > Thank you
>
>         Gabriel
