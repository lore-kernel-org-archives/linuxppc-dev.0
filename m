Return-Path: <msalter@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A22F81A07D8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2015 01:03:22 +1100 (AEDT)
Message-ID: <1447855399.3974.24.camel@redhat.com>
Subject: Re: kernel BUG at drivers/scsi/scsi_lib.c:1096!
From: Mark Salter <msalter@redhat.com>
To: Michael Ellerman <mpe@ellerman.id.au>, "James E. J. Bottomley"
 <JBottomley@odin.com>, brking <brking@us.ibm.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Date: Wed, 18 Nov 2015 09:03:19 -0500
In-Reply-To: <1447838334.1564.2.camel@ellerman.id.au>
References: <1447838334.1564.2.camel@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-11-18 at 20:18 +1100, Michael Ellerman wrote:
> Hi folks,
> 
> I'm intermittently seeing the following oops on at least one powerpc box.
> 
> The BUG_ON() is from:
> 
> static int scsi_init_sgtable(struct request *req, struct scsi_data_buffer *sdb)
> {
> 	...
> 	count = blk_rq_map_sg(req->q, req, sdb->table.sgl);
> 	BUG_ON(count > sdb->table.nents);
> 
> Looking at the dump it looks like count was 2, I can't work out what nents was.
> 
> The machine's just a fairly boring bare metal setup, with a single IPR adapter:
> 
> 0001:08:00.0 RAID bus controller: IBM PCI-E IPR SAS Adapter (ASIC) (rev 02)
> 	Subsystem: IBM PCIe3 x8 SAS RAID Internal Adapter 6Gb (57D7)
> 	Flags: bus master, fast devsel, latency 0
> 	Kernel driver in use: ipr
> 
> 
> Anyone seen it before or have any ideas?

I'm also seeing it on arm64 in 4.4-rc1

[    6.859003] Call trace:                                                                      
[    6.861439] [<fffffe000074345c>] scsi_init_sgtable+0x84/0x88                                 
[    6.867072] [<fffffe00007434ac>] scsi_init_io+0x4c/0x1ac                                     
[    6.872358] [<fffffe000075004c>] sd_setup_read_write_cmnd+0x44/0x844                         
[    6.878682] [<fffffe0000750884>] sd_init_command+0x38/0xb0                                   
[    6.884141] [<fffffe00007436e4>] scsi_setup_cmnd+0xd8/0x13c                                  
[    6.889686] [<fffffe000074397c>] scsi_prep_fn+0xc0/0x140                                     
[    6.894973] [<fffffe00003bd0cc>] blk_peek_request+0x148/0x24c                                
[    6.900692] [<fffffe0000744754>] scsi_request_fn+0x58/0x648                                  
[    6.906237] [<fffffe00003b8e80>] __blk_run_queue+0x40/0x58                                   
[    6.911696] [<fffffe00003b91a4>] blk_run_queue+0x30/0x48                                     
[    6.916983] [<fffffe00007422e4>] scsi_run_queue+0x204/0x294                                  
[    6.922528] [<fffffe000074321c>] scsi_end_request+0x13c/0x1a0                                
[    6.928247] [<fffffe0000744ef4>] scsi_io_completion+0xf0/0x564                               
[    6.934052] [<fffffe000073beb0>] scsi_finish_command+0xe4/0x144                              
[    6.939943] [<fffffe00007446cc>] scsi_softirq_done+0x148/0x178                               
[    6.945748] [<fffffe00003c39a4>] blk_done_softirq+0x7c/0x94                                  
[    6.951295] [<fffffe00000c8f44>] __do_softirq+0x114/0x2a0                                    
[    6.956667] [<fffffe00000c9340>] irq_exit+0x8c/0xe4                                          
[    6.961522] [<fffffe000009cf00>] handle_IPI+0x170/0x228                                      
[    6.966721] [<fffffe00000904e0>] gic_handle_irq+0xa0/0xb8                                    
[    6.972093] Exception stack(0xfffffe03dc143de0 to 0xfffffe03dc143f00)                        

> 
> cheers
> 
> 
> systemd[1]: Starting Uncomplicated firewall...
>          Starting Uncomplicated firewall...
> ------------[ cut here ]------------
> kernel BUG at drivers/scsi/scsi_lib.c:1096!
> Oops: Exception in kernel mode, sig: 5 [#1]
> SMP NR_CPUS=2048 NUMA PowerNV
> Modules linked in:
> CPU: 132 PID: 2699 Comm: kworker/132:1H Not tainted 4.4.0-rc1-54939-ge22a248-dirty #77
> Workqueue: kblockd cfq_kick_queue
> task: c000000fef147400 ti: c000000feb384000 task.ti: c000000feb384000
> NIP: c0000000005ab4a8 LR: c0000000005ab490 CTR: 0000000000000000
> REGS: c000000feb387620 TRAP: 0700   Not tainted  (4.4.0-rc1-54939-ge22a248-dirty)
> MSR: 9000000100029033 <SF,HV,EE,ME,IR,DR,RI,LE>  CR: 24002228  XER: 00000000
> CFAR: c000000000464950 SOFTE: 0 
> GPR00: c0000000005ab490 c000000feb3878a0 c000000000d77d00 0000000000000002 
> GPR04: c000000ff2030158 c000000ff47a0c00 0000000000000000 0000000000001000 
> GPR08: 0000000000000000 0000000000000001 0000000000000000 fffffffffffffff7 
> GPR12: 0000000000002200 c00000000fde5200 c0000000000c8098 c000000000b39858 
> GPR16: c000000000ae12c8 c000000000b39948 0000000000000000 0000000000000000 
> GPR20: c0000000005ab9c0 c0000017f5800144 0000000000000000 c000001e551a6850 
> GPR24: c0000017f5800140 c0000007efb9c800 0000000000000000 c000001e551a6800 
> GPR28: 0000000000000000 0000000000000000 c000000ff2030158 c000000feb420240 
> NIP [c0000000005ab4a8] scsi_init_sgtable+0xa8/0x180
> LR [c0000000005ab490] scsi_init_sgtable+0x90/0x180
> Call Trace:
> [c000000feb3878a0] [c0000000005ab490] scsi_init_sgtable+0x90/0x180 (unreliable)
> [c000000feb3878e0] [c0000000005ab5d4] scsi_init_io+0x54/0x160
> [c000000feb387930] [c0000000005fb43c] sd_init_command+0x6c/0xb00
> [c000000feb3879f0] [c0000000005ac2f8] scsi_setup_cmnd+0x108/0x1a0
> [c000000feb387a30] [c0000000005ac594] scsi_prep_fn+0x104/0x1c0
> [c000000feb387a70] [c00000000045d85c] blk_peek_request+0x20c/0x390
> [c000000feb387af0] [c0000000005ad6a8] scsi_request_fn+0xb8/0x7f0
> [c000000feb387bf0] [c0000000004583b4] __blk_run_queue+0x54/0x80
> [c000000feb387c20] [c00000000047e178] cfq_kick_queue+0x38/0xc0
> [c000000feb387c50] [c0000000000c00cc] process_one_work+0x2ac/0x560
> [c000000feb387ce0] [c0000000000c0510] worker_thread+0x190/0x660
> [c000000feb387d80] [c0000000000c8198] kthread+0x108/0x130
> [c000000feb387e30] [c0000000000095b0] ret_from_kernel_thread+0x5c/0xac
> Instruction dump:
> 2fa30000 409e00e4 e8bf0000 e87e0030 7fc4f378 4beb91ed 60000000 813f0008 
> 78630020 7f891840 7d301026 5529effe <0b090000> 907f0008 38600000 813e005c 
> ---[ end trace 3ea632a512ff48d5 ]---
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
