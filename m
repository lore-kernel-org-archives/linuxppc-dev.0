Return-Path: <fujita.tomonori@lab.ntt.co.jp>
Date: Mon, 2 Aug 2010 20:55:03 +0900
To: subrata@linux.vnet.ibm.com
Subject: Re: 2.6.35-stable/ppc64/p7: Badness at lib/dma-debug.c:902, Call
	Trace	& Instruction Dump during boot
From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <1280746270.15317.16.camel@subratamodak.linux.ibm.com>
References: <1280746270.15317.16.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Message-Id: <20100802205404C.fujita.tomonori@lab.ntt.co.jp>
Cc: sachinp@linux.vnet.ibm.com, fujita.tomonori@lab.ntt.co.jp,
	joerg.roedel@amd.com, linux-kernel@vger.kernel.org,
	santil@us.ibm.com, Linuxppc-dev@ozlabs.org, devilbis@us.ibm.com,
	James.Bottomley@suse.de, sleddog@us.ibm.com,
	brking@linux.vnet.ibm.com, tj@kernel.org, dipraksh@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

CC'ed to dma-debug maintainer.

On Mon, 02 Aug 2010 16:21:09 +0530
Subrata Modak <subrata@linux.vnet.ibm.com> wrote:

> Hi,
> 
> On boot, Badness at lib/dma-debug.c:902, Call Trace & Instruction Dump
> are recorded at /var/log/messages:
> 
> ================================================================
> udev: starting version 151
> ses 0:8:0:0: Attached Enclosure device
> IBM eHEA ethernet device driver (Release EHEA_0105)
> mlx4_core: Mellanox ConnectX core driver v0.01 (May 1, 2007)
> mlx4_core: Initializing 0002:01:00.0
> mlx4_core 0002:01:00.0: enabling device (0140 -> 0142)
> ehea: eth0: Jumbo frames are enabled
> ehea: eth0 -> logical port id #1
> ehea: eth1: Jumbo frames are enabled
> ehea: eth1 -> logical port id #2
> mlx4_core 0002:01:00.0: Requested 17 vectors, but only 8 MSI-X vectors
> available, trying again
> mlx4_core 0002:01:00.0: DMA-API: device driver tries to sync DMA memory it has
> not allocated [device address=0x0000000060f22000] [size=4096 bytes]
> ------------[ cut here ]------------
> Badness at lib/dma-debug.c:902
> NIP: c0000000003fdfa0 LR: c0000000003fdf9c CTR: 0000000000000001
> REGS: c000000f35bfad00 TRAP: 0700   Not tainted  (2.6.35)
> MSR: 8000000000029032 <EE,ME,CE,IR,DR>  CR: 48002482  XER: 20000010
> TASK = c000000f35c08000[502] 'modprobe' THREAD: c000000f35bf8000 CPU: 8
> GPR00: c0000000003fdf9c c000000f35bfaf80 c000000001464c48 0000000000000096
> GPR04: 0000000000000001 c0000000000c19b0 0000000000000000 0000000000000002
> GPR08: 0000000000000000 c000000f35c08000 00000000000043b3 0000000000000001
> GPR12: 7669636520616464 c000000003fa5800 0000000000000000 0000000010016628
> GPR16: c000000f32a02000 c000000f32402000 c000000f33604648 c000000f35bfb1c0
> GPR20: c000000f38002120 0000000060f22000 0000000000000200 c000000001f4b000
> GPR24: 0000000000000001 0000000000000001 c000000001f47900 c000000f35bfb0b0
> GPR28: 0000000000000000 c000000f38002120 c0000000013eaea8 c000000f35bfaf80
> NIP [c0000000003fdfa0] .check_sync+0x108/0x52c
> LR [c0000000003fdf9c] .check_sync+0x104/0x52c
> Call Trace:
> [c000000f35bfaf80] [c0000000003fdf9c] .check_sync+0x104/0x52c (unreliable)
> [c000000f35bfb040] [c0000000003fe8d4] .debug_dma_sync_single_for_cpu+0x58/0x70

I guess that this driver does a partial sync with
dma_sync_single_for_* API. dma-debug can't handle it properly. It's
likely that this is a false warning.
