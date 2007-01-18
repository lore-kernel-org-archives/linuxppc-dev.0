Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from inet-tsb5.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A4FB6DDE36
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Jan 2007 18:58:20 +1100 (EST)
Date: Thu, 18 Jan 2007 16:58:05 +0900 (JST)
Message-Id: <200701180758.l0I7w74l005198@toshiba.co.jp>
To: benh@kernel.crashing.org
Subject: Re: [PATCH 16/19] powerpc: udbg supports for Celleb
In-Reply-To: <1169080711.4965.28.camel@localhost.localdomain>
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

Ben-san,

Thank you for your comment.

> > +void __init udbg_init_debug_beat(void)
> > +{
> > +	celleb_vtermno = 0;
> > +	udbg_putc = udbg_putc_beat;
> > +	udbg_getc = udbg_getc_beat;
> > +	udbg_getc_poll = udbg_getc_poll_beat;
> > +}

> Is celleb_vtermno ever != 0 ? I don't see that happening in your
> patch...

No. celleb_vtermno is currently fixed to 0. I had a plan to change
it at runtime, but I forgot to implement such behavior.

> If not, I would just remove it and just pass 0 directly :-) Or make it a
> constant instead of a variable. Note that early debug is really just
> that: optional early debugging which, when enabled, is likely to prevent
> booting on any other platform, so only for use with debug builds. If you
> ever need another value in here, thus, it's perfectly fine to make it a
> Kconfig option that can be set at build time.

Or finding vterm number on the commandline (like pSeries).

I don't stick to use other than 0 for celleb_vtermno, so I'll
#define it to 0. That's the simplest way.

Best regards,
Kou Ishizaki
