Return-Path: <jdl@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 67F5D67A3A
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Apr 2006 02:51:42 +1000 (EST)
Subject: Re: [patch][rfc]flattened device tree: Passing a dtb (blob) to Linux.
From: Jon Loeliger <jdl@freescale.com>
To: Michael Ellerman <michaelellerman@internode.on.net>
In-Reply-To: <1144938844.7777.16.camel@localhost.localdomain>
References: <5148225C-AE27-4365-A1C2-40C46491AF0D@watson.ibm.com>
	<9B2C87C5-0B69-46E7-B48B-9CDB882836B2@watson.ibm.com>
	<20060413053614.2648467DE3@ozlabs.org>
	<C67D530F-2629-4D6B-986B-0FC7CFE525BF@watson.ibm.com>
	<1144926434.7777.5.camel@localhost.localdomain>
	<2A70CBD7-4A52-4599-8BEF-6AC633F62C83@watson.ibm.com>
	<1144938844.7777.16.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1145378886.5314.57.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Tue, 18 Apr 2006 11:48:07 -0500
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Michael Neuling <mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-04-13 at 09:34, Michael Ellerman wrote:
> On Thu, 2006-04-13 at 09:19 -0400, Jimi Xenidis wrote:
> > Actually, is this even an issue? can the LMB handle repeated  
> > reservations?
> 
> It can, but we were thinking about adding code to check and warn if
> reservations overlap, because it usually indicates a bug. Although
> that's probably ok in this case, as long as dtc gets fixed eventually.
> Another option would be to not warn for identical reservations.

> > >>>>> NOTE: that the dtc must also not generate the blob reservation
> > >>>>> entry.

> > >> looking passed my own world I see:
> > >>    - iSeries: not reserving the blob at all
> > >
> > > That sounds right. I think having the kernel do it is definitely the
> > > right option.


OK, I'm back to reading the list and beginning to catch
up some here...

Let me see if I understand the consensus and direction:

    1) DTC should NOT reserve its own blob space in the
       memory map, as it does for generated ASM code now,

    2) Kernel should reserve the blob space early so as
       not to step on itself later,

    3a) Kernel LMB handling should be modified to warn
        for overlapping LMB reservations,

Except that Ben says:

    3b) We should make lmb_reserve() of redudant/overlapping
        entries become harmless I think. We need to be
        backward compatible with earlier blobs that do
        contain themselves in the reserve map.

I think we should interpret "harmless" to be "warn" and not
cause an error at this point in time.

I do not think we should have the blob generate its own
reservation because it is possible that some post-processing
(like U-Boot) can modify and extend it.  Only after that can
the blob's true size be determined.  (Sure, it could update
on the fly too... but double blah).

In all of this, I'm on deck for step 1) above.

jdl
