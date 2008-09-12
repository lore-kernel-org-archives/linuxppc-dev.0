Return-Path: <skepper@chara.vm.bytemark.co.uk>
Received: from chara.vm.bytemark.co.uk (chara.vm.bytemark.co.uk [80.68.89.253])
	by ozlabs.org (Postfix) with ESMTP id EF228DDEE2
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 13 Sep 2008 00:46:31 +1000 (EST)
Date: Fri, 12 Sep 2008 15:46:20 +0100 (BST)
From: Chris Skepper <skepper@ukf.net>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: Not probing devices on PowerPC MPC8247 and kernel 2.6.26
In-Reply-To: <48C7EE10.40500@freescale.com>
Message-ID: <Pine.LNX.4.62.0809121105460.14412@chara.vm.bytemark.co.uk>
References: <Pine.LNX.4.62.0809101058580.24139@chara.vm.bytemark.co.uk>
	<48C7EE10.40500@freescale.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: Chris Skepper <skepper@chara.vm.bytemark.co.uk>
Cc: linuxppc-embedded@ozlabs.org
Reply-To: skepper@ukf.net
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>> I have an MPC8247 based board.  I can get the SMC1 console working, but the 
>> other SCCx serial ports and the FCC1 ethernet doesn't work.
>> 
>> It appears that a part of the problem is that the probe methods are not 
>> called.  The "match" table stuff all looks fine and the serial ports and 
>> ethernet are defined in the .dts file. The module init function is called, 
>> but the probe methods are not reached. It seems driver_register gets 
>> called, so why doesn't something call probe?
>> 
>> Is there likely to be some problem with the bus setup?
>
> Are you calling of_platform_bus_probe() from your platform code, and do the 
> soc and cpm nodes match the bus list (I recommend using compatible = 
> "simple-bus")?
>
> -Scott


Hi Scott,

I added the simple-bus to the soc and cpm nodes and it started working 
just before your email arrived, but it's good to know I did the right 
thing.

Thanks for all your help, I've now got my board working very happily with 
Linux 2.6.26 and arch=powerpc.  In the end it was pretty much all in the 
dts file, but I don't think I'd have got there without your hints.

Cheers,

Chris.
