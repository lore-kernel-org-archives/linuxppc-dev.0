Return-Path: <olaf@aepfle.de>
Received: from mo-p07-ob.rzone.de (mo-p07-ob.rzone.de [81.169.146.190])
	by ozlabs.org (Postfix) with ESMTP id 122A667B83
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Dec 2006 04:12:18 +1100 (EST)
Date: Sun, 3 Dec 2006 18:12:16 +0100 (MET)
From: Olaf Hering <olaf@aepfle.de>
To: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: pata_sl82c105 can not reserve IO region
Message-ID: <20061203171216.GB21947@aepfle.de>
References: <20061130165202.GA23205@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20061130165202.GA23205@aepfle.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Nov 30, Olaf Hering wrote:

> 
> pata_sl82c105 can be used on the ppc64 POWER4 system p610, p615 and p630
> for the onboard IDE CD drive. It could be also used for ppc32 Motorola
> PowerStack PReP systems.
> 
> Unfortunately, it doesnt work for me on the p630:
> 
> PCI: Enabling device: (0000:00:03.1), cmd 141
> PCI: Unable to reserve I/O region #6:10@0 for device 0000:00:03.1
> pata_sl82c105: probe of 0000:00:03.1 failed with error -16

I modified pci_request_regions to request only the first 5 regions.
Now the detection works, but access to the drive does not work:

[  175.479288] PCI: Enabling device: (0000:00:03.1), cmd 141
[  181.533396] ata1: PATA max MWDMA2 cmd 0xF000 ctl 0xF012 bmdma 0xF040 irq 86
[  175.542281] scsi2 : pata_sl82c105
[  175.879574] ata1.00: ATAPI, max UDMA/33
[  176.055641] ata1.00: configured for MWDMA2
[  176.065579] scsi 2:0:0:0: CD-ROM            LG       CD-ROM CRD-8484B 2.01 PQ: 0 ANSI: 5
[  176.077138] sr0: scsi3-mmc drive: 48x/48x cd/rw xa/form2 cdda tray
[  176.086020] Uniform CD-ROM driver Revision: 3.20
[  176.094959] sr 2:0:0:0: Attached scsi CD-ROM sr0
[  176.103932] sr 2:0:0:0: Attached scsi generic sg4 type 5


[  194.947620] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
[  194.947628] ata1.00: (BMDMA stat 0x41)
[  194.947693] ata1.00: tag 0 cmd 0xa0 Emask 0x4 stat 0x40 err 0x0 (timeout)
[  194.947714] ata1: soft resetting port
[  195.448133] ata1.00: configured for MWDMA2
[  195.448157] ata1: EH complete
[  200.450116] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
[  200.450124] ata1.00: (BMDMA stat 0x41)
[  200.450132] ata1.00: tag 0 cmd 0xa0 Emask 0x4 stat 0x40 err 0x0 (timeout)
[  200.450153] ata1: soft resetting port
[  200.945670] ata1.00: configured for MWDMA2
[  200.945695] ata1: EH complete
