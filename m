Return-Path: <glikely@secretlab.ca>
Received: from mail-pa0-f47.google.com (mail-pa0-f47.google.com
 [209.85.220.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E4D9F1A08AA
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Jun 2015 11:44:58 +1000 (AEST)
Received: by padj3 with SMTP id j3so40336864pad.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jun 2015 18:44:56 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@linaro.org>
Subject: Re: of/dynamic: Fix test for PPC_PSERIES
To: Michael Ellerman <mpe@ellerman.id.au>, Geert Uytterhoeven
 <geert+renesas@glider.be>, Rob Herring <robh+dt@kernel.org>, Paul Mackerras
 <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>,
 nfont@linux.vnet.ibm.com
In-Reply-To: <20150604105732.77DFE140273@ozlabs.org>
References: <20150604105732.77DFE140273@ozlabs.org>
Date: Fri, 05 Jun 2015 10:44:48 +0900
Message-Id: <20150605014448.8C8C5C407BD@trevor.secretlab.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu,  4 Jun 2015 20:57:32 +1000 (AEST)
, Michael Ellerman <mpe@ellerman.id.au>
 wrote:
> On Thu, 2015-04-06 at 09:34:41 UTC, Geert Uytterhoeven wrote:
> > "IS_ENABLED(PPC_PSERIES)" always evaluates to false, as IS_ENABLED() is
> > supposed to be used with the full Kconfig symbol name, including the
> > "CONFIG_" prefix.
> > 
> > Add the missing "CONFIG_" prefix to fix this.
> > 
> > Fixes: a25095d451ece23b ("of: Move dynamic node fixups out of powerpc and into common code")
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> 
> > Did this bug cause any breakage?
> > If yes, the fix should go to stable (for v3.17 and later).
> 
> Yikes. Not that I've heard of. But it's reasonably new so possibly it's not hit
> distros that folks tend to run on those machines.
> 
> I'm also not clear how it would break, it could be subtle and we've not noticed.
> 
> Nathan might have more of an idea (on CC).
> 
> On my machine here everything that has an ibm,phandle also has a linux,phandle,
> so we wouldn't hit that code path. But I'm not sure how representative that box
> is.
> 
> cheers

Still, an obvious bug. I've picked it up and marked for stable.

g.
