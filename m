Return-Path: <anton@samba.org>
Date: Thu, 8 Dec 2011 17:04:50 +1100
From: Anton Blanchard <anton@samba.org>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] powerpc: POWER7 optimised copy_to_user/copy_from_user
 using VMX
Message-ID: <20111208170450.22247a4b@kryten>
In-Reply-To: <5188.1323323649@neuling.org>
References: <20111208160227.2ef2d526@kryten>
 <FC884692-A7C3-47F6-BDD5-9E3D955ABF9B@kernel.crashing.org>
 <5188.1323323649@neuling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: paulus@samba.org, sukadev@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi,

> I hate the idea of having a POWER7 FTR bit.  Every loon will (and has
> tried to in the past) attach every POWER7 related thing to it, rather
> than thinking about what the feature really is for.  
> 
> What about other processors which could also benefit from this copy
> loop?  Turning on CPU_FTR_POWER7 for them is gonna look a bit silly.

As we discussed online, we could call it CPU_FTR_VMX_COPY and start
thinking about a better way to solve the CPU feature bit mess.

One idea would be to have a structure of function pointers for each
CPU that gets runtime patched into the right places, similar to how we
do some of the MMU fixups.

Anton
