Return-Path: <dgibson@ozlabs.org>
Date: Fri, 4 May 2007 09:56:20 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: powerpc_flash_init(), wtf!?
Message-ID: <20070503235620.GB28599@localhost.localdomain>
References: <20070501051804.GB3881@localhost.localdomain>
	<4639CBD8.6010205@ru.mvista.com>
	<20070503123055.GE26659@localhost.localdomain>
	<4639DDE1.40904@ru.mvista.com>
	<71e4c68de5240a652b561d8cfa2e05f3@kernel.crashing.org>
	<463A1941.3090608@ru.mvista.com> <463A2192.6020308@ru.mvista.com>
	<e21cca984c076474a6e89018a198d93a@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e21cca984c076474a6e89018a198d93a@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, May 03, 2007 at 08:07:27PM +0200, Segher Boessenkool wrote:
> >>     Yeah, you're right here, and I've probably misunderstood what 
> >> "memory" node was. In fact, the flash in my system resides on the 
> >> same local bus as RAM, so the proper place would be behind the "lbc" 
> >> (or whatever -- it doesn't exist as yet) node on the "soc" bus.  Do 
> >> you think I need to go and document it as well for such cause? :-]
> >
> >    No, that probably won't do. MPC85xx SoC bus has ranges = <e0000000 
> > 00100000> and the NOR flash is mapped at 0xff000000, so it seems that 
> > it can't be located under the "soc" bus (unless that latter has 
> > "ranges" prop extended?).
> 
> If the RAM and/or ROM sit on the SoC bus, the "ranges"
> property in the SoC node should be able to translate
> their addresses, yes.  You could opt for having the
> memory controller a separate device node, as a sibling
> of the "soc" node, if that agrees better with your
> SoC architecture.  "It all depends".

But if the flash really is on an external bus controlled by a bus
controller on the SoC, it sounds like it should go under that bus
bridge.  In which case the SoC would need another range in its ranges
property.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
