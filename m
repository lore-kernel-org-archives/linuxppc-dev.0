Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C3670DDE0D
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Jun 2008 10:31:53 +1000 (EST)
In-Reply-To: <20080606033756.GA6506@yookeroo.seuss>
References: <200806041706.21557.sr@denx.de> <4846B39F.3010601@freescale.com>
	<20080604154351.GB10393@ld0162-tx32.am.freescale.net>
	<20080604211942.2bddc860@zod.rchland.ibm.com>
	<20080605024140.GA30980@yookeroo.seuss>
	<49648f3051f1ba1b39e67ec2ce08367c@kernel.crashing.org>
	<20080606033756.GA6506@yookeroo.seuss>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <c441e44bd7793094a442e429f146c6e8@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: "cell-index" vs. "index" vs. no index in I2C device nodes
Date: Sat, 7 Jun 2008 02:30:46 +0200
To: David Gibson <dwg@au1.ibm.com>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Stefan Roese <sr@denx.de>, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> Aliases can also provide a reasonable way of enumerating devices, if
>>> "reg" isn't suitable on its own.
>>
>> Yes.  In almost all cases, drivers and subsystems do not need this at
>> all though.  In OF, one device points to another by putting the 
>> phandle
>> of that pointed-to device in some property (and buses are represented
>> by their parent bridge).  If the Linux subsystem wants to use an 
>> integer
>> for distinguishing between its various buses, that's fine, but it can
>> just make up these numbers -- the numbers themselves have no actual
>> meaning, only the relationships expressed via those numbers do.
>
> That's true.  However if all the system documentation uses a
> particular numbering of the devices, it's convenient if we can use the
> same numbering in Linux.

Sure, it's convenient, and you can use aliases to get the naming you
want accessible to the user.  The drivers shouldn't depend on this
naming internally though, esp. since it doesn't really help anything.

> Incidentally, another word on "cell-index".  Even for its intended
> purpose, this was always a compromise.  The strictly correct way to
> handle shared registers like this is for the node representing the
> shared resource to have a table of phandles pointing back to the
> devices controlled by the shared registers from which the appropriate
> indices can derived.

IMO, there is no really good (let alone "correct") way of handling
this.

> On at least some 4xx chips, however, the shared resources are
> scattered around various places, but all use the same device
> numbering.  Therefore it seemed expedient to encode that numbering in
> a single place - 'cell-index' - rather than having several such
> tables.

Yeah, it seems to work out for those 4xx.  Other platforms would be
well advised to consider the tradeoff for themselves though, many
SoCs have an even more "wild" design than 4xx does ;-)


Segher
