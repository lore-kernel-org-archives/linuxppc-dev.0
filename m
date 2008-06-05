Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3A47BDF250
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jun 2008 07:31:46 +1000 (EST)
In-Reply-To: <48483B99.3010300@freescale.com>
References: <200806041706.21557.sr@denx.de>	
	<fa686aa40806050839h55d8e358m93248414507f10e2@mail.gmail.com>	
	<48480987.1070701@freescale.com>	
	<fa686aa40806050900i40f0aa62o4bab3b8c7409b15f@mail.gmail.com>	
	<484810A3.5070301@freescale.com>	
	<20080605112122.0381a338@zod.rchland.ibm.com>	
	<48481373.8010706@freescale.com>	
	<20080605132735.3433f2af@zod.rchland.ibm.com>	
	<fa686aa40806051146h10d9add6ude64d59cedf08f7d@mail.gmail.com>	
	<20080605135625.562d1dbe@zod.rchland.ibm.com>
	<fa686aa40806051214u6866cec0m66ea32275d8bd5cc@mail.gmail.com>
	<48483B99.3010300@freescale.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <d944874d9d1712df63cb8a6f6411592a@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: "cell-index" vs. "index" vs. no index in I2C device nodes
Date: Thu, 5 Jun 2008 23:31:25 +0200
To: Timur Tabi <timur@freescale.com>
Cc: Scott Wood <scottwood@freescale.com>, Stefan Roese <sr@denx.de>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> No; use an alias in the aliases node.  That is what aliases is 
>> designed
>> for.  Something like 'index' is a reinvention of the wheel.
>
> Do aliases work in reverse?  That is, if I have a pointer to a device 
> node, can
> I look up its alias directly?  Or do I have to scan the aliases node 
> and do a
> comparison of each phandle, one at a time, until I find a match?  And 
> when I
> find a match, will I need to do sscanf() in order to extract the 
> actual index
> value from the property?

Aliases are one-way.  You can have multiple aliases point to the same 
node,
as well (and that is quite common, even).

If you need a unique identifier for an OF node, use its phandle.
It sounds to me like you just need to set up a mapping between
phandles and Linux i2c bus ids here?


Segher
