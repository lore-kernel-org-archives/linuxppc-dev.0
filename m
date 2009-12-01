Return-Path: <roman.fietze@telemotive.de>
Received: from coyote.quickmin.net (coyote.quickmin.net [217.14.112.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.quickmin.de", Issuer "smtp.quickmin.de" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 0C774B7B68
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  1 Dec 2009 21:03:42 +1100 (EST)
Received: from rfietze.mit.telemotive.de (rfietze.mit.telemotive.de
	[192.168.5.33])
	by alderan.mit.telemotive.de (Postfix) with ESMTP id 8119FBD743
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  1 Dec 2009 11:03:36 +0100 (CET)
From: Roman Fietze <roman.fietze@telemotive.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: MPC5200B XLB BSDIS question
MIME-Version: 1.0
Message-ID: <200912011103.35959.roman.fietze@telemotive.de>
Date: Tue, 1 Dec 2009 11:03:35 +0100
Content-Type: text/plain;
  charset="iso-8859-1"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello list,

In our old, modified 2.4.25 I had a statement that sets the bit BSDIS
(real world bit 16, Freescale bit 15) in the XLB config register for
the MPC5200B.

Checking the XLB config of "my" 2.6.32-rc7 doesn't show this bit set
(XLB config reads 0x0000a006).

But this gives me trouble when running under high (BestComm) load. I
have a stress test programm that writes data via PATA to an ext3
filesystem as fast as possible. At the same time I'm using the SCLPC
together with BestComm to read data from FLASH as fast as possible in
64KiB blocks.

Without this bit set I have wrong data in the DMA receive buffer,
almost always only in the first data word (32 bits wide).

And I also have wrong data if I do not invalidate_dcache_range my DMA
buffer before starting the BC task. Looking at dma_map_single or the
old pci_map_single shows me, that they do the cache invalidation on
architecture with non coherent cache, the MPC5200 should be one of
them.

See this old thread that seems to second my theory about a problem in
the MPC5200B, which wouldn't be the first one:

http://www.mail-archive.com/linuxppc-embedded@ozlabs.org/msg02842.html


Is there a reason not to set that bit? Is it true, as I believe it,
that the "polairity" of this bit is documented the wrong way e.g. in
=46reescale's AN3045?


Roman

=2D-=20
Roman Fietze                Telemotive AG B=FCro M=FChlhausen
Breitwiesen                              73347 M=FChlhausen
Tel.: +49(0)7335/18493-45        http://www.telemotive.de
