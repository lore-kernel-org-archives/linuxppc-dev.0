Return-Path: <SRS0=B87Y=PH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32BC6C43387
	for <linuxppc-dev@archiver.kernel.org>; Sun, 30 Dec 2018 03:31:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4935021019
	for <linuxppc-dev@archiver.kernel.org>; Sun, 30 Dec 2018 03:31:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4935021019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43S5ZR47nMzDqHr
	for <linuxppc-dev@archiver.kernel.org>; Sun, 30 Dec 2018 14:31:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=telegraphics.com.au
 (client-ip=98.124.60.144; helo=kvm5.telegraphics.com.au;
 envelope-from=fthain@telegraphics.com.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=telegraphics.com.au
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 43S5X374CxzDqHK
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Dec 2018 14:29:07 +1100 (AEDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by kvm5.telegraphics.com.au (Postfix) with ESMTP id CF1AB28EDF;
 Sat, 29 Dec 2018 22:29:03 -0500 (EST)
Date: Sun, 30 Dec 2018 14:28:56 +1100 (AEDT)
From: Finn Thain <fthain@telegraphics.com.au>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v8 24/25] powerpc: Adopt nvram module for PPC64
In-Reply-To: <CAK8P3a2p91XJfJuSCZqRLRgC-aP3LR1tMK2DDxTiSuD8_FOg8Q@mail.gmail.com>
Message-ID: <alpine.LNX.2.21.1812301401220.215@nippy.intranet>
References: <cover.1545784679.git.fthain@telegraphics.com.au>
 <2fe2b8e6395aeacfafcbde590a50922d4e632189.1545784679.git.fthain@telegraphics.com.au>
 <CAK8P3a2p91XJfJuSCZqRLRgC-aP3LR1tMK2DDxTiSuD8_FOg8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Sat, 29 Dec 2018, Arnd Bergmann wrote:

> On Wed, Dec 26, 2018 at 1:43 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> 
> > +static ssize_t ppc_nvram_get_size(void)
> > +{
> > +       if (ppc_md.nvram_size)
> > +               return ppc_md.nvram_size();
> > +       return -ENODEV;
> > +}
> 
> > +const struct nvram_ops arch_nvram_ops = {
> > +       .read           = ppc_nvram_read,
> > +       .write          = ppc_nvram_write,
> > +       .get_size       = ppc_nvram_get_size,
> > +       .sync           = ppc_nvram_sync,
> > +};
> 
> Coming back to this after my comment on the m68k side, I notice that 
> there is now a double indirection through function pointers. Have you 
> considered completely removing the operations from ppc_md instead by 
> having multiple copies of nvram_ops?
> 

I considered a few alternatives. I figured that it was refactoring that 
could be deferred, as it would be confined to arch/powerpc. I was more 
interested in the cross-platform API.

> With the current method, it does seem odd to have a single 
> per-architecture instance of the exported structure containing function 
> pointers. This doesn't give us the flexibility of having multiple copies 
> in the kernel the way that ppc_md does, but it adds overhead compared to 
> simply exporting the functions directly.
> 

You're right, there is overhead here.

With a bit of auditing, wrappers like the one you quoted (which merely 
checks whether or not a ppc_md method is implemented) could surely be 
avoided.

The arch_nvram_ops methods are supposed to optional (that is, they are 
allowed to be NULL).

We could call exactly the same function pointers though either ppc_md or 
arch_nvram_ops. That would avoid the double indirection.

-- 

>        Arnd
> 
