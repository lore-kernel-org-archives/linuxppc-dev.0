Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0146.outbound.protection.outlook.com [157.56.111.146])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B2A8E1A029F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Oct 2014 20:44:47 +1100 (EST)
Message-ID: <1413279865.2878.20.camel@aoeu.buserror.net>
Subject: Re: [PATCH 1/4] powerpc: Dynamic DMA zone limits
From: Scott Wood <scottwood@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 14 Oct 2014 11:44:25 +0200
In-Reply-To: <1413273473.26478.52.camel@pasglop>
References: <1407541245-27617-1-git-send-email-scottwood@freescale.com>
 <20141013181436.300988c8@kryten> <1413190849.21457.4.camel@concordia>
 <1413272346.2878.2.camel@aoeu.buserror.net>
 <1413273473.26478.52.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>,
 Shaohui Xie <Shaohui.Xie@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-10-14 at 18:57 +1100, Benjamin Herrenschmidt wrote:
> On Tue, 2014-10-14 at 09:39 +0200, Scott Wood wrote:
> > For a short-term workaround, I'd rather leave CONFIG_ZONE_DMA32 where
> > it
> > is and put #ifdef CONFIG_FSL_SOC (with a comment) around the whole
> > thing.
> 
> I'd like to not enable CONFIG_ZONE_DMA32 when we don't need it, ie,
> on !BOOKE 64-bit

How does 64-bit powermac deal with it, with random PCI cards?  Does it
use an IOMMU for coherent allocations?

In any case, CONFIG_ZONE_DMA32 should be harmless if the zone isn't
dynamically created, but we can limit it to booke if you want.  The
current breakage has nothing to do with ZONE_DMA32, but rather to the
fact that we now check zones at all.  This is why I'd rather have the
short term workaround be a new ifdef, rather than moving ifdef
CONFIG_ZONE_DMA32 (moving it also obscures the way the code should look
if and when the workaround can be removed).

-Scott
