Return-Path: <avolkov@varma-el.com>
Received: from amanaus.varma-el.com (unknown [195.144.244.147])
	by ozlabs.org (Postfix) with ESMTP id 36ADC67A73
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 Mar 2005 23:32:40 +1100 (EST)
Message-ID: <424404E2.2030602@varma-el.com>
Date: Fri, 25 Mar 2005 15:32:34 +0300
From: Andrey Volkov <avolkov@varma-el.com>
MIME-Version: 1.0
To: Sylvain Munaut <tnt@246tNt.com>, Wolfgang Denk <wd@denx.de>
References: <0.20050322_000905.tnt@patchsend.246tNt.com>	<556f5ce38ca914dce63ca24277af4b3e@freescale.com>	<423FC578.8040202@246tNt.com>	<42427C2F.2070104@varma-el.com>
	<4242CFF8.7090908@246tNt.com> <42430DF0.2050304@varma-el.com>
In-Reply-To: <42430DF0.2050304@varma-el.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [RFC] MPC5200 Kernel/UBoot PCI problem
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Sylvain, Wolfgang,

> 
>>
>> Try adding some delays in the pci configuration zone access routines 
>> in mpc52xx_pci.c  I remember someone needed those but still don't know 
>> why, the manual don't say anything about that.
> 
> Board started, after I add udelay(7) in read/write config. Really strange.

Sylvain, answer was in PCI2.2 specification, not in manual.

Wolfgang, as I see, you use same trick in u-boot, as Sylvain suggested 
to me. IMHO this trick is wrong. Below I explain why.

When I insert udelay(1000) after deassertion of RST# (write 0 to PR of 
PCIGSCR), AND remove ALL delays from read/write config, board started 
too ;). Hence problem not in the MPC, but in slow board(s) (re)start
(I was lucky with my board, because udelay must be 1000000).

Here some quotations from "PCI Local Bus Specification rev. 2.2":

 From table 4-6 Timing parameters:
					       |  Min	|Max| Unit
Trhfa| RST# High to First configuration access | 2**25	|   | clocks
Trhff| RST# High to First FRAME# assertion     |   5	|   | clocks

2**25 clocks = 1.016 sec for 33MHz and 0.508 sec for 66MHz PCI.

 From Chapter "4.3.2 Reset":

....
Some PCI devices must be prepared to respond as a target Trhff time 
after RST# deasserts. For example, devices in the path between the CPU 
and the boot ROM (not expansion ROM) must be prepared to respond as a 
target Trhff time after RST# deasserts.

All other devices must be prepared to respond as a target not more than 
Trhfa after the deassertion of RST#. It is recommended that the system 
wait at least Trhfa following the deassertion of RST# to a device before 
the first access to that device, unless the device is in the path 
between the CPU and the boot ROM or the system knows that the device is
ready sooner.

Software that accesses devices prior to the expiration of Trhfa must be 
prepared for the devices either not to respond at all (resulting in 
Master-Abort) or for the devices to respond with Retry until the 
expiration of Trhfa. At no time can a device return invalid data. 
Devices are exempt from the Maximum Retry Time specification and the 
target initial latency requirement until the expiration of Trhfa.
....

-- 
Regards
Andrey Volkov
