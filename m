Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 5504767B52
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Sep 2006 07:29:46 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Allocalting > 4M
Date: Wed, 27 Sep 2006 16:29:45 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B0189DF9D@ismail.innsys.innovsys.com>
In-Reply-To: <200609272300.16962.arnd@arndb.de>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Arnd Bergmann" <arnd@arndb.de>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

=20

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd@arndb.de]=20
> alloc_bootmem is supposed to handle this case, but you can only call
> that very early in your code, before the buddy allocator kicks in
> (free_all_bootmem()). Maybe you should just check why it=20
> fails for you.

I was calling it in the wrong board init function.=20
m82xx_board_init was too early, and our platform_init was too late.

It works now.
