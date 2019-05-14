Return-Path: <SRS0=tOPa=TO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BCA4C04AB4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 May 2019 22:41:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E006B2168B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 May 2019 22:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lA4Lmt90"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E006B2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 453XjJ0KVjzDqNt
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 May 2019 08:41:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::e43; helo=mail-vs1-xe43.google.com;
 envelope-from=slandden@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="lA4Lmt90"; 
 dkim-atps=neutral
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com
 [IPv6:2607:f8b0:4864:20::e43])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 453MSR330JzDqHx
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 May 2019 01:44:39 +1000 (AEST)
Received: by mail-vs1-xe43.google.com with SMTP id v9so10645100vse.5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 May 2019 08:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=doobemoMELlPZ80bJJg6KvAJfoNs19EYl0poLKxcxQg=;
 b=lA4Lmt908J3ykek4At0uQA8xN/0lXGKG8XsbNj/GXNpFMm/m0W7omlNLqEccef2ngn
 UwsjdUpH7Ug/X/hEZq7K7rwBMJ4vnsbCg4cqwqhj+NCeisYdWucYvJc1n7V5WQw3IN8x
 4T34wpWr7kfylwXWIsNIf69Ni8yuW7sfMjrIosjqHWo9sUa0Banjd7Rfzrkq7uFQSbGH
 QWCua/jZARJO2tzSR3cfn8L/0Z16OoA0ZYB+bcibwnmwYl26hd06pJkvSeWkU9N+mVdt
 uqzMuGPfLINM0v8tAw1p9x+IcQI2GPAdTVMyx4WuLwNF0a4vf6PRsmk2ql/eCNLNkvvM
 1VDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=doobemoMELlPZ80bJJg6KvAJfoNs19EYl0poLKxcxQg=;
 b=J8bDeiWUgvf38mm3u6kBsg5tM9RtjlGCxbajelo5jpfJDkIf/7gKRhDqoP6Hjyl2r0
 6pnNRKI0QzqOJAmWk4ew6uZ+uIcF3xw/GWrMSBidZte2Mnn3UpUEFbG1GaCE5hnBpmdC
 56bR4DQQ2q2sgzrEoeim7QEQmKmJ9uED9X2Um5ghh8Asm+AGdfMghn6VwpGP0yBJeCTA
 z7qmpAShOy86hn5f6LAdPp4MWDZ+GNBWFixFj+Wm21MARMfmpCNtxei8+RhRXaGLjw+z
 9YAiibLcWZsH+T+dMMw98rP951T2MN7TMsNbMsxEFmUHm97jrCK3EaF3SpG2ringkLL0
 b49g==
X-Gm-Message-State: APjAAAVOb2VaVN4qpWKX+UQRxKNIoDR2F86dRMljoxHjE4sKGDhyBEEd
 LxpM3wXnLdobHTh2HBhIm3AwOPbfDHE4W9PbUSJbH6D+gE8=
X-Google-Smtp-Source: APXvYqy6RBtSnKwiBZD5aN6lGObeMGGyw/PW5+BaUMATHd9t8UP2ksrUwPFYwObS3gTKQ6tIxELOSpd3LtbShm63Zu8=
X-Received: by 2002:a67:302:: with SMTP id 2mr16339740vsd.91.1557848676999;
 Tue, 14 May 2019 08:44:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190513005104.20140-1-shawn@git.icu>
 <20190514014412.25373-1-shawn@git.icu>
 <a9f1e109e0b6de8abfabc62375403754ab22dcfc.camel@kernel.crashing.org>
In-Reply-To: <a9f1e109e0b6de8abfabc62375403754ab22dcfc.camel@kernel.crashing.org>
From: Shawn Landden <slandden@gmail.com>
Date: Tue, 14 May 2019 10:44:25 -0500
Message-ID: <CA+49okqxAGaNEFJWv-P843vZ0yz0f2qvMkimtAHoCLBojrdwBQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] [PowerPC] Add simd.h implementation
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 15 May 2019 08:38:49 +1000
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
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, May 14, 2019 at 12:43 AM Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> On Mon, 2019-05-13 at 22:44 -0300, Shawn Landden wrote:
> > +
> > +/*
> > + * Were we in user mode when we were
> > + * interrupted?
> > + *
> > + * Doing kernel_altivec/vsx_begin/end() is ok if we are running
> > + * in an interrupt context from user mode - we'll just
> > + * save the FPU state as required.
> > + */
> > +static bool interrupted_user_mode(void)
> > +{
> > +       struct pt_regs *regs = get_irq_regs();
> > +
> > +       return regs && user_mode(regs);
> > +}
> > +
>
> That's interesting .... it *could* work but we'll have to careful audit
> the code to make sure thats ok.
>
> We probably also want to handle the case where the CPU is in the idle
> loop.
That is the next patch. It is best to split these up because then git
bisect works better, and these are higher-risk changes.
>
> Do we always save the user state when switching out these days ? If
> yes, then there's no "live" state to worry about...
>
> Cheers,
> Ben.
>
>
