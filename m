Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D2819DDE0C
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 02:15:18 +1000 (EST)
Date: Tue, 17 Jul 2007 11:15:01 -0500
From: Scott Wood <scottwood@freescale.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/3] 82xx: some 82xx platform hook functions can be shared
	by different boards
Message-ID: <20070717161501.GA7347@ld0162-tx32.am.freescale.net>
References: <469B33F2.9040306@windriver.com> <200707170259.47098.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200707170259.47098.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jul 17, 2007 at 02:59:46AM +0200, Arnd Bergmann wrote:
> This is a step in the wrong direction. CPUINFO_{VENDOR,MACHINE}
> comes from a platform specific header file, so you can not
> use these definitions in platform independent code without
> breaking multiplatform kernels.

My patchset just drops the vendor field, and uses ppc_md.name for the
machine name.  The vendor name can be included in the latter.

> I know you're just moving that code, but it looks horribly wrong
> nonetheless. cpm2_immr is an __iomem variable, so you must not
> dereference it but instead should use the in_8() macro to
> access it.
> 
> Once you get that right, you don't need the volatile variable
> any more.

My patchset addresses this.

-Scott
