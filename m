Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from inet-tsb5.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9A270DDE04
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Dec 2007 17:36:41 +1100 (EST)
Date: Thu, 06 Dec 2007 15:36:27 +0900 (JST)
Message-Id: <20071206.153627.-1300541280.kouish@swc.toshiba.co.jp>
To: arnd@arndb.de
Subject: Re: [PATCH 1/3] cell: fix undefined reference to mmio_nvram_init
In-Reply-To: <200712041410.43736.arnd@arndb.de>
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 04 December 2007, Ishizaki Kou wrote:
> > 
> > +#ifdef CONFIG_MMIO_NVRAM
> > 	mmio_nvram_init();
> > +#endif
> >  }
> 
> The patch is technically correct, but the preferred way of doing this is
> to define a conditional inline function in the header, like:
> 
> #ifdef CONFIG_MMIO_NVRAM
> extern int mmio_nvram_init(void);
> #else
> static inline int mmio_nvram_init(void)
> {
> 	return 0;
> }
> #endif
> 
> so that the caller does not need to know about it.

Okay, I'll change my patch to rewrite include/asm-powerpc/nvram.h.

Best regards,
Kou Ishizaki
