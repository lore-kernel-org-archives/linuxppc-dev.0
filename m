Return-Path: <olh@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5B21C679F5
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Apr 2006 23:36:20 +1000 (EST)
Date: Tue, 4 Apr 2006 15:36:14 +0200
From: Olaf Hering <olh@suse.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] powerpc: iSeries has only 256 IRQs
Message-ID: <20060404133614.GA24210@suse.de>
References: <20060404145620.00697fff.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20060404145620.00697fff.sfr@canb.auug.org.au>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Tue, Apr 04, Stephen Rothwell wrote:

> The iSeries Hypervisor only allows us to specify IRQ numbers up to 255 (it
> has a u8 field to pass it in).  This patch allows platforms to specify a
> maximum to the virtual IRQ numbers we will use and has iSeries set that
> to 255.  If not set, the maximum is NR_IRQS - 1 (as before).

I tried this patch, and the partition dies that way:

vio_register_driver: driver iseries_veth registering
iseries_veth: eth0 attached to iSeries vlan 0 (LPAR map = 0x0005)
Emulex LightPulse Fibre Channel SCSI driver 8.1.4
Copyright(c) 2004-2006 Emulex.  All rights reserved.
PCI: Enabling device: (0000:18:12.0), cmd 3
scsi0 :  on PCI bus 18 device 90 irq 212
PCI: RDL: Device 0x0018:90  I/O Error( 1): 0x0101
PCI: RDL: Device 0x0018:90  I/O Error( 2): 0x0102
PCI: RDL: Device 0x0018:90  I/O Error( 3): 0x0102
PCI: RDL: Device 0x0018:90  I/O Error( 4): 0x0102
Kernel panic - not syncing: PCI: Hardware I/O Error, SRC B6000103, Automatic Reboot Disabled.

 <3>Badness in smp_call_function at arch/powerpc/kernel/smp.c:228
Call Trace:
[C00000000F836E50] [C00000000000E444] .show_stack+0x68/0x1b0 (unreliable)
[C00000000F836EF0] [C000000000264FDC] .program_check_exception+0x1cc/0x5a8
[C00000000F836FC0] [C000000000004A70] program_check_common+0xf0/0x100
--- Exception: 700 at .smp_call_function+0x34/0x1d8
    LR = .smp_call_function+0x28/0x1d8
[C00000000F8372B0] [C000000000334800] zone_names+0x818/0xf18 (unreliable)
[C00000000F837360] [C0000000000376F4] .panic+0xa0/0x194
[C00000000F837400] [C00000000002C354] .CheckReturnCode+0xac/0xc4
[C00000000F837480] [C00000000002CEB0] .iSeries_Read_Long+0x160/0x19c
[C00000000F837530] [D00000000021F5A0] .lpfc_sli_brdrestart+0xc8/0x1c0 [lpfc]
[C00000000F8375D0] [D00000000021F70C] .lpfc_sli_hba_setup+0x74/0x3e0 [lpfc]
[C00000000F837680] [D0000000002328C4] .lpfc_pci_probe_one+0x650/0xa7c [lpfc]
[C00000000F837740] [C0000000001970C4] .pci_device_probe+0x80/0xc4
[C00000000F8377D0] [C0000000001B0DE8] .driver_probe_device+0xa0/0x15c
[C00000000F837870] [C0000000001B1078] .__driver_attach+0xdc/0x164
[C00000000F837900] [C0000000001B051C] .bus_for_each_dev+0x7c/0xd4
[C00000000F8379C0] [C0000000001B0C8C] .driver_attach+0x28/0x40
[C00000000F837A40] [C0000000001AFFBC] .bus_add_driver+0x90/0x170
[C00000000F837AE0] [C0000000001B14A8] .driver_register+0xbc/0xd8
[C00000000F837B70] [C000000000196EA0] .__pci_register_driver+0x8c/0xd8
[C00000000F837C10] [D00000000023C028] .lpfc_init+0x60/0x2828 [lpfc]
[C00000000F837CA0] [C00000000005C564] .sys_init_module+0x1898/0x1bc4
[C00000000F837E30] [C000000000008534] syscall_exit+0x0/0x40
...

Before, it just did not find the card:
...
vio_register_driver: driver iseries_veth registering
iseries_veth: eth0 attached to iSeries vlan 0 (LPAR map = 0x0005)
Emulex LightPulse Fibre Channel SCSI driver 8.1.4
Copyright(c) 2004-2006 Emulex.  All rights reserved.
PCI: Enabling device: (0000:18:12.0), cmd 3
scsi0 :  on PCI bus 18 device 90 irq 235
lpfc 0000:18:12.0: 0:0451 Enable interrupt handler failed
lpfc: probe of 0000:18:12.0 failed with error -38
...

So, there is likely more breakage.
