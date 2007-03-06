Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 44D6CDDF18
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  6 Mar 2007 23:44:28 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: static immap_t   __iomem *imap    or   immap_t *imap;
Date: Tue, 6 Mar 2007 13:44:00 +0100
References: <F1F6EC0C8B75034F9E3A79FC85122E8E6C0AA8@aquib01a>
In-Reply-To: <F1F6EC0C8B75034F9E3A79FC85122E8E6C0AA8@aquib01a>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200703061344.00685.arnd@arndb.de>
Cc: DI BACCO ANTONIO - technolabs <Antonio.DiBacco@technolabs.it>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tuesday 06 March 2007, DI BACCO ANTONIO - technolabs wrote:
> Why should I use
> static immap_t =A0 __iomem *imap;
> And not
> immap_t *imap;
> in a driver?
> when imap =3D ioremap_nocache()
>=20
> In particular I know that __iomem is useful to the compiler to avoid
> reordering and delaying io memory writes but what's the need for static
> in this case?

The '__iomem' is use to allow static checking with the 'sparse' tool,
you really should use that before submitting any code. At this point,
gcc itself doesn't care. ioremap_nocache() returns __iomem, so anything
you assign it to should also be __iomem.

The 'static' is what you should use for _any_ symbol that is private
to your driver in order to avoid namespace pollution, it has nothing
to do whatsoever with whether it is about an __iomem address or not.

	Arnd <><
