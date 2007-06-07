Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net
	[151.189.21.42])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3EB43DDF12
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Jun 2007 02:35:35 +1000 (EST)
In-Reply-To: <1181232276.5674.146.camel@rhino>
References: <1181147415.5674.108.camel@rhino>
	<200706070039.51541.arnd@arndb.de>
	<1181232276.5674.146.camel@rhino>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <63ff9dee6b212cc7908c8e1b73920ea6@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Fix the LPC47M192 SuperIO on the MPC8641 HPCN
Date: Thu, 7 Jun 2007 18:35:10 +0200
To: Wade Farnsworth <wfarnsworth@mvista.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Hardcoded I/O port numbers always worry me a little. I know that this 
>> is
>> supposed to work in general, but can't you read the I/O port range 
>> from
>> a device tree property?
>
> I suppose I could create a device node for the Super I/O config
> registers and use those instead of hardcoding it here.

I'd just hide it all, do this setup in the firmware,
where it belongs, and don't expose the superio config
in the device tree.

> superio_cfg@4e {
> 	reg = <1 4e 2>;
> 	compatible = "smsc-lpc47m192-cfg";
> };
>
> I'm not sure if the name and compatible properties are appropriate
> though.  Any recommendations?

"superio" and "smsc,lpc47m192" I'd say.  You also
then should link the logical devices on the superio
to the device nodes that represent those.  I'm not
sure this is all worth it, this is low-level setup
the firmware should do and everything else can treat
it as a black box.


Segher
