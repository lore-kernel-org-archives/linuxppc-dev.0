Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2241ADDF69
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jun 2008 12:41:35 +1000 (EST)
In-Reply-To: <20080605024140.GA30980@yookeroo.seuss>
References: <200806041706.21557.sr@denx.de> <4846B39F.3010601@freescale.com>
	<20080604154351.GB10393@ld0162-tx32.am.freescale.net>
	<20080604211942.2bddc860@zod.rchland.ibm.com>
	<20080605024140.GA30980@yookeroo.seuss>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <49648f3051f1ba1b39e67ec2ce08367c@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: "cell-index" vs. "index" vs. no index in I2C device nodes
Date: Fri, 6 Jun 2008 04:40:20 +0200
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

>>> From a device tree perspective, index and cell-index are both
>> incorrect.  The IIC macros don't share register blocks with anything,
>> are enumerated as unique instances per macro in the device tree, and
>> should be able to be distinguished by "regs" and/or unit address.
>>
>> Does anyone disagree with that?
>
> Hear, hear.

x2.

> Aliases can also provide a reasonable way of enumerating devices, if
> "reg" isn't suitable on its own.

Yes.  In almost all cases, drivers and subsystems do not need this at
all though.  In OF, one device points to another by putting the phandle
of that pointed-to device in some property (and buses are represented
by their parent bridge).  If the Linux subsystem wants to use an integer
for distinguishing between its various buses, that's fine, but it can
just make up these numbers -- the numbers themselves have no actual
meaning, only the relationships expressed via those numbers do.

In a few cases, particularly where those numbers are user-visible, like
in ethN, the aliases construct is a good solution.  If a 
driver/subsystem
is relying on the aliases though, it should document this in a 
(platform?)
binding -- and it would better have a very good reason for it!


Segher
