Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vxDN108xnzDqHH
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Apr 2017 11:02:08 +1000 (AEST)
Message-ID: <1491181311.26047.23.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Add POWER9 copy_page() loop
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Anton Blanchard <anton@samba.org>, Nicholas Piggin <npiggin@gmail.com>
Cc: paulus@samba.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Date: Mon, 03 Apr 2017 11:01:51 +1000
In-Reply-To: <20170403105434.60309d3e@kryten>
References: <20170320234046.32718-1-anton@ozlabs.org>
 <20170321130109.1dd058c0@roar.ozlabs.ibm.com>
 <20170321150103.6c1336bd@kryten>
 <20170321142139.3072b9b6@roar.ozlabs.ibm.com>
 <20170403105434.60309d3e@kryten>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-04-03 at 10:54 +1000, Anton Blanchard wrote:
> > > Good idea, I hadn't thought of embedding it all in a feature
> > > section.  
> > 
> > It may not work currently because you get those ftr_alt_97 relocation
> > errors with the "else" parts because relative branches to other code
> > need to be direct and I think reachable from both places.
> 
> I thought about this a bit more. One potential issue will be
> profiling - perf annotate will match the samples against the unpatched
> code which could be very confusing.

Could we make all those functions a dynamic-linker style stub ?

IE, they "find" the right target function and call a helper to patch
the calling site to call directly into the right one on the first
call.

Cheers,
Ben.
