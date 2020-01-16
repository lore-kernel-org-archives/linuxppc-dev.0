Return-Path: <SRS0=yMLg=3F=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29253C33CB1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Jan 2020 07:16:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 542F420748
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Jan 2020 07:16:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="Nh2BQZur"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 542F420748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47ywVQ0bwlzDqZT
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Jan 2020 18:16:46 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47ywS74HWtzDq5n
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jan 2020 18:14:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 secure) header.d=jms.id.au header.i=@jms.id.au header.a=rsa-sha256
 header.s=google header.b=Nh2BQZur; dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 47ywS720psz8tDZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jan 2020 18:14:47 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 47ywS71Zcnz9sRQ; Thu, 16 Jan 2020 18:14:47 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::843;
 helo=mail-qt1-x843.google.com; envelope-from=joel.stan@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: ozlabs.org; dkim=pass (1024-bit key;
 secure) header.d=jms.id.au header.i=@jms.id.au header.a=rsa-sha256
 header.s=google header.b=Nh2BQZur; dkim-atps=neutral
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 47ywS63dK1z9sNx
 for <linuxppc-dev@ozlabs.org>; Thu, 16 Jan 2020 18:14:46 +1100 (AEDT)
Received: by mail-qt1-x843.google.com with SMTP id w8so3681059qts.11
 for <linuxppc-dev@ozlabs.org>; Wed, 15 Jan 2020 23:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=a15ZuGAtufU5x/KAhZ9T/j7mhuhDHgJD+8khZdYFPmw=;
 b=Nh2BQZur8b7XtSoakDRAgQMSat3OGhVtEeCk54glRiXp/fVHshHFUx+Flb1pDq+T1h
 lncqFUtsmXHS/Dd2uPdwVAg+cne6uDFeBRqK7xyMUW69c+Nwb39hbVnVCJpc3CAse8gX
 iUmd0PWtJ+5NYyLq3y9ipys7z61bWoFaUV7UM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=a15ZuGAtufU5x/KAhZ9T/j7mhuhDHgJD+8khZdYFPmw=;
 b=VFPrD2dlfEz5cz0hb21EBP6/RYmz2vGjvVmUsofopj7LNpLyHPhChAtu6KSYeGRPec
 1sj+i5EKm7aQJkhbd0yZywPDkVCdBSgTFG0mWULGMNS8jBaV9FnkB27y2XD8Pnix/6Rf
 ZLBQPwYX0UNB+Sv8but8kxTkq7X/XRTQseaI7iby42E2ikwXkkm4Z6YSdtpjAaohiP/6
 cgNSXweIz03y7HhNff+QPtlQcrJsf/htFY2hFGgoDqmtNGanvDKqnmXmxn4MGO1dhZ+s
 AAMU1eN5M8C1VR5HzBWkDQChHGqcAcEVkqzN1IovD+qyVb2O7ZKPiSfn+0VNmQoilltU
 s1Hg==
X-Gm-Message-State: APjAAAUcNxhaqSzQdxwttO6qRBEqBavG8VfqSs0NNjNQiI1+qesXKeJu
 MYDA/RcbnL7ZHA5LsEeflzhGdtaPIwO8aaFZaTs=
X-Google-Smtp-Source: APXvYqwsKGt0z4vWzXr2HVsUIFvOWUqWN4ZpQFS5WV03tmSqauj5TcHXmDw0LFRinRf83H+UwhQDlrH6377Bo7iifGA=
X-Received: by 2002:ac8:3467:: with SMTP id v36mr1039487qtb.255.1579158883358; 
 Wed, 15 Jan 2020 23:14:43 -0800 (PST)
MIME-Version: 1.0
References: <20200116014808.15756-1-mpe@ellerman.id.au>
 <20200116014808.15756-7-mpe@ellerman.id.au>
 <871rs0knbj.fsf@dja-thinkpad.axtens.net>
 <CAOSf1CGnYqa7-QA-hK2OxymOQM8RS55xXq4cOvtou9nGfSWHgA@mail.gmail.com>
In-Reply-To: <CAOSf1CGnYqa7-QA-hK2OxymOQM8RS55xXq4cOvtou9nGfSWHgA@mail.gmail.com>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 16 Jan 2020 07:14:31 +0000
Message-ID: <CACPK8XfBS8qRQ5fromLZXvQ-1EB_=yQvHYb8sWmG-B20ufW+SA@mail.gmail.com>
Subject: Re: [PATCH 7/9] powerpc/configs/skiroot: Enable security features
To: "Oliver O'Halloran" <oohall@gmail.com>
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
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Nayna Jain <nayna@linux.ibm.com>,
 Daniel Axtens <dja@axtens.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 16 Jan 2020 at 07:10, Oliver O'Halloran <oohall@gmail.com> wrote:
>
> On Thu, Jan 16, 2020 at 4:00 PM Daniel Axtens <dja@axtens.net> wrote:
> >
> > Michael Ellerman <mpe@ellerman.id.au> writes:
> >
> > > From: Joel Stanley <joel@jms.id.au>
> > >
> > > This turns on HARDENED_USERCOPY with HARDENED_USERCOPY_PAGESPAN, and
> > > FORTIFY_SOURCE.
> > >
> > > It also enables SECURITY_LOCKDOWN_LSM with _EARLY and
> > > LOCK_DOWN_KERNEL_FORCE_CONFIDENTIALITY options enabled.
> > >
> >
> > As I said before, this will disable xmon entirely. If we want to set
> > this, we should compile out xmon. But if we want xmon in read-only mode
> > to be an option, we should pick integrity mode.
> >
> > I don't really mind, because I don't work with skiroot very
> > much. Oliver, Joel, Nayna, you all do stuff around this sort of level -
> > is this a problem for any of you?
>
> Keep it enabled and force INTEGRITY mode. There are some cases where
> xmon is the only method for debugging a crashing skiroot (hello SMC
> BMCs) so I'd rather it remained available. If there's some actual
> security benefit to disabling it entirely then someone should
> articulate that.

Ack.
