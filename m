Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0116.outbound.protection.outlook.com [207.46.100.116])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3C0A51A0651
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Aug 2015 12:31:54 +1000 (AEST)
Message-ID: <1438828301.2097.126.camel@freescale.com>
Subject: Re: [PATCH v2 2/2] powerpc32: optimise csum_partial() loop
From: Scott Wood <scottwood@freescale.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
CC: Christophe Leroy <christophe.leroy@c-s.fr>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, "Michael
 Ellerman" <mpe@ellerman.id.au>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-kernel@vger.kernel.org>
Date: Wed, 5 Aug 2015 21:31:41 -0500
In-Reply-To: <20150806003059.GD18479@gate.crashing.org>
References: <cover.1435655733.git.christophe.leroy@c-s.fr>
 <67cf476f657e87b2ea586951a57ae3ba3c1e3c0c.1435655733.git.christophe.leroy@c-s.fr>
 <20150806003059.GD18479@gate.crashing.org>
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

On Wed, 2015-08-05 at 19:30 -0500, Segher Boessenkool wrote:
> On Wed, Aug 05, 2015 at 03:29:35PM +0200, Christophe Leroy wrote:
> > On the 8xx, load latency is 2 cycles and taking branches also takes
> > 2 cycles. So let's unroll the loop.
> 
> This is not true for most other 32-bit PowerPC; this patch makes
> performance worse on e.g. 6xx/7xx/7xxx.  Let's not!

Chips with a load latency greater than 2 cycles should also benefit from the 
unrolling.  Have you benchmarked this somewhere and seen it reduce 
performance?  Do you know of any 32-bit PPC chips with a load latency less 
than 2 cycles?

-Scott
