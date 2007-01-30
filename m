Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id D1727DDF75
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jan 2007 21:45:12 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 5/9] ps3: Preallocate bootmem memory for ps3fb
Date: Tue, 30 Jan 2007 11:44:41 +0100
References: <Pine.LNX.4.62.0701251825390.14799@pademelon.sonytel.be>
	<Pine.LNX.4.62.0701300934270.4728@pademelon.sonytel.be>
	<1170148116.26655.328.camel@localhost.localdomain>
In-Reply-To: <1170148116.26655.328.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200701301144.42120.arnd@arndb.de>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	linuxppc-dev@ozlabs.org, Linux Frame Buffer Device Development
	<linux-fbdev-devel@lists.sourceforge.net>,
	James Simmons <jsimmons@infradead.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 30 January 2007 10:08, Benjamin Herrenschmidt wrote:
> 
> > I'm afraid that assumption is usually false, as you only need to access the
> > FLASH when you want to change boot flags or update the boot loader.
> 
> At the same time, flash doesn't have to be fast... can't we use a
> smaller bounce buffer (a page) and divide the transfer ?

No, the problem is that the flash interface only supports an hcall
for 'erase+write', but not separately, so the writes need to do
in erase block size, even if the physical medium can probably
handle smaller writes after a block was erased.

	Arnd <><
