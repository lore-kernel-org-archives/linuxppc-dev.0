Return-Path: <SRS0=vwdz=N7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286F5C46465
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Nov 2018 18:47:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6050F208E4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Nov 2018 18:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="uYazAUbO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6050F208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42zvpg1Z7QzF3b4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Nov 2018 05:47:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="uYazAUbO";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=google.com
 (client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com;
 envelope-from=ndesaulniers@google.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.b="uYazAUbO"; 
 dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42zvly2F4kzF3Xh
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Nov 2018 05:45:33 +1100 (AEDT)
Received: by mail-pl1-x643.google.com with SMTP id b5so1604656plr.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2018 10:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mvQ/yZt43rnSLHWopcQ9j1ld5hJMRX470tXxTIn6PpQ=;
 b=uYazAUbOYMSN+O06CtI7rCBDFhSKsOM+ZOKjGPyH4u8nHRYBSl0WfpuRefg8dRpD4L
 kWuA484LOvMwVI/4ryWy88WO6SNDDoGgK/OYCsrpFFzT6Kpyb+4eJlOHPMzBzUxFFgGS
 2R0bXxNq+igHLJrvCLblQJKygKY1aBolSpqZlbmdyCrSSTQNzGLkeIGofOfYada5Y/xS
 r5QGg1EuFiDDzJqDCHF5/l+QKLW1IRCQcm6SABRN6uKX096K7mleNSkBB/ifLJmE/FkJ
 fO6/BTPgGczMKikGogQ9714UnTDI1WEs7RKzaQTYQC/MI3d/h6q+2tpwrNRjmAyVkPJi
 32vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mvQ/yZt43rnSLHWopcQ9j1ld5hJMRX470tXxTIn6PpQ=;
 b=VOpdRxMiFLkd5eioXA8tVKrWYUlywburTqsBeIbe44ydCmBNlzJDvDEbCLVYOZXcD8
 jkrKBvL/8vcQ5r06QXiWcsWlvzLaGfU8fGJnbiExXPrc4iuv79e3NYNZyi+Jf1wzhy/x
 L66Fg/1hSc2r4v4xC64kJArZKsGZPXVdj/X2JKKCC1F0Unt1XRTYxbiUIwe6seg1lsez
 4uA1jVH2am6nYHnXu4CElbsdQvv5V3AH0OdAg2uyxmHPns6L5s9d/K3TE/B8h3Zo/VC+
 +zw/wLXUigKkT2kAfQecKZ/houggIAcFZuHxI7dZwNUmF/6GJ8CQjRKt4Ng2KMFdAznU
 8eLQ==
X-Gm-Message-State: AA+aEWbVsXH6Da4lKaq08Js4sXdKnaXARS+7MvnMnUFkX8WzP3Os2ovB
 NdULGEVzdD4tmN+qn/4kXUUrolS61r0KyWY6xAhncDgmMrtI6w==
X-Google-Smtp-Source: AFSGD/WKcOwpUCLeNQyBEsrofett22SheZ0szCSAj+vCsufi5PBo9ZH76l4qoLfAP+DtJpozQ/1q8XVHQ+O+5U0Z38c=
X-Received: by 2002:a17:902:8306:: with SMTP id
 bd6mr3390284plb.217.1542739530822; 
 Tue, 20 Nov 2018 10:45:30 -0800 (PST)
MIME-Version: 1.0
References: <20181114024412.19368-1-joel@jms.id.au>
 <CAKwvOd=P6eQsysnhYVjekbKzVMiGZH8K2nO=Y2gNaH6j+yAhSQ@mail.gmail.com>
 <CACPK8XcdMgrnUQsHH4-fHX2Cw7=zXPBhsDJUNGQJ1=hjh0P4CQ@mail.gmail.com>
 <20181120182029.GA23873@gate.crashing.org>
In-Reply-To: <20181120182029.GA23873@gate.crashing.org>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Tue, 20 Nov 2018 10:45:19 -0800
Message-ID: <CAKwvOdmbkZCQzFCDQUMdM-_Ds4zFDZRtr=ZbsHzVzKoEg55K7w@mail.gmail.com>
Subject: Re: [PATCH v2] powerpc/math-emu: Update macros from gmp-6.1.2
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

On Tue, Nov 20, 2018 at 10:20 AM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> On Tue, Nov 20, 2018 at 09:45:33AM +1030, Joel Stanley wrote:
> > On Tue, 20 Nov 2018 at 05:24, Nick Desaulniers <ndesaulniers@google.com> wrote:
> > > >
> > > > The only functional change I noticed was this in udiv_qrnnd.
> > AIUI the upstream source is GMP:
> >
> >  https://gmplib.org/repo/gmp/file/tip/longlong.h
> >
> > > If we're going to borrow implementations from GCC, let's borrow the
> > > same implementation. Otherwise it's hard to have confidence in this
> > > part of the patch.
> >
> > I agree we should use the upstream source.
> >
> > Segher, which tree contains the One True Upstream for longlong.h?
>
> You should probably get your updates from the same place as was used to
> get the file in the first place.

So sounds like GMP is the source to take then.  Joel, would you mind
sending a v3 with just the commit message updated to reflect the fact
that GCC and GMP differ in implementations, and this is taken from
GMP, maybe with some links?  I think that will provide more context
for future travelers.  I'd be happy to add my reviewed-by tag to that.

-- 
Thanks,
~Nick Desaulniers
