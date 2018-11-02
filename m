Return-Path: <SRS0=pcIm=NN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E4BC32789
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Nov 2018 17:41:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9323F2081B
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Nov 2018 17:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="V2r7licP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9323F2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42mqBl3nN4zF37d
	for <linuxppc-dev@archiver.kernel.org>; Sat,  3 Nov 2018 04:41:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="V2r7licP";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=google.com
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=ndesaulniers@google.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.b="V2r7licP"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42mq7G2NZnzF37R
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Nov 2018 04:38:50 +1100 (AEDT)
Received: by mail-pf1-x443.google.com with SMTP id f78-v6so1354602pfe.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Nov 2018 10:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=a5QCiQ5tsAa5YZsiGXmiA7qTRyvmCAg1ea00McmOprE=;
 b=V2r7licPYhdXAZG6Uq2tmWovDTGpCAid0A8GKkXlluRmBEvpYtR4NrxQWIsR9ttsDt
 bqNKi1hZSoTS5p96Dg6u7iWrV5eFdl6wLgmsWIGXGg8ZR0sIgBQt/luoC4+Gw+qUH4KJ
 Q3b0EKAo2ofo6d52Zs8Dtj6eQoJSG5hkihNtf0jfFc1XSyqOFAWj8XGqec0lljxcd0tQ
 Cn+E+6WutswkYErnI8bZnPuI9rf+1E6SJyKLWLBiAlOhwd+kzR+6wBcYgdiojiKM1AS4
 1lgl6aZyjVPFH1ssogoLYcuQ7G+CzWJJ8DpYDTP28Rz9GbP6Ql109l3e8BnGZo5ek/XX
 rlBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=a5QCiQ5tsAa5YZsiGXmiA7qTRyvmCAg1ea00McmOprE=;
 b=nw1pjw47p+MIl/svk8AmM/9JcsBSjcjRtmiZEB8vBdkd0hfWvQWFx8iXk4VC6XjRcf
 sW2cKGnxvTmpJesu+CFyHw82uWHTr+9ZZhBpugWPoy9Xf4vtlQeuieFjfnLGqSWwgQxn
 0ZI2S3YkOv7O8CY65V2emP4fIHofhrjpl+GFo9jJBmaW7hdHMmdR7KpRuvzz/x0vdzau
 M7NXHpyvtSoNNQP22Up9ShhyI4YZIFFnYd3Obh+TyQcQx2H0wqIBIcIHhFxzdS00DrWt
 fsd16aNuNU2zelT7W1rWluby/6Du6p11znnqFffUomMtF8DYZPFR83c2tMM6A3CaZ5C6
 3V4A==
X-Gm-Message-State: AGRZ1gL0HarMSWmtAL2uqBRSHehpH9Alm4xsghtts/fXhkoaMJ0pDkDG
 RCkCpAGNKTUYOYSJgir/puE50GSFXdC8Y5fW+K60IAHLPYk=
X-Google-Smtp-Source: AJdET5ccPWk7YrMZT1Wlhx42fdhsQEpA77XN8i4L5lqXuinL5VjcJ3D/GtWutXNaIaEOZ5tEWxhJj7kGZvKOCVNEnsI=
X-Received: by 2002:a62:5bc4:: with SMTP id
 p187-v6mr12614835pfb.94.1541180327818; 
 Fri, 02 Nov 2018 10:38:47 -0700 (PDT)
MIME-Version: 1.0
References: <20181102033713.31916-1-joel@jms.id.au>
 <20181102173442.GT5994@gate.crashing.org>
In-Reply-To: <20181102173442.GT5994@gate.crashing.org>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Fri, 2 Nov 2018 10:38:36 -0700
Message-ID: <CAKwvOd=3JFm+ReeJ5QfQJ77ypN6+qipB-3LfpVcK+umKud5dgA@mail.gmail.com>
Subject: Re: [PATCH] powerpc/math-emu: Fix building with clang
To: segher@kernel.crashing.org
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
Cc: linuxppc-dev@lists.ozlabs.org, joel@jms.id.au
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Nov 2, 2018 at 10:34 AM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> On Fri, Nov 02, 2018 at 02:07:13PM +1030, Joel Stanley wrote:
> >   arch/powerpc/math-emu/fnmsub.c:46:2: error: invalid use of a cast in a
> >   inline asm context requiring an l-value: remove the cast or build with
> >   -fheinous-gnu-extensions
>
> (It is spelled lvalue).
>
> *All* of extended asm is a GNU extension, what is clang trying to say here?
> Confused :-)

Isn't the result of a cast a temporary value?  Probably just need to
move the case out of the inline asm block to a separate statement.
Having the full backtrace should help.

-- 
Thanks,
~Nick Desaulniers
