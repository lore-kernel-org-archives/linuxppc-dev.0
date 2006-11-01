Return-Path: <johnrose@austin.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E103D67B22
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Nov 2006 05:59:45 +1100 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e36.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id kA1Ixhgr019689
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Nov 2006 13:59:43 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kA1IxhaT431726
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Nov 2006 11:59:43 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kA1IxgnI001855
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Nov 2006 11:59:42 -0700
Subject: powerpc: "unable to handle .. paging request" during IPR probe
From: John Rose <johnrose@austin.ibm.com>
To: External List <linuxppc-dev@ozlabs.org>, Brian King <bjking1@us.ibm.com>
Content-Type: text/plain
Message-Id: <1162407611.28335.27.camel@sinatra.austin.ibm.com>
Mime-Version: 1.0
Date: Wed, 01 Nov 2006 13:00:11 -0600
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anyone else seen this crash during boot on pseries?  This is 2.6.19-rc4
with 4k pages.

Unable to handle kernel paging request for data at address 0x00000010
Faulting instruction address: 0xc00000000006a204
cpu 0x1: Vector: 300 (Data Access) at [c00000006ff82bc0]
pc: c00000000006a204: .flush_workqueue+0x24/0xec
lr: c0000000003848f4: .ata_port_flush_task+0x5c/0x12c
sp: c00000006ff82e40
msr: 8000000000009032
dar: 10
dsisr: 40000000
current = 0xc000000002e3d810
paca = 0xc000000000602700
pid = 1, comm = swapper
enter ? for help
[c00000006ff82ed0] c0000000003848f4 .ata_port_flush_task+0x5c/0x12c
[c00000006ff82f60] c000000000384c78 .ata_exec_internal+0x28c/0x458
[c00000006ff83070] c000000000385070 .ata_dev_read_id+0x12c/0x2f8
[c00000006ff83150] c000000000385bfc .ata_bus_probe+0x180/0x330
[c00000006ff83210] c0000000003912ac .ata_sas_port_init+0x4c/0x6c
[c00000006ff832a0] c0000000003675a4 .ipr_ata_slave_alloc+0x68/0xc0
[c00000006ff83330] c000000000346750 .scsi_alloc_sdev+0x1d0/0x25c
[c00000006ff833e0] c0000000003477c8 .scsi_probe_and_add_lun+0x110/0x2ec
[c00000006ff834b0] c00000000034833c .__scsi_scan_target+0xd8/0x150
[c00000006ff83560] c000000000348518 .scsi_scan_channel+0x7c/0xe0
[c00000006ff83600] c000000000348648 .scsi_scan_host_selected+0xcc/0x13c
[c00000006ff836a0] c00000000036e6dc .ipr_probe+0xe0/0x158
[c00000006ff83740] c00000000024da10 .pci_call_probe+0x104/0x168
[c00000006ff83800] c00000000024dad0 .__pci_device_probe+0x5c/0x8c
[c00000006ff83880] c00000000024db38 .pci_device_probe+0x38/0x6c
[c00000006ff83910] c0000000002be40c .really_probe+0x78/0x1a4
[c00000006ff839b0] c0000000002be660 .driver_probe_device+0xfc/0x12c
[c00000006ff83a50] c0000000002be818 .__driver_attach+0xa0/0x12c
[c00000006ff83ae0] c0000000002bd240 .bus_for_each_dev+0x70/0xc0
[c00000006ff83b90] c0000000002be8cc .driver_attach+0x28/0x40
[c00000006ff83c10] c0000000002bdb7c .bus_add_driver+0x90/0x154
[c00000006ff83cb0] c0000000002befcc .driver_register+0xa8/0xc4
[c00000006ff83d30] c00000000024e06c .__pci_register_driver+0x88/0xc0
[c00000006ff83db0] c0000000005c6a2c .ipr_init+0x34/0x4c
[c00000006ff83e30] c00000000059fb20 .do_initcalls+0x9c/0x19c
[c00000006ff83f00] c000000000009294 .init+0x94/0x1a8
[c00000006ff83f90] c000000000025540 .kernel_thread+0x4c/0x68
