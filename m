Return-Path: <brking@us.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 97CA067C44
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Nov 2006 10:23:59 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id kA6NNmCS003108
	for <linuxppc-dev@ozlabs.org>; Mon, 6 Nov 2006 18:23:48 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kA6NNm2S205642
	for <linuxppc-dev@ozlabs.org>; Mon, 6 Nov 2006 18:23:48 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kA6NNm6J021117
	for <linuxppc-dev@ozlabs.org>; Mon, 6 Nov 2006 18:23:48 -0500
Message-ID: <454FC403.2020009@us.ibm.com>
Date: Mon, 06 Nov 2006 17:23:47 -0600
From: Brian King <brking@us.ibm.com>
MIME-Version: 1.0
To: John Rose <johnrose@austin.ibm.com>
Subject: Re: powerpc: "unable to handle .. paging request" during IPR probe
References: <1162407611.28335.27.camel@sinatra.austin.ibm.com>
In-Reply-To: <1162407611.28335.27.camel@sinatra.austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: External List <linuxppc-dev@ozlabs.org>, Brian King <bjking1@us.ibm.com>
Reply-To: brking@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

John Rose wrote:
> Anyone else seen this crash during boot on pseries?  This is 2.6.19-rc4
> with 4k pages.

This is the exact same signature of the failure that is fixed with
this patch:

http://marc.theaimsgroup.com/?l=linux-ide&m=116169938407596&w=2

It's an initialization sequence problem that exists for monolithic kernels.
Please try the patch and let me know if you are still having a problem.

Brian

> 
> Unable to handle kernel paging request for data at address 0x00000010
> Faulting instruction address: 0xc00000000006a204
> cpu 0x1: Vector: 300 (Data Access) at [c00000006ff82bc0]
> pc: c00000000006a204: .flush_workqueue+0x24/0xec
> lr: c0000000003848f4: .ata_port_flush_task+0x5c/0x12c
> sp: c00000006ff82e40
> msr: 8000000000009032
> dar: 10
> dsisr: 40000000
> current = 0xc000000002e3d810
> paca = 0xc000000000602700
> pid = 1, comm = swapper
> enter ? for help
> [c00000006ff82ed0] c0000000003848f4 .ata_port_flush_task+0x5c/0x12c
> [c00000006ff82f60] c000000000384c78 .ata_exec_internal+0x28c/0x458
> [c00000006ff83070] c000000000385070 .ata_dev_read_id+0x12c/0x2f8
> [c00000006ff83150] c000000000385bfc .ata_bus_probe+0x180/0x330
> [c00000006ff83210] c0000000003912ac .ata_sas_port_init+0x4c/0x6c
> [c00000006ff832a0] c0000000003675a4 .ipr_ata_slave_alloc+0x68/0xc0
> [c00000006ff83330] c000000000346750 .scsi_alloc_sdev+0x1d0/0x25c
> [c00000006ff833e0] c0000000003477c8 .scsi_probe_and_add_lun+0x110/0x2ec
> [c00000006ff834b0] c00000000034833c .__scsi_scan_target+0xd8/0x150
> [c00000006ff83560] c000000000348518 .scsi_scan_channel+0x7c/0xe0
> [c00000006ff83600] c000000000348648 .scsi_scan_host_selected+0xcc/0x13c
> [c00000006ff836a0] c00000000036e6dc .ipr_probe+0xe0/0x158
> [c00000006ff83740] c00000000024da10 .pci_call_probe+0x104/0x168
> [c00000006ff83800] c00000000024dad0 .__pci_device_probe+0x5c/0x8c
> [c00000006ff83880] c00000000024db38 .pci_device_probe+0x38/0x6c
> [c00000006ff83910] c0000000002be40c .really_probe+0x78/0x1a4
> [c00000006ff839b0] c0000000002be660 .driver_probe_device+0xfc/0x12c
> [c00000006ff83a50] c0000000002be818 .__driver_attach+0xa0/0x12c
> [c00000006ff83ae0] c0000000002bd240 .bus_for_each_dev+0x70/0xc0
> [c00000006ff83b90] c0000000002be8cc .driver_attach+0x28/0x40
> [c00000006ff83c10] c0000000002bdb7c .bus_add_driver+0x90/0x154
> [c00000006ff83cb0] c0000000002befcc .driver_register+0xa8/0xc4
> [c00000006ff83d30] c00000000024e06c .__pci_register_driver+0x88/0xc0
> [c00000006ff83db0] c0000000005c6a2c .ipr_init+0x34/0x4c
> [c00000006ff83e30] c00000000059fb20 .do_initcalls+0x9c/0x19c
> [c00000006ff83f00] c000000000009294 .init+0x94/0x1a8
> [c00000006ff83f90] c000000000025540 .kernel_thread+0x4c/0x68
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev


-- 
Brian King
eServer Storage I/O
IBM Linux Technology Center
