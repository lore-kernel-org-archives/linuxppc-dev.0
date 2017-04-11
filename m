Return-Path: <srs0=hk9k=3t=gmail.com=ianjiang.cn@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w29MD6rVHzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 12:03:36 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3w29MD66p8z8swH
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 12:03:36 +1000 (AEST)
Received: from mbob.nabble.com (mbob.nabble.com [162.253.133.15])
 by ozlabs.org (Postfix) with ESMTP id 3w29MD2jQyz9sNJ
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Apr 2017 12:03:36 +1000 (AEST)
Received: from mtom.nabble.com (unknown [162.253.133.81])
 by mbob.nabble.com (Postfix) with ESMTP id 4D7CA40E9F81
 for <linuxppc-dev@ozlabs.org>; Mon, 10 Apr 2017 19:03:01 -0700 (PDT)
Date: Mon, 10 Apr 2017 19:04:28 -0700 (MST)
From: IanJiang <ianjiang.cn@gmail.com>
To: linuxppc-dev@ozlabs.org
Message-ID: <1491876268752-121154.post@n7.nabble.com>
In-Reply-To: <20170410222442.GA11610@gwshan>
References: <1491826953201-121121.post@n7.nabble.com>
 <20170410222442.GA11610@gwshan>
Subject: Re: EEH error in doing DMA with PEX 8619
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thanks for your replay.

I fixed my test according your suggestion. The CPU physical addresses (0x
1f9e400000 and 0x 1f82c00000) converted with virt_to_phys() are used ,
instead of DMA addresses, or BUS physical addresses (0x 60a00000 and 0x
60c00000). However, EEH still reports error.

Memory info.
==========

[130508.050783] Plx8000_NT: Received PLX message ===> 
[130508.050784] Plx8000_NT: PLX_IOCTL_PHYSICAL_MEM_ALLOCATE
[130508.050785] Plx8000_NT: Attempt to allocate physical memory (1953KB)
[130508.051165] Plx8000_NT: Allocated physical memory...
[130508.051167] Plx8000_NT:     CPU Phys Addr: 1f9e400000
[130508.051168] Plx8000_NT:     Bus Phys Addr: 60a00000
[130508.051170] Plx8000_NT:     Kernel VA    : c000001f9e400000
[130508.051171] Plx8000_NT:     Size         : 1E8480h (1MB)
[130508.051173] Plx8000_NT: ...Completed message
[130508.051184] Plx8000_NT: 
[130508.051185] Plx8000_NT: Received message ===> MMAP
[130508.051187] Plx8000_NT: Mapped Phys (1f9e400000) ==> User VA
(3fff83ad0000)
[130508.051189] Plx8000_NT: ...Completed message
[130508.051196] Plx8000_NT: 
[130508.051198] Plx8000_NT: Received PLX message ===> 
[130508.051199] Plx8000_NT: PLX_IOCTL_PHYSICAL_MEM_ALLOCATE
[130508.051200] Plx8000_NT: Attempt to allocate physical memory (1953KB)
[130508.051562] Plx8000_NT: Allocated physical memory...
[130508.051564] Plx8000_NT:     CPU Phys Addr: 1f82c00000
[130508.051565] Plx8000_NT:     Bus Phys Addr: 60c00000
[130508.051566] Plx8000_NT:     Kernel VA    : c000001f82c00000
[130508.051568] Plx8000_NT:     Size         : 1E8480h (1MB)
[130508.051569] Plx8000_NT: ...Completed message
[130508.051580] Plx8000_NT: 
[130508.051581] Plx8000_NT: Received message ===> MMAP
[130508.051583] Plx8000_NT: Mapped Phys (1f82c00000) ==> User VA
(3fff838e0000)
[130508.051585] Plx8000_NT: ...Completed message
[130508.051600] Plx8000_NT: 

EEH info.
========

[130515.365924] Plx8000_DMA: Received PLX message ===> 
[130515.365972] Plx8000_DMA: PLX_IOCTL_DMA_TRANSFER_BLOCK
[130515.366033] PLX DMA[PlxDmaTransferBlock-2479]
[130515.366084] PLX DMA[PlxDmaTransferBlock-2488]
[130515.366131] PLX DMA[PlxDmaTransferBlock-2495]
[130515.366181] Plx8000_DMA: Ch 0 - DMA 0000001F_9E400000 -->
0000001F_82C00000 (65536 bytes)
[130515.366250] PLX DMA[PlxDmaTransferBlock-2503]
[130515.366296] PLX DMA[PlxDmaTransferBlock-2511]
[130515.366343] PLX DMA[PlxDmaTransferBlock-2516]
[130515.366392] PLX DMA[PlxDmaTransferBlock-2521]
[130515.366440] PLX DMA[PlxDmaTransferBlock-2532]
[130515.366487] PLX DMA[PlxDmaTransferBlock-2535]
[130515.366537] PLX DMA[PlxDmaTransferBlock-2539]
[130515.366584] PLX DMA[PlxDmaTransferBlock-2550]
[130515.366632] PLX DMA[PlxDmaTransferBlock-2557]
[130515.366681] PLX DMA[PlxDmaTransferBlock-2562]
[130515.366728] Plx8000_DMA: Start DMA transfer...
[130515.366775] PLX DMA[PlxDmaTransferBlock-2565]
[130515.366826] PLX DMA[PlxDmaTransferBlock-2569]
[130515.366868] EEH: Frozen PE#1 on PHB#1 detected
[130515.366872] EEH: PE location: Slot4, PHB location: N/A
[130515.367997] EEH: This PCI device has failed 1 times in the last hour
[130515.367997] EEH: Notify device drivers to shutdown
[130515.368006] EEH: Collect temporary log
[130515.368072] EEH: of node=0001:01:00:0
[130515.368075] EEH: PCI device/vendor: 861910b5
[130515.368077] EEH: PCI cmd/status register: 00100547
[130515.368079] EEH: Bridge secondary status: 0000
[130515.368081] EEH: Bridge control: 0002
[130515.368081] EEH: PCI-E capabilities and status follow:
[130515.368091] EEH: PCI-E 00: 0052a410 00008004 00000046 0000cc82 
[130515.368098] EEH: PCI-E 10: 00820000 00000000 00000000 00000000 
[130515.368099] EEH: PCI-E 20: 00000000 
[130515.368100] EEH: PCI-E AER capability register set follows:
[130515.368109] EEH: PCI-E AER 00: 13810001 00000000 00000000 00062030 
[130515.368116] EEH: PCI-E AER 10: 00000000 00002000 000000ff 00000000 
[130515.368122] EEH: PCI-E AER 20: 00000000 00000000 00000000 00000000 
[130515.368125] EEH: PCI-E AER 30: 00000000 0e0e0e0e 
[130515.368127] EEH: of node=0001:01:00:1
[130515.368294] Plx8000_DMA: ...Completed message
[130515.368295] PLX DMA[Dispatch_IoControl-1053]
[130515.368295] PLX DMA[Dispatch_IoControl-1061]
[130515.368297] Plx8000_DMA: 
[130515.368298] Plx8000_DMA: Received PLX message ===> 
[130515.368298] Plx8000_DMA: PLX_IOCTL_NOTIFICATION_WAIT
[130515.368299] Plx8000_DMA: Waiting for Interrupt wait object
(c000003c0705f880) to wake-up
[130515.369283] EEH: PCI device/vendor: 861910b5
[130515.369336] EEH: PCI cmd/status register: 10100546
[130515.369384] EEH: PCI-E capabilities and status follow:
[130515.369440] EEH: PCI-E 00: 0002a410 00008fe4 0020204e 0000cc82 
[130515.369506] EEH: PCI-E 10: 00820000 00000000 00000000 00000000 
[130515.369564] EEH: PCI-E 20: 00000000 
[130515.393162] EEH: PCI-E AER capability register set follows:
[130515.420590] EEH: PCI-E AER 00: 1f410001 00000000 00000000 00062030 
[130515.441475] EEH: PCI-E AER 10: 00000000 00002000 000001ff 00000000 
[130515.454700] EEH: PCI-E AER 20: 00000000 00000000 00000000 00000000 
[130515.469331] EEH: PCI-E AER 30: 00000000 00000000 
[130515.488728] EEH: of node=0001:02:01:0
[130515.502865] EEH: PCI device/vendor: 861910b5
[130515.516637] EEH: PCI cmd/status register: 00100546
[130515.536602] EEH: PCI-E capabilities and status follow:
[130515.536659] EEH: PCI-E 00: 0002a410 00008fc4 0000004e 0100cc82 
[130515.552999] EEH: PCI-E 10: 00420000 00000000 00000000 00000000 
[130515.569904] EEH: PCI-E 20: 00000000 
[130515.594771] EEH: PCI-E AER capability register set follows:
[130515.623612] EEH: PCI-E AER 00: 14810001 00000000 00000000 00062030 
[130515.646365] EEH: PCI-E AER 10: 00000000 00002000 000001ff 00000000 
[130515.675020] EEH: PCI-E AER 20: 00000000 00000000 00000000 00000000 
[130515.722944] EEH: PCI-E AER 30: 00000000 00000000 
[130515.722994] PHB3 PHB#1 Diag-data (Version: 1)
[130515.777673] brdgCtl:     00000002
[130515.837348] RootSts:     0002004f 00400000 f0820008 00100147 00002800
[130515.862070] RootErrSts:  00000000 00008000 00000000
[130515.910110] PhbSts:      0000001c00000000 0000001c00000000
[130515.927288] Lem:         0000000008000000 42498e327f502eae
0000000000000000
[130515.954319] InAErr:      0000000100000000 0000000100000000
0e0c010100000800 0000001f9e400000
[130515.987234] PE[  1] A/B: 8200802401010000 8000001f9e400000
[130516.000681] EEH: Enable I/O for affected devices
[130516.008885] EEH: Notify device drivers to resume I/O
[130516.028718] EEH: Enabled DMA for affected devices
[130516.059665] EEH: Notify device driver to resume
[130518.366890] Plx8000_DMA: Timeout waiting for interrupt
[130518.367090] Plx8000_DMA: ...Completed message




--
View this message in context: http://linuxppc.10917.n7.nabble.com/EEH-error-in-doing-DMA-with-PEX-8619-tp121121p121154.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
