Return-Path: <skepper@chara.vm.bytemark.co.uk>
Received: from chara.vm.bytemark.co.uk (chara.vm.bytemark.co.uk [80.68.89.253])
	by ozlabs.org (Postfix) with ESMTP id 6F264DDEED
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Sep 2008 20:32:27 +1000 (EST)
Date: Wed, 10 Sep 2008 11:32:21 +0100 (BST)
From: Chris Skepper <skepper@ukf.net>
To: Marco Stornelli <marco.stornelli@coritel.it>
Subject: Re: Not probing devices on PowerPC MPC8247 and kernel 2.6.26
In-Reply-To: <48C79F12.5040503@coritel.it>
Message-ID: <Pine.LNX.4.62.0809101125400.24945@chara.vm.bytemark.co.uk>
References: <Pine.LNX.4.62.0809101058580.24139@chara.vm.bytemark.co.uk>
	<48C79F12.5040503@coritel.it>
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


> Chris Skepper ha scritto:
>> I have an MPC8247 based board. I can get the SMC1 console working, but the 
>> other SCCx serial ports and the FCC1 ethernet doesn't work.
>> 
>> It appears that a part of the problem is that the probe methods are not 
>> called. The "match" table stuff all looks fine and the serial ports and 
>> ethernet are defined in the .dts file. The module init function is called, 
>> but the probe methods are not reached. It seems driver_register gets 
>> called, so why doesn't something call probe?
>> 
>> Is there likely to be some problem with the bus setup?

On Wed, 10 Sep 2008, Marco Stornelli wrote:
> probably there's some mismatch between the device (for example some 
> information in dts) and the driver. The match function scan for a driver for 
> those devices but the values compared don't match the values of the drivers.

Hi Marco,

Thanks.  But I think the "compatible" properties in the DTS are set 
correctly.  I have "fsl,cpm2-fcc-enet" for the ethernet and 
"fsl,cpm2-scc-uart" which seems to be what's in the match_table.

Is there something else I should check?

Cheers,

Chris.
