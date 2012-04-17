Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp07.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BCE3CB704A
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Apr 2012 15:31:14 +1000 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 17 Apr 2012 11:01:11 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q3H5V1bp4346086
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Apr 2012 11:01:01 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q3HB0hrY016251
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Apr 2012 16:30:43 +0530
Date: Tue, 17 Apr 2012 13:30:52 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Subject: Re: [PATCH v5 00/21] EEH reorganization
Message-ID: <20120417053052.GA22341@shangw>
References: <1330409051-8941-1-git-send-email-shangw@linux.vnet.ibm.com>
 <20120413073931.0c36169b@kryten> <20120413120346.42e01402@kryten>
 <20120417012915.GA3806@shangw> <20120417113738.0f091da4@kryten>
 <1334627871.25353.26.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1334627871.25353.26.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, Anton Blanchard <anton@samba.org>
Reply-To: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Ben, thanks a lot for the backtrace to help narrowing down the root
cause. Also thanks a lot for how to parse the backtrace and register
staff printed by oops ;-) 

Finally, I successfully reproduced the issue on Firebird-L machine
without loading the corresponding device driver for Emulex ethernet
by disable the corresponding config options in .config. With injected
config space data parity error destined to the Emulex ethernet MAC,
I saw following backtrace. The problem came from following piece of
code. Actually, the EEH device should be retrieve from OF node instead
of PCI device since the PCI device didn't trace the corresponding
EEH device yet at that time. I'll send one patch against it soon even
it only need 1 line of code change ;-)

(gdb) p &(((struct eeh_dev *)0)->pdev)
$1 = (struct pci_dev **) 0x70

static void eeh_add_device_late(struct pci_dev *dev)
{
        struct device_node *dn;
        struct eeh_dev *edev;

        if (!dev || !eeh_subsystem_enabled)
                return;
	dn = pci_device_to_OF_node(dev);
	edev = pci_dev_to_eeh_dev(dev);		<<< edev should be NULL
	if (edev->pdev == dev) {		<<< data access fault here.
                pr_debug("EEH: Already referenced !\n");
                return;
        }
        WARN_ON(edev->pdev);
	:
	:
}

[  176.972046] Unable to handle kernel paging request for data at address 0x00000070
[  176.972054] Faulting instruction address: 0xc000000000055ecc
[  176.972064] Oops: Kernel access of bad area, sig: 11 [#1]
[  176.972070] SMP NR_CPUS=1024 NUMA pSeries
[  176.972078] Modules linked in:
[  176.972086] NIP: c000000000055ecc LR: c000000000055ec8 CTR: c00000000005babc
[  176.972102] REGS: c000000f4d913970 TRAP: 0300   Not tainted  (3.4.0-rc2+)
[  176.972109] MSR: 8000000000009032 <SF,EE,ME,IR,DR,RI>  CR: 28000084  XER: 00000009
[  176.972129] SOFTE: 1
[  176.972133] CFAR: c000000000005080
[  176.972138] DAR: 0000000000000070, DSISR: 40000000
[  176.972146] TASK = c000000f4d8c3600[1038] 'eehd' THREAD: c000000f4d910000 CPU: 24
[  176.972155] GPR00: c000000000055ec8 c000000f4d913bf0 c00000000147ed90 000000000000001e 
[  176.972170] GPR04: 0000000000000000 ffffffffffffffff 0000000000000000 0000000000000000 
[  176.972183] GPR08: 000000004f4e450d c000000000c44208 0000000000036710 0000000000ec0000 
[  176.972197] GPR12: 0000000028000082 c00000000ff25400 0000000000000000 000000000106c9c8 
[  176.972212] GPR16: 0000000002280000 0000000002e5acf0 0000000001aff9a4 0000000000000060 
[  176.972227] GPR20: 0000000000000000 ffffffffffffffff ffffffffffffffff c000000001345c78 
[  176.972241] GPR24: c000000001345c70 0000000000000000 0000000000000000 c000000000851ac0 
[  176.972256] GPR28: c000000000a95ad3 c000000f529f2c28 c000000f529f2c00 c000000f4d880000 
[  176.972276] NIP [c000000000055ecc] .eeh_add_device_tree_late+0x17c/0x2c4
[  176.972286] LR [c000000000055ec8] .eeh_add_device_tree_late+0x178/0x2c4
[  176.972294] Call Trace:
[  176.972300] [c000000f4d913bf0] [c000000000055ec8] .eeh_add_device_tree_late+0x178/0x2c4 (unreliable)
[  176.972316] [c000000f4d913ca0] [c000000000036bc8] .pcibios_finish_adding_to_bus+0x74/0x90
[  176.972328] [c000000f4d913d20] [c000000000059b50] .pcibios_add_pci_devices+0x12c/0x150
[  176.972339] [c000000f4d913db0] [c000000000057c60] .eeh_reset_device+0x10c/0x140
[  176.972350] [c000000f4d913e50] [c000000000057ee4] .handle_eeh_events+0x250/0x42c
[  176.972361] [c000000f4d913f10] [c000000000058560] .eeh_event_handler+0xe4/0x178
[  176.972372] [c000000f4d913f90] [c000000000021550] .kernel_thread+0x54/0x70
[  176.972380] Instruction dump:
[  176.972384] eb82a1f0 7f83e378 487dd2e9 60000000 e862a1f8 7f64db78 487dd2d9 60000000 
[  176.972400] eb5f02c0 7f83e378 487dd2c9 60000000 <e81a0070> 7fa0f800 40de0028 e862a188 

Thanks,
Gavin

>
>More precisely, the original oops reported by Anton decodes as such:
>
>>Oops: Kernel access of bad area, sig: 11 [#1]
>
>This is typically a bad memory access..
>
>>SMP NR_CPUS=1024 NUMA pSeries
>>Modules linked in:
>>NIP: c000000000055af8 LR: c000000000033204 CTR: 0000000000000000
>>REGS: c000001f42fb7990 TRAP: 0300   Tainted: G        W     (3.4.0-rc2-00065-gf549e08-dirty)
>
>TRAP: 300 means that it's the result of a data access interrupts, ie,
>load or store to a bad address
>
>>MSR: 8000000000009032 <SF,EE,ME,IR,DR,RI>  CR: 24008084  XER: 00000000
>>SOFTE: 1
>>CFAR: 00000000000049b8
>>DAR: 0000000000000070, DSISR: 40000000
>
>Here the DAR tells us what address was accessed. 0x70 is a strong indication
>that this was an access to a NULL pointer (at offset 0x70 from that pointer).
>
>It -might- be something else (such as a NULL passed to a list head or such)
>but the idea that there's a NULL floating around is a good hint.
>
>>TASK = c000001f6c7dfc40[19010] 'eehd' THREAD: c000001f42fb4000 CPU: 6
>>GPR00: 0000000000000001 c000001f42fb7c10 c000000000bd3a28 c000001f80ab0800 
>>GPR04: c000001f7c57d418 0000000000000380 c000001f7c57e070 c000000000ed5360 
>>GPR08: 0000000000000000 c000000000c77088 0000000000000000 0000000000000001 
>>GPR12: 0000000044008088 c00000000eda1500 00000000019ffa78 0000000000a70000 
>>GPR16: 00000000000000bb c000000000a9f754 c000000000963230 000000000000005e 
>>GPR20: 0000000001b37e80 00000000000000bb 0000000000000000 c000000000b0ad90 
>>GPR24: 0000000000000000 c000000000b10588 0000000000000001 c000001f80ab0800 
>>GPR28: 0000000000000000 c000001f80ab0828 0000000000000000 c000001f7ee10000 
>>NIP [c000000000055af8] .eeh_add_device_tree_late+0x58/0xf0
>
>This is the function where it happened (eeh_add_device_tree_late)
>
>>LR [c000000000033204] .pcibios_finish_adding_to_bus+0x34/0x50
>>Call Trace:
>>[c000001f42fb7c10] [00000000fdffffff] 0xfdffffff (unreliable)
>>[c000001f42fb7ca0] [c000000000033204] .pcibios_finish_adding_to_bus+0x34/0x50
>>[c000001f42fb7d20] [c000000000059a5c] .pcibios_add_pci_devices+0x7c/0x190
>>[c000001f42fb7db0] [c000000000057a6c] .eeh_reset_device+0xfc/0x1a0
>>[c000001f42fb7e50] [c000000000057e18] .handle_eeh_events+0x308/0x480
>>[c000001f42fb7f00] [c0000000000584dc] .eeh_event_handler+0x13c/0x1d0
>>[c000001f42fb7f90] [c00000000002099c] .kernel_thread+0x54/0x70
>
>And your backtrace. You can see that you got an eeh event, which triggered an
>eeh reset, which triggered a pcibios_add_pci_devices() etc...
>
>>Instruction dump:
>>480000a8 60000000 ebff0000 7fbfe800 419e0098 2fbf0000 419e005c e9229eb0 
>>80090008 2f800000 419e004c ebdf01d0 <e81e0070> 7fbf0000 3160ffff
>>7d2b0110 
>
>Cheers,
>Ben.
>
>
