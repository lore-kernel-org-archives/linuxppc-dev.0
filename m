Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 4D3121007D1
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Dec 2011 06:40:28 +1100 (EST)
Message-ID: <1323373215.12793.38.camel@pasglop>
Subject: Re: [PATCH] powerpc: POWER7 optimised copy_to_user/copy_from_user
 using VMX
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Anton Blanchard <anton@samba.org>
Date: Fri, 09 Dec 2011 06:40:15 +1100
In-Reply-To: <20111208170450.22247a4b@kryten>
References: <20111208160227.2ef2d526@kryten>
 <FC884692-A7C3-47F6-BDD5-9E3D955ABF9B@kernel.crashing.org>
 <5188.1323323649@neuling.org> <20111208170450.22247a4b@kryten>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Michael Neuling <mikey@neuling.org>, paulus@samba.org,
 sukadev@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2011-12-08 at 17:04 +1100, Anton Blanchard wrote:
> Hi,
> 
> > I hate the idea of having a POWER7 FTR bit.  Every loon will (and has
> > tried to in the past) attach every POWER7 related thing to it, rather
> > than thinking about what the feature really is for.  
> > 
> > What about other processors which could also benefit from this copy
> > loop?  Turning on CPU_FTR_POWER7 for them is gonna look a bit silly.
> 
> As we discussed online, we could call it CPU_FTR_VMX_COPY and start
> thinking about a better way to solve the CPU feature bit mess.
> 
> One idea would be to have a structure of function pointers for each
> CPU that gets runtime patched into the right places, similar to how we
> do some of the MMU fixups.

Or the vdso... we have a table of some sort which is used to patch
symbols.

But it's keyed off cpu features.

I'm reluctant to adding another table of PVRs, it needs to deal with the
pseudo-PVRs from pHyp, and things will get out of sync.

CPU features are the way to go, tho we can use them to key off a branch
patching mechanism if we want to. It's easy to add new bitmasks for
in-kernel features at least (it's the user features which are more nasty
but they are a separate thing).

So if we have to we can split cpu feature into another separate mask
like I did for mmu features with the same macros etc... For example, the
debug features could be moved out, or whatever.

Cheers,
Ben.
 
