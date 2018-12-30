Return-Path: <SRS0=B87Y=PH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A1FC43387
	for <linuxppc-dev@archiver.kernel.org>; Sun, 30 Dec 2018 07:29:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78260213F2
	for <linuxppc-dev@archiver.kernel.org>; Sun, 30 Dec 2018 07:29:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78260213F2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43SBsX3WF0zDqJV
	for <linuxppc-dev@archiver.kernel.org>; Sun, 30 Dec 2018 18:29:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=telegraphics.com.au
 (client-ip=98.124.60.144; helo=kvm5.telegraphics.com.au;
 envelope-from=fthain@telegraphics.com.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=telegraphics.com.au
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 43SBpG5PkDzDqJc
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Dec 2018 18:26:46 +1100 (AEDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by kvm5.telegraphics.com.au (Postfix) with ESMTP id 99A9021FEF;
 Sun, 30 Dec 2018 02:26:43 -0500 (EST)
Date: Sun, 30 Dec 2018 18:26:40 +1100 (AEDT)
From: Finn Thain <fthain@telegraphics.com.au>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v8 13/25] m68k: Dispatch nvram_ops calls to Atari or Mac
 functions
In-Reply-To: <CAK8P3a0P7r+PCykB1cHq3HBrpHagfJ5WhDV7JR-wu0tGTMSFMA@mail.gmail.com>
Message-ID: <alpine.LNX.2.21.1812301750320.424@nippy.intranet>
References: <cover.1545784679.git.fthain@telegraphics.com.au>
 <505240b144f1666acf26a3c1e93c8e6868fe1408.1545784679.git.fthain@telegraphics.com.au>
 <CAK8P3a0P7r+PCykB1cHq3HBrpHagfJ5WhDV7JR-wu0tGTMSFMA@mail.gmail.com>
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
 Geert Uytterhoeven <geert@linux-m68k.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Joshua Thompson <funaho@jurai.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, 29 Dec 2018, Arnd Bergmann wrote:

> On Wed, Dec 26, 2018 at 1:43 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> 
> > +
> > +static ssize_t m68k_nvram_get_size(void)
> > +{
> > +       if (MACH_IS_ATARI)
> > +               return atari_nvram_get_size();
> > +       else if (MACH_IS_MAC)
> > +               return mac_pram_get_size();
> > +       return -ENODEV;
> > +}
> > +
> > +/* Atari device drivers call .read (to get checksum validation) whereas
> > + * Mac and PowerMac device drivers just use .read_byte.
> > + */
> > +const struct nvram_ops arch_nvram_ops = {
> > +#ifdef CONFIG_MAC
> > +       .read_byte      = m68k_nvram_read_byte,
> > +       .write_byte     = m68k_nvram_write_byte,
> > +#endif
> > +#ifdef CONFIG_ATARI
> > +       .read           = m68k_nvram_read,
> > +       .write          = m68k_nvram_write,
> > +       .set_checksum   = m68k_nvram_set_checksum,
> > +       .initialize     = m68k_nvram_initialize,
> > +#endif
> > +       .get_size       = m68k_nvram_get_size,
> > +};
> > +EXPORT_SYMBOL(arch_nvram_ops);
> 
> Since the operations are almost entirely distinct, why not have two
> separate 'nvram_ops' instances here that each refer to just
> the set they actually need?
> 

The reason for that is that I am alergic to code duplication. But I'll 
change it if you think it matters. BTW, this patch has already been acked 
by Geert.

> I was actually expecting one more patch here that would make the
> arch_nvram_ops a pointer to one of multiple structures, which would
> be easier to do with multiple copies, but I suppose there is no need
> for that here (there might be on ppc, I have to look again).
> 

Yes, I considered that too. I picked the variation that makes everything 
const.

-- 

>        Arnd
> 
