Return-Path: <arnd@arndb.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 38D47B712E
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 15 Jun 2009 17:05:45 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 10/33] powerpc/cell: Extract duplicated IOPTE_* to
	<asm/iommu.h>
Date: Mon, 15 Jun 2009 09:05:29 +0200
References: <1244644748-24211-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-11-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1245030085.19217.5.camel@pasglop>
In-Reply-To: <1245030085.19217.5.camel@pasglop>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200906150905.30744.arnd@arndb.de>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, cbe-oss-dev@ozlabs.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Monday 15 June 2009, Benjamin Herrenschmidt wrote:
> On Wed, 2009-06-10 at 16:38 +0200, Geert Uytterhoeven wrote:
> > Both arch/powerpc/platforms/cell/iommu.c and arch/powerpc/platforms/ps3/mm.c
> > contain the same Cell IOMMU page table entry definitions. Extract them and move
> > them to <asm/iommu.h>, while adding a CBE_ prefix.
> > This also allows them to be used by drivers.
> 
> Are we sure include/asm/iommu.h is the right place for that ?
> 
> I'm hesitating here...

Good point, that file does not contain hardware specific definitions but
only interfaces.

Geert, how about putting them into arch/powerpc/include/asm/cell-regs.h
instead?

	Arnd <><
