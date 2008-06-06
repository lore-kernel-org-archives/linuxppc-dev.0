Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp02.au.ibm.com (E23SMTP02.au.ibm.com [202.81.18.163])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp02.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6F5E4DDF3B
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jun 2008 13:42:43 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp02.au.ibm.com (8.13.1/8.13.1) with ESMTP id m563gWxW008069
	for <linuxppc-dev@ozlabs.org>; Fri, 6 Jun 2008 13:42:32 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m563gNEx4624538
	for <linuxppc-dev@ozlabs.org>; Fri, 6 Jun 2008 13:42:23 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m563geW0014139
	for <linuxppc-dev@ozlabs.org>; Fri, 6 Jun 2008 13:42:40 +1000
Date: Fri, 6 Jun 2008 13:37:56 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: "cell-index" vs. "index" vs. no index in I2C device nodes
Message-ID: <20080606033756.GA6506@yookeroo.seuss>
References: <200806041706.21557.sr@denx.de> <4846B39F.3010601@freescale.com>
	<20080604154351.GB10393@ld0162-tx32.am.freescale.net>
	<20080604211942.2bddc860@zod.rchland.ibm.com>
	<20080605024140.GA30980@yookeroo.seuss>
	<49648f3051f1ba1b39e67ec2ce08367c@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <49648f3051f1ba1b39e67ec2ce08367c@kernel.crashing.org>
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

On Fri, Jun 06, 2008 at 04:40:20AM +0200, Segher Boessenkool wrote:
>>>> From a device tree perspective, index and cell-index are both
>>> incorrect.  The IIC macros don't share register blocks with anything,
>>> are enumerated as unique instances per macro in the device tree, and
>>> should be able to be distinguished by "regs" and/or unit address.
>>>
>>> Does anyone disagree with that?
>>
>> Hear, hear.
>
> x2.
>
>> Aliases can also provide a reasonable way of enumerating devices, if
>> "reg" isn't suitable on its own.
>
> Yes.  In almost all cases, drivers and subsystems do not need this at
> all though.  In OF, one device points to another by putting the phandle
> of that pointed-to device in some property (and buses are represented
> by their parent bridge).  If the Linux subsystem wants to use an integer
> for distinguishing between its various buses, that's fine, but it can
> just make up these numbers -- the numbers themselves have no actual
> meaning, only the relationships expressed via those numbers do.

That's true.  However if all the system documentation uses a
particular numbering of the devices, it's convenient if we can use the
same numbering in Linux.

> In a few cases, particularly where those numbers are user-visible, like
> in ethN, the aliases construct is a good solution.  If a  
> driver/subsystem
> is relying on the aliases though, it should document this in a  
> (platform?)
> binding -- and it would better have a very good reason for it!

Incidentally, another word on "cell-index".  Even for its intended
purpose, this was always a compromise.  The strictly correct way to
handle shared registers like this is for the node representing the
shared resource to have a table of phandles pointing back to the
devices controlled by the shared registers from which the appropriate
indices can derived.

On at least some 4xx chips, however, the shared resources are
scattered around various places, but all use the same device
numbering.  Therefore it seemed expedient to encode that numbering in
a single place - 'cell-index' - rather than having several such
tables.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
