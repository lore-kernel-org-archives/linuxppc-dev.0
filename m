Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2B563DDE07
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Sep 2007 13:25:29 +1000 (EST)
In-Reply-To: <a58bb9a05680c3befc4d3588992caed0@kernel.crashing.org>
References: <Pine.LNX.4.64.0709111436290.14121@blarg.am.freescale.net>
	<a58bb9a05680c3befc4d3588992caed0@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <39A1A44F-CD73-4CC1-89DE-608A1041AAF7@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v3] [POWERPC] 85xx: Add basic Uniprocessor MPC8572 DS port
Date: Wed, 12 Sep 2007 22:28:24 -0500
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 12, 2007, at 8:36 AM, Segher Boessenkool wrote:

> Looks a lot better, thanks!
>
> Some minor nits and suggestions...
>
>> +/ {
>> +	model = "fsl,MPC8572DS";
>> +	compatible = "fsl,MPC8572DS", "fsl,MPC85xxDS";
>
> We don't want "xx" compatible entries; especially here it makes
> no sense at all.  If the board is compatible to some other (older)
> board, just name that board explicitly.

removed.

>
>> +		PowerPC,8572@0 {
>
> Maybe it would be good to use "PowerPC,e500" instead -- it would
> make it easier to probe for the actual CPU type, that way.  Not
> that Linux uses the name/compatible here at all ;-)

I thought about this, not sure what the best solution is.

>> +	soc8572@ffe00000 {
>
> You should put an interrupt-parent in here, so you can get rid of
> it in all the children.

Are interrupt-parent's inherited by child nodes?

> And then there's the pci_bridge thing we're discussing on IRC, of
> course -- basically, get rid of the pci_bridge pseudo-node, and
> move the interrupt-map for the south-bridge devices into the
> south-bridge node.

Leaving the interrupt-map in the PHB because that works and moving it  
down has issues.

- k
