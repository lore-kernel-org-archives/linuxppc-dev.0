Return-Path: <akonovalov@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id B7600DDE30
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  4 Apr 2007 18:17:34 +1000 (EST)
Message-ID: <46135FF9.3080200@ru.mvista.com>
Date: Wed, 04 Apr 2007 12:21:13 +0400
From: Andrei Konovalov <akonovalov@ru.mvista.com>
MIME-Version: 1.0
To: Leonid <Leonid@a-k-a.net>
Subject: Re: Linux w/ML403 PLB TEMAC
References: <OFA8757C72.4AE0CD07-ON05257280.0056E088-85257280.0059154B@ct.wec.com>
	<406A31B117F2734987636D6CCC93EE3CB0594B@ehost011-3.exch011.intermedia.net>
In-Reply-To: <406A31B117F2734987636D6CCC93EE3CB0594B@ehost011-3.exch011.intermedia.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Leonid,

Please note that the 20060309 patch (i.e. of March 9, 2006)
is for v2.x of PLB TEMAC; the one using SGDMA version 2 IOW.
The most recent v3.xx PLB TEMAC IP from EDK 8.2.02 uses SGDMA version 3.
Guess this is what made the kernel to crash when Glenn tried
the new design with the PLB TEMAC (step 3 in his email below).

The step 5 problem was probably due to XC4VFX12 engineering
samples (all ML403 use the engineering samples AFAIK)
could not work with HARD TEMAC IP version 3.00.b. For ML403 one need
to set the HARD TEMAC IP version to 3.00.a in xps. Then
TEMAC should work OK.


Thanks,
Andrei


Leonid wrote:
> Is Paulus' patch http://source.mvista.com/~ank/paulus-powerpc/20060309/
> for TEMAC the best one or somebody has better suggestion?
> 
> Thanks,
> 
> Leonid. 
> 
> -----Original Message-----
> From: linuxppc-embedded-bounces+leonid=a-k-a.net@ozlabs.org
> [mailto:linuxppc-embedded-bounces+leonid=a-k-a.net@ozlabs.org] On Behalf
> Of Glenn.G.Hart@us.westinghouse.com
> Sent: Monday, February 12, 2007 8:13 AM
> To: linuxppc-embedded@ozlabs.org
> Subject: Linux w/ML403 PLB TEMAC
> 
> I am trying to get Linux up on my ML403 board with the PLB TEMAC with
> SGDMA.  I am almost there and am not sure where to go now.  I have seen
> many posts on this from Robert, Ming, and Rick.  Hopefully somebody know
> the answer.  Since I am going to detail how I got to where I am it can
> be
> somewhat of a guide for others (unless I am doing something really
> wrong).
> 
> 1.  I started with Linux 2.6.19 from kernel.org.  I copied over the
> xparameters_ml40x.h file to xparameters_ml403.h in
> arch/ppc/platforms/4xx/xparameters.  Setting up my kernel configuration
> and
> downloading to the board everything worked OK.  ** I did not have the
> TEMAC
> configured or as part of my PPC project.
> 
> 2.  Next I created a new PPC with the PLB TEMAC and applied all four
> kernel
> patches from PAULUS
> (http://source.mvista.com/~ank/paulus-powerpc/20060309/).  A couple of
> the
> files did not patch completely, so I had to do it by hand.  Recompiling
> the
> kernel (with the TEMAC configured to on) I now had network support.
> 
> 3.  The speed of the network was very poor.  I wanted to implement DMA
> for
> the TEMAC.  I created a new PPC with BSB using DMA on the TEMAC.  Kernel
> recompilied without a problem, but upon starting the kernel I got:
> [    3.813223] Oops: machine check, sig: 7 [#1]
> [    3.864368] NIP: C00E7B08 LR: C00E1640 CTR: 00000000
> [    3.923854] REGS: c01c4f50 TRAP: 0202   Not tainted  (2.6.19)
> [    3.992778] MSR: 00029030 <EE,ME,IR,DR>  CR: 88000028  XER: 20000000
> [    4.069670] TASK = c052ab70[1] 'swapper' THREAD: c052e000
> [    4.132247] GPR00: C00E1640 C052FE10 C052AB70 00000000 00000068
> C5002200
> C04A242C 00000001
> [    4.233281] GPR08: 00000000 C04A2304 C5002010 11111111 28000028
> FFFFCD64
> FFFF0000 FFFF0000
> [    4.334318] GPR16: 0B6654D8 FFFF0000 FFFF0000 FFFF0000 FFFF0000
> FFFF0000
> FFFF0000 FFFF0000
> [    4.435353] GPR24: C017E890 00000000 C04A22D8 C017EA00 C017E9C8
> C017E888
> C04A2260 C04A22D8
> [    4.538579] NIP [C00E7B08] XPacketFifoV200a_Initialize+0x74/0x7c
> [    4.610762] LR [C00E1640] XTemac_ConfigureFifoAccess+0x28/0x9c
> [    4.680752] Call Trace:
> [    4.710037] [C052FE10] [C000ADD8] __ioremap+0xe8/0x14c (unreliable)
> [    4.785448] [C052FE20] [C00E1640]
> XTemac_ConfigureFifoAccess+0x28/0x9c
> [    4.863880] [C052FE30] [C00DFCF8] Initialize+0x3c/0xd0
> [    4.925647] [C052FE40] [C00DF354] xtenet_probe+0x14c/0x5fc
> [    4.991581] [C052FEB0] [C00D6B38] really_probe+0x84/0x154
> [    5.056472] [C052FED0] [C00D6D04] driver_probe_device+0xdc/0xfc
> [    5.127613] [C052FEF0] [C00D6E68] __driver_attach+0x88/0xf4
> [    5.194588] [C052FF10] [C00D5CC0] bus_for_each_dev+0x54/0x94
> [    5.262604] [C052FF40] [C00D6EF8] driver_attach+0x24/0x34
> [    5.327496] [C052FF50] [C00D63E8] bus_add_driver+0x68/0x1b8
> [    5.394471] [C052FF70] [C00D744C] driver_register+0x98/0xac
> [    5.461446] [C052FF80] [C01BBC00] xtenet_init+0x18/0x28
> [    5.524358] [C052FF90] [C0002454] init+0xb0/0x288
> [    5.580917] [C052FFF0] [C0004EA0] kernel_thread+0x44/0x60
> [    5.645794] Instruction dump:
> [    5.681427] 38000000 901f3694 91690004 90a90008 91490000 3800000a
> 7c0004ac 900a0000
> [    5.775062] 80010014 38600000 83e1000c 7c0803a6 <38210010> 4e800020
> 2c030000 7c0802a6
> [    5.875957] Kernel panic - not syncing: Attempted to kill init!
> 
> Going back through previous posts I found that I need to upgrade the
> kernel
> driver for the DMA and TEMAC to V3.
> 
> 4.  From EDK 8.2.02i  SP2.4+0 I copied the files from the BSP to the
> kernel
> using the following steps.
>       a.  Copied the files from linux\drivers\net\xilinx_temac of the
> BSP
> to drivers/net/xilinx_temac of the kernel preserving the Makefile from
> the
> kernel.
>       b.  To adapter.c I remove the #include xilinx_devices.h and added
> #include linux/platform_devices.h and #include platforms/4xx/virtex.h
>       c.  To adapter.c I changed all instances of CHECKSUM_HW to
> CHECKSUM_PARTIAL
>       d.  To the Makefile in linux/drivers/net/xilinux_temac I added
> xtemac_stats.o
>       e.  I removed the #include xparameters.h from xtemac.h
> 
>       f.  Copied the files from linux\drivers\xilinx_common of the BSP
> to
> drivers/xilinx_edk of the kernel.
>       g.  In the drivers/xililnx_edk Makefile I removed the line
> containing
> xdma_channel.o xdma_channel_sg.o
>       h.  In the drivers/xililnx_edk Makefile I commented out the line
> with
> xlinx_syms.o
> 
> 5.  Recompiled the kernel I everything was OK.  Starting the kernel
> everything looked OK:
> [    3.758994] XTemac: using sgDMA mode.
> [    3.803211] XTemac: using TxDRE mode
> [    3.846160] XTemac: using RxDRE mode
> [    3.889186] XTemac: buffer descriptor size: 32768 (0x8000)
> [    3.956476] XTemac: (buffer_descriptor_init) phy: 0x4a8000, virt:
> 0xff100000, size: 0x8000
> [    4.069678] eth0: Xilinx TEMAC #0 at 0x81200000 mapped to 0xC5000000,
> irq=0
> [    4.153560] eth0: XTemac id 1.0f, block id 5, type 8
> 
> 6.  I am using busybox 1.2.1 which worked fine previously configuring
> the
> network.  Now when I execute ifconfig I get the following problem:
> [   12.228721] eth0: XTemac: Options: 0xb8f2
> [   24.197749] eth0: XTemac: Not able to set the speed to 1000 (status:
> 0x148)
> [   34.215593] eth0: XTemac: Not able to set the speed to 100 (status:
> 0x148)
> [   44.232349] eth0: XTemac: Not able to set the speed to 10 (status:
> 0x148)
> [   44.313727] eth0: XTemac: could not negotiate speed
> [   44.372226] eth0: XTemac: Send Threshold = 16, Receive Threshold = 2
> [   44.448421] eth0: XTemac: Send Wait bound = 1, Receive Wait bound = 1
> # [   57.180152] eth0: XTemac: PHY Link carrier lost.
> 
> Anybody have an suggestions?
> 
> Thanks,
> Glenn
> 
> 
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
