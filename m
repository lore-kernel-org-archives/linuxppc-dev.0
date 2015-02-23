Return-Path: <runaway@candw.ms>
Received: from mail-vc0-f178.google.com (mail-vc0-f178.google.com
 [209.85.220.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9C7931A0BA2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2015 02:07:30 +1100 (AEDT)
Received: by mail-vc0-f178.google.com with SMTP id hq11so7547406vcb.9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Feb 2015 07:07:28 -0800 (PST)
Received: from [192.168.1.10] ([205.217.234.37])
 by mx.google.com with ESMTPSA id p7sm3660153vda.24.2015.02.23.07.07.26
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 23 Feb 2015 07:07:27 -0800 (PST)
Message-ID: <54EB422C.2050401@candw.ms>
Date: Mon, 23 Feb 2015 11:07:24 -0400
From: Julian Margetson <runaway@candw.ms>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: Problems with DRI  on Acube Sam460 AMCC 460ex board
References: <54E08E06.8060607@candw.ms>		
 <1424045921.3018.4.camel@ellerman.id.au> <54E4EBD7.5000307@candw.ms>	
 <1424304787.22020.4.camel@ellerman.id.au> <54E53E07.60609@candw.ms>
 <1424314594.22408.1.camel@ellerman.id.au> <54EB253F.9020704@candw.ms>
In-Reply-To: <54EB253F.9020704@candw.ms>
Content-Type: multipart/alternative;
 boundary="------------070004080106070901050905"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------070004080106070901050905
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/23/2015 9:03 AM, Julian Margetson wrote:
> On 2/18/2015 10:56 PM, Michael Ellerman wrote:
>> On Wed, 2015-02-18 at 21:36 -0400, Julian Margetson wrote:
>>> On 2/18/2015 8:13 PM, Michael Ellerman wrote:
>>>
>>>> On Wed, 2015-02-18 at 15:45 -0400, Julian Margetson wrote:
>>>>> On 2/15/2015 8:18 PM, Michael Ellerman wrote:
>>>>>
>>>>>> On Sun, 2015-02-15 at 08:16 -0400, Julian Margetson wrote:
>>>>>>> Hi
>>>>>>>
>>>>>>> I am unable to get any kernel beyond  the 3.16 branch working on an
>>>>>>> Acube Sam460ex
>>>>>>>   AMCC 460ex based motherboard. Kernel  up 3.16.7-ckt6 working.
>>>>>> Does reverting b0345bbc6d09 change anything?
>>>>>>
>>>>>>> [    6.364350] snd_hda_intel 0001:81:00.1: enabling device (0000 -> 0002)
>>>>>>> [    6.453794] snd_hda_intel 0001:81:00.1: ppc4xx_setup_msi_irqs: fail mapping irq
>>>>>>> [    6.487530] Unable to handle kernel paging request for data at address 0x0fa06c7c
>>>>>>> [    6.495055] Faulting instruction address: 0xc032202c
>>>>>>> [    6.500033] Vector: 300 (Data Access) at [efa31cf0]
>>>>>>> [    6.504922]     pc: c032202c: __reg_op+0xe8/0x100
>>>>>>> [    6.509697]     lr: c0014f88: msi_bitmap_free_hwirqs+0x50/0x94
>>>>>>> [    6.515600]     sp: efa31da0
>>>>>>> [    6.518491]    msr: 21000
>>>>>>> [    6.521112]    dar: fa06c7c
>>>>>>> [    6.523915]  dsisr: 0
>>>>>>> [    6.526190]   current = 0xef8bab00
>>>>>>> [    6.529603]     pid   = 115, comm = kworker/0:1
>>>>>>> [    6.534163] enter ? for help
>>>>>>> [    6.537054] [link register   ] c0014f88 msi_bitmap_free_hwirqs+0x50/0x94
>>>>>>> [    6.543811] [efa31da0] c0014f78 msi_bitmap_free_hwirqs+0x40/0x94 (unreliable)
>>>>>>> [    6.551001] [efa31dc0] c001aee8 ppc4xx_setup_msi_irqs+0xac/0xf4
>>>>>>> [    6.556973] [efa31e00] c03503a4 pci_enable_msi_range+0x1e0/0x280
>>>>>>> [    6.563032] [efa31e40] f92c2f74 azx_probe_work+0xe0/0x57c [snd_hda_intel]
>>>>>>> [    6.569906] [efa31e80] c0036344 process_one_work+0x1e8/0x2f0
>>>>>>> [    6.575627] [efa31eb0] c003677c worker_thread+0x2f4/0x438
>>>>>>> [    6.581079] [efa31ef0] c003a3e4 kthread+0xc8/0xcc
>>>>>>> [    6.585844] [efa31f40] c000aec4 ret_from_kernel_thread+0x5c/0x64
>>>>>>> [    6.591910] mon>  <no input ...>
>>>>> Managed to do a third git bisect  with the following results .
>>>> Great work.
>>>>
>>>>> git bisect bad
>>>>> 9279d3286e10736766edcaf815ae10e00856e448 is the first bad commit
>>>>> commit 9279d3286e10736766edcaf815ae10e00856e448
>>>>> Author: Rasmus Villemoes<linux@rasmusvillemoes.dk>
>>>>> Date:   Wed Aug 6 16:10:16 2014 -0700
>>>>>
>>>>>      lib: bitmap: change parameter of bitmap_*_region to unsigned
>>>> So the bug is in the 4xx MSI code, and has always been there, in fact I don't
>>>> see how that code has *ever* worked. The commit you bisected to just caused the
>>>> existing bug to cause an oops.
>>>>
>>>> Can you try this?
>>>>
>>>> diff --git a/arch/powerpc/sysdev/ppc4xx_msi.c b/arch/powerpc/sysdev/ppc4xx_msi.c
>>>> index 6e2e6aa378bb..effb5b878a78 100644
>>>> --- a/arch/powerpc/sysdev/ppc4xx_msi.c
>>>> +++ b/arch/powerpc/sysdev/ppc4xx_msi.c
>>>> @@ -95,11 +95,9 @@ static int ppc4xx_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
>>>>   
>>>>   	list_for_each_entry(entry, &dev->msi_list, list) {
>>>>   		int_no = msi_bitmap_alloc_hwirqs(&msi_data->bitmap, 1);
>>>> -		if (int_no >= 0)
>>>> -			break;
>>>>   		if (int_no < 0) {
>>>> -			pr_debug("%s: fail allocating msi interrupt\n",
>>>> -					__func__);
>>>> +			pr_warn("%s: fail allocating msi interrupt\n", __func__);
>>>> +			return -ENOSPC;
>>>>   		}
>>>>   		virq = irq_of_parse_and_map(msi_data->msi_dev, int_no);
>>>>   		if (virq == NO_IRQ) {
>>>>
>>> Thanks.
>>> This works with 3.17-rc1. Will try with the 3.18 Branch .
>> OK great.
>>
>>> Any ideas why drm is not  working ? (It never worked) .
>> No sorry. You might have more luck if you post a new thread to the dri list.
>>
>>> [    5.809802] Linux agpgart interface v0.103
>>> [    6.137893] [drm] Initialized drm 1.1.0 20060810
>>> [    6.439872] snd_hda_intel 0001:81:00.1: enabling device (0000 -> 0002)
>>> [    6.508544] ppc4xx_setup_msi_irqs: fail allocating msi interrupt
>> I'm curious why it's failing to allocate MSIs. Possibly it's just run out.
>>
>> Can you post the output of 'cat /proc/interrupts'?
>>
>> cheers
>>
>>
>>
>
>
> cat /proc/interrupts
>             CPU0
>   18:          0       UIC  11 Edge      L2C
>   19:          0       UIC  12 Level     snd_ice1724
>   20:          1       UIC  16 Level
>   21:        306       UIC  17 Level     snd_hda_intel
>   22:      12212       UIC   0 Level     0002:00:04.0
>   25:        619       UIC   6 Level     MAL TX EOB
>   26:        937       UIC   7 Level     MAL RX EOB
>   27:          0       UIC   3 Level     MAL SERR
>   28:          0       UIC   4 Level     MAL TX DE
>   31:          0       UIC   5 Level     MAL RX DE
>   32:       6607       UIC  29 Level     ehci_hcd:usb1
>   33:          1       UIC  30 Level     ohci_hcd:usb2
>   38:         19       UIC   2 Level     IBM IIC
>   39:          0       UIC   3 Level     IBM IIC
>   40:          0       UIC  16 Level     EMAC
>   44:          0       UIC   0 Edge      aerdrv
>   45:          0       UIC   2 Edge      aerdrv
> LOC:     117318   Local timer interrupts for timer event device
> LOC:         53   Local timer interrupts for others
> SPU:          0   Spurious interrupts
> PMI:          0   Performance monitoring interrupts
> MCE:          0   Machine check exceptions
>
> More issues with Kernel 4.0.0-rc1
>
> [   33.535692] Unable to handle kernel paging request for data at address 0x00000008
> [   33.566786] Faulting instruction address: 0xc049db84
> [   33.574188] Vector: 300 (Data Access) at [eeb13c20]
> [   33.579086]     pc: c049db84: radeon_audio_enable+0x4/0x18
> [   33.584630]     lr: c049e2f4: radeon_audio_detect+0x288/0x290
> [   33.590429]     sp: eeb13cd0
> [   33.593310]    msr: 29000
> [   33.595931]    dar: 8
> [   33.598207]  dsisr: 0
> [   33.600480]   current = 0xeea93ac0
> [   33.603885]     pid   = 2311, comm = Xorg
> [   33.607922] enter ? for help
> [   33.610806] [link register   ] c049e2f4 radeon_audio_detect+0x288/0x290
> [   33.617469] [eeb13cd0] c049e254 radeon_audio_detect+0x1e8/0x290 (unreliable)
> [   33.624571] [eeb13d00] c03dfe7c radeon_dvi_detect+0x388/0x3ac
> [   33.630369] [eeb13d30] c038b9d4 drm_helper_probe_single_connector_modes_merge_bits+0xf4/0x434
> [   33.638954] [eeb13d70] c03a7670 drm_mode_getconnector+0xf4/0x334
> [   33.645022] [eeb13e10] c039a8c0 drm_ioctl+0x348/0x464
> [   33.650135] [eeb13ed0] c00d0ca0 do_vfs_ioctl+0x52c/0x6e8
> [   33.655507] [eeb13f20] c00d0e9c SyS_ioctl+0x40/0x68
> [   33.660438] [eeb13f40] c000ab04 ret_from_syscall+0x0/0x3c
> [   33.665896] --- Exception: c01 (System Call) at 6fb1b8dc
> [   33.671253] SP (bfa56d20) is in userspace
> [   33.675263] mon>  <no input ...>
> [   35.703835] Oops: Kernel access of bad area, sig: 11 [#1]
> [   35.709554] PREEMPT Canyonlands
> [   35.712876] Modules linked in: cfg80211 snd_ice1724 snd_hda_codec_hdmi snd_ak4113 snd_pt2258 snd_ak4114 snd_i2c snd_ice17xx_ak4xxx snd_ak4xxx_adda snd_ac97_codec snd_hda_intel ac97_bus snd_hda_controller snd_rawmidi snd_hda_codec snd_seq_device snd_pcm snd_timer snd
> [   35.738047] CPU: 0 PID: 2311 Comm: Xorg Not tainted 4.0.0-rc1-Sam460ex #1
> [   35.745189] task: eea93ac0 ti: eeb12000 task.ti: eeb12000
> [   35.750872] NIP: c049db84 LR: c049e2f4 CTR: 00000000
> [   35.756098] REGS: eeb13c20 TRAP: 0300   Not tainted  (4.0.0-rc1-Sam460ex)
> [   35.763241] MSR: 00029000 <CE,EE,ME>  CR: 24004422  XER: 20000000
> [   35.769778] DEAR: 00000008 ESR: 00000000
> GPR00: c049e254 eeb13cd0 eea93ac0 eaa84000 00000000 0000000f ee0532c0 000190d6
> GPR08: eab6da00 00000000 00000000 eeb13cb0 28004422 b7a11ff4 b7a87a98 b7a87988
> GPR16: 00000000 ffffffff 00000000 eeb13e18 eaa08194 eaa08178 00000001 00004000
> GPR24: 00004000 c071cd28 fffffff2 00000000 eab6c000 eaa84000 eab6da00 eab80400
> [   35.804302] NIP [c049db84] radeon_audio_enable+0x4/0x18
> [   35.809799] LR [c049e2f4] radeon_audio_detect+0x288/0x290
> [   35.815480] Call Trace:
> [   35.818053] [eeb13cd0] [c049e254] radeon_audio_detect+0x1e8/0x290 (unreliable)
> [   35.825694] [eeb13d00] [c03dfe7c] radeon_dvi_detect+0x388/0x3ac
> [   35.831956] [eeb13d30] [c038b9d4] drm_helper_probe_single_connector_modes_merge_bits+0xf4/0x434
> [   35.841137] [eeb13d70] [c03a7670] drm_mode_getconnector+0xf4/0x334
> [   35.847663] [eeb13e10] [c039a8c0] drm_ioctl+0x348/0x464
> [   35.853183] [eeb13ed0] [c00d0ca0] do_vfs_ioctl+0x52c/0x6e8
> [   35.858974] [eeb13f20] [c00d0e9c] SyS_ioctl+0x40/0x68
> [   35.864307] [eeb13f40] [c000ab04] ret_from_syscall+0x0/0x3c
> [   35.870196] --- interrupt: c01 at 0x6fb1b8dc
> [   35.870196]     LR = 0x6fb1b800
> [   35.877971] Instruction dump:
> [   35.881106] 8129012c 806a0018 2f890000 419e0018 81290004 2f890000 419e000c 7d2903a6
> [   35.889403] 4e800420 38600000 4e800020 81231c70 <81290008> 2f890000 4d9e0020 7d2903a6
> [   36.042121] ---[ end trace 3e83f5fa0d05c678 ]---
> [   36.046739]
>
With Kernel 3.19

[    2.454668] Linux agpgart interface v0.103
[    2.458979] [drm] Initialized drm 1.1.0 20060810
[    2.463814] [drm] radeon kernel modesetting enabled.
[    2.469870] [drm] initializing kernel modesetting (TURKS 0x1002:0x6758 0x1682:0x318B).
[    2.478007] [drm] register mmio base: 0xe90000000
[    2.482774] [drm] register mmio size: 131072
[    2.665432] ATOM BIOS: TURKS
[    2.668602] radeon 0001:81:00.0: VRAM: 1024M 0x0000000000000000 - 0x000000003FFFFFFF (1024M used)
[    2.677521] radeon 0001:81:00.0: GTT: 1024M 0x0000000040000000 - 0x000000007FFFFFFF
[    2.685201] [drm] Detected VRAM RAM=1024M, BAR=256M
[    2.690094] [drm] RAM width 128bits DDR
[    2.694109] [TTM] Zone  kernel: Available graphics memory: 379192 kiB
[    2.700596] [TTM] Zone highmem: Available graphics memory: 1034552 kiB
[    2.707147] [TTM] Initializing pool allocator
[    2.711540] [TTM] Initializing DMA pool allocator
[    2.716359] [drm] radeon: 1024M of VRAM memory ready
[    2.721355] [drm] radeon: 1024M of GTT memory ready.
[    2.726395] [drm] Loading TURKS Microcode
[    2.730457] [drm] Internal thermal controller with fan control
[    2.741697] [drm] radeon: dpm initialized
[    2.745907] [drm] GART: num cpu pages 262144, num gpu pages 262144
[    2.787690] [drm] PCIE GART of 1024M enabled (table at 0x0000000000274000).
[    2.794953] radeon 0001:81:00.0: WB enabled
[    2.799182] radeon 0001:81:00.0: fence driver on ring 0 use gpu addr 0x0000000040000c00 and cpu addr 0xffc01c00
[    2.809300] radeon 0001:81:00.0: fence driver on ring 3 use gpu addr 0x0000000040000c0c and cpu addr 0xffc01c0c
[    2.839260] radeon 0001:81:00.0: fence driver on ring 5 use gpu addr 0x0000000000072118 and cpu addr 0xf9032118
[    2.849411] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    2.856067] [drm] Driver supports precise vblank timestamp query.
[    2.862183] radeon 0001:81:00.0: radeon: MSI limited to 32-bit
[    2.868058] ppc4xx_setup_msi_irqs: fail allocating msi interrupt
[    2.874153] [drm] radeon: irq initialized.
[    3.103973] [drm:r600_ring_test] *ERROR* radeon: ring 0 test failed (scratch(0x8504)=0xCAFEDEAD)
[    3.112806] radeon 0001:81:00.0: disabling GPU acceleration
[    3.128627] [drm] Radeon Display Connectors
[    3.133369] [drm] Connector 0:
[    3.136481] [drm]   DP-1
[    3.139089] [drm]   HPD1
[    3.141665] [drm]   DDC: 0x6470 0x6470 0x6474 0x6474 0x6478 0x6478 0x647c 0x647c
[    3.149146] [drm]   Encoders:
[    3.152157] [drm]     DFP1: INTERNAL_UNIPHY2
[    3.156473] [drm] Connector 1:
[    3.159570] [drm]   HDMI-A-1
[    3.162469] [drm]   HPD5
[    3.165019] [drm]   DDC: 0x6480 0x6480 0x6484 0x6484 0x6488 0x6488 0x648c 0x648c
[    3.172436] [drm]   Encoders:
[    3.175415] [drm]     DFP2: INTERNAL_UNIPHY2
[    3.179703] [drm] Connector 2:
[    3.182766] [drm]   DVI-I-1
[    3.185570] [drm]   HPD4
[    3.188117] [drm]   DDC: 0x6450 0x6450 0x6454 0x6454 0x6458 0x6458 0x645c 0x645c
[    3.195535] [drm]   Encoders:
[    3.198513] [drm]     DFP3: INTERNAL_UNIPHY
[    3.202706] [drm]     CRT1: INTERNAL_KLDSCP_DAC1
[    3.352245] [drm] fb mappable at 0x80475000
[    3.356458] [drm] vram apper at 0x80000000
[    3.360570] [drm] size 8294400
[    3.363634] [drm] fb depth is 24
[    3.366873] [drm]    pitch is 7680
[    3.575080] Console: switching to colour frame buffer device 240x67
[    3.649278] radeon 0001:81:00.0: fb0: radeondrmfb frame buffer device
[    3.656071] radeon 0001:81:00.0: registered panic notifier
[    3.666472] [drm] Initialized radeon 2.40.0 20080528 for 0001:81:00.0 on minor 0

attempting to post this on dri-devel-request@lists.freedesktop.org


--------------070004080106070901050905
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">On 2/23/2015 9:03 AM, Julian Margetson
      wrote:<br>
    </div>
    <blockquote cite="mid:54EB253F.9020704@candw.ms" type="cite">
      <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
      <div class="moz-cite-prefix">On 2/18/2015 10:56 PM, Michael
        Ellerman wrote:<br>
      </div>
      <blockquote cite="mid:1424314594.22408.1.camel@ellerman.id.au"
        type="cite">
        <pre wrap="">On Wed, 2015-02-18 at 21:36 -0400, Julian Margetson wrote:
</pre>
        <blockquote type="cite">
          <pre wrap="">On 2/18/2015 8:13 PM, Michael Ellerman wrote:

</pre>
          <blockquote type="cite">
            <pre wrap="">On Wed, 2015-02-18 at 15:45 -0400, Julian Margetson wrote:
</pre>
            <blockquote type="cite">
              <pre wrap="">On 2/15/2015 8:18 PM, Michael Ellerman wrote:

</pre>
              <blockquote type="cite">
                <pre wrap="">On Sun, 2015-02-15 at 08:16 -0400, Julian Margetson wrote:
</pre>
                <blockquote type="cite">
                  <pre wrap="">Hi

I am unable to get any kernel beyond  the 3.16 branch working on an
Acube Sam460ex
 AMCC 460ex based motherboard. Kernel  up 3.16.7-ckt6 working.
</pre>
                </blockquote>
                <pre wrap="">Does reverting b0345bbc6d09 change anything?

</pre>
                <blockquote type="cite">
                  <pre wrap="">[    6.364350] snd_hda_intel 0001:81:00.1: enabling device (0000 -&gt; 0002)
[    6.453794] snd_hda_intel 0001:81:00.1: ppc4xx_setup_msi_irqs: fail mapping irq
[    6.487530] Unable to handle kernel paging request for data at address 0x0fa06c7c
[    6.495055] Faulting instruction address: 0xc032202c
[    6.500033] Vector: 300 (Data Access) at [efa31cf0]
[    6.504922]     pc: c032202c: __reg_op+0xe8/0x100
[    6.509697]     lr: c0014f88: msi_bitmap_free_hwirqs+0x50/0x94
[    6.515600]     sp: efa31da0
[    6.518491]    msr: 21000
[    6.521112]    dar: fa06c7c
[    6.523915]  dsisr: 0
[    6.526190]   current = 0xef8bab00
[    6.529603]     pid   = 115, comm = kworker/0:1
[    6.534163] enter ? for help
[    6.537054] [link register   ] c0014f88 msi_bitmap_free_hwirqs+0x50/0x94
[    6.543811] [efa31da0] c0014f78 msi_bitmap_free_hwirqs+0x40/0x94 (unreliable)
[    6.551001] [efa31dc0] c001aee8 ppc4xx_setup_msi_irqs+0xac/0xf4
[    6.556973] [efa31e00] c03503a4 pci_enable_msi_range+0x1e0/0x280
[    6.563032] [efa31e40] f92c2f74 azx_probe_work+0xe0/0x57c [snd_hda_intel]
[    6.569906] [efa31e80] c0036344 process_one_work+0x1e8/0x2f0
[    6.575627] [efa31eb0] c003677c worker_thread+0x2f4/0x438
[    6.581079] [efa31ef0] c003a3e4 kthread+0xc8/0xcc
[    6.585844] [efa31f40] c000aec4 ret_from_kernel_thread+0x5c/0x64
[    6.591910] mon&gt;  &lt;no input ...&gt;
</pre>
                </blockquote>
              </blockquote>
              <pre wrap="">Managed to do a third git bisect  with the following results .
</pre>
            </blockquote>
            <pre wrap="">Great work.

</pre>
            <blockquote type="cite">
              <pre wrap="">git bisect bad
9279d3286e10736766edcaf815ae10e00856e448 is the first bad commit
commit 9279d3286e10736766edcaf815ae10e00856e448
Author: Rasmus Villemoes <a moz-do-not-send="true" class="moz-txt-link-rfc2396E" href="mailto:linux@rasmusvillemoes.dk">&lt;linux@rasmusvillemoes.dk&gt;</a>
Date:   Wed Aug 6 16:10:16 2014 -0700

    lib: bitmap: change parameter of bitmap_*_region to unsigned
</pre>
            </blockquote>
            <pre wrap="">So the bug is in the 4xx MSI code, and has always been there, in fact I don't
see how that code has *ever* worked. The commit you bisected to just caused the
existing bug to cause an oops.

Can you try this?

diff --git a/arch/powerpc/sysdev/ppc4xx_msi.c b/arch/powerpc/sysdev/ppc4xx_msi.c
index 6e2e6aa378bb..effb5b878a78 100644
--- a/arch/powerpc/sysdev/ppc4xx_msi.c
+++ b/arch/powerpc/sysdev/ppc4xx_msi.c
@@ -95,11 +95,9 @@ static int ppc4xx_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 
 	list_for_each_entry(entry, &amp;dev-&gt;msi_list, list) {
 		int_no = msi_bitmap_alloc_hwirqs(&amp;msi_data-&gt;bitmap, 1);
-		if (int_no &gt;= 0)
-			break;
 		if (int_no &lt; 0) {
-			pr_debug("%s: fail allocating msi interrupt\n",
-					__func__);
+			pr_warn("%s: fail allocating msi interrupt\n", __func__);
+			return -ENOSPC;
 		}
 		virq = irq_of_parse_and_map(msi_data-&gt;msi_dev, int_no);
 		if (virq == NO_IRQ) {

</pre>
          </blockquote>
          <pre wrap="">Thanks.
</pre>
        </blockquote>
        <blockquote type="cite">
          <pre wrap="">This works with 3.17-rc1. Will try with the 3.18 Branch .
</pre>
        </blockquote>
        <pre wrap="">OK great.

</pre>
        <blockquote type="cite">
          <pre wrap="">Any ideas why drm is not  working ? (It never worked) .
</pre>
        </blockquote>
        <pre wrap="">No sorry. You might have more luck if you post a new thread to the dri list.

</pre>
        <blockquote type="cite">
          <pre wrap="">[    5.809802] Linux agpgart interface v0.103
[    6.137893] [drm] Initialized drm 1.1.0 20060810
[    6.439872] snd_hda_intel 0001:81:00.1: enabling device (0000 -&gt; 0002)
[    6.508544] ppc4xx_setup_msi_irqs: fail allocating msi interrupt
</pre>
        </blockquote>
        <pre wrap="">I'm curious why it's failing to allocate MSIs. Possibly it's just run out.

Can you post the output of 'cat /proc/interrupts'?

cheers



</pre>
      </blockquote>
      <br>
      <br>
      <pre class="western">cat /proc/interrupts
           CPU0       
 18:          0       UIC  11 Edge      L2C
 19:          0       UIC  12 Level     snd_ice1724
 20:          1       UIC  16 Level   
 21:        306       UIC  17 Level     snd_hda_intel
 22:      12212       UIC   0 Level     0002:00:04.0
 25:        619       UIC   6 Level     MAL TX EOB
 26:        937       UIC   7 Level     MAL RX EOB
 27:          0       UIC   3 Level     MAL SERR
 28:          0       UIC   4 Level     MAL TX DE
 31:          0       UIC   5 Level     MAL RX DE
 32:       6607       UIC  29 Level     ehci_hcd:usb1
 33:          1       UIC  30 Level     ohci_hcd:usb2
 38:         19       UIC   2 Level     IBM IIC
 39:          0       UIC   3 Level     IBM IIC
 40:          0       UIC  16 Level     EMAC
 44:          0       UIC   0 Edge      aerdrv
 45:          0       UIC   2 Edge      aerdrv
LOC:     117318   Local timer interrupts for timer event device
LOC:         53   Local timer interrupts for others
SPU:          0   Spurious interrupts
PMI:          0   Performance monitoring interrupts
MCE:          0   Machine check exceptions</pre>
      <br>
      More issues with Kernel 4.0.0-rc1<br>
      <br>
      <meta http-equiv="content-type" content="text/html; charset=utf-8">
      <pre class="western">[   33.535692] Unable to handle kernel paging request for data at address 0x00000008
[   33.566786] Faulting instruction address: 0xc049db84
[   33.574188] Vector: 300 (Data Access) at [eeb13c20]
[   33.579086]     pc: c049db84: radeon_audio_enable+0x4/0x18
[   33.584630]     lr: c049e2f4: radeon_audio_detect+0x288/0x290
[   33.590429]     sp: eeb13cd0
[   33.593310]    msr: 29000
[   33.595931]    dar: 8
[   33.598207]  dsisr: 0
[   33.600480]   current = 0xeea93ac0
[   33.603885]     pid   = 2311, comm = Xorg
[   33.607922] enter ? for help
[   33.610806] [link register   ] c049e2f4 radeon_audio_detect+0x288/0x290
[   33.617469] [eeb13cd0] c049e254 radeon_audio_detect+0x1e8/0x290 (unreliable)
[   33.624571] [eeb13d00] c03dfe7c radeon_dvi_detect+0x388/0x3ac
[   33.630369] [eeb13d30] c038b9d4 drm_helper_probe_single_connector_modes_merge_bits+0xf4/0x434
[   33.638954] [eeb13d70] c03a7670 drm_mode_getconnector+0xf4/0x334
[   33.645022] [eeb13e10] c039a8c0 drm_ioctl+0x348/0x464
[   33.650135] [eeb13ed0] c00d0ca0 do_vfs_ioctl+0x52c/0x6e8
[   33.655507] [eeb13f20] c00d0e9c SyS_ioctl+0x40/0x68
[   33.660438] [eeb13f40] c000ab04 ret_from_syscall+0x0/0x3c
[   33.665896] --- Exception: c01 (System Call) at 6fb1b8dc
[   33.671253] SP (bfa56d20) is in userspace
[   33.675263] mon&gt;  &lt;no input ...&gt;
[   35.703835] Oops: Kernel access of bad area, sig: 11 [#1]
[   35.709554] PREEMPT Canyonlands
[   35.712876] Modules linked in: cfg80211 snd_ice1724 snd_hda_codec_hdmi snd_ak4113 snd_pt2258 snd_ak4114 snd_i2c snd_ice17xx_ak4xxx snd_ak4xxx_adda snd_ac97_codec snd_hda_intel ac97_bus snd_hda_controller snd_rawmidi snd_hda_codec snd_seq_device snd_pcm snd_timer snd
[   35.738047] CPU: 0 PID: 2311 Comm: Xorg Not tainted 4.0.0-rc1-Sam460ex #1
[   35.745189] task: eea93ac0 ti: eeb12000 task.ti: eeb12000
[   35.750872] NIP: c049db84 LR: c049e2f4 CTR: 00000000
[   35.756098] REGS: eeb13c20 TRAP: 0300   Not tainted  (4.0.0-rc1-Sam460ex)
[   35.763241] MSR: 00029000 &lt;CE,EE,ME&gt;  CR: 24004422  XER: 20000000
[   35.769778] DEAR: 00000008 ESR: 00000000
GPR00: c049e254 eeb13cd0 eea93ac0 eaa84000 00000000 0000000f ee0532c0 000190d6
GPR08: eab6da00 00000000 00000000 eeb13cb0 28004422 b7a11ff4 b7a87a98 b7a87988
GPR16: 00000000 ffffffff 00000000 eeb13e18 eaa08194 eaa08178 00000001 00004000
GPR24: 00004000 c071cd28 fffffff2 00000000 eab6c000 eaa84000 eab6da00 eab80400
[   35.804302] NIP [c049db84] radeon_audio_enable+0x4/0x18
[   35.809799] LR [c049e2f4] radeon_audio_detect+0x288/0x290
[   35.815480] Call Trace:
[   35.818053] [eeb13cd0] [c049e254] radeon_audio_detect+0x1e8/0x290 (unreliable)
[   35.825694] [eeb13d00] [c03dfe7c] radeon_dvi_detect+0x388/0x3ac
[   35.831956] [eeb13d30] [c038b9d4] drm_helper_probe_single_connector_modes_merge_bits+0xf4/0x434
[   35.841137] [eeb13d70] [c03a7670] drm_mode_getconnector+0xf4/0x334
[   35.847663] [eeb13e10] [c039a8c0] drm_ioctl+0x348/0x464
[   35.853183] [eeb13ed0] [c00d0ca0] do_vfs_ioctl+0x52c/0x6e8
[   35.858974] [eeb13f20] [c00d0e9c] SyS_ioctl+0x40/0x68
[   35.864307] [eeb13f40] [c000ab04] ret_from_syscall+0x0/0x3c
[   35.870196] --- interrupt: c01 at 0x6fb1b8dc
[   35.870196]     LR = 0x6fb1b800
[   35.877971] Instruction dump:
[   35.881106] 8129012c 806a0018 2f890000 419e0018 81290004 2f890000 419e000c 7d2903a6
[   35.889403] 4e800420 38600000 4e800020 81231c70 &lt;81290008&gt; 2f890000 4d9e0020 7d2903a6
[   36.042121] ---[ end trace 3e83f5fa0d05c678 ]---
[   36.046739]</pre>
      <title></title>
      <meta name="generator" content="LibreOffice 4.3.5.2 (Windows)">
      <meta name="created" content="00:00:00">
      <meta name="changed" content="00:00:00">
      <style type="text/css">
		@page { margin: 0.79in }
		pre.cjk { font-family: "NSimSun", monospace }
		p { margin-bottom: 0.1in; line-height: 120% }
		a:link { so-language: zxx }
	</style><br>
    </blockquote>
    With Kernel 3.19<br>
    <meta http-equiv="content-type" content="text/html; charset=utf-8">
    <pre class="western">[    2.454668] Linux agpgart interface v0.103
[    2.458979] [drm] Initialized drm 1.1.0 20060810
[    2.463814] [drm] radeon kernel modesetting enabled.
[    2.469870] [drm] initializing kernel modesetting (TURKS 0x1002:0x6758 0x1682:0x318B).
[    2.478007] [drm] register mmio base: 0xe90000000
[    2.482774] [drm] register mmio size: 131072
[    2.665432] ATOM BIOS: TURKS
[    2.668602] radeon 0001:81:00.0: VRAM: 1024M 0x0000000000000000 - 0x000000003FFFFFFF (1024M used)
[    2.677521] radeon 0001:81:00.0: GTT: 1024M 0x0000000040000000 - 0x000000007FFFFFFF
[    2.685201] [drm] Detected VRAM RAM=1024M, BAR=256M
[    2.690094] [drm] RAM width 128bits DDR
[    2.694109] [TTM] Zone  kernel: Available graphics memory: 379192 kiB
[    2.700596] [TTM] Zone highmem: Available graphics memory: 1034552 kiB
[    2.707147] [TTM] Initializing pool allocator
[    2.711540] [TTM] Initializing DMA pool allocator
[    2.716359] [drm] radeon: 1024M of VRAM memory ready
[    2.721355] [drm] radeon: 1024M of GTT memory ready.
[    2.726395] [drm] Loading TURKS Microcode
[    2.730457] [drm] Internal thermal controller with fan control
[    2.741697] [drm] radeon: dpm initialized
[    2.745907] [drm] GART: num cpu pages 262144, num gpu pages 262144
[    2.787690] [drm] PCIE GART of 1024M enabled (table at 0x0000000000274000).
[    2.794953] radeon 0001:81:00.0: WB enabled
[    2.799182] radeon 0001:81:00.0: fence driver on ring 0 use gpu addr 0x0000000040000c00 and cpu addr 0xffc01c00
[    2.809300] radeon 0001:81:00.0: fence driver on ring 3 use gpu addr 0x0000000040000c0c and cpu addr 0xffc01c0c
[    2.839260] radeon 0001:81:00.0: fence driver on ring 5 use gpu addr 0x0000000000072118 and cpu addr 0xf9032118
[    2.849411] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    2.856067] [drm] Driver supports precise vblank timestamp query.
[    2.862183] radeon 0001:81:00.0: radeon: MSI limited to 32-bit
[    2.868058] ppc4xx_setup_msi_irqs: fail allocating msi interrupt
[    2.874153] [drm] radeon: irq initialized.
[    3.103973] [drm:r600_ring_test] *ERROR* radeon: ring 0 test failed (scratch(0x8504)=0xCAFEDEAD)
[    3.112806] radeon 0001:81:00.0: disabling GPU acceleration
[    3.128627] [drm] Radeon Display Connectors
[    3.133369] [drm] Connector 0:
[    3.136481] [drm]   DP-1
[    3.139089] [drm]   HPD1
[    3.141665] [drm]   DDC: 0x6470 0x6470 0x6474 0x6474 0x6478 0x6478 0x647c 0x647c
[    3.149146] [drm]   Encoders:
[    3.152157] [drm]     DFP1: INTERNAL_UNIPHY2
[    3.156473] [drm] Connector 1:
[    3.159570] [drm]   HDMI-A-1
[    3.162469] [drm]   HPD5
[    3.165019] [drm]   DDC: 0x6480 0x6480 0x6484 0x6484 0x6488 0x6488 0x648c 0x648c
[    3.172436] [drm]   Encoders:
[    3.175415] [drm]     DFP2: INTERNAL_UNIPHY2
[    3.179703] [drm] Connector 2:
[    3.182766] [drm]   DVI-I-1
[    3.185570] [drm]   HPD4
[    3.188117] [drm]   DDC: 0x6450 0x6450 0x6454 0x6454 0x6458 0x6458 0x645c 0x645c
[    3.195535] [drm]   Encoders:
[    3.198513] [drm]     DFP3: INTERNAL_UNIPHY
[    3.202706] [drm]     CRT1: INTERNAL_KLDSCP_DAC1
[    3.352245] [drm] fb mappable at 0x80475000
[    3.356458] [drm] vram apper at 0x80000000
[    3.360570] [drm] size 8294400
[    3.363634] [drm] fb depth is 24
[    3.366873] [drm]    pitch is 7680
[    3.575080] Console: switching to colour frame buffer device 240x67
[    3.649278] radeon 0001:81:00.0: fb0: radeondrmfb frame buffer device
[    3.656071] radeon 0001:81:00.0: registered panic notifier
[    3.666472] [drm] Initialized radeon 2.40.0 20080528 for 0001:81:00.0 on minor 0</pre>
    <title></title>
    <meta name="generator" content="LibreOffice 4.3.5.2 (Windows)">
    <meta name="created" content="00:00:00">
    <meta name="changed" content="00:00:00">
    <style type="text/css">
		@page { margin: 0.79in }
		pre.cjk { font-family: "NSimSun", monospace }
		p { margin-bottom: 0.1in; line-height: 120% }
		a:link { so-language: zxx } </style>attempting to post this on
    <a class="moz-txt-link-abbreviated" href="mailto:dri-devel-request@lists.freedesktop.org">dri-devel-request@lists.freedesktop.org</a><br>
    <br>
  </body>
</html>

--------------070004080106070901050905--
