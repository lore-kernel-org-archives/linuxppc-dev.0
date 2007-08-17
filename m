Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 61CE8DDDF9
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Aug 2007 06:15:30 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/3] [POWERPC] Copy over headers from arch/ppc to
	arch/powerpc that we need
Date: Fri, 17 Aug 2007 19:05:52 +0200
References: <Pine.LNX.4.64.0708170157140.15311@blarg.am.freescale.net>
	<Pine.LNX.4.64.0708170212210.15311@blarg.am.freescale.net>
	<Pine.LNX.4.64.0708170213040.15311@blarg.am.freescale.net>
In-Reply-To: <Pine.LNX.4.64.0708170213040.15311@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200708171905.52855.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 17 August 2007, Kumar Gala wrote:
> To build arch/powerpc without including asm-ppc/ we need these files
> in asm-powerpc/

Looks mostly good, but

>  include/asm-powerpc/8xx_immap.h   |  564 +++++++++++++++++
>  include/asm-powerpc/commproc.h    |  692 ++++++++++++++++++++
>  include/asm-powerpc/cpm2.h        | 1248 +++++++++++++++++++++++++++++++++++++
>  include/asm-powerpc/gg2.h         |   61 ++
>  include/asm-powerpc/highmem.h     |  135 ++++
>  include/asm-powerpc/hydra.h       |  102 +++
>  include/asm-powerpc/immap_cpm2.h  |  648 +++++++++++++++++++
>  include/asm-powerpc/kgdb.h        |   57 ++
>  include/asm-powerpc/m8260_pci.h   |  187 ++++++

The m8260_pci.h file is not namespace clean, it defines macros like
PCI_CFG_ADDR_REG that are likely to create conflicts at some point of
time. Since the only file including this header is 
arch/powerpc/platforms/82xx/m82xx_pci.h, I'd suggest merging the two,
to make sure nobody can accidentally include it.

Some of the other files also have minor style bitrot, e.g. use of
volatile pointers, typedefs and CamelCase identifiers, though none
of them should prevent the move.

	Arnd <><
