Return-Path: <scottwood@freescale.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3B48C1A017A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Nov 2014 09:13:58 +1100 (AEDT)
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0135.outbound.protection.outlook.com [157.56.110.135])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3FE6D14012A
 for <linuxppc-dev@ozlabs.org>; Tue, 18 Nov 2014 09:13:56 +1100 (AEDT)
Message-ID: <1416262424.15957.94.camel@freescale.com>
Subject: Re: [PATCH 2/2] powerpc/mpc85xx: Add DPAA Q/BMan support to device
 tree(s)
From: Scott Wood <scottwood@freescale.com>
To: Emil Medve <Emilian.Medve@Freescale.com>
Date: Mon, 17 Nov 2014 16:13:44 -0600
In-Reply-To: <5469CE79.7090406@Freescale.com>
References: <1415870513-10632-1-git-send-email-Emilian.Medve@Freescale.com>
 <1415914923.15957.64.camel@freescale.com> <5469CE79.7090406@Freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Geoff Thorpe <Geoff.Thorpe@Freescale.com>,
 Poonam Aggrwal <poonam.aggrwal@Freescale.com>,
 Chunhe Lan <Chunhe.Lan@Freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-11-17 at 04:31 -0600, Emil Medve wrote:
> Hello Scott,
> 
> 
> On 11/13/2014 03:42 PM, Scott Wood wrote:
> > On Thu, 2014-11-13 at 03:21 -0600, Emil Medve wrote:
> >> From: Kumar Gala <galak@kernel.crashing.org>
> >>
> >> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> >> Signed-off-by: Geoff Thorpe <Geoff.Thorpe@freescale.com>
> >> Signed-off-by: Hai-Ying Wang <Haiying.Wang@freescale.com>
> >> Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
> >> Signed-off-by: Poonam Aggrwal <poonam.aggrwal@freescale.com>
> >> Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
> >> Change-Id: If643fa5ba0a903aef8f5056a2c90ebecc995b760
> > 
> > I suspect these patches are changed quite a bit from Kumar's version...
> 
> Across SDK releases I've been trying retain the authors names and the
> 'Signed-off-by' list is the only place that can accommodate them all.
> Kumar is the first author, and besides this exercise the most significant
> 
> > It's good to note changes after the listed author has stopped being
> > involved, so they don't get the blame for anything they wouldn't have
> > put in there.
> 
> Bah. Most of the sordid history is lost

You don't need the full history.  If Kumar wrote most of it then he
should stay as the From: line, but maybe put a line before your signoff,
something like:
[Emil: various updates]
to indicate it wasn't passed on as is, as is recommended in
Documentation/SubmittingPatches.

> > no-map and reusable don't make sense together.  How can the OS reuse the
> > memory if it can't map it?
> 
> Perhaps I've been reading/speculating(?) too much about it. Now granted
> the code is still young (?), but in between "under the control of the
> device driver using the region" and "the device driver(s) owning the
> region need to be able to reclaim it back" it sort of made sense

No-map says to never map the region except under control of the driver.
Reusable says it's ok to use the region (which implies mapping) outside
the control of the driver, except when the driver claims the region via
some unspecified mechanism.

FWIW, the one place I can find in the code that currently insists on
"reusable" rejects regions with "no-map" (rmem_cma_setup), and the one
place I can find that currently insists on "no-map" rejects regions with
"reusable" (rmem_dma_setup).

> > no-map is burdensome (and I believe not yet implemented) on mpc85xx,
> > where we want to use huge TLB entries to cover all of (low) memory.  Is
> > it really needed?
> 
> I'm thinking no-map would be part of having/making this reserved memory
> into a different coherency domain then the... everything else

OK, but it's not actually required to use a different coherency domain.
You're putting configuration into the device tree, and it's a
particularly burdensome bit of configuration on mpc85xx due to the way
the TLB works (it also doesn't currently work as advertised on PPC).
Have you benchmarked to see what the benefit is of using a separate
coherence domain?

> > What do we gain from specifying reusable here?
> 
> I guess the obvious of having this memory usable for something else when
> the B/QMan drivers don't use it

When would they not use it?

> > How is it actually supposed to work?
> 
> You mean how should one implement 'reusable'?

Yes.

-Scott
