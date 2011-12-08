Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: POWER7 optimised copy_to_user/copy_from_user
 using VMX
In-reply-to: <FC884692-A7C3-47F6-BDD5-9E3D955ABF9B@kernel.crashing.org>
References: <20111208160227.2ef2d526@kryten>
 <FC884692-A7C3-47F6-BDD5-9E3D955ABF9B@kernel.crashing.org>
Date: Thu, 08 Dec 2011 16:54:09 +1100
Message-ID: <5188.1323323649@neuling.org>
Cc: paulus@samba.org, Anton Blanchard <anton@samba.org>,
 sukadev@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

<snip>
> > +#define CPU_FTR_POWER7 = LONG_ASM_CONST(0x2000000000000000)
<snip>
> Can we find a means to do the fixup that does NOT require a FTR bit?  I
> have the feeling FSL will want to have various optimized copy functions
> for our different cores and I hate to blow features bits just for this.

+1

I hate the idea of having a POWER7 FTR bit.  Every loon will (and has
tried to in the past) attach every POWER7 related thing to it, rather
than thinking about what the feature really is for.  

What about other processors which could also benefit from this copy
loop?  Turning on CPU_FTR_POWER7 for them is gonna look a bit silly.

Mikey
