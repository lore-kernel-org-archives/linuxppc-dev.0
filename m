Return-Path: <wangkefeng.wang@huawei.com>
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [119.145.14.65])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s7JdK1rXmzDqZ5
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Aug 2016 23:47:48 +1000 (AEST)
Subject: Re: Problem booting Kernel 4.8-rc1 on Sam460ex ( Canyonlands)
To: Julian Margetson <runaway@candw.ms>, <linuxppc-dev@lists.ozlabs.org>
References: <ce142972-52a8-452f-8911-70af927ae425@candw.ms>
 <a9fe88f0-14ba-7ca6-66b4-69b84fa8a823@huawei.com>
 <d5280537-e579-0ee6-9011-f2fa6157204c@candw.ms>
CC: <mpe@ellerman.id.au>, <imunsie@au1.ibm.com>, <benh@kernel.crashing.org>,
 Rob Herring <robh+dt@kernel.org>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <5194d5e9-0c2a-004b-f295-b34ece0d9004@huawei.com>
Date: Mon, 8 Aug 2016 21:39:36 +0800
MIME-Version: 1.0
In-Reply-To: <d5280537-e579-0ee6-9011-f2fa6157204c@candw.ms>
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

+cc Rob

On 2016/8/8 20:51, Julian Margetson wrote:
> On 8/8/2016 8:22 AM, Kefeng Wang wrote:
>> On 2016/8/8 19:52, Julian Margetson wrote:
>>> Problem booting Kernel 4.8-rc1 on Sam460ex ( Canyonlands) machine .
>>>
>>> This is what I get with the bisect.
>> Hi Julian
>>
>> I have no Sam460ex machine, could you show the good and bad kernel bootlog?

I have no experience about PowerPC, the status shows below,
version			boot
v4.7			ok
v4.8-rc1		fail
v4.7 + this patch  	fail(right?)

Does PowerPC support earlyprintk/earlycon? Please set it, and let's show somethings from earlyprintk.



>>
>> Thanks,
>> Kefeng
>>
>>> Regards
>>>
>>> Julian
>>>
>>>
>>> 44a7185c2ae6383c88ff5b1ef2e2969f35d7b8b7 is the first bad commit
>>> commit 44a7185c2ae6383c88ff5b1ef2e2969f35d7b8b7
>>> Author: Kefeng Wang <wangkefeng.wang@huawei.com>
>>> Date:   Wed Jun 1 14:52:54 2016 +0800
>>>
>>>      of/platform: Add common method to populate default bus
>>>
>>>      The arch code calls of_platform_populate() with default match table
>>>      when it wants to populate default bus.
>>>
>>>      This patch introduce a new of_platform_default_populate_init() and make it
>>>      arch_initcall_sync(it should be later than some iommu configration, eg,
>>>      of_iommu_init() and swiotlb_late_init in arm64), then we can finish above
>>>      job in common method.
>>>
>>>      In order to avoid the default bus being populated twice, simply checking
>>>      the flag of bus node whether has be set OF_POPULATED_BUS or not.
>>>
>>>      After that, we can safely remove the caller in arch code.
>>>
>>>      Btw, add debug print in of_platform_populate(), and use __func__ to
>>>      print function's name of of_platform_bus_create().
>>>
>>>      Cc: Rob Herring <robh+dt@kernel.org>
>>>      Cc: Frank Rowand <frowand.list@gmail.com>
>>>      Cc: Grant Likely <grant.likely@linaro.org>
>>>      Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>>>      Signed-off-by: Rob Herring <robh@kernel.org>
>>>
>>> :040000 040000 2d2438c33110bd5d0cba9540357c7e81f74485dd 3ad033aad77298c3a6f50ed4c651d7336825d700 M    drivers
>>> root@julian-VirtualBox:/usr/src/linux-test#
>>>
>>>
>>> git bisect log
>>> git bisect start
>>> # good: [523d939ef98fd712632d93a5a2b588e477a7565e] Linux 4.7
>>> git bisect good 523d939ef98fd712632d93a5a2b588e477a7565e
>>> # bad: [29b4817d4018df78086157ea3a55c1d9424a7cfc] Linux 4.8-rc1
>>> git bisect bad 29b4817d4018df78086157ea3a55c1d9424a7cfc
>>> # good: [1c88e19b0f6a8471ee50d5062721ba30b8fd4ba9] Merge branch 'akpm' (patches from Andrew)
>>> git bisect good 1c88e19b0f6a8471ee50d5062721ba30b8fd4ba9
>>> # bad: [77a87824ed676ca8ff8482e4157d3adb284fd381] clocksource/drivers/clps_711x: fixup for "ARM: clps711x:
>>> git bisect bad 77a87824ed676ca8ff8482e4157d3adb284fd381
>>> # bad: [c9b95e5961c0294e0efffeaa847c1a1e6369204c] Merge tag 'sound-4.8-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound
>>> git bisect bad c9b95e5961c0294e0efffeaa847c1a1e6369204c
>>> # good: [1056c9bd2702ea1bb79abf9bd1e78c578589d247] Merge tag 'clk-for-linus-4.8' of git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux
>>> git bisect good 1056c9bd2702ea1bb79abf9bd1e78c578589d247
>>> # bad: [bad60e6f259a01cf9f29a1ef8d435ab6c60b2de9] Merge tag 'powerpc-4.8-1' of git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux
>>> git bisect bad bad60e6f259a01cf9f29a1ef8d435ab6c60b2de9
>>> # bad: [bad60e6f259a01cf9f29a1ef8d435ab6c60b2de9] Merge tag 'powerpc-4.8-1' of git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux
>>> git bisect bad bad60e6f259a01cf9f29a1ef8d435ab6c60b2de9
>>> # good: [f7b9ebb79e90b19bf6a2cb805a536258437fc3fa] powerpc: Re-order setup_panic()
>>> git bisect good f7b9ebb79e90b19bf6a2cb805a536258437fc3fa
>>> # good: [f7b9ebb79e90b19bf6a2cb805a536258437fc3fa] powerpc: Re-order setup_panic()
>>> git bisect good f7b9ebb79e90b19bf6a2cb805a536258437fc3fa
>>> # good: [944171cbf499d3445c749f7c13c46de0a564a905] pNFS: Actively set attributes as invalid if LAYOUTCOMMIT is outstanding
>>> git bisect good 944171cbf499d3445c749f7c13c46de0a564a905
>>> # bad: [b325e04ea21081439f0f3e7fe1117e883a9031d8] Merge branch 'x86-cpu-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
>>> git bisect bad b325e04ea21081439f0f3e7fe1117e883a9031d8
>>> # bad: [b325e04ea21081439f0f3e7fe1117e883a9031d8] Merge branch 'x86-cpu-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
>>> git bisect bad b325e04ea21081439f0f3e7fe1117e883a9031d8
>>> # bad: [0e13f99d3a4816a3996a69721388b4cf1a982cf8] Documentation: dt: i2c: use correct STMicroelectronics vendor prefix
>>> git bisect bad 0e13f99d3a4816a3996a69721388b4cf1a982cf8
>>> # bad: [1a1d2f9968660e016883b21c499158c08d9c87bf] mips: use of_platform_default_populate() to populate default bus
>>> git bisect bad 1a1d2f9968660e016883b21c499158c08d9c87bf
>>> # bad: [db41252cf8b58c8a57226204e113b9dffaebf693] cris: Remove unnecessary of_platform_populate with default match table
>>> git bisect bad db41252cf8b58c8a57226204e113b9dffaebf693
>>> # bad: [61c78644e7f1bd9445b3d7ddc3d35989a38985ee] arc: Remove unnecessary of_platform_populate with default match table
>>> git bisect bad 61c78644e7f1bd9445b3d7ddc3d35989a38985ee
>>> # bad: [44a7185c2ae6383c88ff5b1ef2e2969f35d7b8b7] of/platform: Add common method to populate default bus
>>> git bisect bad 44a7185c2ae6383c88ff5b1ef2e2969f35d7b8b7
>>> # good: [bb8e15d60462a84a25a3bf33e8bc29b46c6d470a] of: iommu: make of_iommu_init() postcore_initcall_sync
>>> git bisect good bb8e15d60462a84a25a3bf33e8bc29b46c6d470a
>>> # first bad commit: [44a7185c2ae6383c88ff5b1ef2e2969f35d7b8b7] of/platform: Add common method to populate default bus
>>>
>>>
>>>
>>>
>>> .
>>>
>>
>>
> 
> On all Bad Boots no output after Loading  Device tree Uboot message :
> 
> Loading  Device tree  to 00ffa00,  end 00fffb18  ... OK .
> 
> 
> Good boot below. The m41t80 issue is from kernel 4.7.0
> 
> ==========================================================================================================
> 
> =~=~=~=~=~=~=~=~=~=~=~= PuTTY log 2016.08.08 06:03:22 =~=~=~=~=~=~=~=~=~=~=~=
> [    0.000000] Using Canyonlands machine description
> [    0.000000] Linux version 4.7.0-sam460ex-jm-06197-g1c88e19-dirty (root@julian-VirtualBox) (gcc version 5.4.0 20160609 (Ubuntu 5.4.0-6ubuntu1~16.04.1) ) #1 PREEMPT Mon Aug 8 05:57:08 AST 2016
> [    0.000000] Zone ranges:
> [    0.000000]   DMA      [mem 0x0000000000000000-0x000000002fffffff]
> [    0.000000]   Normal   empty
> [    0.000000]   HighMem  [mem 0x0000000030000000-0x000000007fffffff]
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000000000000-0x000000007fffffff]
> [    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x000000007fffffff]
> [    0.000000] MMU: Allocated 1088 bytes of context maps for 255 contexts
> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 522752
> [    0.000000] Kernel command line: root=/dev/sda6 console=ttyS0,115200 console=tty0 fb=false
> [    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
> [    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
> [    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
> [    0.000000] Sorting __ex_table...
> [    0.000000] allocated 2097152 bytes of page_ext
> [    0.000000] Memory: 1997324K/2097152K available (7964K kernel code, 340K rwdata, 4464K rodata, 260K init, 1412K bss, 99828K reserved, 0K cma-reserved, 1310720K highmem)
> [    0.000000] Kernel virtual memory layout:
> [    0.000000]   * 0xfffcf000..0xfffff000  : fixmap
> [    0.000000]   * 0xffc00000..0xffe00000  : highmem PTEs
> [    0.000000]   * 0xffa00000..0xffc00000  : consistent mem
> [    0.000000]   * 0xffa00000..0xffa00000  : early ioremap
> [    0.000000]   * 0xf1000000..0xffa00000  : vmalloc & ioremap
> [    0.000000] SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
> [    0.000000] Preemptible hierarchical RCU implementation.
> [    0.000000] Build-time adjustment of leaf fanout to 32.
> [    0.000000] NR_IRQS:512 nr_irqs:512 16
> [    0.000000] UIC0 (32 IRQ sources) at DCR 0xc0
> [    0.000000] UIC1 (32 IRQ sources) at DCR 0xd0
> [    0.000000] UIC2 (32 IRQ sources) at DCR 0xe0
> [    0.000000] UIC3 (32 IRQ sources) at DCR 0xf0
> [    0.000014] clocksource: timebase: mask: 0xffffffffffffffff max_cycles: 0x10a60dda894, max_idle_ns: 440795207041 ns
> [    0.000027] clocksource: timebase mult[dda520] shift[24] registered
> [    0.000160] Console: colour dummy device 80x25
> [    0.000731] console [tty0] enabled
> [    0.000772] pid_max: default: 32768 minimum: 301
> [    0.000900] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
> [    0.000929] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
> [    0.003844] devtmpfs: initialized
> [    0.007485] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
> [    0.007702] xor: measuring software checksum speed
> [    0.017654]    8regs     :   900.000 MB/sec
> [    0.027471]    8regs_prefetch:   800.000 MB/sec
> [    0.037528]    32regs    :  1232.000 MB/sec
> [    0.047601]    32regs_prefetch:  1052.000 MB/sec
> [    0.047637] xor: using function: 32regs (1232.000 MB/sec)
> [    0.047664] prandom: seed boundary self test passed
> [    0.049723] prandom: 100 self tests passed
> [    0.050388] NET: Registered protocol family 16
> [    0.055897] cpuidle: using governor ladder
> [    0.058906] cpuidle: using governor menu
> [    0.059331] 256k L2-cache enabled
> [    0.059449] PCIE0: Checking link...
> [    0.059467] PCIE0: Device detected, waiting for link...
> [    0.059486] PCIE0: link is up !
> [    0.162817] PCI host bridge /plb/pciex@d00000000 (primary) ranges:
> [    0.162868]  MEM 0x0000000e00000000..0x0000000e7fffffff -> 0x0000000080000000
> [    0.162904]  MEM 0x0000000f00000000..0x0000000f000fffff -> 0x0000000000000000
> [    0.162936]   IO 0x0000000f80000000..0x0000000f8000ffff -> 0x0000000000000000
> [    0.162973] 4xx PCI DMA offset set to 0x00000000
> [    0.162991] 4xx PCI DMA window base to 0x0000000000000000
> [    0.163010] DMA window size 0x0000000080000000
> e000ff]   390]_bus1:80ot besour[mem8000-0xefffffus ass [00000xffff27]bus :80:t busourmem 001000xf0fff]s adds [00000000ff])
>  0.23] pcus 080: r b8-0xffff])    0756i_bu02:ootreso [mec0ee0-0xffffbus aess 000000x00ff])
>    0602] _bus2:0ot besou[bus ff]
>   0.53] 0000:00.R 13:sigio  fc100xffff]
> [ 0.26] p000:40.0: 13: igneo  0c1]00:42.0: 1: asned  0xff000fc10
> [ 2887pci :42:0: BA assid [ixfffc0-0x109f]    8782]i 001:00PCI bge tus 42[   88806ci 41:0   be wi [ifffc-0xfff]
>    0838 0000:00CI bre tos 41-
> [ .28dgow [0xfff00-0c1fff[   88960ci 080: BAR asd [mxe80000-0xffff4bit f]
> [ 0.28] pc001:0.0:  14:igneem 0x000xe90ff]
>   0.74] p000100.0:R 1siio  fe10xffff]
> [ 0.286] p001:80.0: 0000e8fff 64bpref    09147i 0001:00.BAR ssign[mem9000-0xffffit]
>   0.86] p000100.0:R 6:ignedem 0x04000xe90ff pr
> [ .2892 pci 1:81:1: B: assed [m0xe90000-0063f64bi[   89258ci 081:00 BARassig [io fffe-0xff0ff]
>  :0CI bre tos 81-
> [  .2893 pci1:80:0:   dge ow [0xff00-0xe1ff[    8933ci 0080:00 be win [meme9000-0xeffff[    89360ci 080:00   e wi [meme8000-0xeffffbit ]
> [0.0: ned  0xd8000083fff]
> [0.289] pc02:0.0: B1: aned  0xd0000-841f]
> [ 0.28] pci02:.0: 6: aned  0xd800008427 pre[    8954ci 0000:0 BAR assi [memd8420-0xd801f[    89575ci 000:04 BARassig  000:04.0AR 0signeio  010-07]
> [ 0.286] pc002:4.0:  2: gned   0x-0x10
> [  .2896 pci2:000: : assed [0x102x102[   89678ci 000:0 BAR assi [io1024-027]
>    0030] d6: 2x1  ()   MB/s    01223 M[    9823aid6:t32xen() 90 M
> [   41538raidnt32xxor()236
> [  .432 raidint3 gen( 433 s
> [ 0.44] rai int  xo  25/s
> [ 0.42] ra: int8  g   27B/s
>   0.43] r6: ix8  x)   2MB/s   0868]d6: ug algthm 2: uintxcoverlgori
> [ .4844 vga deviaddedCI:081:00decodio+mwns=n,locone
>   006] rb: led
>  0.481] vgb: be conl pole 0081:0
> [   4849SCSI sysfacves
> 0.4] ue:terw iaceer [  864sbcreged eviive
> [.487 pe: PPS veregd
> 0.4] pre:war. 5- Cght-20doomegiom@lt> 0.2]l0  07nceux Arctuivetia.
> 0.4] clourwitto souime
> [ 491FS-C: L
> [.49 Calesded  014] Rered ocoily   168P eis[ 118CP hasle es: 8 (or 5, 140 )
> [ 0.51] TCash tes cgurestabed 8bind2)
> [ 0.515] Uash te ens: 51orde, 245bytes[   12372DP-Lhash le ees: (orde2, 2 byte
> [ 0.513] RPegistd namUNIXket tsportdule.    3790]C: Rteredp trort le.
>   0.08] R Regired trat mod.
> [0.513] RPCegisd tcpSv4.1ckchl traort le.
>   0.20] Cd notmap
> [  .517 dw_ 4bff00.dDesigr256 er: 168 bs)
>  0.525] wngseimes_bits maxer=1cker=0   353]d: ld
> [ 0.54] ntfdriv.1.3lagsW].
>   0.591]  initPI von 7.
> [  .555 asynx: anitiaed (ac)
> 55locker SCgener(bsgiver sion load(maj49)
>   0.520] chedu noopgist
> [  .5560 ioduleadliegistd
> [0.556] ioedulfq rteredefau
> [  55865crc3RC_LETS = CRC_BITS 4
> [0.558] 799c
> [ 0.55] cr: CRC_BIT64
> [ 0.557] cc: setestssed,oces22594ytes49488sec
>   0.03] c2_coe: 83selts pd
> [ 0.69] cr_comb: 837elf s pas
> [ .6981 glo4 selestssed, aile    09523]nirqttingiggerde 3 irq f prof 000:00cie0aileth er -22   0.974] epor00:40.0: alingE thh PCIME irupt
>    0013 000:00.ignal PMEough e PMterru
> [  70003pci :42:0: Siing Pthng trer m3 forq 46led_set_type0/0x
> [  .700 pciee: p of 0:80::pcie failwithor -2[   19875erial250/0 dri, 2 s, Iharinable[  22436onsottyS0isab
> [  84298seri50.0yS0 MIO 0f600(irq 9nsoletyS0]able    434rial.0: t1 atO 0x40040rq =  baseud =200) a U650A
>   2.008] ole [S0] dbled   2.679]60030eriatyS0 MMIOef600 (i23, _baud69120is a50
> [ 3.27] cole [0]  t MMx4ef600 (= 24,se_b= 69) is 6550
> [    354312PAPRervisbytennelver
> [    5946enerion-vile mry dr v1.[    3.265053]drm]tiali drm.0 20810
> [   70079drm] eon el mdrtialig ke modeting RDE 02:0xF 0x:0x770x00[    3.84957drm]isteio b 0xe90000
>    3.732]m] reter m si62144
> [    3.626063] ATOM BIOS: C44501
> [    3.629353] radeon 0001:81:00.0: VRAM: 1024M 0x0000000000000000 - 0x000000003FFFFFFF (1024M used)
> [    3.638286] radeon 0001:81:00.0: GTT: 2048M 0x0000000040000000 - 0x00000000BFFFFFFF
> [    3.645978] [drm] Detected VRAM RAM=1024M, BAR=256M
> [    3.650880] [drm] RAM width 128bits DDR
> [    3.654926] [TTM] Zone  kernel: Available graphics memory: 376788 kiB
> [    3.661421] [TTM] Zone highmem: Available graphics memory: 1032148 kiB
> [    3.667982] [TTM] Initializing pool allocator
> [    3.672388] [TTM] Initializing DMA pool allocator
> [    3.677219] [drm] radeon: 1024M of VRAM memory ready
> [    3.682226] [drm] radeon: 2048M of GTT memory ready.
> [    3.687269] [drm] Loading verde Microcode
> [    3.691341] [drm] Internal thermal controller with fan control
> [    3.697541] [drm] probing gen 2 caps for device aaa1:bed1 = 18cc41/0
> [    3.746630] [drm] radeon: dpm initialized
> [    3.753028] [drm] Found VCE firmware/feedback version 50.0.1 / 17!
> [    3.759293] [drm] GART: num cpu pages 524288, num gpu pages 524288
> [    3.775858] [drm] probing gen 2 caps for device aaa1:bed1 = 18cc41/0
> [    3.836592] [drm] PCIE GART of 2048M enabled (table at 0x00000000001D6000).
> [    3.843945] radeon 0001:81:00.0: WB enabled
> [    3.848184] radeon 0001:81:00.0: fence driver on ring 0 use gpu addr 0x0000000040000c00 and cpu addr 0xffc01c00
> [    3.858313] radeon 0001:81:00.0: fence driver on ring 1 use gpu addr 0x0000000040000c04 and cpu addr 0xffc01c04
> [    3.868440] radeon 0001:81:00.0: fence driver on ring 2 use gpu addr 0x0000000040000c08 and cpu addr 0xffc01c08
> [    3.878563] radeon 0001:81:00.0: fence driver on ring 3 use gpu addr 0x0000000040000c0c and cpu addr 0xffc01c0c
> [    3.888683] radeon 0001:81:00.0: fence driver on ring 4 use gpu addr 0x0000000040000c10 and cpu addr 0xffc01c10
> [    3.915475] radeon 0001:81:00.0: fence driver on ring 5 use gpu addr 0x0000000000075a18 and cpu addr 0xf90b5a18
> [    3.952576] radeon 0001:81:00.0: fence driver on ring 6 use gpu addr 0x0000000040000c18 and cpu addr 0xffc01c18
> [    3.962722] radeon 0001:81:00.0: fence driver on ring 7 use gpu addr 0x0000000040000c1c and cpu addr 0xffc01c1c
> [    3.972853] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
> [    3.979495] [drm] Driver supports precise vblank timestamp query.
> [    3.985614] radeon 0001:81:00.0: radeon: MSI limited to 32-bit
> [    3.991491] ppc4xx_setup_msi_irqs: fail allocating msi interrupt
> [    3.997598] [drm] radeon: irq initialized.
> [    4.757353] [drm:r600_ring_test] *ERROR* radeon: ring 0 test failed (scratch(0x850C)=0xCAFEDEAD)
> [    4.766204] radeon 0001:81:00.0: disabling GPU acceleration
> [    4.975496] [drm] Radeon Display Connectors
> [    4.980108] [drm] Connector 0:
> [    4.983305] [drm]   HDMI-A-1
> [    4.986272] [drm]   HPD4
> [    4.988861] [drm]   DDC: 0x6570 0x6570 0x6574 0x6574 0x6578 0x6578 0x657c 0x657c
> [    4.996314] [drm]   Encoders:
> [    4.999316] [drm]     DFP1: INTERNAL_UNIPHY2
> [    5.003606] [drm] Connector 1:
> [    5.006678] [drm]   DVI-I-1
> [    5.009491] [drm]   HPD2
> [    5.012043] [drm]   DDC: 0x6560 0x6560 0x6564 0x6564 0x6568 0x6568 0x656c 0x656c
> [    5.019465] [drm]   Encoders:
> [    5.022448] [drm]     DFP2: INTERNAL_UNIPHY
> [    5.026650] [drm]     CRT1: INTERNAL_KLDSCP_DAC1
> [    5.145056] [drm] fb mappable at 0x805D7000
> [    5.149276] [drm] vram apper at 0x80000000
> [    5.153396] [drm] size 8294400
> [    5.156466] [drm] fb depth is 24
> [    5.159713] [drm]    pitch is 7680
> [    5.458524] Console: switching to colour frame buffer device 240x67
> [    5.537736] radeon 0001:81:00.0: fb0: radeondrmfb frame buffer device
> [    5.547643] [drm] Initialized radeon 2.45.0 20080528 for 0001:81:00.0 on minor 0
> [    5.556010] [drm] amdgpu kernel modesetting enabled.
> [    5.578159] brd: module loaded
> [    5.589687] loop: module loaded
> [    5.593550] sm501 0002:00:06.0: enabling device (0004 -> 0006)
> [    5.599960] sm501 0002:00:06.0: incorrect device id c0000105
> [    5.607471] sata_sil 0002:00:04.0: Applying R_ERR on DMA activate FIS errata fix
> [    5.617801] scsi host0: sata_sil
> [    5.622004] scsi host1: sata_sil
> [    5.625866] ata1: SATA max UDMA/100 mmio m512@0xd84280000 tf 0xd84280080 irq 22
> [    5.633777] ata2: SATA max UDMA/100 mmio m512@0xd84280000 tf 0xd842800c0 irq 22
> [    5.642820] libphy: Fixed MDIO Bus: probed
> [    5.647913] PPC 4xx OCP EMAC driver, version 3.54
> [    5.653342] MAL v2 /plb/mcmal, 2 TX channels, 16 RX channels
> [    5.659743] ZMII /plb/opb/emac-zmii@ef600d00 initialized
> [    5.665717] RGMII /plb/opb/emac-rgmii@ef601500 initialized with MDIO support
> [    5.673465] TAH /plb/opb/emac-tah@ef601350 initialized
> [    5.679071] TAH /plb/opb/emac-tah@ef601450 initialized
> [    5.684935] /plb/opb/emac-rgmii@ef601500: input 0 in RGMII mode
> [    5.692793] eth0: EMAC-0 /plb/opb/ethernet@ef600e00, MAC 00:50:c2:80:d5:00
> [    5.700240] eth0: found Generic MII PHY (0x00)
> [    5.705214] /plb/opb/emac-rgmii@ef601500: input 1 in RGMII mode
> [    5.713023] eth1: EMAC-1 /plb/opb/ethernet@ef600f00, MAC 00:00:00:00:00:00
> [    5.720470] eth1: found Generic MII PHY (0x01)
> [    5.725324] PPP generic driver version 2.4.2
> [    5.730230] PPP BSD Compression module registered
> [    5.735398] PPP Deflate Compression module registered
> [    5.740794] NET: Registered protocol family 24
> [    5.746162] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> [    5.753458] ppc-of-ehci 4bffd0400.ehci: OF EHCI
> [    5.758602] ppc-of-ehci 4bffd0400.ehci: new USB bus registered, assigned bus number 1
> [    5.768059] ppc-of-ehci 4bffd0400.ehci: irq 32, io mem 0x4bffd0400
> [    5.781576] ppc-of-ehci 4bffd0400.ehci: USB 2.0 started, EHCI 1.00
> [    5.788309] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
> [    5.795510] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    5.803164] usb usb1: Product: OF EHCI
> [    5.821307] usb usb1: Manufacturer: Linux 4.7.0-sam460ex-jm-06197-g1c88e19-dirty ehci_hcd
> [    5.844035] usb usb1: SerialNumber: PPC-OF USB
> [    5.863546] hub 1-0:1.0: USB hub found
> [    5.881844] hub 1-0:1.0: 1 port detected
> [    5.900610] ehci-pci: EHCI PCI platform driver
> [    5.919816] ehci-platform: EHCI generic platform driver
> [    5.939956] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
> [    5.961022] ppc-of-ohci 4bffd0000.usb: OF OHCI
> [    5.979985] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> [    6.001187] ata1.00: ATAPI: ASUS    DRW-24B3ST   i, 1.00, max UDMA/100
> [    6.023323] ppc-of-ohci 4bffd0000.usb: new USB bus registered, assigned bus number 2
> [    6.046397] ata1.00: configured for UDMA/100
> [    6.066357] ppc-of-ohci 4bffd0000.usb: irq 33, io mem 0x4bffd0000
> [    6.091978] scsi 0:0:0:0: CD-ROM            ASUS DRW-24B3ST   i   1.00 PQ: 0 ANSI: 5
> [    6.146837] sr 0:0:0:0: [sr0] scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 cdda tray
> [    6.193563] cdrom: Uniform CD-ROM driver Revision: 3.20
> [    6.228572] usb 1-1: new high-speed USB device number 2 using ppc-of-ehci
> [    6.285880] sr 0:0:0:0: Attached scsi generic sg0 type 5
> [    6.347020] usb 1-1: New USB device found, idVendor=0424, idProduct=2517
> [    6.390568] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [    6.441746] hub 1-1:1.0: USB hub found
> [    6.483569] hub 1-1:1.0: 7 ports detected
> [    6.633708] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> [    6.689905] ata2.00: ATA-8: WDC WD5000AAKS-00UU3A0, 01.03B01, max UDMA/133
> [    6.736568] ata2.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 0/32)
> [    6.786000] ata2.00: configured for UDMA/100
> [    6.811573] usb 1-1.1: new high-speed USB device number 3 using ppc-of-ehci
> [    6.887833] scsi 1:0:0:0: Direct-Access     ATA      WDC WD5000AAKS-0 3B01 PQ: 0 ANSI: 5
> [    6.927219] usb 1-1.1: New USB device found, idVendor=1a40, idProduct=0101
> [    6.965537] sd 1:0:0:0: [sda] 976773168 512-byte logical blocks: (500 GB/466 GiB)
> [    6.965782] sd 1:0:0:0: [sda] Write Protect is off
> [    6.965791] sd 1:0:0:0: [sda] Mode Sense: 00 3a 00 00
> [    6.965887] sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> [    6.966260] sd 1:0:0:0: Attached scsi generic sg1 type 0
> [    7.003074]  sda: RDSK (512) sda1 (SFS^@)(res 2 spb 1) sda2 (SFS^@)(res 2 spb 1) sda3 (SFS^@)(res 2 spb 1) sda4 (SFS^@)(res 2 spb 1) sda5 (NTFS)(res 2 spb 2) sda6 ((res 2 spb 1) sda7 ((res 2 spb 1) sda8 ((res 2 spb 1)
> [    7.005691] sd 1:0:0:0: [sda] Attached SCSI disk
> [    7.015107] usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
> [    7.015115] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    7.015120] usb usb2: Product: OF OHCI
> [    7.015125] usb usb2: Manufacturer: Linux 4.7.0-sam460ex-jm-06197-g1c88e19-dirty ohci_hcd
> [    7.015130] usb usb2: SerialNumber: PPC-OF USB
> [    7.015821] hub 2-0:1.0: USB hub found
> [    7.015859] hub 2-0:1.0: 1 port detected
> [    7.016412] ohci-pci: OHCI PCI platform driver
> [    7.016550] ohci-platform: OHCI generic platform driver
> [    7.016747] uhci_hcd: USB Universal Host Controller Interface driver
> [    7.017327] usbcore: registered new interface driver usblp
> [    7.017512] usbcore: registered new interface driver usb-storage
> [    7.017764] usbcore: registered new interface driver usbserial
> [    7.017867] usbcore: registered new interface driver usbserial_generic
> [    7.017952] usbserial: USB Serial support registered for generic
> [    7.018456] mousedev: PS/2 mouse device common for all mice
> [    7.020131] i2c /dev entries driver
> [    7.023708] Unable to handle kernel paging request for data at address 0x000001dc
> [    7.023712] Faulting instruction address: 0xc07bf188
> [    7.023721] Vector: 300 (Data Access) at [eea6fd20]
> [    7.023747]     pc: c07bf188: __mutex_lock_slowpath+0x80/0x2f4
> [    7.023757]     lr: c07bf128: __mutex_lock_slowpath+0x20/0x2f4
> [    7.023760]     sp: eea6fdd0
> [    7.023762]    msr: 21000
> [    7.023765]    dar: 1dc
> [    7.023767]  dsisr: 800000
> [    7.023770]   current = 0xeea8ea00
> [    7.023773]     pid   = 1463, comm = irq/47-m41t80
> [    7.023779] Linux version 4.7.0-sam460ex-jm-06197-g1c88e19-dirty (root@julian-VirtualBox) (gcc version 5.4.0 20160609 (Ubuntu 5.4.0-6ubuntu1~16.04.1) ) #1 PREEMPT Mon Aug 8 05:57:08 AST 2016
> [    7.023806] enter ? for help
> [    7.023823] [eea6fe30] c07bf414 mutex_lock+0x18/0x24
> [    7.023842] [eea6fe40] c058b61c m41t80_handle_irq+0x28/0xac
> [    7.023869] [eea6fe60] c005604c irq_thread_fn+0x2c/0x48
> [    7.023880] [eea6fe80] c005626c irq_thread+0xc4/0x160
> [    7.023892] [eea6fed0] c003f76c kthread+0xc8/0xcc
> [    7.023908] [eea6ff40] c000b154 ret_from_kernel_thread+0x5c/0x64
> [    7.023914] mon>  <no input ...>
> [    9.023962] Oops: Kernel access of bad area, sig: 11 [#1]
> [    9.023965] PREEMPT Canyonlands
> [    9.023969] Modules linked in:
> [    9.023977] CPU: 0 PID: 1463 Comm: irq/47-m41t80 Not tainted 4.7.0-sam460ex-jm-06197-g1c88e19-dirty #1
> [    9.023982] task: eea8ea00 task.stack: eea6e000
> [    9.023985] NIP: c07bf188 LR: c07bf128 CTR: c058b5f4
> [    9.023989] REGS: eea6fd20 TRAP: 0300   Not tainted (4.7.0-sam460ex-jm-06197-g1c88e19-dirty)
> [    9.023999] MSR: 00021000 <CE,ME>  CR: 24000222  XER: 20000000
> [    9.024049] DEAR: 000001dc ESR: 00800000
> [    9.024049] GPR00: c07bf128 eea6fdd0 eea8ea00 00000000 eea30000 00000000 00000000 eea8ed2c
> [    9.024049] GPR08: c0dc0aa8 00000000 00000000 eea6fe80 24082284 00000000 c003f6a4 eea259e0
> [    9.024049] GPR16: 00000000 00000000 00000000 00000000 00000000 c0cb0000 00000001 ee996c54
> [    9.024049] GPR24: eea2e264 00000000 ee996c5c eea8ea00 eea259b0 00029000 c0cc0000 000001d8
> [    9.024057] NIP [c07bf188] __mutex_lock_slowpath+0x80/0x2f4
> [    9.024062] LR [c07bf128] __mutex_lock_slowpath+0x20/0x2f4
> [    9.024063] Call Trace:
> [    9.024072] [eea6fdd0] [c07bf128] __mutex_lock_slowpath+0x20/0x2f4 (unreliable)
> [    9.024078] [eea6fe30] [c07bf414] mutex_lock+0x18/0x24
> [    9.024085] [eea6fe40] [c058b61c] m41t80_handle_irq+0x28/0xac
> [    9.024092] [eea6fe60] [c005604c] irq_thread_fn+0x2c/0x48
> [    9.024097] [eea6fe80] [c005626c] irq_thread+0xc4/0x160
> [    9.024103] [eea6fed0] [c003f76c] kthread+0xc8/0xcc
> [    9.024109] [eea6ff40] [c000b154] ret_from_kernel_thread+0x5c/0x64
> [    9.024112] Instruction dump:
> [    9.024127] 8129d398 2f890000 40be001c 3c80c0b5 3c60c0b5 388413bf 38630a2e 480028d1
> [    9.024139] 0fe00000 7fa000a6 7c000146 39200000 <913f0004> 813ed190 2f890000 409e0044
> [    9.024151] ---[ end trace 869202da147d3b5e ]---
> [    9.024153]
> [    9.024158] note: irq/47-m41t80[1463] exited with preempt_count 1
> [    9.024168] Unable to handle kernel paging request for data at address 0xffffffe0
> [    9.024171] Faulting instruction address: 0xc003fb9c
> [    9.024175] Vector: 300 (Data Access) at [eea6fbc0]
> [    9.024185]     pc: c003fb9c: kthread_data+0x4/0xc
> [    9.024194]     lr: c0056140: irq_thread_dtor+0x48/0xb0
> [    9.024197]     sp: eea6fc70
> [    9.024199]    msr: 21000
> [    9.024202]    dar: ffffffe0
> [    9.024204]  dsisr: 0
> [    9.024206]   current = 0xeea8ea00
> [    9.024210]     pid   = 1463, comm = irq/47-m41t80
> [    9.024215] Linux version 4.7.0-sam460ex-jm-06197-g1c88e19-dirty (root@julian-VirtualBox) (gcc version 5.4.0 20160609 (Ubuntu 5.4.0-6ubuntu1~16.04.1) ) #1 PREEMPT Mon Aug 8 05:57:08 AST 2016
> [    9.024220] enter ? for help
> [    9.024224] mon>  <no input ...>
> [   11.024269] Oops: Kernel access of bad area, sig: 11 [#2]
> [   11.024271] PREEMPT Canyonlands
> [   11.024274] Modules linked in:
> [   11.024280] CPU: 0 PID: 1463 Comm: irq/47-m41t80 Tainted: G      D         4.7.0-sam460ex-jm-06197-g1c88e19-dirty #1
> [   11.024283] task: eea8ea00 task.stack: eea6e000
> [   11.024286] NIP: c003fb9c LR: c0056140 CTR: c00560f8
> [   11.024290] REGS: eea6fbc0 TRAP: 0300   Tainted: G D          (4.7.0-sam460ex-jm-06197-g1c88e19-dirty)
> [   11.024299] MSR: 00021000 <CE,ME>  CR: 44002824  XER: 20000000
> [   11.024351] DEAR: ffffffe0 ESR: 00000000
> [   11.024351] GPR00: c003e0ac eea6fc70 eea8ea00 eea8ea00 00000000 00000001 00000000 00000000
> [   11.024351] GPR08: eea6e000 00000000 00000004 eea6fcb0 24002424 00000000 c003f6a4 eea259e0
> [   11.024351] GPR16: 00000000 00000000 00000000 00000000 00000000 c0cb0000 00000001 ee996c54
> [   11.024351] GPR24: eea2e264 00000000 c0cb9000 eea6fcb8 c0dc0000 eea8ed2c 00000000 eea8ea00
> [   11.024356] NIP [c003fb9c] kthread_data+0x4/0xc
> [   11.024360] LR [c0056140] irq_thread_dtor+0x48/0xb0
> [   11.024361] Call Trace:
> [   11.024368] [eea6fc70] [00021000] 0x21000 (unreliable)
> [   11.024385] [eea6fc80] [c003e0ac] task_work_run+0x90/0xac
> [   11.024403] [eea6fcb0] [c00286fc] do_exit+0x304/0x7a0
> [   11.024417] [eea6fcf0] [c00077ac] die+0x26c/0x274
> [   11.024424] [eea6fd10] [c000b538] handle_page_fault+0x7c/0x80
> [   11.024434] --- interrupt: 300 at __mutex_lock_slowpath+0x80/0x2f4
> [   11.024434]     LR = __mutex_lock_slowpath+0x20/0x2f4
> [   11.024440] [eea6fe30] [c07bf414] mutex_lock+0x18/0x24
> [   11.024447] [eea6fe40] [c058b61c] m41t80_handle_irq+0x28/0xac
> [   11.024455] [eea6fe60] [c005604c] irq_thread_fn+0x2c/0x48
> [   11.024460] [eea6fe80] [c005626c] irq_thread+0xc4/0x160
> [   11.024466] [eea6fed0] [c003f76c] kthread+0xc8/0xcc
> [   11.024473] [eea6ff40] [c000b154] ret_from_kernel_thread+0x5c/0x64
> [   11.024475] Instruction dump:
> [   11.024489] 7ce0412d 40a2fff4 7f831000 419e0010 48004369 387fffe4 4877df69 39200000
> [   11.024502] 39610010 7d234b78 4bfd203c 81230238 <8069ffe0> 4e800020 9421ffe0 39200000
> [   11.024505] ---[ end trace 869202da147d3b5f ]---
> [   11.024507]
> [   11.024509] Fixing recursive fault but reboot is needed!
> [   11.024515] sched: RT throttling activated
> [   11.024716] Unable to handle kernel paging request for data at address 0x00000008
> [   11.024719] Faulting instruction address: 0xc0246cb8
> [   11.024725] Vector: 300 (Data Access) at [eea6fa70]
> [   11.024740]     pc: c0246cb8: exit_shm+0x18/0x148
> [   11.024753]     lr: c00286cc: do_exit+0x2d4/0x7a0
> [   11.024756]     sp: eea6fb20
> [   11.024758]    msr: 29000
> [   11.024761]    dar: 8
> [   11.024763]  dsisr: 0
> [   11.024765]   current = 0xeea8ea00
> [   11.024769]     pid   = 1463, comm = irq/47-m41t80
> [   11.024775] Linux version 4.7.0-sam460ex-jm-06197-g1c88e19-dirty (root@julian-VirtualBox) (gcc version 5.4.0 20160609 (Ubuntu 5.4.0-6ubuntu1~16.04.1) ) #1 PREEMPT Mon Aug 8 05:57:08 AST 2016
> [   11.024785] enter ? for help
> [   11.024789] mon>  <no input ...>
> [   13.024898] Oops: Kernel access of bad area, sig: 11 [#3]
> [   13.024902] PREEMPT Canyonlands
> [   13.024905] Modules linked in:
> [   13.024911] CPU: 0 PID: 1463 Comm: irq/47-m41t80 Tainted: G      D         4.7.0-sam460ex-jm-06197-g1c88e19-dirty #1
> [   13.024914] task: eea8ea00 task.stack: eea6e000
> [   13.024917] NIP: c0246cb8 LR: c00286cc CTR: c0047a00
> [   13.024921] REGS: eea6fa70 TRAP: 0300   Tainted: G D          (4.7.0-sam460ex-jm-06197-g1c88e19-dirty)
> [   13.024932] MSR: 00029000 <CE,EE,ME>  CR: 24008222  XER: 00000000
> [   13.024985] DEAR: 00000008 ESR: 00000000
> [   13.024985] GPR00: c00286cc eea6fb20 eea8ea00 eea8ea00 00000000 783c77ef 00000001 00000800
> [   13.024985] GPR08: ffffffff 00000000 eea8eda0 eea6fb50 c0c6f380 00000000 c003f6a4 eea259e0
> [   13.024985] GPR16: 00000000 00000000 00000000 00000000 00000000 c0cb0000 00000001 ee996c54
> [   13.024985] GPR24: eea2e264 00000000 eea8ecd8 eea6fb58 0000000b 00000000 eea6e000 eea8ea00
> [   13.024991] NIP [c0246cb8] exit_shm+0x18/0x148
> [   13.024997] LR [c00286cc] do_exit+0x2d4/0x7a0
> [   13.024998] Call Trace:
> [   13.025018] [eea6fb20] [c0cb0000] tcpv6_protosw+0x8/0x18 (unreliable)
> [   13.025025] [eea6fb50] [c00286cc] do_exit+0x2d4/0x7a0
> [   13.025033] [eea6fb90] [c00077ac] die+0x26c/0x274
> [   13.025041] [eea6fbb0] [c000b538] handle_page_fault+0x7c/0x80
> [   13.025049] --- interrupt: 300 at kthread_data+0x4/0xc
> [   13.025049]     LR = irq_thread_dtor+0x48/0xb0
> [   13.025055] [eea6fc70] [00021000] 0x21000 (unreliable)
> [   13.025064] [eea6fc80] [c003e0ac] task_work_run+0x90/0xac
> [   13.025073] [eea6fcb0] [c00286fc] do_exit+0x304/0x7a0
> [   13.025079] [eea6fcf0] [c00077ac] die+0x26c/0x274
> [   13.025086] [eea6fd10] [c000b538] handle_page_fault+0x7c/0x80
> [   13.025096] --- interrupt: 300 at __mutex_lock_slowpath+0x80/0x2f4
> [   13.025096]     LR = __mutex_lock_slowpath+0x20/0x2f4
> [   13.025102] [eea6fe30] [c07bf414] mutex_lock+0x18/0x24
> [   13.025111] [eea6fe40] [c058b61c] m41t80_handle_irq+0x28/0xac
> [   13.025122] [eea6fe60] [c005604c] irq_thread_fn+0x2c/0x48
> [   13.025127] [eea6fe80] [c005626c] irq_thread+0xc4/0x160
> [   13.025133] [eea6fed0] [c003f76c] kthread+0xc8/0xcc
> [   13.025140] [eea6ff40] [c000b154] ret_from_kernel_thread+0x5c/0x64
> [   13.025143] Instruction dump:
> [   13.025157] 80010014 7fc3f378 bbc10008 7c0803a6 38210010 4be07acc 9421ffd0 7c0802a6
> [   13.025170] bf210014 90010034 3b4302d8 812302ec <83890008> 812302d8 7f9a4840 419e011c
> [   13.025175] ---[ end trace 869202da147d3b60 ]---
> [   13.025176]
> [   13.025178] Fixing recursive fault but reboot is needed!
> [   13.518850] rtc-m41t80 8-0068: rtc core: registered m41t80 as rtc0
> [   13.614246] ibm-iic 4ef600700.i2c: using standard (100 kHz) mode
> [   13.614790] ibm-iic 4ef600800.i2c: using standard (100 kHz) mode
> [   13.614949] md: linear personality registered for level -1
> [   13.614953] md: raid0 personality registered for level 0
> [   13.614956] md: raid1 personality registered for level 1
> [   13.614959] md: raid10 personality registered for level 10
> [   13.638691] md: raid6 personality registered for level 6
> [   13.638695] md: raid5 personality registered for level 5
> [   13.638698] md: raid4 personality registered for level 4
> [   13.639455] device-mapper: ioctl: 4.35.0-ioctl (2016-06-23) initialised: dm-devel@redhat.com
> [   13.639459] EDAC PPC4xx MC: v1.0.0
> [   13.639462] EDAC PPC4xx MC: Reporting type: interrupt
> [   13.639841] hidraw: raw HID events driver (C) Jiri Kosina
> [   13.641387] usbcore: registered new interface driver usbhid
> [   13.641390] usbhid: USB HID core driver
> [   13.724951] snd_ice1724 0000:42:00.0: No matching model found for ID 0x12140324
> [   13.818895] usbcore: registered new interface driver snd-usb-audio
> [   13.819105] usbcore: registered new interface driver snd-ua101
> [   13.819335] usbcore: registered new interface driver snd-usb-usx2y
> [   13.819722] ipip: IPv4 and MPLS over IPv4 tunneling driver
> [   13.820905] Initializing XFRM netlink socket
> [   13.822474] NET: Registered protocol family 10
> [   13.823842] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
> [   13.824619] NET: Registered protocol family 17
> [   13.824642] NET: Registered protocol family 15
> [   13.824876] Running MSI bitmap self-tests ...
> [   13.826213] zswap: loaded using pool lzo/zbud
> [   13.847392] Key type encrypted registered
> [   13.966616] rtc-m41t80 8-0068: setting system clock to 2016-08-08 06:03:19 UTC (1470636199)
> [   13.966774] ALSA device list:
> [   13.966777]   #0: Virtual MIDI Card 1
> [   13.966779]   #1: ICEnsemble ICE1724 at 0xfffc1080, irq 19
> [   17.710533] md: Waiting for all devices to be available before autodetect
> [   17.731361] usb 1-1.1: New USB device strings: Mfr=0, Product=1, SerialNumber=0
> [   17.731367] usb 1-1.1: Product: USB 2.0 Hub
> [   17.732232] hub 1-1.1:1.0: USB hub found
> [   17.732436] hub 1-1.1:1.0: 4 ports detected
> [   17.809830] md: If you don't use raid, use raid=noautodetect
> [   17.830553] md: Autodetecting RAID arrays.
> [   17.848907] md: Scanned 0 and added 0 devices.
> [   17.867410] md: autorun ...
> [   17.884122] usb 1-1.2: new low-speed USB device number 4 using ppc-of-ehci
> [   17.905299] md: ... autorun DONE.
> [   17.946801] EXT4-fs (sda6): couldn't mount as ext3 due to feature incompatibilities
> [   17.969626] EXT4-fs (sda6): couldn't mount as ext2 due to feature incompatibilities
> [   18.008131] EXT4-fs (sda6): mounted filesystem with ordered data mode. Opts: (null)
> [   18.030904] VFS: Mounted root (ext4 filesystem) readonly on device 8:6.
> [   18.056243] usb 1-1.2: New USB device found, idVendor=045e, idProduct=07b9
> [   18.078413] usb 1-1.2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [   18.100533] usb 1-1.2: Product: USB Keyboard
> [   18.119530] usb 1-1.1.1: new full-speed USB device number 5 using ppc-of-ehci
> [   18.119770] devtmpfs: mounted
> [   18.120413] Freeing unused kernel memory: 260K (c0c27000 - c0c68000)
> [   18.120419] This architecture does not have kernel memory protection.
> [   18.205408] usb 1-1.2: Manufacturer: LITEON Technology
> [   18.234233] input: LITEON Technology USB Keyboard as /devices/platform/plb/4bffd0400.ehci/usb1/1-1/1-1.2/1-1.2:1.0/0003:045E:07B9.0001/input/input0
> [   18.266119] usb 1-1.1.1: New USB device found, idVendor=0d8c, idProduct=000c
> [   18.289976] usb 1-1.1.1: New USB device strings: Mfr=0, Product=1, SerialNumber=0
> [   18.313732] usb 1-1.1.1: Product: C-Media USB Audio Device
> [   18.337028] hid-generic 0003:045E:07B9.0001: input,hidraw0: USB HID v1.10 Keyboard [LITEON Technology USB Keyboard] on usb-PPC-OF USB-1.2/input0
> [   18.371323] random: fast init done
> [   18.415717] input: C-Media USB Audio Device    as /devices/platform/plb/4bffd0400.ehci/usb1/1-1/1-1.1/1-1.1.1/1-1.1.1:1.3/0003:0D8C:000C.0002/input/input1
> [   18.447707] usb 1-1.6: new full-speed USB device number 6 using ppc-of-ehci
> [   18.526105] hid-generic 0003:0D8C:000C.0002: input,hidraw1: USB HID v1.00 Device [C-Media USB Audio Device   ] on usb-PPC-OF USB-1.1.1/input3
> [   18.576345] usb 1-1.6: New USB device found, idVendor=046d, idProduct=c52b
> [   18.601980] usb 1-1.6: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [   18.628478] usb 1-1.6: Product: USB Receiver
> [   18.651837] usb 1-1.6: Manufacturer: Logitech
> [   18.686483] logitech-djreceiver 0003:046D:C52B.0005: hiddev0,hidraw2: USB HID v1.11 Device [Logitech USB Receiver] on usb-PPC-OF USB-1.6/input2
> [   18.831613] input: Logitech M570 as /devices/platform/plb/4bffd0400.ehci/usb1/1-1/1-1.6/1-1.6:1.2/0003:046D:C52B.0005/0003:046D:1028.0006/input/input2
> [   18.867014] logitech-hidpp-device 0003:046D:1028.0006: input,hidraw3: USB HID v1.11 Mouse [Logitech M570] on usb-PPC-OF USB-1.6:1
> [   18.917603] usb 1-1.7: new high-speed USB device number 7 using ppc-of-ehci
> [   19.034752] random: crng init done
> [   19.065579] usb 1-1.7: New USB device found, idVendor=0424, idProduct=2240
> [   19.093702] usb 1-1.7: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [   19.122137] usb 1-1.7: Product: Ultra Fast Media
> [   19.147878] usb 1-1.7: Manufacturer: Generic
> [   19.173228] usb 1-1.7: SerialNumber: 000000225001
> [   19.199741] usb-storage 1-1.7:1.0: USB Mass Storage device detected
> [   19.227484] scsi host2: usb-storage 1-1.7:1.0
> [   19.254205] scsi host2: runtime PM trying to activate child device host2 but parent (1-1.7:1.0) is not active
> [   19.499854] systemd[1]: systemd 229 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ -LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN)
> [   19.540682] systemd[1]: Detected architecture ppc.
> 
> Welcome to Ubuntu 16.04.1 LTS!
> 
> [   19.586760] systemd[1]: Set hostname to <Amigaone>.
> [   20.325942] scsi 2:0:0:0: Direct-Access     Generic  Ultra HS-COMBO   1.98 PQ: 0 ANSI: 0
> [   20.360659] sd 2:0:0:0: Attached scsi generic sg2 type 0
> [   20.389891] sd 2:0:0:0: [sdb] 15523840 512-byte logical blocks: (7.95 GB/7.40 GiB)
> [   20.422371] sd 2:0:0:0: [sdb] Write Protect is off
> [   20.450217] sd 2:0:0:0: [sdb] Mode Sense: 23 00 00 00
> [   20.479747] sd 2:0:0:0: [sdb] No Caching mode page found
> [   20.507413] sd 2:0:0:0: [sdb] Assuming drive cache: write through
> [   20.555264]  sdb:
> [   20.584348] sd 2:0:0:0: [sdb] Attached SCSI removable disk
> [   21.592232] systemd[1]: Created slice System Slice.
> [  OK  ] Created slice System Slice.
> [   21.627100] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
> [  OK  ] Started Forward Password Requests to Wall Directory Watch.
> [   21.667055] systemd[1]: Listening on Journal Socket (/dev/log).
> [  OK  ] Listening on Journal Socket (/dev/log).
> [   21.703803] systemd[1]: Reached target Swap.
> [  OK  ] Reached target Swap.
> [   21.736766] systemd[1]: Reached target Encrypted Volumes.
> [  OK  ] Reached target Encrypted Volumes.
> [   21.772762] systemd[1]: Reached target User and Group Name Lookups.
> [  OK  ] Reached target User and Group Name Lookups.
> [   21.810124] systemd[1]: Created slice system-serial\x2dgetty.slice.
> [  OK  ] Created slice system-serial\x2dgetty.slice.
> [   21.848074] systemd[1]: Listening on Journal Socket.
> [  OK  ] Listening on Journal Socket.
> [   21.884925] systemd[1]: Starting Nameserver information manager...
>          Starting Nameserver information manager...
> [   21.926053] systemd[1]: Starting Uncomplicated firewall...
>          Starting Uncomplicated firewall...
> [   21.969889] systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
> [  OK  ] Set up automount Arbitrary Executab...ats File System Automount Point.
> [   22.016550] systemd[1]: Mounting POSIX Message Queue File System...
>          Mounting POSIX Message Queue File System...
> [   22.058785] systemd[1]: Mounting Debug File System...
>          Mounting Debug File System...
> [   22.098259] systemd[1]: Listening on fsck to fsckd communication Socket.
> [  OK  ] Listening on fsck to fsckd communication Socket.
> [   22.140956] systemd[1]: Starting Set console keymap...
>          Starting Set console keymap...
> [   22.221424] systemd[1]: Starting Load Kernel Modules...
>          Starting Load Kernel Modules...
> [   22.258816] systemd[1]: Reached target Remote File Systems (Pre).
> [  OK  ] Reached target Remote File Systems (Pre).
> [   22.303960] systemd[1]: Reached target Remote File Systems.
> [  OK  ] Reached target Remote File Systems.
> [   22.348211] systemd[1]: Listening on udev Control Socket.
> [  OK  ] Listening on udev Control Socket.
> [   22.387454] systemd[1]: Starting Create Static Device Nodes in /dev...
>          Starting Create Static Device Nodes in /dev...
> [   22.436117] systemd[1]: Listening on /dev/initctl Compatibility Named Pipe.
> [  OK  ] Listening on /dev/initctl Compatibility Named Pipe.
> [   22.481231] systemd[1]: Started Braille Device Support.
> [  OK  ] Started Braille Device Support.
> [   22.873954] systemd[1]: Created slice User and Session Slice.
> [  OK  ] Created slice User and Session Slice.
> [   22.935797] systemd[1]: Reached target Slices.
> [  OK  ] Reached target Slices.
> [   22.991967] systemd[1]: Listening on udev Kernel Socket.
> [  OK  ] Listening on udev Kernel Socket.
> [   23.044935] systemd[1]: Started Read required files in advance.
> [  OK  ] Started Read required files in advance.
> [   23.084812] systemd[1]: Listening on Syslog Socket.
> [  OK  ] Listening on Syslog Socket.
> [   23.121479] systemd[1]: Starting Journal Service...
>          Starting Journal Service...
> [   23.181927] systemd[1]: Mounted Debug File System.
> [  OK  ] Mounted Debug File System.
> [   23.214890] systemd[1]: Mounted POSIX Message Queue File System.
> [  OK  ] Mounted POSIX Message Queue File System.
> [   23.257541] systemd[1]: Started Uncomplicated firewall.
> [  OK  ] Started Uncomplicated firewall.
> [   23.298807] systemd[1]: Started Set console keymap.
> [  OK  ] Started Set console keymap.
> [   23.330898] systemd[1]: systemd-modules-load.service: Main process exited, code=exited, status=1/FAILURE
> [   23.360468] systemd[1]: Failed to start Load Kernel Modules.
> [FAILED] Failed to start Load Kernel Modules.
> See 'systemctl status systemd-modules-load.service' for details.
> [   23.402843] systemd[1]: systemd-modules-load.service: Unit entered failed state.
> [   23.431855] systemd[1]: systemd-modules-load.service: Failed with result 'exit-code'.
> [   23.460356] systemd[1]: Started Create Static Device Nodes in /dev.
> [  OK  ] Started Create Static Device Nodes in /dev.
> [   23.494841] systemd[1]: brltty.service: Main process exited, code=exited, status=228/SECCOMP
> [   23.551244] systemd[1]: brltty.service: Unit entered failed state.
> [   23.597722] systemd[1]: brltty.service: Failed with result 'exit-code'.
> [   23.646338] systemd[1]: ureadahead.service: Main process exited, code=exited, status=5/NOTINSTALLED
> [   23.703400] systemd[1]: ureadahead.service: Unit entered failed state.
> [   23.751701] systemd[1]: ureadahead.service: Failed with result 'exit-code'.
> [   23.804551] systemd[1]: Started Nameserver information manager.
> [  OK  ] Started Nameserver information manager.
> [   24.130515] systemd[1]: Started Journal Service.
> [  OK  ] Started Journal Service.
>          Starting udev Kernel Device Manager...
>          Mounting Configuration File System...
>          Mounting FUSE Control File System...
>          Starting Apply Kernel Variables...
> [  OK  ] Mounted Configuration File System.
> [  OK  ] Mounted FUSE Control File System.
> [  OK  ] Started Apply Kernel Variables.
> [  OK  ] Started udev Kernel Device Manager.
>          Starting File System Check on Root Device...
>          Starting LSB: QEMU KVM module loading script...
> [  OK  ] Started File System Check Daemon to report status.
> [  OK  ] Started File System Check on Root Device.
>          Starting Remount Root and Kernel File Systems...
> [  OK  ] Started LSB: QEMU KVM module loading script.
> [  OK  ] Started Remount Root and Kernel File Systems.
>          Starting Flush Journal to Persistent Storage...
>          Starting Load/Save Random Seed...
> [  OK  ] Reached target Local File Systems (Pre).
> [  OK  ] Reached target Local File Systems.
>          Starting Tell Plymouth To Write Out Runtime Data...
>          Starting Set console font and keymap...
>          Starting LSB: AppArmor initialization...
>          Starting udev Coldplug all Devices...
> [  OK  ] Started Load/Save Random Seed.
> [  OK  ] Started Tell Plymouth To Write Out Runtime Data.
> [  OK  ] Started Flush Journal to Persistent Storage.
>          Starting Create Volatile Files and Directories...
> [  OK  ] Started LSB: AppArmor initialization.
>          Starting Raise network interfaces...
> [  OK  ] Started Create Volatile Files and Directories.
> [  OK  ] Reached target System Time Synchronized.
>          Starting Update UTMP about System Boot/Shutdown...
> [  OK  ] Started Update UTMP about System Boot/Shutdown.
> [  OK  ] Started Set console font and keymap.
> [  OK  ] Created slice system-getty.slice.
> [  OK  ] Started udev Coldplug all Devices.
> [  OK  ] Started Dispatch Password Requests to Console Directory Watch.
> [  OK  ] Reached target System Initialization.
> [  OK  ] Listening on CUPS Scheduler.
> [  OK  ] Started CUPS Scheduler.
> [  OK  ] Started Trigger resolvconf update for networkd DNS.
> [  OK  ] Reached target Paths.
> [  OK  ] Started Daily apt activities.
> [  OK  ] Started Daily Cleanup of Temporary Directories.
> [  OK  ] Listening on Avahi mDNS/DNS-SD Stack Activation Socket.
> [  OK  ] Started Timer to automatically refresh installed snaps.
> [  OK  ] Reached target Timers.
> [  OK  ] Listening on UUID daemon activation socket.
>          Starting Socket activation for snappy daemon.
> [  OK  ] Listening on D-Bus System Message Bus Socket.
> [  OK  ] Listening on Socket activation for snappy daemon.
> [  OK  ] Reached target Sockets.
> [  OK  ] Reached target Basic System.
> [  OK  ] Started Cgroup management daemon.
>          Starting LSB: Speech Dispatcher...
> [  OK  ] Started Snappy daemon.
>          Starting LSB: Load kernel modules needed to enable cpufreq scaling...
> [  OK  ] Started Self Monitoring and Reporting Technology (SMART) Daemon.
> [  OK  ] Started Avahi DNS Configuration Daemon.
> [  OK  ] Started CUPS Scheduler.
>          Starting System Logging Service...
>          Starting Restore /etc/resolv.conf i...re the ppp link was shut down...
>          Starting Accounts Service...
> [  OK  ] Started Run anacron jobs.
>          Starting Permit User Sessions...
> [  OK  ] Started crash report submission daemon.
>          Starting Save/Restore Sound Card State...
>          Starting Modem Manager...
>          Starting LSB: handle special hotkeys of Apple computers...
>          Starting LSB: daemon to balance interrupts for SMP systems...
> [  OK  ] Started Regular background program processing daemon.
>          Starting LSB: Set the CPU Frequency Scaling governor to "ondemand"...
>          Starting Avahi mDNS/DNS-SD Stack...
>          Starting LSB: automatic crash report generation...
>          Starting Initialize hardware monitoring sensors...
> [  OK  ] Started D-Bus System Message Bus.
> [  OK  ] Started Avahi mDNS/DNS-SD Stack.
> [  OK  ] Started Make remote CUPS printers available locally.
>          Starting Network Manager...
>          Starting Login Service...
> [  OK  ] Started System Logging Service.
> [  OK  ] Started Restore /etc/resolv.conf if...fore the ppp link was shut down.
> [  OK  ] Started Permit User Sessions.
> [  OK  ] Started LSB: handle special hotkeys of Apple computers.
> [  OK  ] Started Initialize hardware monitoring sensors.
> [  OK  ] Found device /dev/ttyS0.
> [  OK  ] Started LSB: Speech Dispatcher.
> [  OK  ] Started LSB: Load kernel modules needed to enable cpufreq scaling.
> [  OK  ] Started LSB: Set the CPU Frequency Scaling governor to "ondemand".
> [  OK  ] Started LSB: automatic crash report generation.
>          Starting Authenticate and Authorize Users to Run Privileged Tasks...
> [  OK  ] Started ifup for eth0.
>          Starting LSB: set CPUFreq kernel parameters...
> [  OK  ] Reached target Sound Card.
>          Starting Light Display Manager...
> [  OK  ] Started Login Service.
> [  OK  ] Started LSB: daemon to balance interrupts for SMP systems.
> [  OK  ] Started LSB: set CPUFreq kernel parameters.
> [  OK  ] Started Save/Restore Sound Card State.
> [  OK  ] Started Authenticate and Authorize Users to Run Privileged Tasks.
> [  OK  ] Started Accounts Service.
> [  OK  ] Started Network Manager.
>          Starting Network Manager Wait Online...
>          Starting Network Manager Script Dispatcher Service...
> [  OK  ] Started Modem Manager.
> [  OK  ] Started Network Manager Script Dispatcher Service.
> [  OK  ] Started Light Display Manager.
>          Starting Hostname Service...
> [  OK  ] Started Hostname Service.
>          Starting LSB: start Samba SMB/CIFS daemon (smbd)...
> [  OK  ] Started Network Manager Wait Online.
> [  OK  ] Created slice User Slice of lightdm.
>          Starting User Manager for UID 108...
> [  OK  ] Started Session c1 of user lightdm.
> [  OK  ] Started User Manager for UID 108.
> [  OK  ] Stopped Braille Device Support.
> [  OK  ] Started Braille Device Support.
> 
> 
> [  OK  ] Started LSB: start Samba SMB/CIFS daemon (smbd).
>          Starting RealtimeKit Scheduling Policy Service...
> [  OK  ] Started RealtimeKit Scheduling Policy Service.
> [*     ] A start job is running for Raise network interfaces (44s / 5min 42s)
> [**    ] A start job is running for Raise network interfaces (44s / 5min 42s)
> [***   ] A start job is running for Raise network interfaces (45s / 5min 42s)
> [ ***  ] A start job is running for Raise network interfaces (45s / 5min 42s)
> [  *** ] A start job is running for Raise network interfaces (46s / 5min 42s)
> [   ***] A start job is running for Raise network interfaces (46s / 5min 42s)
> [  OK  ] Started Raise network interfaces.
> [  OK  ] Reached target Network.
> [  OK  ] Reached target Network is Online.
>          Starting LSB: start Samba NetBIOS nameserver (nmbd)...
>          Starting /etc/rc.local Compatibility...
>          Starting LSB: Start NTP daemon...
>          Starting LSB: start Samba daemons for the AD DC...
>          Starting LSB: disk temperature monitoring daemon...
> [  OK  ] Started /etc/rc.local Compatibility.
> [  OK  ] Started LSB: disk temperature monitoring daemon.
>          Starting Hold until boot process finishes up...
> [  OK  ] Started Hold until boot process finishes up.
> [  OK  ] Started Serial Getty on ttyS0.
>          Starting Set console scheme...
> [  OK  ] Started Getty on tty1.
> [  OK  ] Reached target Login Prompts.
> [  OK  ] Started Set console scheme.
> [  OK  ] Started LSB: Start NTP daemon.
> Ubuntu 16.04.1 LTS Amigaone ttyS0
> 
> Amigaone login: [  OK  ] Stopped Stop ureadahead data collection 45s after completed startup.
> [  OK  ] Stopped target Timers.
> [  OK  ] Stopped target Graphical Interface.
>          Stopping Light Display Manager...
>          Stopping Authenticate and Authorize Users to Run Privileged Tasks...
>          Stopping RealtimeKit Scheduling Policy Service...
>          Stopping Session c1 of user lightdm.
>          Stopping User Manager for UID 108...
> [  OK  ] Stopped Daily Cleanup of Temporary Directories.
>          Starting Unattended Upgrades Shutdown...
> [  OK  ] Stopped target Sound Card.
>          Stopping TLP system startup/shutdown...
>          Stopping Accounts Service...
>          Stopping Save/Restore Sound Card State...
> [  OK  ] Stopped Daily apt activities.
> [  OK  ] Unmounted /run/user/108/gvfs.
> [  OK  ] Stopped Accounts Service.
> [  OK  ] Stopped Authenticate and Authorize Users to Run Privileged Tasks.
> [  OK  ] Stopped User Manager for UID 108.
> [  OK  ] Stopped RealtimeKit Scheduling Policy Service.
> [  OK  ] Stopped Session c1 of user lightdm.
> [  OK  ] Stopped Light Display Manager.
> [  OK  ] Stopped Save/Restore Sound Card State.
> [  OK  ] Removed slice User Slice of lightdm.
> [  OK  ] Stopped User Manager for UID 108.
> [  OK  ] Removed slice user-108.slice.
> [  OK  ] Unmounted /run/user/108.
> [  OK  ] Stopped TLP system startup/shutdown.
> [  OK  ] Stopped target Multi-User System.
>          Stopping Make remote CUPS printers available locally...
>          Stopping LSB: Speech Dispatcher...
>          Stopping LSB: disk temperature monitoring daemon...
>          Stopping Modem Manager...
>          Stopping Self Monitoring and Reporting Technology (SMART) Daemon...
>          Stopping crash report submission daemon...
>          Stopping Login Service...
>          Stopping Snappy daemon...
>          Stopping LSB: handle special hotkeys of Apple computers...
>          Stopping LSB: set CPUFreq kernel parameters...
>          Stopping Avahi DNS Configuration Daemon...
>          Stopping LSB: automatic crash report generation...
> [  OK  ] Stopped Initialize hardware monitoring sensors.
>          Stopping Regular background program processing daemon...
>          Stopping Run anacron jobs...
> [  OK  ] Stopped Timer to automatically refresh installed snaps.
> [  OK  ] Stopped target Login Prompts.
>          Stoppi         Stopping Serial Getty on ttyS0...
>          Stopping LSB: start Samba SMB/CIFS daemon (smbd)...
>          Stopping System Logging Service...
>          Stopping LSB: Start NTP daemon...
>          Stopping LSB: Set the CPU Frequency Scaling governor to "ondemand"...
>          Stopping LSB: start Samba daemons for the AD DC...
>          Stopping LSB: daemon to balance interrupts for SMP systems...
>          Stopping Cgroup management daemon...
> [  OK  ] Stopped Cgroup management daemon.
> [  OK  ] Stopped Snappy daemon.
> [  OK  ] Stopped Self Monitoring and Reporting Technology (SMART) Daemon.
> [  OK  ] Stopped Avahi DNS Configuration Daemon.
> [  OK  ] Stopped System Logging Service.
> [  OK  ] Stopped Run anacron jobs.
> [  OK  ] Stopped crash report submission daemon.
> [  OK  ] Stopped Modem Manager.
> [  OK  ] Stopped Regular background program processing daemon.
> [  OK  ] Stopped Make remote CUPS printers available locally.
> [  OK  ] Stopped Login Service.
> [  OK  ] Stopped Serial Getty on ttyS0.
> [  OK  ] Stopped Getty on tty1.
> [  OK  ] Stopped LSB: handle special hotkeys of Apple computers.
> [  OK  ] Started Unattended Upgrades Shutdown.
> [  OK  ] Stopped LSB: Speech Dispatcher.
> [  OK  ] Stopped LSB: disk temperature monitoring daemon.
> [  OK  ] Stopped LSB: set CPUFreq kernel parameters.
> [  OK  ] Stopped LSB: Start NTP daemon.
> [  OK  ] Stopped LSB: Set the CPU Frequency Scaling governor to "ondemand".
> [  OK  ] Stopped LSB: automatic crash report generation.
> [  OK  ] Stopped LSB: daemon to balance interrupts for SMP systems.
>          Stopping LSB: Load kernel modules needed to enable cpufreq scaling...
> [  OK  ] Removed slice system-getty.slice.
> [  OK  ] Stopped /etc/rc.local Compatibility.
> [  OK  ] Removed slice system-serial\x2dgetty.slice.
>          Stopping Permit User Sessions...
>          Stopping Avahi mDNS/DNS-SD Stack...
> [  OK  ] Stopped target System Time Synchronized.
> [  OK  ] Stopped Avahi mDNS/DNS-SD Stack.
> [  OK  ] Stopped Permit User Sessions.
> [  OK  ] Stopped LSB: Load kernel modules needed to enable cpufreq scaling.
> [  OK  ] Stopped target User and Group Name Lookups.
> [  OK  ] Stopped LSB: start Samba SMB/CIFS daemon (smbd).
> [  OK  ] Stopped LSB: start Samba daemons for the AD DC.
>          Stopping CUPS Scheduler...
>          Stopping LSB: start Samba NetBIOS nameserver (nmbd)...
> [  OK  ] Stopped CUPS Scheduler.
> [  OK  ] Stopped LSB: start Samba NetBIOS nameserver (nmbd).
> [  OK  ] Stopped target Network is Online.
> [  OK  ] Stopped target Network.
> [  OK  ] Stopped Network Manager Wait Online.
>          Stopping Network Manager...
>          Stopping Raise network interfaces...
> [  OK  ] Stopped target Remote File Systems.
> [  OK  ] Stopped target Remote File Systems (Pre).
> [  OK  ] Stopped Network Manager.
>          Stopping D-Bus System Message Bus...
> [  OK  ] Stopped D-Bus System Message Bus.
> [  OK  ] Stopped target Basic System.
> [  OK  ] Stopped target Slices.
> [  OK  ] Removed slice User and Session Slice.
> [  OK  ] Stopped target Paths.
> [  OK  ] Stopped CUPS Scheduler.
> [  OK  ] Stopped Dispatch Password Requests to Console Directory Watch.
> [  OK  ] Stopped Forward Password Requests to Wall Directory Watch.
> [  OK  ] Stopped Trigger resolvconf update for networkd DNS.
> [  OK  ] Stopped target Sockets.
> [  OK  ] Closed UUID daemon activation socket.
> [  OK  ] Closed Avahi mDNS/DNS-SD Stack Activation Socket.
> [  OK  ] Closed CUPS Scheduler.
> [  OK  ] Closed Syslog Socket.
> [  OK  ] Closed Socket activation for snappy daemon.
> [  OK  ] Closed D-Bus System Message Bus Socket.
> [  OK  ] Stopped target System Initialization.
>          Stopping Update UTMP about System Boot/Shutdown...
> [  OK  ] Stopped target Swap.
>          Stopping Load/Save Random Seed...
> [  OK  ] Stopped target Encrypted Volumes.
> [  OK  ] Stopped Load/Save Random Seed.
> [  OK  ] Stopped Update UTMP about System Boot/Shutdown.
> [  OK  ] Stopped Create Volatile Files and Directories.
> [  OK  ] Stopped Raise network interfaces.
> [  OK  ] Stopped Apply Kernel Variables.
> [  OK  ] Stopped target Local File Systems.
>          Unmounting /run/cgmanager/fs...
> [  OK  ] Unmounted /run/cgmanager/fs.
> [  OK  ] Reached target Unmount All Filesystems.
> [  OK  ] Stopped target Local File Systems (Pre).
> [  OK  ] Stopped Remount Root and Kernel File Systems.
> [  OK  ] Stopped Create Static Device Nodes in /dev.
> [  OK  ] Reached target Shutdown.
> [  101.814465] reboot: Restarting system
> 
> 
> U-Boot 2015.a (May 16 2015 - 14:20:11)
> 
> CPU:   AMCC PowerPC 460EX Rev. B at 1155 MHz (PLB=231 OPB=115 EBC=115)
>        No Security/Kasumi support
>        Bootstrap Option H - Boot ROM Location I2C (Addr 0x52)
>        Internal PCI arbiter enabled
>        32 kB I-Cache 32 kB D-Cache
> Board: Sam460ex/cr, PCIe 4x + PCIe 1x
> I2C:   ready
> DRAM:  2 GiB (ECC not enabled, 462 MHz, CL4)
> PCI:   Bus Dev VenId DevId Class Int
>         00  04  1095  3512  0104  00
>         00  06  126f  0501  0380  00
> PCIE0: successfully set as root-complex
>         03  00  1412  1724  0401  60
>         02  00  1b21  1080  0604  00
> PCIE1: successfully set as root-complex
>         05  00  1002  683f  0300  66
> Net:   ppc_4xx_eth0
> FPGA:  Revision 03 (2010-10-07)
> SM502: found
> PERMD2:not found
> VGA:   1
> VESA:  OK
> 
> 
> U-Boot 2015.a (May 16 2015 - 14:20:11)
> 
> CPU:   AMCC PowerPC 460EX Rev. B at 1155 MHz (PLB=231 OPB=115 EBC=115)
>        No Security/Kasumi support
>        Bootstrap Option H - Boot ROM Location I2C (Addr 0x52)
>        Internal PCI arbiter enabled
>        32 kB I-Cache 32 kB D-Cache
> Board: Sam460ex/cr, PCIe 4x + PCIe 1x
> I2C:   ready
> DRAM:  2 GiB (ECC not enabled, 462 MHz, CL4)
> PCI:   Bus Dev VenId DevId Class Int
>         00  04  1095  3512  0104  00
>         00  06  126f  0501  0380  00
> PCIE0: successfully set as root-complex
>         03  00  1412  1724  0401  ff
>         02  00  1b21  1080  0604  00
> PCIE1: successfully set as root-complex
>         05  00  1002  683f  0300  ff
> Net:   ppc_4xx_eth0
> FPGA:  Revision 03 (2010-10-07)
> SM502: found
> PERMD2:not found
> VGA:   1
> VESA:  OK
> 
> 
> U-Boot 2015.a (May 16 2015 - 14:20:11)
> 
> CPU:   AMCC PowerPC 460EX Rev. B at 1155 MHz (PLB=231 OPB=115 EBC=115)
>        No Security/Kasumi support
>        Bootstrap Option H - Boot ROM Location I2C (Addr 0x52)
>        Internal PCI arbiter enabled
>        32 kB I-Cache 32 kB D-Cache
> Board: Sam460ex/cr, PCIe 4x + PCIe 1x
> I2C:   ready
> DRAM:  2 GiB (ECC not enabled, 462 MHz, CL4)
> PCI:   Bus Dev VenId DevId Class Int
>         00  04  1095  3512  0104  00
>         00  06  126f  0501  0380  00
> PCIE0: successfully set as root-complex
>         03  00  1412  1724  0401  ff
>         02  00  1b21  1080  0604  00
> PCIE1: successfully set as root-complex
>         05  00  1002  683f  0300  ff
> Net:   ppc_4xx_eth0
> FPGA:  Revision 03 (2010-10-07)
> SM502: found
> PERMD2:not found
> VGA:   1
> VESA:  OK
> 
> 
> U-Boot 2015.a (May 16 2015 - 14:20:11)
> 
> CPU:   AMCC PowerPC 460EX Rev. B at 1155 MHz (PLB=231 OPB=115 EBC=115)
>        No Security/Kasumi support
>        Bootstrap Option H - Boot ROM Location I2C (Addr 0x52)
>        Internal PCI arbiter enabled
>        32 kB I-Cache 32 kB D-Cache
> Board: Sam460ex/cr, PCIe 4x + PCIe 1x
> I2C:   ready
> DRAM:  2 GiB (ECC not enabled, 462 MHz, CL4)
> PCI:   Bus Dev VenId DevId Class Int
>         00  04  1095  3512  0104  00
>         00  06  126f  0501  0380  00
> PCIE0: successfully set as root-complex
>         03  00  1412  1724  0401  ff
>         02  00  1b21  1080  0604  00
> PCIE1: successfully set as root-complex
>         05  00  1002  683f  0300  ff
> Net:   ppc_4xx_eth0
> FPGA:  Revision 03 (2010-10-07)
> SM502: found
> PERMD2:not found
> VGA:   1
> VESA:  OK
> 
> 
> U-Boot 2015.a (May 16 2015 - 14:20:11)
> 
> CPU:   AMCC PowerPC 460EX Rev. B at 1155 MHz (PLB=231 OPB=115 EBC=115)
>        No Security/Kasumi support
>        Bootstrap Option H - Boot ROM Location I2C (Addr 0x52)
>        Internal PCI arbiter enabled
>        32 kB I-Cache 32 kB D-Cache
> Board: Sam460ex/cr, PCIe 4x + PCIe 1x
> I2C:   ready
> DRAM:  2 GiB (ECC not enabled, 462 MHz, CL4)
> PCI:   Bus Dev VenId DevId Class Int
>         00  04  1095  3512  0104  00
>         00  06  126f  0501  0380  00
> PCIE0: successfully set as root-complex
>         03  00  1412  1724  0401  ff
>         02  00  1b21  1080  0604  00
> PCIE1: successfully set as root-complex
>         05  00  1002  683f  0300  ff
> Net:   ppc_4xx_eth0
> FPGA:  Revision 03 (2010-10-07)
> SM502: found
> PERMD2:not found
> VGA:   1
> VESA:  OK
> [    0.000000] Using Canyonlands machine description
> [    0.000000] Linux version 4.7.0-sam460ex-jm-06999-g1056c9b-dirty (root@julian-VirtualBox) (gcc version 5.4.0 20160609 (Ubuntu 5.4.0-6ubuntu1~16.04.1) ) #4 PREEMPT Mon Aug 8 06:26:13 AST 2016
> [    0.000000] Zone ranges:
> [    0.000000]   DMA      [mem 0x0000000000000000-0x000000002fffffff]
> [    0.000000]   Normal   empty
> [    0.000000]   HighMem  [mem 0x0000000030000000-0x000000007fffffff]
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000000000000-0x000000007fffffff]
> [    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x000000007fffffff]
> [    0.000000] MMU: Allocated 1088 bytes of context maps for 255 contexts
> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 522752
> [    0.000000] Kernel command line: root=/dev/sda0 console=ttyS0,115200 console=tty0 fb=false
> [    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
> [    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
> [    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
> [    0.000000] Sorting __ex_table...
> [    0.000000] allocated 2097152 bytes of page_ext
> [    0.000000] Memory: 1997308K/2097152K available (7972K kernel code, 344K rwdata, 4468K rodata, 260K init, 1412K bss, 99844K reserved, 0K cma-reserved, 1310720K highmem)
> [    0.000000] Kernel virtual memory layout:
> [    0.000000]   * 0xfffcf000..0xfffff000  : fixmap
> [    0.000000]   * 0xffc00000..0xffe00000  : highmem PTEs
> [    0.000000]   * 0xffa00000..0xffc00000  : consistent mem
> [    0.000000]   * 0xffa00000..0xffa00000  : early ioremap
> [    0.000000]   * 0xf1000000..0xffa00000  : vmalloc & ioremap
> [    0.000000] SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
> [    0.000000] Preemptible hierarchical RCU implementation.
> [    0.000000] Build-time adjustment of leaf fanout to 32.
> [    0.000000] NR_IRQS:512 nr_irqs:512 16
> [    0.000000] UIC0 (32 IRQ sources) at DCR 0xc0
> [    0.000000] UIC1 (32 IRQ sources) at DCR 0xd0
> [    0.000000] UIC2 (32 IRQ sources) at DCR 0xe0
> [    0.000000] UIC3 (32 IRQ sources) at DCR 0xf0
> [    0.000014] clocksource: timebase: mask: 0xffffffffffffffff max_cycles: 0x10a60dda894, max_idle_ns: 440795207041 ns
> [    0.000028] clocksource: timebase mult[dda520] shift[24] registered
> [    0.000162] Console: colour dummy device 80x25
> [    0.000734] console [tty0] enabled
> [    0.000772] pid_max: default: 32768 minimum: 301
> [    0.000898] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
> [    0.000927] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
> [    0.003809] devtmpfs: initialized
> [    0.007405] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
> [    0.007619] xor: measuring software checksum speed
> [    0.017656]    8regs     :   896.000 MB/sec
> [    0.027470]    8regs_prefetch:   800.000 MB/sec
> [    0.037523]    32regs    :  1232.000 MB/sec
> [    0.047593]    32regs_prefetch:  1052.000 MB/sec
> [    0.047628] xor: using function: 32regs (1232.000 MB/sec)
> [    0.047655] prandom: seed boundary self test passed
> [    0.049712] prandom: 100 self tests passed
> [    0.050377] NET: Registered protocol family 16
> [    0.055893] cpuidle: using governor ladder
> [    0.058910] cpuidle: using governor menu
> [    0.059338] 256k L2-cache enabled
> [    0.059456] PCIE0: Checking link...
> [    0.059473] PCIE0: Device detected, waiting for link...
> [    0.059492] PCIE0: link is up !
> [    0.162821] PCI host bridge /plb/pciex@d00000000 (primary) ranges:
> [    0.162871]  MEM 0x0000000e00000000..0x0000000e7fffffff -> 0x0000000080000000
> [    0.162908]  MEM 0x0000000f00000000..0x0000000f000fffff -> 0x0000000000000000
> [    0.162940]   IO 0x0000000f80000000..0x0000000f8000ffff -> 0x0000000000000000
> [    0.162978] 4xx PCI DMA offset set to 0x00000000
> [    0.162996] 4xx PCI DMA window base to 0x0000000000000000
> [    0.163015] DMA window size 0x0000000080000000
> [    0.163050] PCIE0: successfully set as root-complex
> [    0.163099] PCIE1: Checking link...
> [    0.163116] PCIE1: Device detected, waiting for link...
> [    0.163134] PCIE1: link is up !
> [    0.267187] PCI host bridge /plb/pciex@d20000000 (primary) ranges:
> [    0.267230]  MEM 0x0000000e80000000..0x0000000effffffff -> 0x0000000080000000
> [    0.267266]  MEM 0x0000000f00100000..0x0000000f001fffff -> 0x0000000000000000
> [    0.267298]   IO 0x0000000f80010000..0x0000000f8001ffff -> 0x0000000000000000
> [    0.267329] 4xx PCI DMA offset set to 0x00000000
> [    0.267346] 4xx PCI DMA window base to 0x0000000000000000
> [    0.267365] DMA window size 0x0000000080000000
> [    0.267396] PCIE1: successfully set as root-complex
> [    0.267486] PCI host bridge /plb/pci@c0ec00000 (primary) ranges:
> [    0.267515]  MEM 0x0000000d80000000..0x0000000dffffffff -> 0x0000000080000000
> [    0.267551]  MEM 0x0000000c0ee00000..0x0000000c0eefffff -> 0x0000000000000000
> [    0.267582]   IO 0x0000000c08000000..0x0000000c0800ffff -> 0x0000000000000000
> [    0.267612] 4xx PCI DMA offset set to 0x00000000
> [    0.267630] 4xx PCI DMA window base to 0x0000000000000000
> [    0.267649] DMA window size 0x0000000080000000
> [    0.276802] PCI: Probing PCI hardware
> [    0.277181] PCI host bridge to bus 0000:40
> [    0.277222] pci_bus 0000:40: root bus resource [io 0xfffc0000-0xfffcffff] (bus address [0x0000-0xffff])
> [    0.277261] pci_bus 0000:40: root bus resource [mem 0xe00000000-0xe7fffffff] (bus address [0x80000000-0xffffffff])
> [    0.277298] pci_bus 0000:40: root bus resource [mem 0xf00000000-0xf000fffff] (bus address [0x00000000-0x000fffff])
> [    0.277335] pci_bus 0000:40: root bus resource [bus 40-ff]
> [    0.277520] PCI: Hiding 4xx host bridge resources 0000:40:00.0
> [    0.280928] pci 0000:40:00.0: PCI bridge to [bus 41-7f]
> [    0.281058] pci 0000:41:00.0: bridge configuration invalid ([bus 02-02]), reconfiguring
> [    0.281909] pci 0000:41:00.0: PCI bridge to [bus 42-ff]
> [    0.282277] PCI host bridge to bus 0001:80
> [    0.282316] pci_bus 0001:80: root bus resource [io 0xfffe0000-0xfffeffff] (bus address [0x0000-0xffff])
> [    0.282352] pci_bus 0001:80: root bus resource [mem 0xe80000000-0xeffffffff] (bus address [0x80000000-0xffffffff])
> [    0.282389] pci_bus 0001:80: root bus resource [mem 0xf00100000-0xf001fffff] (bus address [0x00000000-0x000fffff])
> [    0.282425] pci_bus 0001:80: root bus resource [bus 80-ff]
> [    0.282565] PCI: Hiding 4xx host bridge resources 0001:80:00.0
> [    0.287008] pci 0001:80:00.0: PCI bridge to [bus 81-bf]
> [    0.287438] PCI host bridge to bus 0002:00
> [    0.287476] pci_bus 0002:00: root bus resource [io 0x0000-0xffff]
> [    0.287502] pci_bus 0002:00: root bus resource [mem 0xd80000000-0xdffffffff] (bus address [0x80000000-0xffffffff])
> [    0.287539] pci_bus 0002:00: root bus resource [mem 0xc0ee00000-0xc0eefffff] (bus address [0x00000000-0x000fffff])
> [    0.287575] pci_bus 0002:00: root bus resource [bus 00-ff]
> [    0.288606] pci 0000:40:00.0: BAR 13: assigned [io 0xfffc1000-0xfffc1fff]
> [    0.288650] pci 0000:41:00.0: BAR 13: assigned [io 0xfffc1000-0xfffc1fff]
> [    0.288678] pci 0000:42:00.0: BAR 1: assigned [io 0xfffc1000-0xfffc107f]
> [    0.288708] pci 0000:42:00.0: BAR 0: assigned [io 0xfffc1080-0xfffc109f]
> [    0.288736] pci 0000:41:00.0: PCI bridge to [bus 42]
> [    0.288760] pci 0000:41:00.0:   bridge window [io 0xfffc1000-0xfffc1fff]
> [    0.288793] pci 0000:40:00.0: PCI bridge to [bus 41-7f]
> [    0.288815] pci 0000:40:00.0:   bridge window [io 0xfffc1000-0xfffc1fff]
> [    0.288914] pci 0001:80:00.0: BAR 15: assigned [mem 0xe80000000-0xe8fffffff 64bit pref]
> [    0.288997] pci 0001:80:00.0: BAR 14: assigned [ 0.27] pc001:0.0:  13:ignedo  0e1000fffe]
> [ 0.289] p01:8.0: 0: aned [ 0xe0000-8fff 64biref]
>    0100]  000:00.0AR 2signemem 000000xe9fff t]
> [ 0.29] pc001:0.0: 6: gned m 0x40p:81:: BAR assd [mexe9000-0x063f4bit]    09211i 0001:00BAR 4ssign[io ffe10xffff]
>   0.38]00000.I b to  8
> [ 289pci:80:   gew [ixff0-01ff   928i 00: 93i 00:00  b wi[mem80-0xfffit
> [.28 pc2:00: B: ed0xd0003ff
> [ .28 pc2:00: : aed 0xd00041f
> [.289 pc2:00: : ased0xd000-42ssi[mem84-0x01f    952i 00:0BARssi[io 0000f]  0.53]00004.R igno  0-0]
> 0.28] p02:.0:2: ned 0x0x1
> [  289pci:0: B asdi0:04BAR 3ssig[io  024-27]
>   0.352] 6: inx1  g)   MB/s
>    0.213]d6: i2x1 ()    MB/    07235id6: 32x2n()  0 M[ 14374aid6:t32xor() 36 M
> [   4315raidnt32xgen(433 M
> [  .448 raidint32 xor  ge  2/s
>  0.48] ra: in8  x   20B/s
>   0.52] 6: u algohm ix4 g 433 s
> [0.4] rai ...r() 2MB/sw end
> [0.4] ra usintx1 overgori
> [   4834vgaardevicddedI:0001:00ecodeo+memns=nlock0] vg: br con posse 001:00.[    8394CSI systemitiad
> [ 0.485] use: rteredw inace der u
> [  .4853 usb: regered  intce dr hub    5439]bcoregistd nevice ver u
> [  485g
> [  .486 pps_e: Sare v 5.3. Copht 202007olfomettiometlinu>
> [ 0.48] Pock ort ster[    8732DAC MVer:.0
> [ 0.487] Aced Lx SoArchiturever ializ
> [ .490 clocurceitcheo cloourc
> [ 4910Cachees: Led
>  0.512] NRegised pcol fly 2
>    0724 estshed h taentr 819rder: 327yte    0861]P biash e ens: 8(ord5, 160 b
> [ .5111 TCPsh ts couredtabd 81ind )
> [0.51] UDPsh t enP-Liash e ens: 5ord, 24byt[    1245ET: strotocfami
> [  .512 RPCgist namNIX et trportule.   0.826]: Reered trart me.
> [ 0.54] RRegied trans movkchan trart moe.
>  0.511]  notap b
> [  5162dw_dm4bff0.dmesigne DMntrol, 1nels   478] ex tabltries56 (r: 068 b)
> [ 0.52] wogsetmestabitsmax_r=19ket_r=0
>   0.35] : lo
> [  . 07] init I ven 7.
> [  55446asyn: apiitiad (as)
> [0.554] bo: pooize:page    04732ockr SCeneribsg)ver vion loademajo9)
> [ 0.58] iohedunoop iste
> [   5547io suler dlinerfaul[    5717rc32C_LE_S = CRC_BITS
> [  .557 crc3selfts pad, pssed944s in440 n
> [.558 crc CBIT4
> [ 0.558] cr: selestssed, cess25944tes 94864ec
>  0.625] c_comb: 83eco 837lf  pa
> [  6967glob: selstsed, iled
>    0153] irq:ting ggee 3 irqailic_serq_t0x0/0)
>  0.64] apro 000:00ie00ileh er-22
>   0.92] port0:400: Siling  thr PCIeE inupt
>   0.30 Perr[   9865ci 0042:0 Signg PMhrougCIe intet
> [0.69] gen: Seg trir mo for  46 ed (uset_type+/0x1
> [   69875pci: prof 0080:0pcie0faileith r -22    0760]rial50/ 2251nsoletyS0sabl[    428eri0.0:S0 atIO 060030irq , baaud =1200 a U6550A
>    2663] sole yS0]bled
> [    2.034220] serial8250.0: ttyS1 at MMIO 0x4ef600400 (irq = 24, base_baud = 691200) is a U6_16550A
> [    2.044492] console [ttyS0] disabled
> [    0.000000] Using Canyonlands machine description
> [    0.000000] Linux version 4.7.0-sam460ex-jm-06999-g1056c9b-dirty (rjirtuax) (gvers5.4.016060Ubunt.4.0untu1.04. #4 PMPT MAug :26:1ST 2
> [   0000Zone ges:
>    0000] MA  [mem 0000000000x000002fff]
>   0.000] rmal mpty   0.000] ighM[mem 000000ble staor eanode 0.000]ly mey nodange    00000node : [mex000000000-0x00007ffff 0000itmetup  0 [0x00000000-000000ffff[    0000MU: Acate88 by of ext m for conts
> [ 0.00] Bp  Topages2275    00000rnel mande: ro/dev0 cone=tty1152onsolty0 alse
>    0000]  hasble eies:6 (: 2, 84 b)
> [0.000] Den cacash te ents: 12 (or: 7, 288 s)
>  0.00] In-cacash te ens: 65 (ord 6, 44 by)
> [00allocd 202 bytof pext
>   0.000] ry: 1308K7152Kail(7972ernede, 3 rwd 4468odata60K , 14bss,44K rrved cma-erved3107highm
> [  .000 Kernvirtmemorayou[    0000 * 000] 0xff00.e000: him PTE[ 0000 * 000000xffc0  :sistmem
>   0.000]0xf00..a00: eaiorem
> [  0000  * 00000xff00  alloiorem
> [  0000SLUBalign, Or0-3, Obje0, CP1, N=1
> imptati
> [   0000Builimestmef leanout 32.   0.000]IRQS nr_:512
> [  00000UIC0 IRQrces DC0
> [ 0.00] UI32 IRourcat Dxd0  0.00] ( so) a 0xe0    0000C3 (RQ ses) aCR 0affffffffmax_ces: a60d4, mdle_447041
> [ 000clockrce:ebalt[d0] [24]iste
> [ 000Cons codumvice25
> [ 0.04] cle [] end
> 0.000] x: dlt: 38 mim: 3[    00898ounths)
>  0.07] Mpoinche  tablntri2048 der:8192 e  0.09] mpfs:itiad
> [0.00] cloourciffiemask:ffff maxles: ffff max_e_ns1126027500s
> [0.007] xoreasu sofeum
> [ .01   s ch:0.00/sec   0523]32reg  :  2.00/sec
>    0.593]32rere  10500 Mc
> [ 0.04] xorsingction2regs232.MB/se
> [   0476prand seedundarelf  pass
> [   04971pran 100 f tepass[ 60.055] cpue: u gover lad
> [  .058 cpu: usigove men   93386k L2che eled
>   050: ing... 730: De ed, ing flink
> [  0594PCIEinkp !
>   0.21]host dge /pci0000x0e00000..000000ffff> 0x000000000 2908]EM 00000f00000x000f000ff -> 000000000
> [  .1629   000080000..0x000f8ffff 0x0000000
> [ 0.168] 4CI DMffsett to 00000
> [  162994xx PDMA ow bato 00 000008000
> [  .1630 PCIsucceully  as -comp
> [  .163 PCIECheck link
> [ .1631 PCIEDevietect wai for k...   0134] E1: l is
> [  .2671 PCIt bri /plbiex@00000rimarange
> [   2672 MEM 0000800
>  0.26] 0x0000f0000..000001fff> 0x00000000    07298IO 0x00001000x000f800f -> 00000000
> [   26734xx DMAet so 0x0000
>    0346] PCI winbase 0x000000000
> [ 0.25] DMindowze 00cy se rootmple    7486I horidgelb/p0ec00 (priy) rs:
> [ 0.25]  M0x000d80000..00000fffff> 0x000080000     7551]EM 00000c0000x000c0eeff ->000000000
> [  .2675   I000000800. 0.22] 4CI Dffsett to00000
> [  26764xx DMA ow bato 000000000    07649]A wi size000080000
> [  .276 PCI:obinI harre
>  0.271] Post bge tos 00
> [0.277] pcis 000: robus urce x00ffff[    77261ci_b000:4root resoe [mexe0000-0ffff(buress 8000-0xfffff]    07298i_bus00:4oot bresou [mef00000-0xfffffbus ess [00000x000ff])
>    0.335]_bus0:40:ot besou[bus ff]
>  s 0000:00[    80928ci 040:00 PCI dge bus 4f]
>  0.28] pc000:0.0:dge iguran ind ([02-02 recgurin[    8190ci 0041:0 PCIdge tbus f]
> [ 0.287] Post bge ts 0000
> [ 0.28] pcis 000 dressx000ffff][   82352ci_b001:8root resoe [mxe80000-0fffff(bus ress80000-0xff   238i_b01:ootres [mf0010-0fffbusess0000x0ff]   425_bu1:8ot beso[bress 0:00[  870ci 80: PCdgebusf]
>  0.8] ostge s 000
> 0.2s 00: busurc  0-0xf
> [.28 pc 00: rus rce 0x000ffff] (ddr0x80s ce [0xc000ee (budrex000-0fff[   875ci_002roo ree [b0-f   860i 000BARass [ifff-0xfff   650 0:00AR ssi[ioffc0xfR 1igneo  0c100fffc]
> [0.28] pc00:.0: 0: aned  0xff080-fc10
> [   2887pci 0:41:: PCidge[bus
> [ .288 pci0:41:0: dge ow [0xff00-0xc1ff[   8879ci 040:00 PCIdge tbus f]
> [ 0.25]1000ffc1f
> [  .288 pci1:800: BA5: aned [ 0xe0000-8fff 64biref]
>    0997] 0001:00.0AR 1ssign[mem90000-0xe9ffff    09027i 0000:00BAR assig [iofffe1-0xffff]
>    0.058] 0001:00.0Aft pr
> [   2891pci 0:81:: BAR assd [mxe9000-003ff4bit]    9139i 0001:00BAR 6ssig[mem9004-0xefffff]
> [ 0.22] p001:0.1 0:gnedm 060000e900f 64
> [  .289 pci 1:810: B: assed [0c80:00 PCIdge tbus f]
> [ 0.21] pc001:0.0: ridgndo  0xf1000ffe1f
> [ .289 pci 1:800:   dge ow [m0xe9000-000ff
> [  .289 pci 1:800:  dge wow [0xe80000-ffff64bief]
>   0.213] 000206.0:R 0:  0.41] 000206.0:R 1:ignedem 00000xd841ff]
>   0.269]00004.0R 6:igneem 0x2000xd842ff p
> [  .289 pci2:00:0: B: assed [0xd84000-42801
> [ .2895 pci2:00:0: B: aseci00:0 BAR assi [io 1010017]
>    0579]  000:04.0AR 2signeio  18-0xf]
>  0.24] pc002:4.0: 1: gned  0x1-0x1
> [  .289 pci 2:000: BA: ased [i0x10x102[    63052aid6t32x1en()00 M
> [   3.397 raidint3 gen 390 s
> [0.41] rai int  xor  23/s
>  0.439] r: in4  ge   4B/s
>   0.38] r6: x4  )   MB/s
>    0688] d6: 2x8 ()   MB/    2828]id6:32x8 r() 7 MB/[ 8285aid6:ing rit: .or()  MB/mw eed
>  0.480] r: usintx1covelgori
> [ .4834 vga devaddeCI:081:00decoio+mwns=,locone
>   0.79] vrb: ed
> [ 0.44] vb: be conl pole 081:00
> [  48394SCSIsystenitew facver s
> [0.48] usbe: rterew inace der h[   8543sbcoregied neviciver
> [  .485 pps_e: LPPS ver.egistd
> [0.4] ppre: ware . 5.- Cght 2-200dolfoometgiom@linist
> [  48732EDAC Ver0.0
>   0.97] ncedux S Archcturivertiali.
> [0.490] clourcwitchto csourcimeb
> [  49079FS-C: Loa
> [ .491 Cachles:ded  0.592]  Regired ocolily 2    0724]P o, 32bytes[   1086CP bihashle enes: 8 (or 5, 40 b)
> [0.51] TCPash es cogurestabed 8bind 2)
>  0.510] Uash e ents: 5orde, 245byte[   1139DP-Lihashlees: (or2, 2 byt
> [  5124NET:]egisd naUNIX ket spordule    02826C: Rterep tort le.
>   0.44] R Regred transt mo.
> [ 0.51] RPegisd tcSv4.1ckchl trort le.
>   0.551] d notmap
> [ .516 dw_ 4bf00.dmDesirx able ries6 (o: 0, 8 by
> [ .5253 worset:estamits=ax_o=19 et_o=0
>  0.55] zb loa
> [   5481ntfsiver .32 gs: .
> [ 0.54] funit  vers 7.2[   54464sync apitial (as
>   732]ck l SCSInerisg) er veon 0oadeajor)
> [ 0.55] ioeduleoop ster[   547o scler dlineiste
> [  55498io suler regred ault)    7179c32: _LE_ = 6RC_BTS =
> [   5572crc3elf ts p558crc3CRC_ITS =
> [  .558 crc selfsts ped, essed5944es in4864c
> [0.62] crcombi lf  pass
> [   6967crc3ombin8373f tespass[    96794lob:self-ts pad, 0led
>   0.653] rqx0/0x)
> [ 0.69] aerobe 000100.0:e002led w err22
> [ 0.62] pcort :40:0: Siing PthroPCIe  intpt
>  00] p000:40.0:nalinME thgh PPME irrup    08654i 0002:00Signg PMErougIe PMnt mof46 fd (uet_iype+00x16[    9875cie_ prof 0000:00cie0ailedth  -2   760]ial:0/1dri2 po IRQring ble 0251]solyS0]abl    2803rial.0: 0 atO 0x40030rq =  basuole S0] eled  220] al825: ttat MM0x4e400 ( = 24ase_ = 60) isU6_1A
> [ 2.044] coe [tt] dised
> [ 2.04] 4e0300ial: S0 aIO 0x600irq =, basaud =1200 a 16
> [  .2401 con [tty ena
> [  ttt MMIx4ef00 (i= 24,se_b= 691) i6550
> [    354137PAPR ervibyte nnelver
> [    3.59300enerion-vile mry drr v1[    3.264900] drm]tiali dr.0 2810[  69918drm]eon kel mo76drm] tialg ker modeting RDE 02:0xF 0x:0x70x00)[    38479drm]isterio b 0xe90000
>    3.578]m] reter m size62144
> [    3.625894] ATOM BIOS: C44501
> [    3.629187] radeon 0001:81:00.0: VRAM: 1024M 0x0000000000000000 - 0x000000003FFFFFFF (1024M used)
> [    3.638118] radeon 0001:81:00.0: GTT: 2048M 0x0000000040000000 - 0x00000000BFFFFFFF
> [    3.645811] [drm] Detected VRAM RAM=1024M, BAR=256M
> [    3.650711] [drm] RAM width 128bits DDR
> [    3.654757] [TTM] Zone  kernel: Available graphics memory: 376780 kiB
> [    3.661251] [TTM] Zone highmem: Available graphics memory: 1032140 kiB
> [    3.667811] [TTM] Initializing pool allocator
> [    3.672209] [TTM] Initializing DMA pool allocator
> [    3.677040] [drm] radeon: 1024M of VRAM memory ready
> [    3.682047] [drm] radeon: 2048M of GTT memory ready.
> [    3.687089] [drm] Loading verde Microcode
> [    3.691162] [drm] Internal thermal controller with fan control
> [    3.697373] [drm] probing gen 2 caps for device aaa1:bed1 = 18cc41/0
> [    3.746388] [drm] radeon: dpm initialized
> [    3.752789] [drm] Found VCE firmware/feedback version 50.0.1 / 17!
> [    3.759063] [drm] GART: num cpu pages 524288, num gpu pages 524288
> [    3.775632] [drm] probing gen 2 caps for device aaa1:bed1 = 18cc41/0
> [    3.831981] [drm] PCIE GART of 2048M enabled (table at 0x00000000001D6000).
> [    3.839329] radeon 0001:81:00.0: WB enabled
> [    3.843571] radeon 0001:81:00.0: fence driver on ring 0 use gpu addr 0x0000000040000c00 and cpu addr 0xffc01c00
> [    3.853700] radeon 0001:81:00.0: fence driver on ring 1 use gpu addr 0x0000000040000c04 and cpu addr 0xffc01c04
> [    3.863828] radeon 0001:81:00.0: fence driver on ring 2 use gpu addr 0x0000000040000c08 and cpu addr 0xffc01c08
> [    3.873958] radeon 0001:81:00.0: fence driver on ring 3 use gpu addr 0x0000000040000c0c and cpu addr 0xffc01c0c
> [    3.884088] radeon 0001:81:00.0: fence driver on ring 4 use gpu addr 0x0000000040000c10 and cpu addr 0xffc01c10
> [    3.910846] radeon 0001:81:00.0: fence driver on ring 5 use gpu addr 0x0000000000075a18 and cpu addr 0xf90b5a18
> [    3.947919] radeon 0001:81:00.0: fence driver on ring 6 use gpu addr 0x0000000040000c18 and cpu addr 0xffc01c18
> [    3.958081] radeon 0001:81:00.0: fence driver on ring 7 use gpu addr 0x0000000040000c1c and cpu addr 0xffc01c1c
> [    3.968212] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
> [    3.974854] [drm] Driver supports precise vblank timestamp query.
> [    3.980975] radeon 0001:81:00.0: radeon: MSI limited to 32-bit
> [    3.986851] ppc4xx_setup_msi_irqs: fail allocating msi interrupt
> [    3.992948] [drm] radeon: irq initialized.
> [    4.751266] [drm:r600_ring_test] *ERROR* radeon: ring 0 test failed (scratch(0x850C)=0xCAFEDEAD)
> [    4.760116] radeon 0001:81:00.0: disabling GPU acceleration
> [    4.969071] [drm] Radeon Display Connectors
> [    4.973801] [drm] Connector 0:
> [    4.976926] [drm]   HDMI-A-1
> [    4.979861] [drm]   HPD4
> [    4.982477] [drm]   DDC: 0x6570 0x6570 0x6574 0x6574 0x6578 0x6578 0x657c 0x657c
> [    4.989931] [drm]   Encoders:
> [    4.992946] [drm]     DFP1: INTERNAL_UNIPHY2
> [    4.997246] [drm] Connector 1:
> [    5.000317] [drm]   DVI-I-1
> [    5.003128] [drm]   HPD2
> [    5.005686] [drm]   DDC: 0x6560 0x6560 0x6564 0x6564 0x6568 0x6568 0x656c 0x656c
> [    5.013117] [drm]   Encoders:
> [    5.016108] [drm]     DFP2: INTERNAL_UNIPHY
> [    5.020311] [drm]     CRT1: INTERNAL_KLDSCP_DAC1
> [    5.137541] [drm] fb mappable at 0x805D7000
> [    5.141763] [drm] vram apper at 0x80000000
> [    5.145882] [drm] size 8294400
> [    5.148953] [drm] fb depth is 24
> [    5.152199] [drm]    pitch is 7680
> [    5.449365] Console: switching to colour frame buffer device 240x67
> [    5.527518] radeon 0001:81:00.0: fb0: radeondrmfb frame buffer device
> [    5.536617] [drm] Initialized radeon 2.45.0 20080528 for 0001:81:00.0 on minor 0
> [    5.544972] [drm] amdgpu kernel modesetting enabled.
> [    5.567055] brd: module loaded
> [    5.578466] loop: module loaded
> [    5.582413] sm501 0002:00:06.0: enabling device (0004 -> 0006)
> [    5.588821] sm501 0002:00:06.0: incorrect device id c0000105
> [    5.596300] sata_sil 0002:00:04.0: Applying R_ERR on DMA activate FIS errata fix
> [    5.606508] scsi host0: sata_sil
> [    5.610798] scsi host1: sata_sil
> [    5.614663] ata1: SATA max UDMA/100 mmio m512@0xd84280000 tf 0xd84280080 irq 22
> [    5.622607] ata2: SATA max UDMA/100 mmio m512@0xd84280000 tf 0xd842800c0 irq 22
> [    5.631619] libphy: Fixed MDIO Bus: probed
> [    5.636726] PPC 4xx OCP EMAC driver, version 3.54
> [    5.642143] MAL v2 /plb/mcmal, 2 TX channels, 16 RX channels
> [    5.648500] ZMII /plb/opb/emac-zmii@ef600d00 initialized
> [    5.654419] RGMII /plb/opb/emac-rgmii@ef601500 initialized with MDIO support
> [    5.662173] TAH /plb/opb/emac-tah@ef601350 initialized
> [    5.667767] TAH /plb/opb/emac-tah@ef601450 initialized
> [    5.673656] /plb/opb/emac-rgmii@ef601500: input 0 in RGMII mode
> [    5.681475] eth0: EMAC-0 /plb/opb/ethernet@ef600e00, MAC 00:50:c2:80:d5:00
> [    5.688925] eth0: found Generic MII PHY (0x00)
> [    5.693905] /plb/opb/emac-rgmii@ef601500: input 1 in RGMII mode
> [    5.701669] eth1: EMAC-1 /plb/opb/ethernet@ef600f00, MAC 00:00:00:00:00:00
> [    5.709115] eth1: found Generic MII PHY (0x01)
> [    5.713968] PPP generic driver version 2.4.2
> [    5.718911] PPP BSD Compression module registered
> [    5.724057] PPP Deflate Compression module registered
> [    5.729438] NET: Registered protocol family 24
> [    5.734820] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> [    5.742111] ppc-of-ehci 4bffd0400.ehci: OF EHCI
> [    5.747218] ppc-of-ehci 4bffd0400.ehci: new USB bus registered, assigned bus number 1
> [    5.755838] ppc-of-ehci 4bffd0400.ehci: irq 32, io mem 0x4bffd0400
> [    5.768549] ppc-of-ehci 4bffd0400.ehci: USB 2.0 started, EHCI 1.00
> [    5.775297] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
> [    5.782498] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    5.790149] usb usb1: Product: OF EHCI
> [    5.808104] usb usb1: Manufacturer: Linux 4.7.0-sam460ex-jm-06999-g1056c9b-dirty ehci_hcd
> [    5.830638] usb usb1: SerialNumber: PPC-OF USB
> [    5.850003] hub 1-0:1.0: USB hub found
> [    5.868098] hub 1-0:1.0: 1 port detected
> [    5.886698] ehci-pci: EHCI PCI platform driver
> [    5.905697] ehci-platform: EHCI generic platform driver
> [    5.925647] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
> [    5.946487] ppc-of-ohci 4bffd0000.usb: OF OHCI
> [    5.965248] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> [    5.986223] ata1.00: ATAPI: ASUS    DRW-24B3ST   i, 1.00, max UDMA/100
> [    6.008139] ppc-of-ohci 4bffd0000.usb: new USB bus registered, assigned bus number 2
> [    6.030992] ata1.00: configured for UDMA/100
> [    6.050717] ppc-of-ohci 4bffd0000.usb: irq 33, io mem 0x4bffd0000
> [    6.075646] scsi 0:0:0:0: CD-ROM            ASUS DRW-24B3ST   i   1.00 PQ: 0 ANSI: 5
> [    6.132731] sr 0:0:0:0: [sr0] scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 cdda tray
> [    6.178537] cdrom: Uniform CD-ROM driver Revision: 3.20
> [    6.212547] usb 1-1: new high-speed USB device number 2 using ppc-of-ehci
> [    6.269842] sr 0:0:0:0: Attached scsi generic sg0 type 5
> [    6.330967] usb 1-1: New USB device found, idVendor=0424, idProduct=2517
> [    6.374543] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [    6.424722] hub 1-1:1.0: USB hub found
> [    6.465543] hub 1-1:1.0: 7 ports detected
> [    6.617682] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> [    6.672873] ata2.00: ATA-8: WDC WD5000AAKS-00UU3A0, 01.03B01, max UDMA/133
> [    6.720543] ata2.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 0/32)
> [    6.767833] ata2.00: configured for UDMA/100
> [    6.795548] usb 1-1.1: new high-speed USB device number 3 using ppc-of-ehci
> [    6.867808] scsi 1:0:0:0: Direct-Access     ATA      WDC WD5000AAKS-0 3B01 PQ: 0 ANSI: 5
> [    6.907170] usb 1-1.1: New USB device found, idVendor=1a40, idProduct=0101
> [    6.944509] sd 1:0:0:0: [sda] 976773168 512-byte logical blocks: (500 GB/466 GiB)
> [    6.944753] sd 1:0:0:0: [sda] Write Protect is off
> [    6.944762] sd 1:0:0:0: [sda] Mode Sense: 00 3a 00 00
> [    6.944858] sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> [    6.945233] sd 1:0:0:0: Attached scsi generic sg1 type 0
> [    6.954453]  sda: RDSK (512) sda1 (SFS^@)(res 2 spb 1) sda2 (SFS^@)(res 2 spb 1) sda3 (SFS^@)(res 2 spb 1) sda4 (SFS^@)(res 2 spb 1) sda5 (NTFS)(res 2 spb 2) sda6 ((res 2 spb 1) sda7 ((res 2 spb 1) sda8 ((res 2 spb 1)
> [    6.957008] sd 1:0:0:0: [sda] Attached SCSI disk
> [    6.994875] usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
> [    6.994882] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    6.994887] usb usb2: Product: OF OHCI
> [    6.994892] usb usb2: Manufacturer: Linux 4.7.0-sam460ex-jm-06999-g1056c9b-dirty ohci_hcd
> [    6.994897] usb usb2: SerialNumber: PPC-OF USB
> [    6.995601] hub 2-0:1.0: USB hub found
> [    6.995638] hub 2-0:1.0: 1 port detected
> [    6.996192] ohci-pci: OHCI PCI platform driver
> [    6.996327] ohci-platform: OHCI generic platform driver
> [    6.996469] uhci_hcd: USB Universal Host Controller Interface driver
> [    6.997103] usbcore: registered new interface driver usblp
> [    6.997289] usbcore: registered new interface driver usb-storage
> [    6.997494] usbcore: registered new interface driver usbserial
> [    6.997637] usbcore: registered new interface driver usbserial_generic
> [    6.997725] usbserial: USB Serial support registered for generic
> [    6.998229] mousedev: PS/2 mouse device common for all mice
> [    6.999925] i2c /dev entries driver
> [    7.003492] Unable to handle kernel paging request for data at address 0x000001dc
> [    7.003496] Faulting instruction address: 0xc07c09b8
> [    7.003505] Vector: 300 (Data Access) at [eea4bd20]
> [    7.003533]     pc: c07c09b8: __mutex_lock_slowpath+0x80/0x2f4
> [    7.003543]     lr: c07c0958: __mutex_lock_slowpath+0x20/0x2f4
> [    7.003545]     sp: eea4bdd0
> [    7.003547]    msr: 21000
> [    7.003550]    dar: 1dc
> [    7.003552]  dsisr: 800000
> [    7.003555]   current = 0xeea50000
> [    7.003558]     pid   = 1463, comm = irq/47-m41t80
> [    7.003564] Linux version 4.7.0-sam460ex-jm-06999-g1056c9b-dirty (root@julian-VirtualBox) (gcc version 5.4.0 20160609 (Ubuntu 5.4.0-6ubuntu1~16.04.1) ) #4 PREEMPT Mon Aug 8 06:26:13 AST 2016
> [    7.003592] enter ? for help
> [    7.003609] [eea4be30] c07c0c44 mutex_lock+0x18/0x24
> [    7.003629] [eea4be40] c058c95c m41t80_handle_irq+0x28/0xac
> [    7.003643] [eea4be60] c0056510 irq_thread_fn+0x2c/0x48
> [    7.003653] [eea4be80] c0056730 irq_thread+0xc4/0x160
> [    7.003666] [eea4bed0] c003fc10 kthread+0xc8/0xcc
> [    7.003682] [eea4bf40] c000b14c ret_from_kernel_thread+0x5c/0x64
> [    7.003688] mon>  <no input ...>
> [    9.003736] Oops: Kernel access of bad area, sig: 11 [#1]
> [    9.003739] PREEMPT Canyonlands
> [    9.003743] Modules linked in:
> [    9.003751] CPU: 0 PID: 1463 Comm: irq/47-m41t80 Not tainted 4.7.0-sam460ex-jm-06999-g1056c9b-dirty #4
> [    9.003756] task: eea50000 task.stack: eea4a000
> [    9.003759] NIP: c07c09b8 LR: c07c0958 CTR: c058c934
> [    9.003763] REGS: eea4bd20 TRAP: 0300   Not tainted (4.7.0-sam460ex-jm-06999-g1056c9b-dirty)
> [    9.003772] MSR: 00021000 <CE,ME>  CR: 24000222  XER: 20000000
> [    9.003823] DEAR: 000001dc ESR: 00800000
> [    9.003823] GPR00: c07c0958 eea4bdd0 eea50000 00000000 eea2f000 00000000 00000000 eea5032c
> [    9.003823] GPR08: c0dc4aac 00000000 00000000 eea4be80 24082284 00000000 c003fb48 eea259e0
> [    9.003823] GPR16: 00000000 00000000 00000000 00000000 00000000 c0cb0000 00000001 ee9f6c54
> [    9.003823] GPR24: eea30064 00000000 ee9f6c5c eea50000 eea259b0 00029000 c0cc0000 000001d8
> [    9.003830] NIP [c07c09b8] __mutex_lock_slowpath+0x80/0x2f4
> [    9.003835] LR [c07c0958] __mutex_lock_slowpath+0x20/0x2f4
> [    9.003837] Call Trace:
> [    9.003845] [eea4bdd0] [c07c0958] __mutex_lock_slowpath+0x20/0x2f4 (unreliable)
> [    9.003851] [eea4be30] [c07c0c44] mutex_lock+0x18/0x24
> [    9.003858] [eea4be40] [c058c95c] m41t80_handle_irq+0x28/0xac
> [    9.003863] [eea4be60] [c0056510] irq_thread_fn+0x2c/0x48
> [    9.003869] [eea4be80] [c0056730] irq_thread+0xc4/0x160
> [    9.003875] [eea4bed0] [c003fc10] kthread+0xc8/0xcc
> [    9.003881] [eea4bf40] [c000b14c] ret_from_kernel_thread+0x5c/0x64
> [    9.003884] Instruction dump:
> [    9.003899] 81291398 2f890000 40be001c 3c80c0b5 3c60c0b5 3884363f 38632cae 480028d1
> [    9.003912] 0fe00000 7fa000a6 7c000146 39200000 <913f0004> 813e1190 2f890000 409e0044
> [    9.003922] ---[ end trace 3db80573360ccdb3 ]---
> [    9.003924]
> [    9.003930] note: irq/47-m41t80[1463] exited with preempt_count 1
> [    9.003939] Unable to handle kernel paging request for data at address 0xffffffe0
> [    9.003941] Faulting instruction address: 0xc0040040
> [    9.003945] Vector: 300 (Data Access) at [eea4bbc0]
> [    9.003955]     pc: c0040040: kthread_data+0x4/0xc
> [    9.003965]     lr: c0056604: irq_thread_dtor+0x48/0xb0
> [    9.003967]     sp: eea4bc70
> [    9.003970]    msr: 21000
> [    9.003972]    dar: ffffffe0
> [    9.003974]  dsisr: 0
> [    9.003977]   current = 0xeea50000
> [    9.003980]     pid   = 1463, comm = irq/47-m41t80
> [    9.003985] Linux version 4.7.0-sam460ex-jm-06999-g1056c9b-dirty (root@julian-VirtualBox) (gcc version 5.4.0 20160609 (Ubuntu 5.4.0-6ubuntu1~16.04.1) ) #4 PREEMPT Mon Aug 8 06:26:13 AST 2016
> [    9.003990] enter ? for help
> [    9.003994] mon>  <no input ...>
> [   11.004039] Oops: Kernel access of bad area, sig: 11 [#2]
> [   11.004041] PREEMPT Canyonlands
> [   11.004044] Modules linked in:
> [   11.004050] CPU: 0 PID: 1463 Comm: irq/47-m41t80 Tainted: G      D         4.7.0-sam460ex-jm-06999-g1056c9b-dirty #4
> [   11.004053] task: eea50000 task.stack: eea4a000
> [   11.004056] NIP: c0040040 LR: c0056604 CTR: c00565bc
> [   11.004060] REGS: eea4bbc0 TRAP: 0300   Tainted: G D          (4.7.0-sam460ex-jm-06999-g1056c9b-dirty)
> [   11.004069] MSR: 00021000 <CE,ME>  CR: 44002824  XER: 20000000
> [   11.004121] DEAR: ffffffe0 ESR: 00000000
> [   11.004121] GPR00: c003e550 eea4bc70 eea50000 eea50000 00000000 00000001 00000000 00000000
> [   11.004121] GPR08: eea4a000 00000000 00000004 eea4bcb0 24002424 00000000 c003fb48 eea259e0
> [   11.004121] GPR16: 00000000 00000000 00000000 00000000 00000000 c0cb0000 00000001 ee9f6c54
> [   11.004121] GPR24: eea30064 00000000 c0cbd000 eea4bcb8 c0dc0000 eea5032c 00000000 eea50000
> [   11.004126] NIP [c0040040] kthread_data+0x4/0xc
> [   11.004130] LR [c0056604] irq_thread_dtor+0x48/0xb0
> [   11.004131] Call Trace:
> [   11.004138] [eea4bc70] [00021000] 0x21000 (unreliable)
> [   11.004156] [eea4bc80] [c003e550] task_work_run+0x90/0xac
> [   11.004174] [eea4bcb0] [c00286f4] do_exit+0x304/0x7a0
> [   11.004188] [eea4bcf0] [c00077a4] die+0x26c/0x274
> [   11.004195] [eea4bd10] [c000b530] handle_page_fault+0x7c/0x80
> [   11.004204] --- interrupt: 300 at __mutex_lock_slowpath+0x80/0x2f4
> [   11.004204]     LR = __mutex_lock_slowpath+0x20/0x2f4
> [   11.004211] [eea4be30] [c07c0c44] mutex_lock+0x18/0x24
> [   11.004217] [eea4be40] [c058c95c] m41t80_handle_irq+0x28/0xac
> [   11.004223] [eea4be60] [c0056510] irq_thread_fn+0x2c/0x48
> [   11.004229] [eea4be80] [c0056730] irq_thread+0xc4/0x160
> [   11.004234] [eea4bed0] [c003fc10] kthread+0xc8/0xcc
> [   11.004241] [eea4bf40] [c000b14c] ret_from_kernel_thread+0x5c/0x64
> [   11.004244] Instruction dump:
> [   11.004257] 7ce0412d 40a2fff4 7f831000 419e0010 48004389 387fffe4 4877f2f5 39200000
> [   11.004271] 39610010 7d234b78 4bfd1b90 81230238 <8069ffe0> 4e800020 9421ffe0 39200000
> [   11.004274] ---[ end trace 3db80573360ccdb4 ]---
> [   11.004275]
> [   11.004277] Fixing recursive fault but reboot is needed!
> [   11.004283] sched: RT throttling activated
> [   11.004391] Unable to handle kernel paging request for data at address 0x00000008
> [   11.004394] Faulting instruction address: 0xc0247fec
> [   11.004399] Vector: 300 (Data Access) at [eea4ba70]
> [   11.004416]     pc: c0247fec: exit_shm+0x18/0x148
> [   11.004426]     lr: c00286c4: do_exit+0x2d4/0x7a0
> [   11.004429]     sp: eea4bb20
> [   11.004431]    msr: 29000
> [   11.004433]    dar: 8
> [   11.004435]  dsisr: 0
> [   11.004438]   current = 0xeea50000
> [   11.004441]     pid   = 1463, comm = irq/47-m41t80
> [   11.004447] Linux version 4.7.0-sam460ex-jm-06999-g1056c9b-dirty (root@julian-VirtualBox) (gcc version 5.4.0 20160609 (Ubuntu 5.4.0-6ubuntu1~16.04.1) ) #4 PREEMPT Mon Aug 8 06:26:13 AST 2016
> [   11.004456] enter ? for help
> [   11.004461] mon>  <no input ...>
> [   13.004560] Oops: Kernel access of bad area, sig: 11 [#3]
> [   13.004563] PREEMPT Canyonlands
> [   13.004567] Modules linked in:
> [   13.004573] CPU: 0 PID: 1463 Comm: irq/47-m41t80 Tainted: G      D         4.7.0-sam460ex-jm-06999-g1056c9b-dirty #4
> [   13.004576] task: eea50000 task.stack: eea4a000
> [   13.004579] NIP: c0247fec LR: c00286c4 CTR: c0047ec4
> [   13.004583] REGS: eea4ba70 TRAP: 0300   Tainted: G D          (4.7.0-sam460ex-jm-06999-g1056c9b-dirty)
> [   13.004594] MSR: 00029000 <CE,EE,ME>  CR: 24008222  XER: 00000000
> [   13.004647] DEAR: 00000008 ESR: 00000000
> [   13.004647] GPR00: c00286c4 eea4bb20 eea50000 eea50000 00000000 7728a33b 00000001 00000800
> [   13.004647] GPR08: ffffffff 00000000 eea503a0 eea4bb50 c0c72960 00000000 c003fb48 eea259e0
> [   13.004647] GPR16: 00000000 00000000 00000000 00000000 00000000 c0cb0000 00000001 ee9f6c54
> [   13.004647] GPR24: eea30064 00000000 eea502d8 eea4bb58 0000000b 00000000 eea4a000 eea50000
> [   13.004653] NIP [c0247fec] exit_shm+0x18/0x148
> [   13.004659] LR [c00286c4] do_exit+0x2d4/0x7a0
> [   13.004661] Call Trace:
> [   13.004674] [eea4bb20] [c0cb0000] udp_prot+0x30/0xcc (unreliable)
> [   13.004681] [eea4bb50] [c00286c4] do_exit+0x2d4/0x7a0
> [   13.004690] [eea4bb90] [c00077a4] die+0x26c/0x274
> [   13.004698] [eea4bbb0] [c000b530] handle_page_fault+0x7c/0x80
> [   13.004706] --- interrupt: 300 at kthread_data+0x4/0xc
> [   13.004706]     LR = irq_thread_dtor+0x48/0xb0
> [   13.004712] [eea4bc70] [00021000] 0x21000 (unreliable)
> [   13.004721] [eea4bc80] [c003e550] task_work_run+0x90/0xac
> [   13.004728] [eea4bcb0] [c00286f4] do_exit+0x304/0x7a0
> [   13.004734] [eea4bcf0] [c00077a4] die+0x26c/0x274
> [   13.004741] [eea4bd10] [c000b530] handle_page_fault+0x7c/0x80
> [   13.004752] --- interrupt: 300 at __mutex_lock_slowpath+0x80/0x2f4
> [   13.004752]     LR = __mutex_lock_slowpath+0x20/0x2f4
> [   13.004758] [eea4be30] [c07c0c44] mutex_lock+0x18/0x24
> [   13.004768] [eea4be40] [c058c95c] m41t80_handle_irq+0x28/0xac
> [   13.004773] [eea4be60] [c0056510] irq_thread_fn+0x2c/0x48
> [   13.004779] [eea4be80] [c0056730] irq_thread+0xc4/0x160
> [   13.004785] [eea4bed0] [c003fc10] kthread+0xc8/0xcc
> [   13.004792] [eea4bf40] [c000b14c] ret_from_kernel_thread+0x5c/0x64
> [   13.004794] Instruction dump:
> [   13.004808] 80010014 7fc3f378 bbc10008 7c0803a6 38210010 4be06c5c 9421ffd0 7c0802a6
> [   13.004822] bf210014 90010034 3b4302d8 812302ec <83890008> 812302d8 7f9a4840 419e011c
> [   13.004826] ---[ end trace 3db80573360ccdb5 ]---
> [   13.004827]
> [   13.004830] Fixing recursive fault but reboot is needed!
> [   13.492945] rtc-m41t80 8-0068: rtc core: registered m41t80 as rtc0
> [   13.587274] ibm-iic 4ef600700.i2c: using standard (100 kHz) mode
> [   13.587797] ibm-iic 4ef600800.i2c: using standard (100 kHz) mode
> [   13.587956] md: linear personality registered for level -1
> [   13.587959] md: raid0 personality registered for level 0
> [   13.587962] md: raid1 personality registered for level 1
> [   13.587965] md: raid10 personality registered for level 10
> [   13.611405] md: raid6 personality registered for level 6
> [   13.611410] md: raid5 personality registered for level 5
> [   13.611413] md: raid4 personality registered for level 4
> [   13.612218] device-mapper: ioctl: 4.35.0-ioctl (2016-06-23) initialised: dm-devel@redhat.com
> [   13.612221] EDAC PPC4xx MC: v1.0.0
> [   13.612224] EDAC PPC4xx MC: Reporting type: interrupt
> [   13.612598] hidraw: raw HID events driver (C) Jiri Kosina
> [   13.613518] usbcore: registered new interface driver usbhid
> [   13.613521] usbhid: USB HID core driver
> [   13.696645] snd_ice1724 0000:42:00.0: No matching model found for ID 0x12140324
> [   13.789334] usbcore: registered new interface driver snd-usb-audio
> [   13.790261] usbcore: registered new interface driver snd-ua101
> [   13.790421] usbcore: registered new interface driver snd-usb-usx2y
> [   13.790648] ipip: IPv4 and MPLS over IPv4 tunneling driver
> [   13.791274] Initializing XFRM netlink socket
> [   13.792696] NET: Registered protocol family 10
> [   13.794090] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
> [   13.795089] NET: Registered protocol family 17
> [   13.795110] NET: Registered protocol family 15
> [   13.795346] Running MSI bitmap self-tests ...
> [   13.796661] zswap: loaded using pool lzo/zbud
> [   13.817734] Key type encrypted registered
> [   13.935593] rtc-m41t80 8-0068: setting system clock to 2016-08-08 06:26:43 UTC (1470637603)
> [   13.935749] ALSA device list:
> [   13.935751]   #0: Virtual MIDI Card 1
> [   13.935754]   #1: ICEnsemble ICE1724 at 0xfffc1080, irq 19
> [   17.639439] md: Waiting for all devices to be available before autodetect
> [   17.660067] usb 1-1.1: New USB device strings: Mfr=0, Product=1, SerialNumber=0
> [   17.660073] usb 1-1.1: Product: USB 2.0 Hub
> [   17.660953] hub 1-1.1:1.0: USB hub found
> [   17.661157] hub 1-1.1:1.0: 4 ports detected
> [   17.737755] md: If you don't use raid, use raid=noautodetect
> [   17.758229] md: Autodetecting RAID arrays.
> [   17.776473] md: Scanned 0 and added 0 devices.
> [   17.794750] md: autorun ...
> [   17.811349] md: ... autorun DONE.
> [   17.828864] VFS: Cannot open root device "sda0" or unknown-block(0,0): error -6
> [   17.850250] Please append a correct "root=" boot option; here are the available partitions:
> [   17.872910] 0100          131072 ram0  (driver?)
> [   17.891933] usb 1-1.2: new low-speed USB device number 4 using ppc-of-ehci
> [   17.913474] 0101          131072 ram1  (driver?)
> [   17.932742] 0102          131072 ram2  (driver?)
> [   17.951806] 0103          131072 ram3  (driver?)
> [   17.970542] 0104          131072 ram4  (driver?)
> [   17.989165] 0105          131072 ram5  (driver?)
> [   18.007689] 0106          131072 ram6  (driver?)
> [   18.026207] 0107          131072 ram7  (driver?)
> [   18.044619] 0108          131072 ram8  (driver?)
> [   18.062999] 0109          131072 ram9  (driver?)
> [   18.081110] 010a          131072 ram10  (driver?)
> [   18.099036] usb 1-1.2: New USB device found, idVendor=045e, idProduct=07b9
> [   18.099043] usb 1-1.2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [   18.099048] usb 1-1.2: Product: USB Keyboard
> [   18.099053] usb 1-1.2: Manufacturer: LITEON Technology
> [   18.158236] usb 1-1.1.1: new full-speed USB device number 5 using ppc-of-ehci
> [   18.199232] input: LITEON Technology USB Keyboard as /devices/platform/plb/4bffd0400.ehci/usb1/1-1/1-1.2/1-1.2:1.0/0003:045E:07B9.0001/input/input0
> [   18.226697] 010b          131072 ram11  (driver?)
> [   18.245552] 010c          131072 ram12  (driver?)
> [   18.265255] hid-generic 0003:045E:07B9.0001: input,hidraw0: USB HID v1.10 Keyboard [LITEON Technology USB Keyboard] on usb-PPC-OF USB-1.2/input0
> [   18.293796] 010d          131072 ram13  (driver?)
> [   18.313565] 010e          131072 ram14  (driver?)
> [   18.333168] 010f          131072 ram15  (driver?)
> [   18.352562] 0b00         1048575 sr0 [   18.356323] usb 1-1.1.1: New USB device found, idVendor=0d8c, idProduct=000c
> [   18.356330] usb 1-1.1.1: New USB device strings: Mfr=0, Product=1, SerialNumber=0
> [   18.356335] usb 1-1.1.1: Product: C-Media USB Audio Device
> [   18.423918] usb 1-1.6: new full-speed USB device number 6 using ppc-of-ehci
> 
> [   18.446376]  driver: sr
> [   18.479340] 0800       488386584 sda  driver: sd
> [   18.499307]   0801         2096688 sda1
> [   18.518445]   0802        52428312 sda2
> [   18.537351]   0803        52428312 sda3
> [   18.555949]   0804        52428312 sda4
> [   18.574448]   0805       246168744 sda5
> [   18.593093]   0806        21798912 sda6
> [   18.611485]   0807        19531248 sda7
> [   18.629686]   0808        19531248 sda8
> [   18.647810] Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)
> [   18.670422] Rebooting in 180 seconds..
> 
> U-Boot 2015.a (May 16 2015 - 14:20:11)
> 
> CPU:   AMCC PowerPC 460EX Rev. B at 1155 MHz (PLB=231 OPB=115 EBC=115)
>        No Security/Kasumi support
>        Bootstrap Option H - Boot ROM Location I2C (Addr 0x52)
>        Internal PCI arbiter enabled
>        32 kB I-Cache 32 kB D-Cache
> Board: Sam460ex/cr, PCIe 4x + PCIe 1x
> I2C:   ready
> DRAM:  2 GiB (ECC not enabled, 462 MHz, CL4)
> PCI:   Bus Dev VenId DevId Class Int
>         00  04  1095  3512  0104  00
>         00  06  126f  0501  0380  00
> PCIE0: successfully set as root-complex
>         03  00  1412  1724  0401  ff
>         02  00  1b21  1080  0604  00
> PCIE1: successfully set as root-complex
>         05  00  1002  683f  0300  ff
> Net:   ppc_4xx_eth0
> FPGA:  Revision 03 (2010-10-07)
> SM502: found
> PERMD2:not found
> VGA:   1
> VESA:  OK
> 
> 
> U-Boot 2015.a (May 16 2015 - 14:20:11)
> 
> CPU:   AMCC PowerPC 460EX Rev. B at 1155 MHz (PLB=231 OPB=115 EBC=115)
>        No Security/Kasumi support
>        Bootstrap Option H - Boot ROM Location I2C (Addr 0x52)
>        Internal PCI arbiter enabled
>        32 kB I-Cache 32 kB D-Cache
> Board: Sam460ex/cr, PCIe 4x + PCIe 1x
> I2C:   ready
> DRAM:  2 GiB (ECC not enabled, 462 MHz, CL4)
> PCI:   Bus Dev VenId DevId Class Int
>         00  04  1095  3512  0104  00
>         00  06  126f  0501  0380  00
> PCIE0: successfully set as root-complex
>         03  00  1412  1724  0401  ff
>         02  00  1b21  1080  0604  00
> PCIE1: successfully set as root-complex
>         05  00  1002  683f  0300  ff
> Net:   ppc_4xx_eth0
> FPGA:  Revision 03 (2010-10-07)
> SM502: found
> PERMD2:not found
> VGA:   1
> VESA:  OK
> [    0.000000] Linux version 4.7.0-rc3-sam460ex-jm-00238-gf7b9ebb-dirty (root@julian-VirtualBox) (gcc version 5.4.0 20160609 (Ubuntu 5.4.0-6ubuntu1~16.04.1) ) #6 PREEMPT Mon Aug 8 06:45:28 AST 2016
> [    0.000000] Using Canyonlands machine description
> [    0.000000] Zone ranges:
> [    0.000000]   DMA      [mem 0x0000000000000000-0x000000002fffffff]
> [    0.000000]   Normal   empty
> [    0.000000]   HighMem  [mem 0x0000000030000000-0x000000007fffffff]
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000000000000-0x000000007fffffff]
> [    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x000000007fffffff]
> [    0.000000] MMU: Allocated 1088 bytes of context maps for 255 contexts
> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 522752
> [    0.000000] Kernel command line: root=/dev/sda0 console=ttyS0,115200 console=tty0 fb=false
> [    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
> [    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
> [    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
> [    0.000000] Sorting __ex_table...
> [    0.000000] allocated 2097152 bytes of page_ext
> [    0.000000] Memory: 1997356K/2097152K available (7928K kernel code, 344K rwdata, 4456K rodata, 260K init, 1420K bss, 99796K reserved, 0K cma-reserved, 1310720K highmem)
> [    0.000000] Kernel virtual memory layout:
> [    0.000000]   * 0xfffcf000..0xfffff000  : fixmap
> [    0.000000]   * 0xffc00000..0xffe00000  : highmem PTEs
> [    0.000000]   * 0xffa00000..0xffc00000  : consistent mem
> [    0.000000]   * 0xffa00000..0xffa00000  : early ioremap
> [    0.000000]   * 0xf1000000..0xffa00000  : vmalloc & ioremap
> [    0.000000] SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
> [    0.000000] Preemptible hierarchical RCU implementation.
> [    0.000000] Build-time adjustment of leaf fanout to 32.
> [    0.000000] NR_IRQS:512 nr_irqs:512 16
> [    0.000000] UIC0 (32 IRQ sources) at DCR 0xc0
> [    0.000000] UIC1 (32 IRQ sources) at DCR 0xd0
> [    0.000000] UIC2 (32 IRQ sources) at DCR 0xe0
> [    0.000000] UIC3 (32 IRQ sources) at DCR 0xf0
> [    0.000014] clocksource: timebase: mask: 0xffffffffffffffff max_cycles: 0x10a60dda894, max_idle_ns: 440795207041 ns
> [    0.000026] clocksource: timebase mult[dda520] shift[24] registered
> [    0.000162] Console: colour dummy device 80x25
> [    0.000746] console [tty0] enabled
> [    0.000784] pid_max: default: 32768 minimum: 301
> [    0.000901] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
> [    0.000928] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
> [    0.003844] devtmpfs: initialized
> [    0.007520] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
> [    0.007725] xor: measuring software checksum speed
> [    0.017646]    8regs     :   900.000 MB/sec
> [    0.027466]    8regs_prefetch:   800.000 MB/sec
> [    0.037514]    32regs    :  1232.000 MB/sec
> [    0.047589]    32regs_prefetch:  1084.000 MB/sec
> [    0.047624] xor: using function: 32regs (1232.000 MB/sec)
> [    0.047649] prandom: seed boundary self test passed
> [    0.049700] prandom: 100 self tests passed
> [    0.050442] NET: Registered protocol family 16
> [    0.055874] cpuidle: using governor ladder
> [    0.057955] cpuidle: using governor menu
> [    0.058398] 256k L2-cache enabled
> [    0.058518] PCIE0: Checking link...
> [    0.058535] PCIE0: Device detected, waiting for link...
> [    0.058555] PCIE0: link is up !
> [    0.160876] PCI host bridge /plb/pciex@d00000000 (primary) ranges:
> [    0.160928]  MEM 0x0000000e00000000..0x0000000e7fffffff -> 0x0000000080000000
> [    0.160965]  MEM 0x0000000f00000000..0x0000000f000fffff -> 0x0000000000000000
> [    0.160997]   IO 0x0000000f80000000..0x0000000f8000ffff -> 0x0000000000000000
> [    0.161034] 4xx PCI DMA offset set to 0x00000000
> [    0.161053] 4xx PCI DMA window base to 0x0000000000000000
> [    0.161072] DMA window size 0x0000000080000000
> [    0.161108] PCIE0: successfully set as root-complex
> [    0.161157] PCIE1: Checking link...
> [    0.161174] PCIE1: Device detected, waiting for link...
> [    0.161193] PCIE1: link is up !
> [    0.263236] PCI host bridge /plb/pciex@d20000000 (primary) ranges:
> [    0.263280]  MEM 0x0000000e80000000..0x0000000effffffff -> 0x0000000080000000
> [    0.263315]  MEM 0x0000000f00100000..0x0000000f001fffff -> 0x0000000000000000
> [    0.263347]   IO 0x0000000f80010000..0x0000000f8001ffff -> 0x0000000000000000
> [    0.263379] 4xx PCI DMA offset set to 0x00000000
> [    0.263396] 4xx PCI DMA window base to 0x0000000000000000
> [    0.263415] DMA window size 0x0000000080000000
> [    0.263446] PCIE1: successfully set as root-complex
> [    0.263540] PCI host bridge /plb/pci@c0ec00000 (primary) ranges:
> [    0.263569]  MEM 0x0000000d80000000..0x0000000dffffffff -> 0x0000000080000000
> [    0.263605]  MEM 0x0000000c0ee00000..0x0000000c0eefffff -> 0x0000000000000000
> [    0.263636]   IO 0x0000000c08000000..0x0000000c0800ffff -> 0x0000000000000000
> [    0.263684] 4xx PCI DMA offset set to 0x00000000
> [    0.263705] 4xx PCI DMA window base to 0x0000000000000000
> [    0.263724] DMA window size 0x0000000080000000
> [    0.272812] PCI: Probing PCI hardware
> [    0.273199] PCI host bridge to bus 0000:40
> [    0.273241] pci_bus 0000:40: root bus resource [io 0xfffc0000-0xfffcffff] (bus address [0x0000-0xffff])
> [    0.273279] pci_bus 0000:40: root bus resource [mem 0xe00000000-0xe7fffffff] (bus address [0x80000000-0xffffffff])
> [    0.273317] pci_bus 0000:40: root bus resource [mem 0xf00000000-0xf000fffff] (bus address [0x00000000-0x000fffff])
> [    0.273355] pci_bus 0000:40: root bus resource [bus 40-ff]
> [    0.273544] PCI: Hiding 4xx host bridge resources 0000:40:00.0
> [    0.275894] pci 0000:40:00.0: PCI bridge to [bus 41-7f]
> [    0.276021] pci 0000:41:00.0: bridge configuration invalid ([bus 02-02]), reconfiguring
> [    0.276930] pci 0000:41:00.0: PCI bridge to [bus 42-ff]
> [    0.277304] PCI host bridge to bus 0001:80
> [    0.277343] pci_bus 0001:80: root bus resource [io 0xfffe0000-0xfffeffff] (bus address [0x0000-0xffff])
> [    0.277380] pci_bus 0001:80: root bus resource [mem 0xe80000000-0xeffffffff] (bus address [0x80000000-0xffffffff])
> [    0.277417] pci_bus 0001:80: root bus resource [mem 0xf00100000-0xf001fffff] (bus address [0x00000000-0x000fffff])
> [    0.277455] pci_bus 0001:80: root bus resource [bus 80-ff]
> [    0.277603] PCI: Hiding 4xx host bridge resources 0001:80:00.0
> [    0.280974] pci 0001:80:00.0: PCI bridge to [bus 81-bf]
> [    0.281409] PCI host bridge to bus 0002:00
> [    0.281447] pci_bus 0002:00: root bus resource [io 0x0000-0xffff]
> [    0.281474] pci_bus 0002:00: root bus resource [mem 0xd80000000-0xdffffffff] (bus address [0x80000000-0xffffffff])
> [    0.281512] pci_bus 0002:00: root bus resource [mem 0xc0ee00000-0xc0eefffff] (bus address [0x00000000-0x000fffff])
> [    0.281549] pci_bus 0002:00: root bus resource [bus 00-ff]
> [    0.282598] pci 0000:40:00.0: BAR 13: assigned [io 0xfffc1000-0xfffc1fff]
> [    0.282641] pci 0000:41:00.0: BAR 13: assigned [io 0xfffc1000-0xfffc1fff]
> [    0.282669] pci 0000:42:00.0: BAR 1: assigned [io 0xfffc1000-0xfffc107f]
> [    0.282699] pci 0000:42:00.0: BAR 0: assig[io ffc0xf9f] 028]00000.0I br to  42]   752] 000xfffcf]
>  0.285] p000:40.0:  brito [41-[   8280ci 40:0   e wi [iofffc-0xffff]
>    0911]  0001:00.AR 15ssign[mem80000-0xeffff it p
> [  .283 pc1:80: 4: aned  0xe0000900]13: gned  0xf1000-ffe1
> [  .2830 pci1:81:0: B: ased 0xe8000-ffff64bief]  003] 000100.0R 2:ignedem 000000xe90ff 64]
> [ 0.28] pci01:8.0: B6: asned  0xe [   836bit]   0.215] 000:00.AR 4signio  fe10xffff]
>  0.3] 0010. brito 81-[  83ci 080:   bre wi [iofffe-0xffff]
>    0292]  000:00.0 bridwinmem 0000xeffwinmem 000000xe8ffff t pre
> [   28341pci :00:0: BAR assd [mexd8000-0xfff
> [ 2834pci :00:: BA assd [xd84000-1ffff
> [  28347pci 0:00:: BAR assid [mxd84200-0x27ffref]
>    508 1f   0535] 000:04.0AR 4signeio  00-0xf]
> [ 0.280] p002:04.0:  0: gned   0-0x
> [ .28 pci2:000: BA: ased [0x10x101f[   8361ci 0000:0 BAR assi [io 1020023]
>    0.638] 0002:040] : int1  g   30B/s
>   0.39] r6: inx1  )   1MB/s   0.260] d6: 2x2  ()   MB/s 0335id6:32xr() 6 MB[    2755aid6:t32x4en()33 MB
> [   4445raid6nt32xxor(246 M
> [ . s
> [0.47] r in  xor  20/s
> [ 0.49] ra: usalgorm int4 ge433 M
> [ .4787 rai.... () 2B/s,  enab
> [ .4787 raiusingtx1veryorith[ 79292gaareviceded::000:00.codes+mems=nonockse
> [  vg bricontrposs 00:00    9826]SI sustemtiali
> [  .481 usbc: reered  intce drr us
> [ 4812usbco regred nintee dri hub
>    0337]corgis newice er u[   8188ps_c LinuS APr. 1 iste
> [   481pps_ct007 lfo Gettiomeinux
> [ .482 PTPck srt retered    3249]AC Mer: 30
> [ 0.48] Aded Li Sourchiture er Inalize
> [  48653clocrctch clourceebase    6790]-CacLoade[    8709]egisd prool fy 2
>   0.85] Testahed tntri8192der:3276tes)   0.229] bindsh t ent: 81order, 16 byte
> [   5079TCP: h tab conred (abli 819nd 8
> [.508 UDh tent 512der:24576t e: 51rder: 245ytes)   8448T: Reterotocami
> [ 509RPC:isnameIX sot trort mle.
>   0.40]  Regired transt mod.
> [0.509] RPCegisd tcpanspmodu
> [   5090RPCistetcp 4.1 chantrant mop[    1247w_dmabffd0.dmasignW DMAtrol 1 chels
>   0.553]rq: inger 3 frq 46iledc_seq_tyx0/0x)
> [ 0.52] fuhash le ees: 2(ord0, 71bytes[  21388orkit: titamps.53 zboaded    4469fs: der 22 [Fl: R/
> [   54524fuset (APersi.24)   0.779]nc_txpi ialias[  508ounool: 6es
>  0.4] B lCSI ric) d ve 0.dedor
> [ 551io ulep rt   1234 ser cegid (lt)  057] 2:E_B 64_BE = 369c32f tpprd 2 bn 9 ns   4891c32C_LS =[  549rc3elfs p, psed44cmb37 tas   456c32bin73 tessse   613b: lf- pa 0 d
> [0.6] g: Seg tr m fo 4edsettyp/0x
> [  696pci 00:00.ig PMEouge Pterr
> [ 6964pPCIe intpt
>  0.0] p000:0.0:naliME thgh PPME irrupt 6554iepor001:80.0:nalinME tgh PCPME irrupt    6581]i 0001:0Signg PMrougIe PMnterr
> [ .6966 pci 1:811: Sling thro PCIeE inupt
>   0 IRQ sing led  02]oleS0] bled   0413] ial80: t at M 0x40300q = 2based = 00) i U6_0A
> [ 2.6] cole [0] eed
> [    2.039068] serial8250.0: ttyS1 at MMIO 0x4ef600400 (irq = 24, base_baud = 691200) is a U6_16550A
> [    2.049355] console [ttyS0] disabled
> [    0.000000] Linux version 4.7.0-rc3-sam460ex-jm-002tual (grsio4.0 060unt.0-tu14.1)6 PRT Mong5:2 20    0000ingonlmacdescion
>   0.00]  ran
> [  .0000   D     0x000000000-0000fffff
> [  0000  N
> [ 000-00000ffff
> [  00000Movazone rt fach
> [.000 Earlemorde ras
> [0.0]      em 00000000000007ffff]
> [0.000] Inim senode mem 0000000000x0007ffff]
>  0.000] MAllocd 108ytescontineliin Zordobigroup on.tal s: 522
> 0.00] Ker com lineoot=//sdansoleyS0,00 le=tfb=
> [.000 PID h taentri 4096rder 163ytes)    0000ntryhe htabletri31072rder 5242by55der: 2621ytes)    0000rtingex_t...
>   0.00] cated9715tes oage_
> [   0000Memor19973/209K abl8K kl co344K ata,6K roa, 2init20K b 997rese, 0K-resd, 1320K mem)
>    0.000]nel vual ry lat:
>  0000  * c0000xffe00  ghmeEs
>  0.00]  xffa00..00000 consent
> [   0000  * a000000 rlymap
>   0.00]  0xf100..0a000: vmac & map
>   0.000] : HWn=32,der= Mrle rcRCUemenon.
>   0.000] ld-tadjunt af ft to
> [ .000 NR_:512 irqs 16
>   0.00] U (32 so) at  0xc    000C1 (3RQ ses) aCR 0x
> [   0000UIC2  IRQrces) DCR 0
> atxf0
>   0.14] cksou timee: m 0xffffff mcycl0x10da894ax_idns: 9520 ns
>   0.026] ksour timee muda520hift[ regired
>   0.62] Cole:our dy de 80[   00746onsotty0]abled    0784]d_maefa1] -cacash te ents: 2(orde1, 81byte[    0092ountt-cahashle enes: (ord 1, 8 byt
> [   00384devt: inilized    7520]ocksoe: jes: m: 0xffff _cyc 0xffff, _idl: 1044600 n    07725r: m646]8reg  : 0.00/sec
>    0466] 8regefet  800 MB
> [ .0  gs  1230 MB
> [  .047    gs_prtch:84.00B/se    07624r: us funcn: 3s (1000 Mec)
>   0.49] pdom:d boury stessed
>   0.00] 2] NRegised pcol fly 1    05874]uidlsing ernodder
>    0955] idleinrnoru
> [0.0] 252-caenabl
> [  0585PCIEheckilink
> [   0585PCIE0evictectewaitfor l...
>   0.055] 0: lis u
> [ e0000imaryange[    6092MEM 00000000000x000e7ffff ->000080000
> [ 0.16]  MEx000f00000..000ffff 0x000000000
>    0997] O 0x000f80000000008000f -> 000000000[    6103xx PCMA ot set 0x0000
>  0000
> [0.161] DMndow e 0000080000
>    0108] E0: essfu set rootplex
>    0157]E1: Ckingk...   174E1:ce deted,ting  lin
> [  .16 PCIElink up !   0.236]  hosidge b/pcd20000 (prr000ffff-> 0x000000000[   6331MEM 0000010000x0000f00ff ->000000000
> [0.26]   x0000f8000..0x0001fff 0x0000000
>   0.79] PCI offset to00000
> [ .263 4xx  DMAdow b to 00000
> 0.2] PC sucfullyt ast-cox
> [ 0.26] PCIst be /pci@c00000imaryange[    6356MEM 00000000000x000dffff -00080000
> 0.26]  x000c0ee00..0x0000fffff 0x000000000    0.636] O ->000000000[  636xx PMA ot se 0x0000
>   0.05] 4PCI windoase x000000000
> [ 0.26] DMndow e 0x000080000
>    0812] : Prg Prdw[    73199CI hbridgo bu00:40 3241i_bufff-0xffff] s ads [0x0-0x])
> [ 0.29] pus 040:  bourceem 000000xe7fff] ( add [0x80000fffff)
> [0.27] pcs 000: robus urce m 0x00000f000ff] (addr[0x00000fff
> [ .273 pci_ 000: roous rrce [ 40-
> [ dgurce00:4.0
>  0.274] p000:0 brto 41-7[   76021ci 041:00 briconfiatiovalidbus2]), onfing
> [ 0.270] p000:40.0: bridto [42-ff[   7730CI brio bus01:8 07343i_fff-0xffff] s ads [0x0-0x])
> [ 0.270] pus 0080:  buourcem 00000xefffff]  addr [0x0000-ffff)
> [ 0.27] pcs 0000: rbus rurcem 0xf00000f001f] (baddr[0x0000-00fffrce 80-
> [   277PCI: inghostdgeurce01:8.0
> [ 0.284] p001:80.0: brito [b81-b[  8140CI hbrido bus02:0 01447i_bu02:00oot resou [io0000-fff]
>    0474] _bus2:00:ot besour[me00xffff])
>   0.12] bus :00: t busourcmem ee0000xc0efff]s adds [0x000000ff])
>  0.289] pus 000: bus ourcus 0]
> [ 0.28] pc00:40.0: 13: gned   0x1000-ffc1
> [  .2826 pci0:410: Bf
> [ 28pci :42:: BA assd [ixfffc0-0x107f]    02699i 0002:00BAR ssign[io ffc10xfff9f]
>   0.228] 0000:00.0I  to 42]
>    0752] 000:00.0 briwindoio  fc100xffff]
> [ 0.25] pc000:0.0:ci40   e w [ifffc-0xfffff]   0911] 000:00.0AR 1ssig[mem8000-0xffffit p
> [  .283 pci 1:800: BA4: aned  0x0000900]
> [0.28] pc01:8.0: 13: agned  0xf1000ffe1f
> [.2830 p0x000-ffff64bief]  003] 00000.0R 2:igneem 000000xe90ff 64]
> [0.28] pc01:81.0: 6: asned  0xe00009005f pre[    831ci 81: BARassi [mee9000-0x63ffbit]   0sigio  fe10xfffef]
>  0.283] pc001:0.0: brito 81[   8326ci 0080:0   be wi [iofffe1-0xfff]   0.292] 000:00.0 briwindomem 000000xe9fff]   0318 00:00 bwindmem00000xef:  assid [mxd8000-0ffff
> [  283pci :00: B ad [xd800-1ff
> [  2834pci:00:: BA assd [mexd8400-0x27fffref]   0.508] 0002:04.AR 5signemem 42800xd1ff   535] 000f]
>  0.280] p002:04.0: 0: agned   0x-0x1
> [  .283 pci 2:000: B: ed0x10x101[    8361ci 00:04 BARassig [io1020-023]
>    0638]  000:04.0AR 3signio  024-0x7]
>  0.35036: ix1  x)   MB/s
>    0260] d6: 2x2  ()   MB/    0335]id6:32x2 r() 6 MB/[ 2755aidt32en()33 MB
> [  44453raidnt32xxor(246 M
> [  .461 raidint3 gen( 277 s
> [0.478] ra int3  alm int4 ge433 M
> [ .4787 raid....() 24B/s,  ena
> [  .4787 raiusingtx1 very orit[  7929gevid:00:00cod+mes=nocke
> 0.4] v: l
> [ .47 vg brconpos 000:.48 us: rere ince r us
> [481usb reredinte d hu   337coregis neiceer [ 81ps_ LiS Ar. ist
> [ 4819pps: Sre 5.3Copt 20007lfoett ckrt   324AC er:0
> 0.4] Aed  Srchureer ali
> [ 48clorcetch clurcebas  679-CLoa[  870achs: d
> 0.5] egid hed h tabntri8192 der:3276te  229 bish t ent: 81orde, 16 byte
> [   5079TCP:h ta conred (abli 8192nd 8
> [  .5081 UDPh tabentr 512 de2457tes)   0.182]-Litesh t entr: 8T: Rteredotocamily
> [  50900RPC:istenameIXt tort le.
>   0.40] R Regired trant mod.
> [ 0.509] RPegistd tcpanspmodul
> [   5090RPC: istertcp 4.1 bchantrant .
> 0.51] Conot rp bcsign DMAtrol 1 chels
>   0.553] rq: ing tger  3 forq ilc_sq_tx0/0)
> [0.52] fuhashle ees: 2(ord0, 71bytes[    2138orkint: titamps=28 _ord9 bu_orde
> [  .537 zbuoad    04469f
> 5452fuse t (APersi.24)
>    0779] nc_tpi inalizasync[    5087ounceool s: es
>  0.54]  layCSI gric ) dri ver 0.4 ded or 24
> [   55102io sulerp regered   0.039]schedr deane rtere dlt)
>   0.557] c2: CE_BIT 64,_BE B = 64    3697c32:f tepassprocd 225 byten 97 nsec   4891c3C_LES = 6[   54919rc32elf s pa, prosed 244 b in 42 ns
> [  62405crc32mbin373 s testasse    0456161b: 64lf-t pass 0 fad
> [0.695] gen: Seg trir mod for 46 fed (uset_itype/0x16
> [  69pc 000:00.0igna PME oughe PMEterr
> [   6964pci :41:: Siging throuPCIe intept
> [PME rrup    6554]iepo001:80.0:nalinME tgh PCPME rrupt    6581i 0001:00Signag PMroughIe Pnter
> [ .6 pc1:81:1: Sling thro PCIE intupt
>   0.04] Sal: /1655rive 02]ole S0] dbled  41ial80: at  0x40300q = based = 00) i U6_0A
>  2.016] le [0] ened
>  2.038] sel825 ttySt MMx4ef00
> .0 con [tt disd
> [ 2.05] 4e300.a200)a 1
> [ttenab
> [    3.256596] ef60.ser ttyt MMIx4ef00 (= 24,se_b= 69) is 6550
> [    366107PAPR ervbytnnever
> [    37127eneron-vile mry dr v1.[ dr.0 2810
> [    38190drm]eon kel mettn
> [    3.288056] drm]tialig ke modeting RDE 02:0xF 0x:0x70x00)[ 3.96742drm]isterio b 0xe0000
>    35mter  s62144[    3.637839] ATOM BIOS: C44501
> [    3.641131] radeon 0001:81:00.0: VRAM: 1024M 0x0000000000000000 - 0x000000003FFFFFFF (1024M used)
> [    3.650064] radeon 0001:81:00.0: GTT: 2048M 0x0000000040000000 - 0x00000000BFFFFFFF
> [    3.657749] [drm] Detected VRAM RAM=1024M, BAR=256M
> [    3.662642] [drm] RAM width 128bits DDR
> [    3.666696] [TTM] Zone  kernel: Available graphics memory: 376804 kiB
> [    3.673189] [TTM] Zone highmem: Available graphics memory: 1032164 kiB
> [    3.679750] [TTM] Initializing pool allocator
> [    3.684152] [TTM] Initializing DMA pool allocator
> [    3.688988] [drm] radeon: 1024M of VRAM memory ready
> [    3.693991] [drm] radeon: 2048M of GTT memory ready.
> [    3.699046] [drm] Loading verde Microcode
> [    3.703113] [drm] Internal thermal controller with fan control
> [    3.709319] [drm] probing gen 2 caps for device aaa1:bed1 = 18cc41/0
> [    3.758444] [drm] radeon: dpm initialized
> [    3.764845] [drm] Found VCE firmware/feedback version 50.0.1 / 17!
> [    3.771104] [drm] GART: num cpu pages 524288, num gpu pages 524288
> [    3.787836] [drm] probing gen 2 caps for device aaa1:bed1 = 18cc41/0
> [    3.848115] [drm] PCIE GART of 2048M enabled (table at 0x00000000001D6000).
> [    3.855452] radeon 0001:81:00.0: WB enabled
> [    3.859692] radeon 0001:81:00.0: fence driver on ring 0 use gpu addr 0x0000000040000c00 and cpu addr 0xee9afc00
> [    3.869817] radeon 0001:81:00.0: fence driver on ring 1 use gpu addr 0x0000000040000c04 and cpu addr 0xee9afc04
> [    3.879939] radeon 0001:81:00.0: fence driver on ring 2 use gpu addr 0x0000000040000c08 and cpu addr 0xee9afc08
> [    3.890061] radeon 0001:81:00.0: fence driver on ring 3 use gpu addr 0x0000000040000c0c and cpu addr 0xee9afc0c
> [    3.900183] radeon 0001:81:00.0: fence driver on ring 4 use gpu addr 0x0000000040000c10 and cpu addr 0xee9afc10
> [    3.927155] radeon 0001:81:00.0: fence driver on ring 5 use gpu addr 0x0000000000075a18 and cpu addr 0xf90b5a18
> [    3.964289] radeon 0001:81:00.0: fence driver on ring 6 use gpu addr 0x0000000040000c18 and cpu addr 0xee9afc18
> [    3.974451] radeon 0001:81:00.0: fence driver on ring 7 use gpu addr 0x0000000040000c1c and cpu addr 0xee9afc1c
> [    3.984576] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
> [    3.991212] [drm] Driver supports precise vblank timestamp query.
> [    3.997334] radeon 0001:81:00.0: radeon: MSI limited to 32-bit
> [    4.003208] ppc4xx_setup_msi_irqs: fail allocating msi interrupt
> [    4.009341] [drm] radeon: irq initialized.
> [    4.768930] [drm:r600_ring_test] *ERROR* radeon: ring 0 test failed (scratch(0x850C)=0xCAFEDEAD)
> [    4.777780] radeon 0001:81:00.0: disabling GPU acceleration
> [    4.987111] [drm] Radeon Display Connectors
> [    4.991831] [drm] Connector 0:
> [    4.994952] [drm]   HDMI-A-1
> [    4.997879] [drm]   HPD4
> [    5.000499] [drm]   DDC: 0x6570 0x6570 0x6574 0x6574 0x6578 0x6578 0x657c 0x657c
> [    5.007959] [drm]   Encoders:
> [    5.010978] [drm]     DFP1: INTERNAL_UNIPHY2
> [    5.015282] [drm] Connector 1:
> [    5.018355] [drm]   DVI-I-1
> [    5.021167] [drm]   HPD2
> [    5.023722] [drm]   DDC: 0x6560 0x6560 0x6564 0x6564 0x6568 0x6568 0x656c 0x656c
> [    5.031149] [drm]   Encoders:
> [    5.034135] [drm]     DFP2: INTERNAL_UNIPHY
> [    5.038336] [drm]     CRT1: INTERNAL_KLDSCP_DAC1
> [    5.156727] [drm] fb mappable at 0x805D7000
> [    5.160950] [drm] vram apper at 0x80000000
> [    5.165064] [drm] size 8294400
> [    5.168136] [drm] fb depth is 24
> [    5.171384] [drm]    pitch is 7680
> [    5.467542] Console: switching to colour frame buffer device 240x67
> [    5.546748] radeon 0001:81:00.0: fb0: radeondrmfb frame buffer device
> [    5.556599] [drm] Initialized radeon 2.45.0 20080528 for 0001:81:00.0 on minor 0
> [    5.564973] [drm] amdgpu kernel modesetting enabled.
> [    5.586955] brd: module loaded
> [    5.598410] loop: module loaded
> [    5.602364] sm501 0002:00:06.0: enabling device (0004 -> 0006)
> [    5.608771] sm501 0002:00:06.0: incorrect device id c0000105
> [    5.616269] sata_sil 0002:00:04.0: Applying R_ERR on DMA activate FIS errata fix
> [    5.626453] scsi host0: sata_sil
> [    5.630752] scsi host1: sata_sil
> [    5.634601] ata1: SATA max UDMA/100 mmio m512@0xd84280000 tf 0xd84280080 irq 22
> [    5.642511] ata2: SATA max UDMA/100 mmio m512@0xd84280000 tf 0xd842800c0 irq 22
> [    5.651517] libphy: Fixed MDIO Bus: probed
> [    5.656702] PPC 4xx OCP EMAC driver, version 3.54
> [    5.662126] MAL v2 /plb/mcmal, 2 TX channels, 16 RX channels
> [    5.668499] ZMII /plb/opb/emac-zmii@ef600d00 initialized
> [    5.674431] RGMII /plb/opb/emac-rgmii@ef601500 initialized with MDIO support
> [    5.682203] TAH /plb/opb/emac-tah@ef601350 initialized
> [    5.687790] TAH /plb/opb/emac-tah@ef601450 initialized
> [    5.693678] /plb/opb/emac-rgmii@ef601500: input 0 in RGMII mode
> [    5.701505] eth0: EMAC-0 /plb/opb/ethernet@ef600e00, MAC 00:50:c2:80:d5:00
> [    5.708953] eth0: found Generic MII PHY (0x00)
> [    5.713931] /plb/opb/emac-rgmii@ef601500: input 1 in RGMII mode
> [    5.721688] eth1: EMAC-1 /plb/opb/ethernet@ef600f00, MAC 00:00:00:00:00:00
> [    5.729134] eth1: found Generic MII PHY (0x01)
> [    5.733997] PPP generic driver version 2.4.2
> [    5.738908] PPP BSD Compression module registered
> [    5.744079] PPP Deflate Compression module registered
> [    5.749472] NET: Registered protocol family 24
> [    5.754837] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> [    5.762116] ppc-of-ehci 4bffd0400.ehci: OF EHCI
> [    5.767236] ppc-of-ehci 4bffd0400.ehci: new USB bus registered, assigned bus number 1
> [    5.776123] ppc-of-ehci 4bffd0400.ehci: irq 32, io mem 0x4bffd0400
> [    5.788538] ppc-of-ehci 4bffd0400.ehci: USB 2.0 started, EHCI 1.00
> [    5.795272] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
> [    5.802477] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    5.810124] usb usb1: Product: OF EHCI
> [    5.828285] usb usb1: Manufacturer: Linux 4.7.0-rc3-sam460ex-jm-00238-gf7b9ebb-dirty ehci_hcd
> [    5.851410] usb usb1: SerialNumber: PPC-OF USB
> [    5.870997] hub 1-0:1.0: USB hub found
> [    5.889320] hub 1-0:1.0: 1 port detected
> [    5.908120] ehci-pci: EHCI PCI platform driver
> [    5.927336] ehci-platform: EHCI generic platform driver
> [    5.947616] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
> [    5.968764] ppc-of-ohci 4bffd0000.usb: OF OHCI
> [    5.987772] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> [    6.009018] ata1.00: ATAPI: ASUS    DRW-24B3ST   i, 1.00, max UDMA/100
> [    6.031219] ppc-of-ohci 4bffd0000.usb: new USB bus registered, assigned bus number 2
> [    6.054311] ata1.00: configured for UDMA/100
> [    6.074255] ppc-of-ohci 4bffd0000.usb: irq 33, io mem 0x4bffd0000
> [    6.099961] scsi 0:0:0:0: CD-ROM            ASUS DRW-24B3ST   i   1.00 PQ: 0 ANSI: 5
> [    6.152728] sr 0:0:0:0: [sr0] scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 cdda tray
> [    6.199528] cdrom: Uniform CD-ROM driver Revision: 3.20
> [    6.227539] usb 1-1: new high-speed USB device number 2 using ppc-of-ehci
> [    6.290919] sr 0:0:0:0: Attached scsi generic sg0 type 5
> [    6.341996] usb 1-1: New USB device found, idVendor=0424, idProduct=2517
> [    6.385534] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [    6.436709] hub 1-1:1.0: USB hub found
> [    6.478536] hub 1-1:1.0: 7 ports detected
> [    6.637673] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> [    6.695476] ata2.00: ATA-8: WDC WD5000AAKS-00UU3A0, 01.03B01, max UDMA/133
> [    6.740534] ata2.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 0/32)
> [    6.792293] ata2.00: configured for UDMA/100
> [    6.817537] usb 1-1.1: new high-speed USB device number 3 using ppc-of-ehci
> [    6.893796] scsi 1:0:0:0: Direct-Access     ATA      WDC WD5000AAKS-0 3B01 PQ: 0 ANSI: 5
> [    6.931195] usb 1-1.1: New USB device found, idVendor=1a40, idProduct=0101
> [    6.971488] sd 1:0:0:0: [sda] 976773168 512-byte logical blocks: (500 GB/466 GiB)
> [    6.971741] sd 1:0:0:0: [sda] Write Protect is off
> [    6.971750] sd 1:0:0:0: [sda] Mode Sense: 00 3a 00 00
> [    6.971846] sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> [    6.972229] sd 1:0:0:0: Attached scsi generic sg1 type 0
> [    6.977080]  sda: RDSK (512) sda1 (SFS^@)(res 2 spb 1) sda2 (SFS^@)(res 2 spb 1) sda3 (SFS^@)(res 2 spb 1) sda4 (SFS^@)(res 2 spb 1) sda5 (NTFS)(res 2 spb 2) sda6 ((res 2 spb 1) sda7 ((res 2 spb 1) sda8 ((res 2 spb 1)
> [    6.979719] sd 1:0:0:0: [sda] Attached SCSI disk
> [    7.019718] usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
> [    7.019726] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    7.019730] usb usb2: Product: OF OHCI
> [    7.019736] usb usb2: Manufacturer: Linux 4.7.0-rc3-sam460ex-jm-00238-gf7b9ebb-dirty ohci_hcd
> [    7.019741] usb usb2: SerialNumber: PPC-OF USB
> [    7.020446] hub 2-0:1.0: USB hub found
> [    7.020479] hub 2-0:1.0: 1 port detected
> [    7.021080] ohci-pci: OHCI PCI platform driver
> [    7.021220] ohci-platform: OHCI generic platform driver
> [    7.021359] uhci_hcd: USB Universal Host Controller Interface driver
> [    7.021994] usbcore: registered new interface driver usblp
> [    7.022197] usbcore: registered new interface driver usb-storage
> [    7.022416] usbcore: registered new interface driver usbserial
> [    7.022508] usbcore: registered new interface driver usbserial_generic
> [    7.022646] usbserial: USB Serial support registered for generic
> [    7.023171] mousedev: PS/2 mouse device common for all mice
> [    7.024837] i2c /dev entries driver
> [    7.028442] Unable to handle kernel paging request for data at address 0x000001dc
> [    7.028446] Faulting instruction address: 0xc07b58c8
> [    7.028456] Vector: 300 (Data Access) at [ee8bdd20]
> [    7.028490]     pc: c07b58c8: __mutex_lock_slowpath+0x80/0x2f4
> [    7.028501]     lr: c07b5868: __mutex_lock_slowpath+0x20/0x2f4
> [    7.028504]     sp: ee8bddd0
> [    7.028506]    msr: 21000
> [    7.028508]    dar: 1dc
> [    7.028511]  dsisr: 800000
> [    7.028513]   current = 0xee8a9800
> [    7.028517]     pid   = 1465, comm = irq/47-m41t80
> [    7.028523] Linux version 4.7.0-rc3-sam460ex-jm-00238-gf7b9ebb-dirty (root@julian-VirtualBox) (gcc version 5.4.0 20160609 (Ubuntu 5.4.0-6ubuntu1~16.04.1) ) #6 PREEMPT Mon Aug 8 06:45:28 AST 2016
> [    7.028551] enter ? for help
> [    7.028569] [ee8bde30] c07b5b54 mutex_lock+0x18/0x24
> [    7.028584] [ee8bde40] c0584dfc m41t80_handle_irq+0x28/0xac
> [    7.028612] [ee8bde60] c0055ef8 irq_thread_fn+0x2c/0x48
> [    7.028624] [ee8bde80] c0056118 irq_thread+0xc4/0x160
> [    7.028635] [ee8bded0] c003f848 kthread+0xc8/0xcc
> [    7.028650] [ee8bdf40] c000b198 ret_from_kernel_thread+0x5c/0x64
> [    7.028657] mon>  <no input ...>
> [    9.028706] Oops: Kernel access of bad area, sig: 11 [#1]
> [    9.028709] PREEMPT Canyonlands
> [    9.028714] Modules linked in:
> [    9.028722] CPU: 0 PID: 1465 Comm: irq/47-m41t80 Not tainted 4.7.0-rc3-sam460ex-jm-00238-gf7b9ebb-dirty #6
> [    9.028727] task: ee8a9800 ti: ee8bc000 task.ti: ee8bc000
> [    9.028731] NIP: c07b58c8 LR: c07b5868 CTR: c0584dd4
> [    9.028734] REGS: ee8bdd20 TRAP: 0300   Not tainted (4.7.0-rc3-sam460ex-jm-00238-gf7b9ebb-dirty)
> [    9.028744] MSR: 00021000 <CE,ME>  CR: 24000222  XER: 20000000
> [    9.028795] DEAR: 000001dc ESR: 00800000
> [    9.028795] GPR00: c07b5868 ee8bddd0 ee8a9800 00000000 ee940800 00000000 00000000 ee8a9b2c
> [    9.028795] GPR08: c0db8aa8 00000000 00000000 ee8bde80 24082284 00000000 c003f780 ee9479c0
> [    9.028795] GPR16: 00000000 00000000 00000000 00000000 00000000 c0ca0000 00000001 ee88dc54
> [    9.028795] GPR24: ee93d0a4 00000000 ee8a9800 ee93d080 ee947990 00029000 c0cb0000 000001d8
> [    9.028803] NIP [c07b58c8] __mutex_lock_slowpath+0x80/0x2f4
> [    9.028809] LR [c07b5868] __mutex_lock_slowpath+0x20/0x2f4
> [    9.028811] Call Trace:
> [    9.028820] [ee8bddd0] [c07b5868] __mutex_lock_slowpath+0x20/0x2f4 (unreliable)
> [    9.028827] [ee8bde30] [c07b5b54] mutex_lock+0x18/0x24
> [    9.028833] [ee8bde40] [c0584dfc] m41t80_handle_irq+0x28/0xac
> [    9.028840] [ee8bde60] [c0055ef8] irq_thread_fn+0x2c/0x48
> [    9.028848] [ee8bde80] [c0056118] irq_thread+0xc4/0x160
> [    9.028853] [ee8bded0] [c003f848] kthread+0xc8/0xcc
> [    9.028859] [ee8bdf40] [c000b198] ret_from_kernel_thread+0x5c/0x64
> [    9.028862] Instruction dump:
> [    9.028877] 81293398 2f890000 40be001c 3c80c0b4 3c60c0b4 38846a36 386360b6 48002811
> [    9.028890] 0fe00000 7fa000a6 7c000146 39200000 <913f0004> 813e3190 2f890000 409e0044
> [    9.028917] ---[ end trace 936fe0cb640e30c7 ]---
> [    9.028919]
> [    9.028924] note: irq/47-m41t80[1465] exited with preempt_count 1
> [    9.028934] Unable to handle kernel paging request for data at address 0xffffffe0
> [    9.028936] Faulting instruction address: 0xc003fc78
> [    9.028940] Vector: 300 (Data Access) at [ee8bdbd0]
> [    9.028950]     pc: c003fc78: kthread_data+0x4/0xc
> [    9.028961]     lr: c0055fec: irq_thread_dtor+0x48/0xb0
> [    9.028964]     sp: ee8bdc80
> [    9.028966]    msr: 21000
> [    9.028968]    dar: ffffffe0
> [    9.028970]  dsisr: 0
> [    9.028973]   current = 0xee8a9800
> [    9.028976]     pid   = 1465, comm = irq/47-m41t80
> [    9.028982] Linux version 4.7.0-rc3-sam460ex-jm-00238-gf7b9ebb-dirty (root@julian-VirtualBox) (gcc version 5.4.0 20160609 (Ubuntu 5.4.0-6ubuntu1~16.04.1) ) #6 PREEMPT Mon Aug 8 06:45:28 AST 2016
> [    9.028987] enter ? for help
> [    9.028990] mon>  <no input ...>
> [   11.029037] Oops: Kernel access of bad area, sig: 11 [#2]
> [   11.029039] PREEMPT Canyonlands
> [   11.029042] Modules linked in:
> [   11.029047] CPU: 0 PID: 1465 Comm: irq/47-m41t80 Tainted: G      D         4.7.0-rc3-sam460ex-jm-00238-gf7b9ebb-dirty #6
> [   11.029051] task: ee8a9800 ti: ee8bc000 task.ti: ee8bc000
> [   11.029054] NIP: c003fc78 LR: c0055fec CTR: c0055fa4
> [   11.029058] REGS: ee8bdbd0 TRAP: 0300   Tainted: G D          (4.7.0-rc3-sam460ex-jm-00238-gf7b9ebb-dirty)
> [   11.029067] MSR: 00021000 <CE,ME>  CR: 44002824  XER: 20000000
> [   11.029120] DEAR: ffffffe0 ESR: 00000000
> [   11.029120] GPR00: c003e188 ee8bdc80 ee8a9800 ee8a9800 00000000 00000001 00000000 00000000
> [   11.029120] GPR08: ee8bc000 00000000 00000004 ee8bdcb0 24002424 00000000 c003f780 ee9479c0
> [   11.029120] GPR16: 00000000 00000000 00000000 00000000 00000000 c0ca0000 00000001 ee88dc54
> [   11.029120] GPR24: ee93d0a4 00000000 c0caf000 ee8bdcb8 c0dc0000 ee8a9b2c 00000000 ee8a9800
> [   11.029124] NIP [c003fc78] kthread_data+0x4/0xc
> [   11.029130] LR [c0055fec] irq_thread_dtor+0x48/0xb0
> [   11.029131] Call Trace:
> [   11.029140] [ee8bdc80] [c07b73e0] _raw_spin_unlock+0x18/0x54 (unreliable)
> [   11.029157] [ee8bdc90] [c003e188] task_work_run+0x7c/0x98
> [   11.029175] [ee8bdcb0] [c00288b8] do_exit+0x2f4/0x780
> [   11.029188] [ee8bdcf0] [c00077e0] die+0x26c/0x274
> [   11.029195] [ee8bdd10] [c000b57c] handle_page_fault+0x7c/0x80
> [   11.029208] --- interrupt: 300 at __mutex_lock_slowpath+0x80/0x2f4
> [   11.029208]     LR = __mutex_lock_slowpath+0x20/0x2f4
> [   11.029215] [ee8bde30] [c07b5b54] mutex_lock+0x18/0x24
> [   11.029222] [ee8bde40] [c0584dfc] m41t80_handle_irq+0x28/0xac
> [   11.029229] [ee8bde60] [c0055ef8] irq_thread_fn+0x2c/0x48
> [   11.029236] [ee8bde80] [c0056118] irq_thread+0xc4/0x160
> [   11.029242] [ee8bded0] [c003f848] kthread+0xc8/0xcc
> [   11.029249] [ee8bdf40] [c000b198] ret_from_kernel_thread+0x5c/0x64
> [   11.029251] Instruction dump:
> [   11.029265] 7ce0412d 40a2fff4 7f831000 419e0010 48004219 387fffe4 487745d5 39200000
> [   11.029278] 39610010 7d234b78 4bfd2070 81230238 <8069ffe0> 4e800020 9421ffe0 39200000
> [   11.029281] ---[ end trace 936fe0cb640e30c8 ]---
> [   11.029283]
> [   11.029285] Fixing recursive fault but reboot is needed!
> [   11.029291] sched: RT throttling activated
> [   11.029490] Unable to handle kernel paging request for data at address 0x00000008
> [   11.029493] Faulting instruction address: 0xc0244578
> [   11.029499] Vector: 300 (Data Access) at [ee8bda80]
> [   11.029513]     pc: c0244578: exit_shm+0x18/0x148
> [   11.029525]     lr: c0028888: do_exit+0x2c4/0x780
> [   11.029527]     sp: ee8bdb30
> [   11.029530]    msr: 29000
> [   11.029532]    dar: 8
> [   11.029534]  dsisr: 0
> [   11.029537]   current = 0xee8a9800
> [   11.029540]     pid   = 1465, comm = irq/47-m41t80
> [   11.029546] Linux version 4.7.0-rc3-sam460ex-jm-00238-gf7b9ebb-dirty (root@julian-VirtualBox) (gcc version 5.4.0 20160609 (Ubuntu 5.4.0-6ubuntu1~16.04.1) ) #6 PREEMPT Mon Aug 8 06:45:28 AST 2016
> [   11.029559] enter ? for help
> [   11.029564] mon>  <no input ...>
> [   13.029699] Oops: Kernel access of bad area, sig: 11 [#3]
> [   13.029702] PREEMPT Canyonlands
> [   13.029706] Modules linked in:
> [   13.029712] CPU: 0 PID: 1465 Comm: irq/47-m41t80 Tainted: G      D         4.7.0-rc3-sam460ex-jm-00238-gf7b9ebb-dirty #6
> [   13.029717] task: ee8a9800 ti: ee8bc000 task.ti: ee8bc000
> [   13.029721] NIP: c0244578 LR: c0028888 CTR: c00479bc
> [   13.029724] REGS: ee8bda80 TRAP: 0300   Tainted: G D          (4.7.0-rc3-sam460ex-jm-00238-gf7b9ebb-dirty)
> [   13.029735] MSR: 00029000 <CE,EE,ME>  CR: 24008222  XER: 00000000
> [   13.029788] DEAR: 00000008 ESR: 00000000
> [   13.029788] GPR00: c0028888 ee8bdb30 ee8a9800 ee8a9800 00000000 7906f70d 00000001 00000800
> [   13.029788] GPR08: ffffffff 00000000 ee8a9ba0 ee8bdb60 c0c64338 00000000 c003f780 ee9479c0
> [   13.029788] GPR16: 00000000 00000000 00000000 00000000 00000000 c0ca0000 00000001 ee88dc54
> [   13.029788] GPR24: ee93d0a4 00000000 ee8a9ad8 ee8bdb68 0000000b 00000000 ee8bc000 ee8a9800
> [   13.029794] NIP [c0244578] exit_shm+0x18/0x148
> [   13.029803] LR [c0028888] do_exit+0x2c4/0x780
> [   13.029804] Call Trace:
> [   13.029815] [ee8bdb30] [c0ca0000] noop_netdev_queue+0x68/0x88 (unreliable)
> [   13.029823] [ee8bdb60] [c0028888] do_exit+0x2c4/0x780
> [   13.029832] [ee8bdba0] [c00077e0] die+0x26c/0x274
> [   13.029840] [ee8bdbc0] [c000b57c] handle_page_fault+0x7c/0x80
> [   13.029853] --- interrupt: 300 at kthread_data+0x4/0xc
> [   13.029853]     LR = irq_thread_dtor+0x48/0xb0
> [   13.029862] [ee8bdc80] [c07b73e0] _raw_spin_unlock+0x18/0x54 (unreliable)
> [   13.029872] [ee8bdc90] [c003e188] task_work_run+0x7c/0x98
> [   13.029880] [ee8bdcb0] [c00288b8] do_exit+0x2f4/0x780
> [   13.029886] [ee8bdcf0] [c00077e0] die+0x26c/0x274
> [   13.029893] [ee8bdd10] [c000b57c] handle_page_fault+0x7c/0x80
> [   13.029907] --- interrupt: 300 at __mutex_lock_slowpath+0x80/0x2f4
> [   13.029907]     LR = __mutex_lock_slowpath+0x20/0x2f4
> [   13.029914] [ee8bde30] [c07b5b54] mutex_lock+0x18/0x24
> [   13.029921] [ee8bde40] [c0584dfc] m41t80_handle_irq+0x28/0xac
> [   13.029928] [ee8bde60] [c0055ef8] irq_thread_fn+0x2c/0x48
> [   13.029936] [ee8bde80] [c0056118] irq_thread+0xc4/0x160
> [   13.029942] [ee8bded0] [c003f848] kthread+0xc8/0xcc
> [   13.029949] [ee8bdf40] [c000b198] ret_from_kernel_thread+0x5c/0x64
> [   13.029951] Instruction dump:
> [   13.029965] 80010014 7fc3f378 bbc10008 7c0803a6 38210010 4be0a11c 9421ffd0 7c0802a6
> [   13.029979] bf210014 90010034 3b4302d8 812302ec <83890008> 812302d8 7f9a4840 419e011c
> [   13.029983] ---[ end trace 936fe0cb640e30c9 ]---
> [   13.029985]
> [   13.029987] Fixing recursive fault but reboot is needed!
> [   13.525251] rtc-m41t80 8-0068: rtc core: registered m41t80 as rtc0
> [   13.620953] ibm-iic 4ef600700.i2c: using standard (100 kHz) mode
> [   13.621455] ibm-iic 4ef600800.i2c: using standard (100 kHz) mode
> [   13.621658] md: linear personality registered for level -1
> [   13.621662] md: raid0 personality registered for level 0
> [   13.621665] md: raid1 personality registered for level 1
> [   13.621668] md: raid10 personality registered for level 10
> [   13.645387] md: raid6 personality registered for level 6
> [   13.645391] md: raid5 personality registered for level 5
> [   13.645394] md: raid4 personality registered for level 4
> [   13.646256] device-mapper: ioctl: 4.34.0-ioctl (2015-10-28) initialised: dm-devel@redhat.com
> [   13.646260] EDAC PPC4xx MC: v1.0.0
> [   13.646263] EDAC PPC4xx MC: Reporting type: interrupt
> [   13.646658] hidraw: raw HID events driver (C) Jiri Kosina
> [   13.648080] usbcore: registered new interface driver usbhid
> [   13.648083] usbhid: USB HID core driver
> [   13.731980] snd_ice1724 0000:42:00.0: No matching model found for ID 0x12140324
> [   13.825936] usbcore: registered new interface driver snd-usb-audio
> [   13.826199] usbcore: registered new interface driver snd-ua101
> [   13.826397] usbcore: registered new interface driver snd-usb-usx2y
> [   13.826797] ipip: IPv4 over IPv4 tunneling driver
> [   13.828055] Initializing XFRM netlink socket
> [   13.829475] NET: Registered protocol family 10
> [   13.831228] sit: IPv6 over IPv4 tunneling driver
> [   13.831999] NET: Registered protocol family 17
> [   13.832021] NET: Registered protocol family 15
> [   13.832274] Running MSI bitmap self-tests ...
> [   13.833724] zswap: loaded using pool lzo/zbud
> [   13.855085] Key type encrypted registered
> [   13.974847] rtc-m41t80 8-0068: setting system clock to 2016-08-08 06:54:08 UTC (1470639248)
> [   13.974991] ALSA device list:
> [   13.974994]   #0: Virtual MIDI Card 1
> [   13.974996]   #1: ICEnsemble ICE1724 at 0xfffc1080, irq 19
> [   17.776691] md: Waiting for all devices to be available before autodetect
> [   17.797552] usb 1-1.1: New USB device strings: Mfr=0, Product=1, SerialNumber=0
> [   17.797557] usb 1-1.1: Product: USB 2.0 Hub
> [   17.798404] hub 1-1.1:1.0: USB hub found
> [   17.798671] hub 1-1.1:1.0: 4 ports detected
> [   17.876057] md: If you don't use raid, use raid=noautodetect
> [   17.896708] md: Autodetecting RAID arrays.
> [   17.915079] md: Scanned 0 and added 0 devices.
> [   17.933511] md: autorun ...
> [   17.950265] md: ... autorun DONE.
> [   17.967796] VFS: Cannot open root device "sda0" or unknown-block(0,0): error -6
> [   17.989227] Please append a correct "root=" boot option; here are the available partitions:
> [   18.011915] 0100          131072 ram0  (driver?)
> [   18.030973] usb 1-1.2: new low-speed USB device number 4 using ppc-of-ehci
> [   18.052552] 0101          131072 ram1  (driver?)
> [   18.071889] 0102          131072 ram2  (driver?)
> [   18.090983] 0103          131072 ram3  (driver?)
> [   18.109763] 0104          131072 ram4  (driver?)
> [   18.128396] 0105          131072 ram5  (driver?)
> [   18.146948] 0106          131072 ram6  (driver?)
> [   18.165460] 0107          131072 ram7  (driver?)
> [   18.183879] 0108          131072 ram8  (driver?)
> [   18.202278] 0109          131072 ram9  (driver?)
> [   18.220391] 010a          131072 ram10  (driver?)
> [   18.238326] usb 1-1.2: New USB device found, idVendor=045e, idProduct=07b9
> [   18.238333] usb 1-1.2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [   18.238338] usb 1-1.2: Product: USB Keyboard
> [   18.238342] usb 1-1.2: Manufacturer: LITEON Technology
> [   18.297394] usb 1-1.1.1: new full-speed USB device number 5 using ppc-of-ehci
> [   18.338436] input: LITEON Technology USB Keyboard as /devices/platform/plb/4bffd0400.ehci/usb1/1-1/1-1.2/1-1.2:1.0/0003:045E:07B9.0001/input/input0
> [   18.365895] 010b          131072 ram11  (driver?)
> [   18.384775] 010c          131072 ram12 [   18.389835] hid-generic 0003:045E:07B9.0001: input,hidraw0: USB HID v1.10 Keyboard [LITEON Technology USB Keyboard] on usb-PPC-OF USB-1.2/input0
> 
> [   18.418820]  (driver?)
> [   18.451450] 010d          131072 ram13 [   18.455391] usb 1-1.1.1: New USB device found, idVendor=0d8c, idProduct=000c
> [   18.455398] usb 1-1.1.1: New USB device strings: Mfr=0, Product=1, SerialNumber=0
> [   18.455403] usb 1-1.1.1: Product: C-Media USB Audio Device
> [   18.502747] usb 1-1.6: new full-speed USB device number 6 using ppc-of-ehci
> 
> [   18.548167]  (driver?)
> [   18.582506] 010e          131072 ram14  (driver?)
> [   18.603317] 010f          131072 ram15  (driver?)
> [   18.623927] 0b00         1048575 sr0  driver: sr
> [   18.644346] 0800       488386584 sda  driver: sd
> [   18.664610]   0801         2096688 sda1
> [   18.683958]   0802        52428312 sda2
> [   18.703134]   0803        52428312 sda3
> [   18.722193]   0804        52428312 sda4
> [   18.741221]   0805       246168744 sda5
> [   18.760160]   0806        21798912 sda6
> [   18.778901]   0807        19531248 sda7
> [   18.797630]   0808        19531248 sda8
> [   18.816205] Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)
> [   18.839313] Rebooting in 180 seconds..
> 
> 
> ===========================================================================================================
> 
> Bad Boot
> 
> No output after
> 
> Loading  Device tree  to 00ffa00,  end 00fffb18  ... OK
> 
> ============================================================================================================
> 
> U-Boot 2015.a (May 16 2015 - 14:20:11)
> 
> CPU:   AMCC PowerPC 460EX Rev. B at 1155 MHz (PLB=231 OPB=115 EBC=115)
>        No Security/Kasumi support
>        Bootstrap Option H - Boot ROM Location I2C (Addr 0x52)
>        Internal PCI arbiter enabled
>        32 kB I-Cache 32 kB D-Cache
> Board: Sam460ex/cr, PCIe 4x + PCIe 1x
> I2C:   ready
> DRAM:  2 GiB (ECC not enabled, 462 MHz, CL4)
> PCI:   Bus Dev VenId DevId Class Int
>         00  04  1095  3512  0104  00
>         00  06  126f  0501  0380  00
> PCIE0: successfully set as root-complex
>         03  00  1412  1724  0401  60
>         02  00  1b21  1080  0604  00
> PCIE1: successfully set as root-complex
>         05  00  1002  683f  0300  66
> Net:   ppc_4xx_eth0
> FPGA:  Revision 03 (2010-10-07)
> SM502: found
> PERMD2:not found
> VGA:   1
> VESA:  OK
> 
> 
> 
> .
> 
