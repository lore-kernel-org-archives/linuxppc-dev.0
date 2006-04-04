Return-Path: <olh@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0911E679E0
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Apr 2006 04:34:47 +1000 (EST)
Date: Tue, 4 Apr 2006 20:34:42 +0200
From: Olaf Hering <olh@suse.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] powerpc: iSeries has only 256 IRQs
Message-ID: <20060404183442.GA25986@suse.de>
References: <20060404145620.00697fff.sfr@canb.auug.org.au>
	<20060404133614.GA24210@suse.de>
	<20060405010818.7e992a66.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20060405010818.7e992a66.sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Wed, Apr 05, Stephen Rothwell wrote:

> If you have time, can you try (without this patch) just changing NR_IRQS in
> include/asm-powerpc/irq.h from 512 to 256 and see if that kernel will boot
> and what changes (if any) you get to the boot messages.

This results in a different irq:

vio_register_driver: driver iseries_veth registering
iseries_veth: eth0 attached to iSeries vlan 0 (LPAR map = 0x0005)
Emulex LightPulse Fibre Channel SCSI driver 8.1.4
Copyright(c) 2004-2006 Emulex.  All rights reserved.
PCI: Enabling device: (0000:18:12.0), cmd 3
scsi0 :  on PCI bus 18 device 90 irq 55
PCI: RDL: Device 0x0018:90  I/O Error( 1): 0x0101
PCI: RDL: Device 0x0018:90  I/O Error( 2): 0x0102
PCI: RDL: Device 0x0018:90  I/O Error( 3): 0x0102
PCI: RDL: Device 0x0018:90  I/O Error( 4): 0x0102
Kernel panic - not syncing: PCI: Hardware I/O Error, SRC B6000103, Automatic Reboot Disabled.

 <3>Badness in smp_call_function at /usr/src/linux-2.6.16-8/arch/powerpc/kernel/smp.c:228
Call Trace:
[C00000003E8DAF40] [C00000000000E3E4] .show_stack+0x68/0x1b0 (unreliable)
[C00000003E8DAFE0] [C000000000264BF4] .program_check_exception+0x1cc/0x5a8
[C00000003E8DB0B0] [C000000000004A70] program_check_common+0xf0/0x100
--- Exception: 700 at .smp_call_function+0x34/0x1d8
    LR = .smp_call_function+0x28/0x1d8
[C00000003E8DB3A0] [C000000000330000] zone_names+0x818/0xf18 (unreliable)
[C00000003E8DB450] [C0000000000371EC] .panic+0xa0/0x194
[C00000003E8DB4F0] [C00000000002BF48] .CheckReturnCode+0xac/0xc4
[C00000003E8DB570] [C00000000002CAA4] .iSeries_Read_Long+0x160/0x19c
[C00000003E8DB620] [D0000000002215A0] .lpfc_sli_brdrestart+0xc8/0x1c0 [lpfc]
[C00000003E8DB6C0] [D00000000022170C] .lpfc_sli_hba_setup+0x74/0x3e0 [lpfc]
[C00000003E8DB770] [D0000000002348C0] .lpfc_pci_probe_one+0x650/0xa7c [lpfc]
[C00000003E8DB830] [C000000000196D00] .pci_device_probe+0x80/0xc4
[C00000003E8DB8C0] [C0000000001B0A24] .driver_probe_device+0xa0/0x15c
[C00000003E8DB960] [C0000000001B0CB4] .__driver_attach+0xdc/0x164
[C00000003E8DB9F0] [C0000000001B0158] .bus_for_each_dev+0x7c/0xd4
[C00000003E8DBAB0] [C0000000001B08C8] .driver_attach+0x28/0x40
[C00000003E8DBB30] [C0000000001AFBF8] .bus_add_driver+0x90/0x170
[C00000003E8DBBD0] [C0000000001B10E4] .driver_register+0xbc/0xd8
[C00000003E8DBC60] [C000000000196ADC] .__pci_register_driver+0x8c/0xd8
[C00000003E8DBD00] [D00000000023E024] .lpfc_init+0x60/0x282c [lpfc]
[C00000003E8DBD90] [C00000000005C5E4] .sys_init_module+0x1e4/0x448


Great news is that 2.6.5 does it that way:

nst-sys:/ # modprobe  -v lpfc
insmod /lib/modules/2.6.5-override-iseries64/initrd/scsi_transport_fc.ko 
insmod /lib/modules/2.6.5-override-iseries64/initrd/lpfc.ko 
Kernel panic: PCI: Hardware I/O Error, SRC B6000103, Automatic Reboot Disabled.
 
