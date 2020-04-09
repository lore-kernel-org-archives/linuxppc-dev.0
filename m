Return-Path: <SRS0=vMbJ=5Z=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77AE6C2D0EA
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Apr 2020 04:50:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B24DF20757
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Apr 2020 04:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ArTiQa/7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B24DF20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48yTGv4lHPzDqSj
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Apr 2020 14:50:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::341;
 helo=mail-ot1-x341.google.com; envelope-from=jniethe5@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=ArTiQa/7; dkim-atps=neutral
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48yTDy0tQkzDr83
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Apr 2020 14:48:49 +1000 (AEST)
Received: by mail-ot1-x341.google.com with SMTP id l23so9225002otf.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2020 21:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EJXiJXKf8niD9eqk4k5D//MWXAqCo5EAe8QQdLwHHYE=;
 b=ArTiQa/7QXmnRchOXS4SISmqmPnOum3BFWhk6zaV53/LNyMGA38wY00Qxew+WZOnId
 RHxoNntqHAOXFNMVY4Skr3PEuo4qtWnZ3RVbJRo9jCm14FQmNtyqG7YLBUbpmucVMKNY
 eZOp1m++wc3OU7XeQVW3aFlcORmLeyqRqYoPwH/4S0HYWN0JJmouubiIcukMZLetAUfW
 3uyGleG+OcIeMJhSpZJbihksOTl0ygY5wLbCPk+spc0QEoydZGqK/aUkkEO+KrHOW4iy
 A9GFNwXuw5K01Q9LnrgAOahzDhUhmee1ANkFahlpE6Nk7+rjjLOf1LBzOCukHHw126Fz
 B3yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EJXiJXKf8niD9eqk4k5D//MWXAqCo5EAe8QQdLwHHYE=;
 b=EAXc/fVgGEUet8+BCnizyNUNDpzd3h7Df0cZhNbtG76ub0do14I8pwhsTPPHVn4NQ6
 Rz0NCbgCqotZUhwGwF28oesmS8Q2IFItKlTe/r8+PNc+8ODwEOZ0vCXs/hQkp6jAVLWk
 PP5NfNZh/84Csd6lfCIQW9OyJpbWSB5jYiXR4fOkfRE7byNPpNib5VNWuJR+xFJaX0K2
 qM4zvloUJ3ZrDVI/BJTLBKcYskpkNHeGHXAKb6TE12xib55KNKk6GTHbtHrVZ8dfLoql
 RDF2o/xXxRAsUDKWfgOjGiYZgI0UL5cfA9oLg3KmltDgkq5R+fdjiOINTbXx9NuqI8BS
 BflQ==
X-Gm-Message-State: AGi0Pubk2V9PtltO6YzvtNtESvzOegWp9rCWXK8t8PP6avqywiNUvyb3
 dyO3S9MPw4qpe5KtP2JoDK+CoIZAxHiGK2vyKoo=
X-Google-Smtp-Source: APiQypJi5M0becJluhFtteH9DtRj6ZjMtTSe1RDrzmCbWM2l02+JJvY1Qug9igEHAaWdxDDROfQMoLQiJhlw+FQFQoo=
X-Received: by 2002:a9d:62c2:: with SMTP id z2mr8849109otk.155.1586407726305; 
 Wed, 08 Apr 2020 21:48:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200406080936.7180-1-jniethe5@gmail.com>
 <20200406080936.7180-6-jniethe5@gmail.com>
 <20200408182109.GH26902@gate.crashing.org>
In-Reply-To: <20200408182109.GH26902@gate.crashing.org>
From: Jordan Niethe <jniethe5@gmail.com>
Date: Thu, 9 Apr 2020 14:48:35 +1000
Message-ID: <CACzsE9oCZiLXLWVFKsiN9LsLXPsH8r5q4zrgwHP1KHLemTgioA@mail.gmail.com>
Subject: Re: [PATCH v5 05/21] powerpc: Use a function for getting the
 instruction op code
To: Segher Boessenkool <segher@kernel.crashing.org>
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
Cc: Alistair Popple <alistair@popple.id.au>, Daniel Axtens <dja@axtens.net>,
 linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>,
 Balamuruhan S <bala24@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Apr 9, 2020 at 4:21 AM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> Hi!
>
> On Mon, Apr 06, 2020 at 06:09:20PM +1000, Jordan Niethe wrote:
> > +static inline int ppc_inst_opcode(u32 x)
> > +{
> > +     return x >> 26;
> > +}
>
> Maybe you should have "primary opcode" in this function name?
Thanks, that is a good idea.
>
>
> Segher
