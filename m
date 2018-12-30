Return-Path: <SRS0=B87Y=PH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82EA4C43387
	for <linuxppc-dev@archiver.kernel.org>; Sun, 30 Dec 2018 22:14:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6B102081B
	for <linuxppc-dev@archiver.kernel.org>; Sun, 30 Dec 2018 22:14:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6B102081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43SZVz2L1QzDqJR
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Dec 2018 09:14:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=telegraphics.com.au
 (client-ip=98.124.60.144; helo=kvm5.telegraphics.com.au;
 envelope-from=fthain@telegraphics.com.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=telegraphics.com.au
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 43SZSf2dVrzDqJ2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Dec 2018 09:12:50 +1100 (AEDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by kvm5.telegraphics.com.au (Postfix) with ESMTP id 5AD0629BC9;
 Sun, 30 Dec 2018 17:12:44 -0500 (EST)
Date: Mon, 31 Dec 2018 09:12:42 +1100 (AEDT)
From: Finn Thain <fthain@telegraphics.com.au>
To: LEROY Christophe <christophe.leroy@c-s.fr>
Subject: Re: [PATCH v8 13/25] m68k: Dispatch nvram_ops calls to Atari or Mac
 functions
In-Reply-To: <20181230185300.Horde.o5iU5x8n8UeDsyjemaBU_w7@messagerie.si.c-s.fr>
Message-ID: <alpine.LNX.2.21.1812310847210.444@nippy.intranet>
References: <cover.1545784679.git.fthain@telegraphics.com.au>
 <505240b144f1666acf26a3c1e93c8e6868fe1408.1545784679.git.fthain@telegraphics.com.au>
 <CAK8P3a0P7r+PCykB1cHq3HBrpHagfJ5WhDV7JR-wu0tGTMSFMA@mail.gmail.com>
 <alpine.LNX.2.21.1812301750320.424@nippy.intranet>
 <20181230185300.Horde.o5iU5x8n8UeDsyjemaBU_w7@messagerie.si.c-s.fr>
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
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Joshua Thompson <funaho@jurai.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, 30 Dec 2018, LEROY Christophe wrote:

> > > 
> > > Since the operations are almost entirely distinct, why not have two 
> > > separate 'nvram_ops' instances here that each refer to just the set 
> > > they actually need?
> > > 
> > 
> > The reason for that is that I am alergic to code duplication. But I'll 
> > change it if you think it matters. BTW, this patch has already been 
> > acked by Geert.
> 
> I agree it would be cleaner, as it would also avoid this 
> m68k_nvram_get_size() wouldn't it ?
> 

No, that function makes run-time decisions. #ifdef won't work.

> I don't see potential code duplication here, do you ?
> 

Here's my problem with Arnd's suggestion. Consider this C code,

#ifdef FOO
const struct nvram_ops arch_nvram_ops = {
	/* ... */
}
#else
const struct nvram_ops arch_nvram_ops = {
        /* ... */
}
#endif

Lets say you write a hypothetical patch to remove the 'const'. Now you 
have two 'const' keywords to edit, and you have the risk of overlooking 
one of them. The solution to this problem is sometimes referred to as 
"DRY", meaning Don't Repeat Yourself:

const struct nvram_ops arch_nvram_ops = {
        /* ... */
#ifdef FOO
        /* ... */
#else
        /* ... */
#endif
        /* ... */
}

But I'm over-simplifying. Arnd's alternative actually goes like this,

#if defined(CONFIG_MAC) && !defined(CONFIG_ATARI)
const struct nvram_ops arch_nvram_ops = {
        /* ... */
}
#elif !defined(CONFIG_MAC) && defined(CONFIG_ATARI)
const struct nvram_ops arch_nvram_ops = {
        /* ... */
}
#elif defined(CONFIG_MAC) && defined(CONFIG_ATARI)
const struct nvram_ops arch_nvram_ops = {
        /* ... */
}
#endif

So, you're right, this isn't "duplication", it's "triplication".

-- 

> Christophe
> 
