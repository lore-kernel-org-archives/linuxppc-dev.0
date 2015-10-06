Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0113.outbound.protection.outlook.com [157.56.110.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 37D8D1A0019
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Oct 2015 03:56:57 +1100 (AEDT)
Message-ID: <1444150599.5336.289.camel@freescale.com>
Subject: Re: [PATCH v2 15/25] powerpc/8xx: move 8xx SPRN defines into
 reg_8xx.h and add some missing ones
From: Scott Wood <scottwood@freescale.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Date: Tue, 6 Oct 2015 11:56:39 -0500
In-Reply-To: <5613DC41.2000100@c-s.fr>
References: <cover.1442939410.git.christophe.leroy@c-s.fr>
 <a8718136980080a9b8ec7b76e6786a434b50e447.1442939410.git.christophe.leroy@c-s.fr>
 <20150929000346.GH6161@home.buserror.net> <5613DC41.2000100@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-10-06 at 16:35 +0200, Christophe Leroy wrote:
> Le 29/09/2015 02:03, Scott Wood a écrit :
> > On Tue, Sep 22, 2015 at 06:50:58PM +0200, Christophe Leroy wrote:
> > > Move 8xx SPRN defines into reg_8xx.h and add some missing ones
> > > 
> > > Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> > > ---
> > > No change in v2
> > Why are they being moved?  Why are they being separated from the bit
> > definitions?
> > 
> > 
> It was to keep asm/reg_8xx.h self sufficient for the following patch.

Again, it would have been nice if this were in the commit message.

> Also because including asm/mmu-8xx.h creates circular inclusion issue 
> (mmu-8xx.h needs page.h which includes page-32.h, page-32.h includes 
> cache.h, cache.h include reg.h which includes reg_8xx). The circle 
> starts with an inclusion of asm/cache.h by linux/cache.h, himself 
> included by linux/printk.h, and I end up with 'implicit declaration' issues.
> 
> How can I fix that ?

mmu-8xx.h should have been including page.h instead of assuming the caller h 
as done so...  but another option is to do what mmu-book3e.h does, and use 
the kconfig symbols instead of PAGE_SHIFT.

-Scott
