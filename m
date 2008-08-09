Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E300CDDDF3
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Aug 2008 17:41:32 +1000 (EST)
Subject: Re: Device tree question
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Steven A. Falco" <sfalco@harris.com>
In-Reply-To: <489B5350.6050009@harris.com>
References: <489B5350.6050009@harris.com>
Content-Type: text/plain
Date: Sat, 09 Aug 2008 17:41:22 +1000
Message-Id: <1218267682.24157.366.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-08-07 at 15:56 -0400, Steven A. Falco wrote:
> I have added a compact flash to the external bus of a Sequoia
> (PPC440EPx) evaluation board.  It is wired to CS1, and U-boot is set to
> configure CS1 to be at address 0xc1000000.  U-boot can access the
> device, and reports the correct partition table, etc. so I believe the
> hardware is ok.
> 
> I've created a device-tree entry under the EBC0 section of the
> sequoia.dts file:
> 
>                 pata@1,0 {
>                     compatible = "harris,hydra_temp-pata", "ata-generic";
>                     bank-width = <2>;
>                     reg = <1 0 20 1 80 20>;
>                     reg-shift = <4>;
>                     pio-mode = <4>;
>                     interrupts = <27 4>;
>                     interrupt-parent = <&UIC0>;
>                 };
>             };
> 
> This seems to be correct, because if I turn on debug in prom_parse, I
> see a translation that looks reasonable:

Did you check that the resulting physical address was indeed where you
device is supposed to be addressed ?

Ben.

> OF: translating address: 00000001 00000000
> OF: parent bus is default (na=1, ns=1) on /plb/opb
> OF: walking ranges...
> OF: default map, cp=0, s=4000000, da=100000000
> OF: default map, cp=100000000, s=100000, da=100000000
> OF: parent translation for: c1000000
> OF: with offset: 0
> OF: one level translation: c1000000
> OF: parent bus is default (na=2, ns=1) on /plb
> OF: walking ranges...
> OF: default map, cp=0, s=80000000, da=c1000000
> OF: default map, cp=80000000, s=80000000, da=c1000000
> OF: parent translation for: 00000001 80000000
> OF: with offset: 41000000
> OF: one level translation: 00000001 c1000000
> OF: parent bus is default (na=2, ns=1) on /
> OF: no ranges, 1:1 translation
> OF: parent translation for: 00000000 00000000
> OF: with offset: 1c1000000
> OF: one level translation: 00000001 c1000000
> OF: reached root node
> OF: ** translation for device /plb/opb/ebc/pata@1,0 **
> OF: bus is default (na=2, ns=1) on /plb/opb/ebc
> 
> (There is another translation for the alternate registers but I'll omit
> it for brevity.)
> 
> However, there is something wrong, because I get an oops:
> 
> Machine check in kernel mode.
> Data Write PLB Error
> Oops: Machine check, sig: 7 [#1]
> LTT NESTING LEVEL : 0
> Hydra_temp
> Modules linked in:
> NIP: c01e4618 LR: c01e4608 CTR: c01e4078
> REGS: c0398f50 TRAP: 0214   Not tainted  (2.6.25.4-00021-g4b3b5ea-dirty)
> MSR: 00029000 <EE,ME>  CR: 24044028  XER: 20000007
> TASK = cf808400[1] 'swapper' THREAD: cf826000
> GPR00: 00000008 cf827ce0 cf808400 cf3ac000 d1078080 00000000 00000001
> c03869c0
> GPR08: 00000000 c01e4078 cf3ac000 00000001 24044022 00000000 c02e977c
> c02e97e0
> GPR16: c02e97c8 c036a8bc c02e97f4 c02e9808 c037c0a8 c0386978 00000000
> cf360190
> GPR24: 00000027 c0386a64 00000000 00000000 cf360190 00000000 cf360194
> cf3ac000
> NIP [c01e4618] ata_bmdma_freeze+0x44/0x70
> LR [c01e4608] ata_bmdma_freeze+0x34/0x70
> Call Trace:
> [cf827ce0] [0000001f] 0x1f (unreliable)
> [cf827cf0] [c01e4c14] __ata_port_freeze+0x3c/0x5c
> [cf827d00] [c01e4fa4] ata_eh_freeze_port+0x40/0x5c
> [cf827d20] [c01d6868] ata_host_start+0xd8/0x208
> [cf827d40] [c01dd2f4] ata_host_activate+0x28/0x124
> [cf827d70] [c02a60c4] 0xc02a60c4
> [cf827db0] [c02a642c] 0xc02a642c
> [cf827e50] [c0222a7c] of_platform_device_probe+0x5c/0x560
> [cf827e70] [c01b3148] driver_probe_device+0xb8/0x1e8
> [cf827e90] [c01b3470] __driver_attach+0xcc/0xf8
> [cf827eb0] [c01b21c4] bus_for_each_dev+0x5c/0x98
> [cf827ee0] [c01b2f50] driver_attach+0x24/0x34
> [cf827ef0] [c01b2da8] bus_add_driver+0x1d8/0x258
> [cf827f20] [c01b371c] driver_register+0x48/0x114
> [cf827f40] [c0222950] of_register_driver+0x54/0x70
> [cf827f50] [c035ed08] pata_of_platform_init+0x20/0x30
> [cf827f60] [c03471cc] kernel_init+0xc8/0x2ac
> [cf827ff0] [c000e44c] original_kernel_thread+0x44/0x60
> 
> My question is: Did I do the device-tree entry incorrectly or is
> something else wrong?  I'll keep trying to figure it out on my own, but
> if anyone has any tips on debugging this, I'd love to hear them.
> 
>     Steve
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
