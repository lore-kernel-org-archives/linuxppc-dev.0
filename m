Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 3821967A05
	for <linuxppc-dev@ozlabs.org>; Sun, 30 Apr 2006 21:42:26 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: please pull powerpc.git 'merge' branch
Date: Sun, 30 Apr 2006 13:42:01 +0200
References: <17491.1134.565353.149941@cargo.ozlabs.ibm.com>
	<71339D1F-CAF1-4FF0-A1A3-1A74B8984F05@kernel.crashing.org>
	<20060430042059.GO5518@pb15.lixom.net>
In-Reply-To: <20060430042059.GO5518@pb15.lixom.net>
MIME-Version: 1.0
Message-Id: <200604301342.02043.arnd@arndb.de>
Content-Type: text/plain;
  charset="utf-8"
Cc: Olof Johansson <olof@lixom.net>, torvalds@osdl.org,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sunday 30 April 2006 06:20, Olof Johansson wrote:

> We already have SMT, ICACHE_SNOOP and ALTIVEC feature bits, so it probably
> makes sense to stay in the ARCH_2_05 direction. Unfortunately it might
> be tricky to rename the old defines now due to userland exposure.
> 
> I guess Cell breaks all this logic though. Which PPC base version does
> it implement?

The Cell Broadband Engine Architecture in theory is 2.03 and also mandates
some of the extensions that are optional in there.
The relevant sections in the specs are:

| 4.1.1 Optional Features in PowerPC Architecture, Book I (Required for
|       CBEA) 
| The following facilities and instructions are considered optional in
| the PowerPC Architecture, but are required for the PPE by the CBEA
| user mode environment. 
|  • Floating reciprocal estimate single A-form (fres)
|  • Floating reciprocal square-root estimate A-form (frsqte)
|  • Vector/SIMD multimedia extension
| Note: The optional PowerPC floating-point instructions that are
| mandatory in the CBEA are needed for the application space targeted
| by the CBEA. 
|
| 4.1.3 Optional Features in PowerPC Architecture, Book II (Required
|       for CBEA) 
| The following facilities and instructions are considered optional
| in the PowerPC Architecture, but are required in the CBEA.
|  • Data cache block touch X-form (dcbt)
|    This is an optional version of dcbt that permits a program to
|    provide a hint that a sequence of data cache blocks is likely
|    to be needed soon. 
|  Book II describes these facilities and instructions.

I believe the actual implementation is missing one of the mandatory
features of 2.03 that was not in 2.02 though.

	Arnd <><
