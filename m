Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5DA9CDDEEF
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Jan 2007 11:38:07 +1100 (EST)
Subject: Re: [PATCH 16/19] powerpc: udbg supports for Celleb
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
In-Reply-To: <200701120116.l0C1GRLg009802@toshiba.co.jp>
References: <200701120116.l0C1GRLg009802@toshiba.co.jp>
Content-Type: text/plain
Date: Thu, 18 Jan 2007 11:38:31 +1100
Message-Id: <1169080711.4965.28.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> +void __init udbg_init_debug_beat(void)
> +{
> +	celleb_vtermno = 0;
> +	udbg_putc = udbg_putc_beat;
> +	udbg_getc = udbg_getc_beat;
> +	udbg_getc_poll = udbg_getc_poll_beat;
> +}

Is celleb_vtermno ever != 0 ? I don't see that happening in your
patch...

If not, I would just remove it and just pass 0 directly :-) Or make it a
constant instead of a variable. Note that early debug is really just
that: optional early debugging which, when enabled, is likely to prevent
booting on any other platform, so only for use with debug builds. If you
ever need another value in here, thus, it's perfectly fine to make it a
Kconfig option that can be set at build time.

Ben.
