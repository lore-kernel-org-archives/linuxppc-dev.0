Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 7F9B41007D3
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Dec 2011 16:39:22 +1100 (EST)
Message-ID: <1322717953.3729.18.camel@pasglop>
Subject: ppc4xx simple vs SoC's
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@gmail.com>
Date: Thu, 01 Dec 2011 16:39:13 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Josh !

I was helping Tony with some of the Currituck stuff when I noticed an
oddity...

So we have various "SoC" config symbols such as 440EP, 460SX, etc...
that in turn select various bits & pieces that enable support for that
SoC (such as EMAC4 support or FPU support). Those only act as "enables"
for compiling of the code, there is still going to be a runtime check of
course.

Those SoC config symbols are not user selectable, they are meant to be
themselves select'ed by the board Kconfig entries.

However, the entry for ppc44x_simple doesn't select any of these,
meaning for example, AFAIK, that you don't get EMAC4 etc... I'm
surprised things work at all !

What am I missing ?

Cheers,
Ben.
