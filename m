Return-Path: <SRS0=3bX/=SF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3EB3C4360F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 22:29:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3186206B8
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 22:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Hn5DMg+q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3186206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44ZLN03W7ZzDqJg
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 09:29:04 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44ZLL90jV8zDqGJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Apr 2019 09:27:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.b="Hn5DMg+q"; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 44ZLL86f3fz8tDC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Apr 2019 09:27:28 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 44ZLL869QJz9sSh; Thu,  4 Apr 2019 09:27:28 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=google.com
 (client-ip=2607:f8b0:4864:20::d44; helo=mail-io1-xd44.google.com;
 envelope-from=matthewgarrett@google.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.b="Hn5DMg+q"; 
 dkim-atps=neutral
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com
 [IPv6:2607:f8b0:4864:20::d44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 44ZLL82cKQz9sSS
 for <linuxppc-dev@ozlabs.org>; Thu,  4 Apr 2019 09:27:26 +1100 (AEDT)
Received: by mail-io1-xd44.google.com with SMTP id b6so340923iog.0
 for <linuxppc-dev@ozlabs.org>; Wed, 03 Apr 2019 15:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+3faNpmag6jYME5yNI69COYIz0d4qS337f0eaty0yLY=;
 b=Hn5DMg+qfhg8lnUXmQEgJ4eyGQRy86cBCVdOiz+SoR4bX8ULjx3usvppAd3U/Tjo+3
 pHcQLhA3s2MAgrAxsJP7GSq7JG6jMjmn4mjKyBEp/bGnUhoOwSeCwPTclx6LWkhYulrq
 SoU9wFkqFC1RrPQXHhojDrXTjLSQN+So9U3wt214BoVJ5XUbH4bQp44HLENcmeD4Mb3X
 qdL0djpsWoB7JX+T5M6PCzE9BbFqDSBCTtApX3wdEYLcOQPrAI6bORTgR2IpA6jHh8MT
 x6QCOhB3xdwb3cRgS2IhQ6tWhcf8Fn7ZIVFwQJWsgDGNEbeTqB6zPq7VypFgzQgg3Ss5
 o+pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+3faNpmag6jYME5yNI69COYIz0d4qS337f0eaty0yLY=;
 b=knCFuKEmyL9zu0xwF61RpeFIBXDRb0f3LuUZ41bHB9xz1pU23lF46AA++jATg+Exje
 gRsXZSgT8ZGBIeZMTFJhClZMLynMhWFi+WU2wdsrfr3Mk6RSJp0wLaYSNh7L6aRJR4pu
 7c5ze6pMw11yCxUNpfGJQgJmmBec+uMPONQXl381ZrX7mNC5O/kbS7aEqowQUUKdMUp4
 BLu1H/aMD/AsMlq++HQcel8FWBNuiK3Izvids2sGOnNqtZSwLS+I3P5sZidtUZ9+RxM2
 5HYwmR0CVwFC/htiikXJfvltPxGnOQfc6UO1frFCa6m5s994998ktfZNOomNR2w5jhVK
 /1Cw==
X-Gm-Message-State: APjAAAXZCxDi3FH3CO+aWcKUcemzaNjK5bSLfI2kcaNbA98RY/g1evGb
 k4shqCRfGEzS+1ifY+EXD6NdWLTYNG6kbwK09WWfyQ==
X-Google-Smtp-Source: APXvYqyjaucmj870Vz9jHZPatpcn5T0LihCycvdCx7VILq9npP5A6ssDHW9qOcaFARXAimNtxuuxG36+qUImTOEY86c=
X-Received: by 2002:a5e:d514:: with SMTP id e20mr2067567iom.8.1554330444296;
 Wed, 03 Apr 2019 15:27:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190402181505.25037-1-cclaudio@linux.ibm.com>
 <CACdnJuumhkqTb4+1=QBiLmbW4xd3wW=MZu6Tj_KdaoTMhCN+Tg@mail.gmail.com>
 <4ce5e057-0702-b0d5-7bb2-cea5b22e2efa@linux.ibm.com>
 <CACdnJusBm93zwDqTXTx_QYsg1-aGUAAHm_qq8Lcx3TvGTxdmbg@mail.gmail.com>
 <2208f156-d441-3082-2f4c-8030c84ef788@linux.ibm.com>
In-Reply-To: <2208f156-d441-3082-2f4c-8030c84ef788@linux.ibm.com>
From: Matthew Garrett <mjg59@google.com>
Date: Wed, 3 Apr 2019 15:27:13 -0700
Message-ID: <CACdnJuu8OqMrSs0esOmf=ro9n00aYEQ-nikAh6v6sk+YAQw4cQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] Enabling secure boot on PowerNV systems
To: Claudio Carvalho <cclaudio@linux.ibm.com>
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
Cc: linux-efi <linux-efi@vger.kernel.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, Nayna Jain <nayna@linux.ibm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Matthew Garret <matthew.garret@nebula.com>, linuxppc-dev@ozlabs.org,
 Paul Mackerras <paulus@samba.org>, Jeremy Kerr <jk@ozlabs.org>,
 linux-integrity <linux-integrity@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Apr 2, 2019 at 4:31 PM Claudio Carvalho <cclaudio@linux.ibm.com> wrote:
>
>
> On 4/2/19 6:51 PM, Matthew Garrett wrote:
> > So you implement the full PK/KEK/db/dbx/dbt infrastructure, and
> > updates are signed in the same way?
>
> For the first version, our firmware will implement a simplistic PK, KEK and
> db infrastructure (without dbx and dbt) where only the Setup and User modes
> will be supported.

Not supporting dbx seems like a pretty significant shortcoming. How
are signatures meant to be revoked?

> PK, KEK and db updates will be signed the same way, that is, using
> userspace tooling like efitools in PowerNV. As for the authentication
> descriptors, only the EFI_VARIABLE_AUTHENTICATION_2 descriptor will be
> supported.

Is this API documented?

> > In that case we might be better off with a generic interface for this
> > purpose that we can expose on all platforms that implement a secure
> > boot key hierarchy. Having an efivarfs that doesn't allow the creation
> > of arbitrary attributes may break other existing userland
> > expectations.
> >
> For what it's worth, gsmi uses the efivars infrastructure for EFI-like
> variables.

My recollection is that at the time the Chromebook firmware still had
EFI underpinnings and the gsmi code was largely just an alternate
mechanism for calling into something that was fundamentally the EFI
variable store. With hindsight I don't think layering this was the
right move - we've adjusted the semantics of efivarfs on more than one
occasion to deal with the behaviour of real-world EFI platforms, and I
don't think it's helpful to end up in a situation where we're trying
to keep behaviour consistent among entirely different firmware
interfaces.

> What might a generic interface look like?  It would have to work for
> existing secure boot solutions - including EFI - which would seem to imply
> changes to userspace tools.

I think that depends on exactly what problem you're trying to solve.
Some aspects of the EFI secure boot design end up mirroring the
economics of the PC ecosystem rather than being inherently good design
goals, so it'd be helpful to know whether you're taking this solution
because you want the same three-level key infrastructure or because
that just leaves you compatible with the tooling.
