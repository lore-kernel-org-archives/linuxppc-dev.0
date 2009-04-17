Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C2A1EDDE2A
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Apr 2009 00:08:22 +1000 (EST)
Message-Id: <5A611DAC-A7E2-4E96-A087-B9BFD8DF59F9@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1239957182.7443.58.camel@pasglop>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: pci32 code - early_*config*
Date: Fri, 17 Apr 2009 09:08:10 -0500
References: <8393884A-D1B0-4081-980C-CF464A38FD6C@kernel.crashing.org>
	<1239953159.7443.33.camel@pasglop>
	<c8485d470904170103g35e331b0g95d83613ed4bc1f4@mail.gmail.com>
	<1239957182.7443.58.camel@pasglop>
Cc: Linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	Roderick Colenbrander <thunderbird2k@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 17, 2009, at 3:33 AM, Benjamin Herrenschmidt wrote:

> On Fri, 2009-04-17 at 10:03 +0200, Roderick Colenbrander wrote:
>>
>> There are cases when it is really needed (or you would have to access
>> the address and data bus by hand). In my case I'm using a Xilinx PLB
>> soft-core and if certain options in the configuration header aren't
>> set (which aren't set by default) the soft-core is basically  
>> disabled.
>> Cases like this look like valid cases in which early config should be
>> used.
>
> I still wonder whether we could just setup the pci_controller data
> structure and use "normal" PCI config access routines...

The problem is that the "normal" PCI config access routines need a  
pci_bus.  However we don't have one yet and we need to do PCI config  
cycles to the PHB before we call the remainder of the setup code to  
get one.

We could all call our own ops directly and provide a fake bus but this  
is pretty much what the early routines do for us in a common way.

- k
