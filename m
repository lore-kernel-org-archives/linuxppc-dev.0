Return-Path: <runaway@candw.ms>
Received: from mail-vc0-f174.google.com (mail-vc0-f174.google.com
 [209.85.220.174])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 81D371A0CC2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Feb 2015 02:57:48 +1100 (AEDT)
Received: by mail-vc0-f174.google.com with SMTP id id10so1435913vcb.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Feb 2015 07:57:45 -0800 (PST)
Message-ID: <54E607F3.1050901@candw.ms>
Date: Thu, 19 Feb 2015 11:57:39 -0400
From: Julian Margetson <runaway@candw.ms>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: Problems with Kernels 3.17-rc1 and onwards on Acube Sam460 AMCC
 460ex board
References: <54E08E06.8060607@candw.ms>		
 <1424045921.3018.4.camel@ellerman.id.au> <54E4EBD7.5000307@candw.ms>	
 <1424304787.22020.4.camel@ellerman.id.au> <54E53E07.60609@candw.ms>
 <1424314594.22408.1.camel@ellerman.id.au>
In-Reply-To: <1424314594.22408.1.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, Ian Munsie <imunsie@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2/18/2015 10:56 PM, Michael Ellerman wrote:
> On Wed, 2015-02-18 at 21:36 -0400, Julian Margetson wrote:
>> On 2/18/2015 8:13 PM, Michael Ellerman wrote:
>>
>>> On Wed, 2015-02-18 at 15:45 -0400, Julian Margetson wrote:
>>>> On 2/15/2015 8:18 PM, Michael Ellerman wrote:
>>>>
>>>>> On Sun, 2015-02-15 at 08:16 -0400, Julian Margetson wrote:
>>>>>> Hi
>>>>>>
>>>>>> I am unable to get any kernel beyond  the 3.16 branch working on an
>>>>>> Acube Sam460ex
>>>>>>   AMCC 460ex based motherboard. Kernel  up 3.16.7-ckt6 working.
>>>>> Does reverting b0345bbc6d09 change anything?
>>>>>
>>>>>> [    6.364350] snd_hda_intel 0001:81:00.1: enabling device (0000 -> 0002)
>>>>>> [    6.453794] snd_hda_intel 0001:81:00.1: ppc4xx_setup_msi_irqs: fail mapping irq
>>>>>> [    6.487530] Unable to handle kernel paging request for data at address 0x0fa06c7c
>>>>>> [    6.495055] Faulting instruction address: 0xc032202c
>>>>>> [    6.500033] Vector: 300 (Data Access) at [efa31cf0]
>>>>>> [    6.504922]     pc: c032202c: __reg_op+0xe8/0x100
>>>>>> [    6.509697]     lr: c0014f88: msi_bitmap_free_hwirqs+0x50/0x94
>>>>>> [    6.515600]     sp: efa31da0
>>>>>> [    6.518491]    msr: 21000
>>>>>> [    6.521112]    dar: fa06c7c
>>>>>> [    6.523915]  dsisr: 0
>>>>>> [    6.526190]   current = 0xef8bab00
>>>>>> [    6.529603]     pid   = 115, comm = kworker/0:1
>>>>>> [    6.534163] enter ? for help
>>>>>> [    6.537054] [link register   ] c0014f88 msi_bitmap_free_hwirqs+0x50/0x94
>>>>>> [    6.543811] [efa31da0] c0014f78 msi_bitmap_free_hwirqs+0x40/0x94 (unreliable)
>>>>>> [    6.551001] [efa31dc0] c001aee8 ppc4xx_setup_msi_irqs+0xac/0xf4
>>>>>> [    6.556973] [efa31e00] c03503a4 pci_enable_msi_range+0x1e0/0x280
>>>>>> [    6.563032] [efa31e40] f92c2f74 azx_probe_work+0xe0/0x57c [snd_hda_intel]
>>>>>> [    6.569906] [efa31e80] c0036344 process_one_work+0x1e8/0x2f0
>>>>>> [    6.575627] [efa31eb0] c003677c worker_thread+0x2f4/0x438
>>>>>> [    6.581079] [efa31ef0] c003a3e4 kthread+0xc8/0xcc
>>>>>> [    6.585844] [efa31f40] c000aec4 ret_from_kernel_thread+0x5c/0x64
>>>>>> [    6.591910] mon>  <no input ...>
>>>> Managed to do a third git bisect  with the following results .
>>> Great work.
>>>
>>>> git bisect bad
>>>> 9279d3286e10736766edcaf815ae10e00856e448 is the first bad commit
>>>> commit 9279d3286e10736766edcaf815ae10e00856e448
>>>> Author: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>>>> Date:   Wed Aug 6 16:10:16 2014 -0700
>>>>
>>>>      lib: bitmap: change parameter of bitmap_*_region to unsigned
>>> So the bug is in the 4xx MSI code, and has always been there, in fact I don't
>>> see how that code has *ever* worked. The commit you bisected to just caused the
>>> existing bug to cause an oops.
>>>
>>> Can you try this?
>>>
>>> diff --git a/arch/powerpc/sysdev/ppc4xx_msi.c b/arch/powerpc/sysdev/ppc4xx_msi.c
>>> index 6e2e6aa378bb..effb5b878a78 100644
>>> --- a/arch/powerpc/sysdev/ppc4xx_msi.c
>>> +++ b/arch/powerpc/sysdev/ppc4xx_msi.c
>>> @@ -95,11 +95,9 @@ static int ppc4xx_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
>>>   
>>>   	list_for_each_entry(entry, &dev->msi_list, list) {
>>>   		int_no = msi_bitmap_alloc_hwirqs(&msi_data->bitmap, 1);
>>> -		if (int_no >= 0)
>>> -			break;
>>>   		if (int_no < 0) {
>>> -			pr_debug("%s: fail allocating msi interrupt\n",
>>> -					__func__);
>>> +			pr_warn("%s: fail allocating msi interrupt\n", __func__);
>>> +			return -ENOSPC;
>>>   		}
>>>   		virq = irq_of_parse_and_map(msi_data->msi_dev, int_no);
>>>   		if (virq == NO_IRQ) {
>>>
>> Thanks.
>> This works with 3.17-rc1. Will try with the 3.18 Branch .
> OK great.
>
>> Any ideas why drm is not  working ? (It never worked) .
> No sorry. You might have more luck if you post a new thread to the dri list.
>
>> [    5.809802] Linux agpgart interface v0.103
>> [    6.137893] [drm] Initialized drm 1.1.0 20060810
>> [    6.439872] snd_hda_intel 0001:81:00.1: enabling device (0000 -> 0002)
>> [    6.508544] ppc4xx_setup_msi_irqs: fail allocating msi interrupt
> I'm curious why it's failing to allocate MSIs. Possibly it's just run out.
>
> Can you post the output of 'cat /proc/interrupts'?
>
> cheers
>
>
>

With Kernel 3.19.0 for the first time a Radeon HD7750 is now showing 
video  but the HDMI audio not working .

[    8.255402] Linux agpgart interface v0.103
[    8.491334] [drm] Initialized drm 1.1.0 20060810
[    8.867204] snd_hda_intel 0001:81:00.1: enabling device (0000 -> 0002)
[    8.968395] snd_hda_intel 0001:81:00.1: Force to snoop mode by module 
option
[    9.062427] ppc4xx_setup_msi_irqs: fail allocating msi interrupt
[    9.243778] input: HDA ATI HDMI HDMI/DP,pcm=3 as 
/devices/pci0001:80/0001:80:00.0/0001:81:00.1/sound/card0/input3
[    9.576242] [drm] radeon kernel modesetting enabled.
[    9.586233] [drm] initializing kernel modesetting (VERDE 
0x1002:0x683F 0x1545:0x7750).
[    9.595194] [drm] register mmio base: 0xe90000000
[    9.600195] [drm] register mmio size: 262144
[   10.498475] Adding 62828k swap on /dev/sda10.  Priority:-1 extents:1 
across:62828k FS
[   10.538221] ATOM BIOS: C44501
[   10.577399] radeon 0001:81:00.0: VRAM: 1024M 0x0000000000000000 - 
0x000000003FFFFFFF (1024M used)
[   10.652394] radeon 0001:81:00.0: GTT: 1024M 0x0000000040000000 - 
0x000000007FFFFFFF
[   10.708420] [drm] Detected VRAM RAM=1024M, BAR=256M
[   10.734401] [drm] RAM width 128bits DDR
[   10.774502] [TTM] Zone  kernel: Available graphics memory: 380676 kiB
[   10.830617] [TTM] Zone highmem: Available graphics memory: 1036036 kiB
[   10.864963] [TTM] Initializing pool allocator
[   10.891976] [TTM] Initializing DMA pool allocator
[   10.934818] [drm] radeon: 1024M of VRAM memory ready
[   10.972424] [drm] radeon: 1024M of GTT memory ready.
[   11.015787] [drm] Loading verde Microcode
[   11.058293] radeon 0001:81:00.0: Direct firmware load for 
radeon/verde_pfp.bin failed with error -2
[   11.142723] radeon 0001:81:00.0: Direct firmware load for 
radeon/verde_me.bin failed with error -2
[   11.214753] radeon 0001:81:00.0: Direct firmware load for 
radeon/verde_ce.bin failed with error -2
[   11.271860] radeon 0001:81:00.0: Direct firmware load for 
radeon/verde_rlc.bin failed with error -2
[   11.349589] radeon 0001:81:00.0: Direct firmware load for 
radeon/verde_mc.bin failed with error -2
[   11.415403] EXT3-fs (sda6): using internal journal
[   11.425054] [drm] radeon/VERDE_mc2.bin: 31500 bytes
[   11.466433] radeon 0001:81:00.0: Direct firmware load for 
radeon/verde_smc.bin failed with error -2
[   11.572727] [drm] Internal thermal controller with fan control
[   11.606086] [drm] probing gen 2 caps for device aaa1:bed1 = 18cc41/0
[   11.861380] [drm] radeon: dpm initialized
[   11.926464] [drm] GART: num cpu pages 262144, num gpu pages 262144
[   11.939005] [drm] probing gen 2 caps for device aaa1:bed1 = 18cc41/0
[   12.014047] [drm] PCIE GART of 1024M enabled (table at 
0x0000000000277000).
[   12.022187] radeon 0001:81:00.0: WB enabled
[   12.031433] radeon 0001:81:00.0: fence driver on ring 0 use gpu addr 
0x0000000040000c00 and cpu addr 0xee030c00
[   12.045537] radeon 0001:81:00.0: fence driver on ring 1 use gpu addr 
0x0000000040000c04 and cpu addr 0xee030c04
[   12.056326] radeon 0001:81:00.0: fence driver on ring 2 use gpu addr 
0x0000000040000c08 and cpu addr 0xee030c08
[   12.068686] radeon 0001:81:00.0: fence driver on ring 3 use gpu addr 
0x0000000040000c0c and cpu addr 0xee030c0c
[   12.080826] radeon 0001:81:00.0: fence driver on ring 4 use gpu addr 
0x0000000040000c10 and cpu addr 0xee030c10
[   12.117757] radeon 0001:81:00.0: fence driver on ring 5 use gpu addr 
0x0000000000075a18 and cpu addr 0xf97b5a18
[   12.133144] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[   12.151401] [drm] Driver supports precise vblank timestamp query.
[   12.164055] radeon 0001:81:00.0: radeon: MSI limited to 32-bit
[   12.172006] ppc4xx_setup_msi_irqs: fail allocating msi interrupt
[   12.178727] [drm] radeon: irq initialized.
[   13.035762] [drm:r600_ring_test [radeon]] *ERROR* radeon: ring 0 test 
failed (scratch(0x850C)=0xCAFEDEAD)
[   13.048036] radeon 0001:81:00.0: disabling GPU acceleration
[   13.306979] [drm] Radeon Display Connectors
[   13.325221] [drm] Connector 0:
[   13.333718] [drm]   HDMI-A-1
[   13.336676] [drm]   HPD4
[   13.339735] [drm]   DDC: 0x6570 0x6570 0x6574 0x6574 0x6578 0x6578 
0x657c 0x657c
[   13.347380] [drm]   Encoders:
[   13.350987] [drm]     DFP1: INTERNAL_UNIPHY2
[   13.355514] [drm] Connector 1:
[   13.358607] [drm]   DVI-I-1
[   13.361752] [drm]   HPD2
[   13.364663] [drm]   DDC: 0x6560 0x6560 0x6564 0x6564 0x6568 0x6568 
0x656c 0x656c
[   13.372705] [drm]   Encoders:
[   13.375902] [drm]     DFP2: INTERNAL_UNIPHY
[   13.381008] [drm]     CRT1: INTERNAL_KLDSCP_DAC1
[   13.594430] [drm] fb mappable at 0x80478000
[   13.604813] [drm] vram apper at 0x80000000
[   13.612036] [drm] size 8294400
[   13.615691] [drm] fb depth is 24
[   13.618958] [drm]    pitch is 7680
[   13.825852] Console: switching to colour frame buffer device 240x67
[   13.919441] radeon 0001:81:00.0: fb0: radeondrmfb frame buffer device
[   13.934122] radeon 0001:81:00.0: registered panic notifier
[   13.949441] [drm] Initialized radeon 2.40.0 20080528 for 0001:81:00.0 
on minor 0
[   30.112745] [drm:dce6_audio_get_pin [radeon]] *ERROR* No connected 
audio pins found!
