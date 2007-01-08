Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 21AF7DDE05
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Jan 2007 17:38:10 +1100 (EST)
In-Reply-To: <1168236558.22458.187.camel@localhost.localdomain>
References: <OF7EF2F643.75F7008B-ON8625725D.00157658-8625725D.00167CB4@au1.ibm.com>
	<1168236558.22458.187.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <8ee3d13b73a511a785ac4744c268943e@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: EMAC OF binding....
Date: Mon, 8 Jan 2007 07:38:20 +0100
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Cc: Christian Rund <Christian.Rund@de.ibm.com>,
	Hartmut Penner <HPENNER@de.ibm.com>, Murali N Iyer <mniyer@us.ibm.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>  - compatible        : compatible list, contains 2 entries, first is 
> "emac-CHIP" where
>                        CHIP is the host ASIC (440gx, 405gp, axon) and 
> second is either
>                        "emac" or "emac4".
>                        For axon, thus, we have: "emac-axon","emac4"

"ibm,emac-axon" etc. please.

>  - local-mac-address : 6 bytes, MAC address

Don't forget "mac-address", if the device is opened
in OF; and "max-frame-size" please.

>  - cell-index        : 1 cell, hardware index of the EMAC cell on a 
> given ASIC (typically
>                        0x00000000 and 0x00000001 for EMAC-0 and EMAC-1 
> on each Axon chip)

Can you find a better name?  What is this used for, anyway?

>  - max-mtu           : 1 cell, maximum MTU supported in bytes

See "max-frame-size", MTU is on a higher level than device
level and as such shouldn't be here; the OF networking layer
can set something like this if it wants.

>  - mal-burst-size    : 1 cell, MAL burst size (used to calculate 
> thresholds)

In bytes?


Segher
