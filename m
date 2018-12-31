Return-Path: <SRS0=LDiU=PI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06347C43387
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Dec 2018 12:37:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FB6520828
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Dec 2018 12:37:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FB6520828
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Sxf90r0HzDqJq
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Dec 2018 23:37:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.160.194; helo=mail-qt1-f194.google.com;
 envelope-from=arndbergmann@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com
 [209.85.160.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43SxYR0KMPzDqKM
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Dec 2018 23:33:14 +1100 (AEDT)
Received: by mail-qt1-f194.google.com with SMTP id u47so24563082qtj.6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Dec 2018 04:33:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RwU2Y+gpTZt+nue9fhxVSylTa7plk4FrzInK4LqoluI=;
 b=ror+Wa3+a48p+2js3zL12C85IVM+CwICwinP5gSlH4Grb/8hwlT5NM3fsW+LVE9duu
 bqzQb7+2Vijq1sosipk8y/S/2T7mvLWOpvXRgMURJGTAGxdr8VcFbo8Dju70SR4QPMuA
 /VqdRF/oAQzMXl5uCSr0DlyXJibrAnRdPSy7YMpDpgYNBJ90e/zT/bFG3OWRkQPKPb+r
 dzgrtVty2FYImsBGoHsLWVN/pu8ZDEgcUJKqJr7Yr9y36BzDzToWU8lqRTFB5UMjCHzF
 bBs8F97+KQ2vh6ewN2Dl8BCQSpvbIYb0WvLuI4W37vKfXp90jzRpR8vU9RBxK57Quq+z
 XFtQ==
X-Gm-Message-State: AJcUukdWDlq6UGPEUpcGTGDOEt79+abs9TMqChr9KjovCBvwiRrTf5F8
 CY779eGaKgLQJthmAitptpm/rt533Eq2Mr0OK3I=
X-Google-Smtp-Source: ALg8bN4TD/GbypKBpOh5YRDFPzr2bnm3gxPGhwf/NOqhuWWtVExcUwllgVZc0JW3lX4qvLgT1gWHihXC91JJj95wCKA=
X-Received: by 2002:a0c:f50c:: with SMTP id j12mr35192233qvm.149.1546259592841; 
 Mon, 31 Dec 2018 04:33:12 -0800 (PST)
MIME-Version: 1.0
References: <cover.1545784679.git.fthain@telegraphics.com.au>
 <2fe2b8e6395aeacfafcbde590a50922d4e632189.1545784679.git.fthain@telegraphics.com.au>
 <CAK8P3a2p91XJfJuSCZqRLRgC-aP3LR1tMK2DDxTiSuD8_FOg8Q@mail.gmail.com>
 <alpine.LNX.2.21.1812301401220.215@nippy.intranet>
In-Reply-To: <alpine.LNX.2.21.1812301401220.215@nippy.intranet>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 31 Dec 2018 13:32:56 +0100
Message-ID: <CAK8P3a3OD9ou=y+PaZ03v-ivW4A3fwwzA+aL+CoJDd_L2vTMLA@mail.gmail.com>
Subject: Re: [PATCH v8 24/25] powerpc: Adopt nvram module for PPC64
To: Finn Thain <fthain@telegraphics.com.au>
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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, Dec 30, 2018 at 4:29 AM Finn Thain <fthain@telegraphics.com.au> wrote:
>
> On Sat, 29 Dec 2018, Arnd Bergmann wrote:
>
> > On Wed, Dec 26, 2018 at 1:43 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> >
> > > +static ssize_t ppc_nvram_get_size(void)
> > > +{
> > > +       if (ppc_md.nvram_size)
> > > +               return ppc_md.nvram_size();
> > > +       return -ENODEV;
> > > +}
> >
> > > +const struct nvram_ops arch_nvram_ops = {
> > > +       .read           = ppc_nvram_read,
> > > +       .write          = ppc_nvram_write,
> > > +       .get_size       = ppc_nvram_get_size,
> > > +       .sync           = ppc_nvram_sync,
> > > +};
> >
> > Coming back to this after my comment on the m68k side, I notice that
> > there is now a double indirection through function pointers. Have you
> > considered completely removing the operations from ppc_md instead by
> > having multiple copies of nvram_ops?
> >
>
> I considered a few alternatives. I figured that it was refactoring that
> could be deferred, as it would be confined to arch/powerpc. I was more
> interested in the cross-platform API.

Fair enough.

> > With the current method, it does seem odd to have a single
> > per-architecture instance of the exported structure containing function
> > pointers. This doesn't give us the flexibility of having multiple copies
> > in the kernel the way that ppc_md does, but it adds overhead compared to
> > simply exporting the functions directly.
> >
>
> You're right, there is overhead here.
>
> With a bit of auditing, wrappers like the one you quoted (which merely
> checks whether or not a ppc_md method is implemented) could surely be
> avoided.
>
> The arch_nvram_ops methods are supposed to optional (that is, they are
> allowed to be NULL).
>
> We could call exactly the same function pointers though either ppc_md or
> arch_nvram_ops. That would avoid the double indirection.

I think you can have a 'const' structure in the __ro_after_init section,
so without changing anything else, powerpc could just copy the
function pointers from ppc_md into the arch_nvram_ops at early
init time, which should ideally simplify your implementation as well.

        Arnd
