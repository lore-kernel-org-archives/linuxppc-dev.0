Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 5516D67B66
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Sep 2006 07:00:03 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Allocalting > 4M
Date: Wed, 27 Sep 2006 23:00:16 +0200
References: <DCEAAC0833DD314AB0B58112AD99B93B0189DF9C@ismail.innsys.innovsys.com>
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B0189DF9C@ismail.innsys.innovsys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200609272300.16962.arnd@arndb.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Am Wednesday 27 September 2006 22:34 schrieb Rune Torgersen:
> Is there any way, short of using mem= on kernel command line and
> reserving memory, to allocate more than 4M of contigous physical memory?
> We're trying to allocalte a 8M buffer for use in some DMA transfers for
> a bank of DSP's.
> We were using get_Free_pages to allocate the meory before we made the
> buffer bigger. It seems that get_free_pages cannot allocate more than
> 2^10 pages (4M on ppc)
> I also tried alloc_bootmem, but it fails also.

alloc_bootmem is supposed to handle this case, but you can only call
that very early in your code, before the buddy allocator kicks in
(free_all_bootmem()). Maybe you should just check why it fails for you.

	Arnd <><
