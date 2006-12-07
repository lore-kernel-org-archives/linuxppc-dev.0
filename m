Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id A47EE67CB3
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Dec 2006 08:37:35 +1100 (EST)
Date: Thu, 7 Dec 2006 22:37:33 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [PATCH] ps3: add vuart support
In-Reply-To: <457879BE.9000704@am.sony.com>
Message-ID: <Pine.LNX.4.62.0612072229260.30717@pademelon.sonytel.be>
References: <45775D89.7030904@am.sony.com> <200612071937.22607.arnd@arndb.de>
	<457879BE.9000704@am.sony.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 7 Dec 2006, Geoff Levand wrote:
> Arnd Bergmann wrote:
> > On Thursday 07 December 2006 01:17, Geoff Levand wrote:
> >> Adds support for the PS3 virtual UART (vuart).  The vuart provides a
> >> bi-directional byte stream data link between logical partitions.
> > 
> > Looks good now, just a few minor comments:
> > 
> >> +struct ports_bmp
> >> +{
> >> +	u64 status;
> >> +	u64 unused[3];
> >> +} __attribute__ ((packed));
> > 
> > Do you really want to have this structure packed? It will produce
> > better code if it isn't.
> 
> Yes, it is a little obscure in the code, but the address of the ports_bmp
> instance is passed to ps3_alloc_vuart_irq(), which in turn calls
> lv1_configure_virtual_uart_irq().  The HV (actually the vuart service
> in the policy module) uses this as a 256 bit bitmap to indicate the
> interrupt status of the ports.  The system supports 256 ports, but
> currently just two ports, 1 and 3, are used, so I took advantage of
> that to simplify the code and just used the first word of the bitmap.

I think Arnd meant that the `__attribute__ ((packed))' is useless for structs
containing u64 members only. The natural alignment of 64-bit values is on a
64-bit boundary, so there won't be padding anyway.

IIRC, someone (davem?) told me a long time ago gcc _always_ uses byte-accesses
when accessing members in a struct with `__attribute__ ((packed))', since the
members may be unaligned. Even when the values are perfectly aligned. So it's
better not to use `__attribute__ ((packed))' unless it's really needed.

Why is there a comment about `Needs 4 byte alignment.'? The way it's used, it
will always be 8-byte aligned anyway.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
