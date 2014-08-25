Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6D4761A003F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Aug 2014 15:29:38 +1000 (EST)
Message-ID: <1408944577.7941.4.camel@concordia>
Subject: Re: [PATCH] powerpc: edac: Fix build error
From: Michael Ellerman <mpe@ellerman.id.au>
To: Pranith Kumar <bobby.prani@gmail.com>
Date: Mon, 25 Aug 2014 15:29:37 +1000
In-Reply-To: <1408673991-17892-1-git-send-email-bobby.prani@gmail.com>
References: <1408673991-17892-1-git-send-email-bobby.prani@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: open list <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>,
 Doug Thompson <dougthompson@xmission.com>, Paul Mackerras <paulus@samba.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "open list:EDAC-CORE" <linux-edac@vger.kernel.org>, "open
 list:LINUX FOR POWERPC..." <linuxppc-dev@lists.ozlabs.org>,
 Mauro Carvalho Chehab <m.chehab@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-08-21 at 22:19 -0400, Pranith Kumar wrote:
> Fix the following build error:
> 
> drivers/edac/ppc4xx_edac.c: In function 'mfsdram':
> drivers/edac/ppc4xx_edac.c:249: error: implicit declaration of function
> '__mfdcri'
> drivers/edac/ppc4xx_edac.c: In function 'mtsdram':
> drivers/edac/ppc4xx_edac.c:266: error: implicit declaration of function
> '__mtdcri'
> drivers/edac/ppc4xx_edac.c:269: warning: 'return' with a value, in function
> returning void
> drivers/edac/ppc4xx_edac.c: In function 'ppc4xx_edac_init_csrows':
> drivers/edac/ppc4xx_edac.c:924: warning: initialization from incompatible
> pointer type
> drivers/edac/ppc4xx_edac.c:977: error: request for member 'dimm' in something
> not a structure or union
> drivers/edac/ppc4xx_edac.c: In function 'ppc4xx_edac_map_dcrs':
> drivers/edac/ppc4xx_edac.c:1209: warning: passing argument 1 of 'dcr_map_mmio'
> discards qualifiers from pointer target type
> 
> This driver depends on PPC_DCR_NATIVE to be set for the relevant headers to be
> included. Also if PPC_DCR_MMIO=n the build fails. So make PPC_DCR depend on both
> these options.

Um, NAK I think. The whole point is that some platforms implement DCR natively
and some via MMIO, and that's meant to be hidden by the DCR API.

If the driver is directly calling DCR native routines then it should depend on
that.

cheers
