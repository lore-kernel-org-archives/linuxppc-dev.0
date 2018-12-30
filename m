Return-Path: <SRS0=B87Y=PH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8387AC43387
	for <linuxppc-dev@archiver.kernel.org>; Sun, 30 Dec 2018 23:15:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9750820818
	for <linuxppc-dev@archiver.kernel.org>; Sun, 30 Dec 2018 23:15:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9750820818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Sbrs0jnXzDqLN
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Dec 2018 10:15:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=telegraphics.com.au
 (client-ip=98.124.60.144; helo=kvm5.telegraphics.com.au;
 envelope-from=fthain@telegraphics.com.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=telegraphics.com.au
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 43SbpY1dvTzDqJ3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Dec 2018 10:13:25 +1100 (AEDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by kvm5.telegraphics.com.au (Postfix) with ESMTP id ABAD52994E;
 Sun, 30 Dec 2018 18:13:19 -0500 (EST)
Date: Mon, 31 Dec 2018 10:13:17 +1100 (AEDT)
From: Finn Thain <fthain@telegraphics.com.au>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v8 18/25] powerpc: Implement nvram sync ioctl
In-Reply-To: <alpine.LNX.2.21.1812301744540.424@nippy.intranet>
Message-ID: <alpine.LNX.2.21.1812311006040.444@nippy.intranet>
References: <cover.1545784679.git.fthain@telegraphics.com.au>
 <3ba1dd965c1097e00463eafe7c7d5fd93bbed836.1545784679.git.fthain@telegraphics.com.au>
 <CAK8P3a0-4vGuCR4aCq0=D1Du1K=f5MtnB9fyCBnOsF+4Na5dMg@mail.gmail.com>
 <alpine.LNX.2.21.1812301744540.424@nippy.intranet>
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

On Sun, 30 Dec 2018, Finn Thain wrote:

> > > diff --git a/include/linux/nvram.h b/include/linux/nvram.h
> > > index b7bfaec60a43..24a57675dba1 100644
> > > --- a/include/linux/nvram.h
> > > +++ b/include/linux/nvram.h
> > > @@ -18,8 +18,12 @@ struct nvram_ops {
> > >         unsigned char   (*read_byte)(int);
> > >         void            (*write_byte)(unsigned char, int);
> > >         ssize_t         (*get_size)(void);
> > > +#ifdef CONFIG_PPC
> > > +       long            (*sync)(void);
> > > +#else
> > >         long            (*set_checksum)(void);
> > >         long            (*initialize)(void);
> > > +#endif
> > >  };
> > 
> > Maybe just leave all entries visible here, and avoid the above #ifdef 
> > checks.
> > 
> 
> The #ifdef isn't there just to save a few bytes, though it does do that. 
> It's really meant to cause a build failure when I mess up somewhere. But 
> I'm happy to change it if you can see a reason to do so (?)
> 

I think the problem with these #ifdef conditionals is that they don't 
express the correct constraints. So, at the end of this series I'd prefer 
to see,

struct nvram_ops {
       ssize_t         (*read)(char *, size_t, loff_t *);
       ssize_t         (*write)(char *, size_t, loff_t *);
       unsigned char   (*read_byte)(int);
       void            (*write_byte)(unsigned char, int);
       ssize_t         (*get_size)(void);
#if defined(CONFIG_PPC)
       long            (*sync)(void);
       int             (*get_partition)(int);
#elif defined(CONFIG_X86) || defined(CONFIG_M68K)
       long            (*set_checksum)(void);
       long            (*initialize)(void);
#endif
};

Is that okay with you?

-- 
