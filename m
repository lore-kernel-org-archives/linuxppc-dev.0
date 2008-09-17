Return-Path: <marco.stornelli@coritel.it>
Message-ID: <48D0F031.8040801@coritel.it>
Date: Wed, 17 Sep 2008 13:55:29 +0200
From: Marco Stornelli <marco.stornelli@coritel.it>
MIME-Version: 1.0
To: Caner Altinbasak <caner.altinbasak@gmail.com>
Subject: Re: spinlock problem
References: <2246c2320809170444j66aef147w638b44eb2f978410@mail.gmail.com>
In-Reply-To: <2246c2320809170444j66aef147w638b44eb2f978410@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-15
Cc: Linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

But does the test work? Maybe the kernel is configured with softlook
check (see the kernel menu under kernel hacking), try to disable it and
recompile. However there's something strange...

Caner Altinbasak ha scritto:
> Hi!
> I am using a Curtiss Wright DY4-183 board with PPC7447 CPU. I've a pci
> graphics card with a M9 GPU on it. There is a transparent bridge between the
> GPU and my PCI bus. My problem a trouble with radeon_dri driver. I want to
> run a miniglx application to see how the graphics performance is but I am
> having the following error. I think there is a problem with unhandled
> interrupts! Have an idea?
> 
> -bash-3.2# ./sample_server &
> [1] 1082
> -bash-3.2# [miniglx] probed chipset 0x4c66
> got MMIOAddress 0x1801e000 offset 67108864
> shared virtual width is 1024
> [drm] added 8192 byte SAREA at 0x61036000
> [drm] mapped SAREA 0x61036000 to 0x18026000, size 8192
> [drm] framebuffer handle = 0x80000000
> [drm] register handle = 0x70000000
> [pci] 8192 kB allocated with handle 0x62187000
> [pci] ring handle = 0x62187000
> [pci] ring read ptr handle = 0x62288000
> [pci] vertex/indirect buffers handle = 0x62289000
> [pci] GART texture map handle = 0x62489000
> Using 8 MB AGP aperture
> Using 1 MB for the ring buffhStart = 1040, hEnd = 1136, hTotal = 1312
> vStart = 769, vEnd = 772, vTotal = 800
> h_total_disp = 0x7f00a3    hsync_strt_wid = 0x8c040d
> v_total_disp = 0x2ff031f           vsync_strt_wid = 0x830300
> pixclock = 12699
> freq = 7874
> freq = 7874, PLL min = 12000, PLL max = 35000
> ref_div = 5, ref_clk = 2700, output_freq = 15748
> ref_div = 5, ref_clk = 2700, output_freq = 15748
> post div = 0x1
> fb_div = 0x1d
> ppll_div_3 = 0x1001d
> er
> Using 2 MB for BUG: soft lockup detected on CPU#0!
> NIP: 40042044 LR: 40042140 CTR: 400185B4
> REGS: 5e25bbb0 TRAP: 0901   Not tainted  (2.6.16.13.CWCEC.K)
> MSR: 00009032 <EE,ME,IR,DR>  CR: 2490C142  XER: 20000000
> TASK = 40aa78b0[1082] 'sample_server' THREAD: 5e25a000
> NIP [40042044] handle_IRQ_event+0x34/0xb8
> LR [40042140] __do_IRQ+0x78/0x1a0
> Call Trace:
> [5E25BC60] [400188A8] cw_pic_unmask_irq_183+0x118/0x138 (unreliable)
> [5E25BC80] [40042140] __do_IRQ+0x78/0x1a0
> [5E25BCB0] [4000B1E4] do_IRQ+0x44/0x88
> [5E25BCD0] [40004F1C] ret_from_except+0x0/0x14
> [5E25BD90] [40049DDC] __alloc_pages+0x70/0x2a4
> [5E25BDA0] [40042074] handle_IRQ_event+0x64/0xb8
> [5E25BDC0] [40042140] __do_IRQ+0x78/0x1a0
> [5E25BDF0] [4000B1E4] do_IRQ+0x44/0x88
> [5E25BE10] [40004F1C] ret_from_except+0x0/0x14
> [5E25BED0] [400244CC] __do_softirq+0x50/0x120
> [5E25BF00] [40024614] do_softirq+0x78/0x80
> [5E25BF10] [4002478C] irq_exit+0x60/0x78
> [5E25BF20] [4000B1E8] do_IRQ+0x48/0x88
> [5E25BF40] [40004F1C] ret_from_except+0x0/0x14
> Instruction dump:
> 9421ffe0 bf61000c 7cbf2b78 7c7b1b78 7c9d2378 90010024 80050004 74092000
> 40820010 7c0000a6 60008000 7c000124 <3bc00000> 3b800000 48000010 83ff0014
> vertex/indirect buffers
> Using 1 MB for AGP textures
> Will use back buffer at offset 0x300000
> Will use depth buffer at offset 0x600000
> Will use 56320 kb for textures at offset 0x900000
> [drm] Added 32 65536 byte vertex/indirect buffers
> [drm] dma control initialized, using IRQ 16
> [drm] Initialized kernel gart heap manager, 5111808
> color tiling disabled
> page flipping disabled
> [miniglx] Setting mode: visible 1024x768 virtual 1024x768x32
> [miniglx] Readback mode: visible 1024x768 virtual 1024x768x32
> RADEONEngineRestore
> 
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded

-- 
Marco Stornelli
Embedded Software Engineer
CoRiTeL - Consorzio di Ricerca sulle Telecomunicazioni
http://www.coritel.it

marco.stornelli@coritel.it
+39 06 72582838
