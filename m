Return-Path: <runaway@candw.ms>
Received: from mail-vc0-f177.google.com (mail-vc0-f177.google.com
 [209.85.220.177])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B1FFD1A0DFA
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  8 Mar 2015 03:10:34 +1100 (AEDT)
Received: by mail-vc0-f177.google.com with SMTP id id10so7149374vcb.8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 Mar 2015 08:10:32 -0800 (PST)
Message-ID: <54FB22F0.1050506@candw.ms>
Date: Sat, 07 Mar 2015 12:10:24 -0400
From: Julian Margetson <runaway@candw.ms>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: Problems with Kernels 3.17-rc1 and onwards on Acube Sam460 AMCC
 460ex board
References: <54E08E06.8060607@candw.ms>	
 <1424045921.3018.4.camel@ellerman.id.au> <54E4EBD7.5000307@candw.ms>	
 <1424304787.22020.4.camel@ellerman.id.au> <54E53E07.60609@candw.ms>	
 <1424314594.22408.1.camel@ellerman.id.au> <54E55796.6000401@candw.ms>	
 <54E78A12.7080409@candw.ms> <1424737962.2318.2.camel@ellerman.id.au>	
 <45dfe45093f.4ef2935f@smtp.gmail.com> <54ECCD8A.3060708@gmx.net>	
 <54ECDE7D.6070303@candw.ms> <54EDCD9E.5010104@candw.ms>	
 <54F6F081.9060007@candw.ms> <1425513154.32154.12.camel@ellerman.id.au>
 <54F83ADC.9050203@candw.ms>
In-Reply-To: <54F83ADC.9050203@candw.ms>
Content-Type: multipart/alternative;
 boundary="------------090408020701000507050903"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------090408020701000507050903
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/5/2015 7:15 AM, Julian Margetson wrote:
> On 3/4/2015 7:52 PM, Michael Ellerman wrote:
>> On Wed, 2015-03-04 at 07:46 -0400, Julian Margetson wrote:
>>> Still stuck.
>>> Problem still exist with 4.0.0-rc2 and I cant finish the bisect.
>>> Triggered when using HDMI. No problem when using DVI.
>>> [   33.535692] Unable to handle kernel paging request for data at 
>>> address 0x00000008
>>> [   33.566786] Faulting instruction address: 0xc049db84
>>> [   33.574188] Vector: 300 (Data Access) at [eeb13c20]
>>> [   33.579086]     pc: c049db84: radeon_audio_enable+0x4/0x18
>>> [   33.584630]     lr: c049e2f4: radeon_audio_detect+0x288/0x290
>>> [   33.590429]     sp: eeb13cd0
>>> [   33.593310]    msr: 29000
>>> [   33.595931]    dar: 8
>>> [   33.598207]  dsisr: 0
>>> [   33.600480]   current = 0xeea93ac0
>>> [   33.603885]     pid   = 2311, comm = Xorg
>>> [   33.607922] enter ? for help
>>> [   33.610806] [link register   ] c049e2f4 
>>> radeon_audio_detect+0x288/0x290
>>> [   33.617469] [eeb13cd0] c049e254 radeon_audio_detect+0x1e8/0x290 
>>> (unreliable)
>>> [   33.624571] [eeb13d00] c03dfe7c radeon_dvi_detect+0x388/0x3ac
>>> [   33.630369] [eeb13d30] c038b9d4 
>>> drm_helper_probe_single_connector_modes_merge_bits+0xf4/0x434
>>> [   33.638954] [eeb13d70] c03a7670 drm_mode_getconnector+0xf4/0x334
>>> [   33.645022] [eeb13e10] c039a8c0 drm_ioctl+0x348/0x464
>>> [   33.650135] [eeb13ed0] c00d0ca0 do_vfs_ioctl+0x52c/0x6e8
>>> [   33.655507] [eeb13f20] c00d0e9c SyS_ioctl+0x40/0x68
>>> [   33.660438] [eeb13f40] c000ab04 ret_from_syscall+0x0/0x3c
>>> [   33.665896] --- Exception: c01 (System Call) at 6fb1b8dc
>>> [   33.671253] SP (bfa56d20) is in userspace
>>> [   33.675263] mon>  <no input ...>
>> This just looks like a missing NULL check in the radeon code. 
>> Probably here:
>>
>> void radeon_audio_detect(struct drm_connector *connector,
>>     enum drm_connector_status status)
>> {
>>     struct radeon_device *rdev;
>>     struct radeon_encoder *radeon_encoder;
>>     struct radeon_encoder_atom_dig *dig;
>>
>>     if (!connector || !connector->encoder)
>>         return;
>>
>>     rdev = connector->encoder->dev->dev_private;
>>                                ^
>>
>> So you could try adding "!connector->encoder->dev" to the if there.
>>
>> cheers
>>
>>
>>
> Thanks.
>
> Results in the following .
> [    3.179934] [drm] Radeon Display Connectors
> [    3.184711] [drm] Connector 0:
> [    3.187827] [drm]   DP-1
> [    3.190443] [drm]   HPD1
> [    3.193018] [drm]   DDC: 0x6470 0x6470 0x6474 0x6474 0x6478 0x6478 
> 0x647c 0x6                         47c
> [    3.200502] [drm]   Encoders:
> [    3.203510] [drm]     DFP1: INTERNAL_UNIPHY2
> [    3.207823] [drm] Connector 1:
> [    3.210923] [drm]   HDMI-A-1
> [    3.213831] [drm]   HPD5
> [    3.216381] [drm]   DDC: 0x6480 0x6480 0x6484 0x6484 0x6488 0x6488 
> 0x648c 0x6                         48c
> [    3.223809] [drm]   Encoders:
> [    3.226795] [drm]     DFP2: INTERNAL_UNIPHY2
> [    3.231083] [drm] Connector 2:
> [    3.234155] [drm]   DVI-I-1
> [    3.236968] [drm]   HPD4
> [    3.239523] [drm]   DDC: 0x6450 0x6450 0x6454 0x6454 0x6458 0x6458 
> 0x645c 0x6                         45c
> [    3.246942] [drm]   Encoders:
> [    3.249929] [drm]     DFP3: INTERNAL_UNIPHY
> [    3.254130] [drm]     CRT1: INTERNAL_KLDSCP_DAC1
> [    3.262872] Unable to handle kernel paging request for data at 
> address 0x00000000
> [    3.270407] Faulting instruction address: 0xc04a4280
> [    3.275394] Vector: 300 (Data Access) at [ea847b20]
> [    3.280286]     pc: c04a4280: radeon_audio_detect+0x1c/0x290
> [    3.286016]     lr: c03e6170: radeon_dp_detect+0x218/0x224
> [    3.291563]     sp: ea847bd0
> [    3.294453]    msr: 29000
> [    3.297084]    dar: 0
> [    3.299366]  dsisr: 0
> [    3.301649]   current = 0xea850000
> [    3.305062]     pid   = 1, comm = swapper
> [    3.309101] enter ? for help
> [    3.311994] [ea847c00] c03e6170 radeon_dp_detect+0x218/0x224
> [    3.317709] [ea847c20] c039160c 
> drm_helper_probe_single_connector_modes_merge _bits+0xf4/0x434
> [    3.326303] [ea847c60] c0398d68 
> drm_fb_helper_probe_connector_modes+0x5c/0x70
> [    3.333499] [ea847c80] c039ad40 
> drm_fb_helper_initial_config+0x38/0x380
> [    3.340174] [ea847cc0] c03f1848 radeon_fbdev_init+0xc8/0xfc
> [    3.345808] [ea847ce0] c03eb1cc radeon_modeset_init+0x77c/0x94c
> [    3.351781] [ea847d40] c03c72fc radeon_driver_load_kms+0xcc/0x134
> [    3.357935] [ea847d60] c03a3cfc drm_dev_register+0x9c/0x120
> [    3.363569] [ea847d80] c03a6538 drm_get_pci_dev+0xf4/0x190
> [    3.369116] [ea847da0] c033d194 pci_device_probe+0x68/0xb4
> [    3.374680] [ea847dc0] c04b8a4c driver_probe_device+0xd4/0x1f4
> [    3.380583] [ea847df0] c04b8c48 __driver_attach+0x78/0xa0
> [    3.386034] [ea847e10] c04b6fd8 bus_for_each_dev+0x8c/0x9c
> [    3.391572] [ea847e40] c04b81a8 bus_add_driver+0xf8/0x1d4
> [    3.397024] [ea847e60] c04b90fc driver_register+0xb4/0xf8
> [    3.402475] [ea847e80] c00016f0 do_one_initcall+0x114/0x19c
> [    3.408109] [ea847ef0] c0992a8c kernel_init_freeable+0x124/0x1c0
> [    3.414176] [ea847f30] c0001cc0 kernel_init+0x14/0xf4
> [    3.419280] [ea847f40] c000ac5c ret_from_kernel_thread+0x5c/0x64
> [    3.425347] mon>  <no input ...>
> [    5.428725] Oops: Kernel access of bad area, sig: 11 [#1]
> [    5.434140] PREEMPT Canyonlands
> [    5.437301] Modules linked in:
> [    5.440378] CPU: 0 PID: 1 Comm: swapper Not tainted 
> 4.0.0-rc2-Sam460ex #1
> [    5.447182] task: ea850000 ti: ea846000 task.ti: ea846000
> [    5.452597] NIP: c04a4280 LR: c03e6170 CTR: c03e44c0
> [    5.457571] REGS: ea847b20 TRAP: 0300   Not tainted 
> (4.0.0-rc2-Sam460ex)
> [    5.464374] MSR: 00029000 <CE,EE,ME>  CR: 82000028  XER: 00000000
> [    5.470582] DEAR: 00000000 ESR: 00000000
> GPR00: c03e6170 ea847bd0 ea850000 eeb6e400 00000002 00000000 ea847a48 
> 00000000
> GPR08: 00000000 ffffffff 00000000 ea847c00 22000022 00000000 c0910000 
> c091798f
> GPR16: c09179a5 c09179bb c09179d1 c09179e7 c09179fc c0910000 00000001 
> 00004000
> GPR24: 00004000 c0759c14 c0b40000 eeac8000 eeb671a0 eeb66400 00000000 
> eeb6e400
> [    5.503365] NIP [c04a4280] radeon_audio_detect+0x1c/0x290
> [    5.508780] LR [c03e6170] radeon_dp_detect+0x218/0x224
> [    5.513931] Call Trace:
> [    5.516391] [ea847bd0] [eeb6e40c] 0xeeb6e40c (unreliable)
> [    5.521835] [ea847c00] [c03e6170] radeon_dp_detect+0x218/0x224
> [    5.527696] [ea847c20] [c039160c] 
> drm_helper_probe_single_connector_modes_mer ge_bits+0xf4/0x434
> [    5.536429] [ea847c60] [c0398d68] 
> drm_fb_helper_probe_connector_modes+0x5c/0x 70
> [    5.543772] [ea847c80] [c039ad40] 
> drm_fb_helper_initial_config+0x38/0x380
> [    5.550587] [ea847cc0] [c03f1848] radeon_fbdev_init+0xc8/0xfc
> [    5.556358] [ea847ce0] [c03eb1cc] radeon_modeset_init+0x77c/0x94c
> [    5.562477] [ea847d40] [c03c72fc] radeon_driver_load_kms+0xcc/0x134
> [    5.568771] [ea847d60] [c03a3cfc] drm_dev_register+0x9c/0x120
> [    5.574544] [ea847d80] [c03a6538] drm_get_pci_dev+0xf4/0x190
> [    5.580231] [ea847da0] [c033d194] pci_device_probe+0x68/0xb4
> [    5.585916] [ea847dc0] [c04b8a4c] driver_probe_device+0xd4/0x1f4
> [    5.591948] [ea847df0] [c04b8c48] __driver_attach+0x78/0xa0
> [    5.597547] [ea847e10] [c04b6fd8] bus_for_each_dev+0x8c/0x9c
> [    5.603233] [ea847e40] [c04b81a8] bus_add_driver+0xf8/0x1d4
> [    5.608831] [ea847e60] [c04b90fc] driver_register+0xb4/0xf8
> [    5.614430] [ea847e80] [c00016f0] do_one_initcall+0x114/0x19c
> [    5.620204] [ea847ef0] [c0992a8c] kernel_init_freeable+0x124/0x1c0
> [    5.626408] [ea847f30] [c0001cc0] kernel_init+0x14/0xf4
> [    5.631661] [ea847f40] [c000ac5c] ret_from_kernel_thread+0x5c/0x64
> [    5.637864] Instruction dump:
> [    5.640851] 80890010 38210020 4bfffb20 39610020 4bb6ced0 9421ffd0 
> 7c0802a6 bf                         810020
> [    5.648732] 7c7f1b79 90010034 41820274 83df020c <813e0000> 2f890000 
> 419e0264 2b840001
> [    5.656812] ---[ end trace bdaa0514de2b69bd ]---
> [    5.661441]
> [    6.663014] Kernel panic - not syncing: Attempted to kill init! 
> exitcode=0x00                         00000b
> [    6.663014]
> [    6.672182] Rebooting in 180 seconds..
>
>
With the latest commits

[   29.960572] Unable to handle kernel paging request for data at address 0x00000008
[   29.974350] Faulting instruction address: 0xc04a4f44
[   32.012918] Oops: Kernel access of bad area, sig: 11 [#1]
[   32.044900] PREEMPT Canyonlands
[   32.061504] Modules linked in: cfg80211 bnep rfcomm bluetooth
[   32.081023] CPU: 0 PID: 2087 Comm: Xorg Not tainted 4.0.0-rc2-Sam460ex #1
[   32.101802] task: ed6891a0 ti: ed606000 task.ti: ed606000
[   32.121175] NIP: c04a4f44 LR: c03e6a4c CTR: c03d7b6c
[   32.139995] REGS: ed607c50 TRAP: 0300   Not tainted  (4.0.0-rc2-Sam460ex)
[   32.160678] MSR: 00029000 <CE,EE,ME>  CR: 24004442  XER: 00000000
[   32.180922] DEAR: 00000008 ESR: 00000000
GPR00: c03e6a4c ed607d00 ed6891a0 eeac8000 00000000 0000000f ed607be8 00000000
GPR08: 0000f6a3 00000000 eeaae400 ed607cc0 24004422 b7ceeff8 b7d05c14 00000000
GPR16: 00000000 ffffffff 00000000 ed607e18 eeaae578 eebe2600 00000001 00004000
GPR24: 00004000 c075bd08 fffffff2 00000000 eeac8000 00000001 00000001 ee51a400
[   32.285496] NIP [c04a4f44] radeon_audio_enable+0x4/0x18
[   32.305509] LR [c03e6a4c] radeon_dvi_detect+0x388/0x3ac
[   32.325444] Call Trace:
[   32.342325] [ed607d00] [c03e6a4c] radeon_dvi_detect+0x388/0x3ac (unreliable)
[   32.364075] [ed607d30] [c0391cc4] drm_helper_probe_single_connector_modes_merge_bits+0xf4/0x434
[   32.387631] [ed607d70] [c03adecc] drm_mode_getconnector+0xe4/0x330
[   32.408687] [ed607e10] [c03a0bbc] drm_ioctl+0x348/0x464
[   32.428766] [ed607ed0] [c00d0aac] do_vfs_ioctl+0x52c/0x6e8
[   32.449123] [ed607f20] [c00d0ca8] SyS_ioctl+0x40/0x68
[   32.469149] [ed607f40] [c000ab04] ret_from_syscall+0x0/0x3c
[   32.489581] --- interrupt: c01 at 0x6fae92bc
[   32.489581]     LR = 0x6fae91e0
[   32.526311] Instruction dump:
[   32.543848] 8129012c 806a0018 2f890000 419e0018 81290004 2f890000 419e000c 7d2903a6
[   32.566711] 4e800420 38600000 4e800020 81231cd8 <81290008> 2f890000 4d9e0020 7d2903a6
[   32.741188] ---[ end trace c9d41ee106b06efa ]---
[   32.745808]




--------------090408020701000507050903
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">On 3/5/2015 7:15 AM, Julian Margetson
      wrote:<br>
    </div>
    <blockquote cite="mid:54F83ADC.9050203@candw.ms" type="cite">On
      3/4/2015 7:52 PM, Michael Ellerman wrote:
      <br>
      <blockquote type="cite">On Wed, 2015-03-04 at 07:46 -0400, Julian
        Margetson wrote:
        <br>
        <blockquote type="cite">Still stuck.
          <br>
          Problem still exist with 4.0.0-rc2 and I cant finish the
          bisect.
          <br>
          Triggered when using HDMI. No problem when using DVI.
          <br>
          [   33.535692] Unable to handle kernel paging request for data
          at address 0x00000008
          <br>
          [   33.566786] Faulting instruction address: 0xc049db84
          <br>
          [   33.574188] Vector: 300 (Data Access) at [eeb13c20]
          <br>
          [   33.579086]     pc: c049db84: radeon_audio_enable+0x4/0x18
          <br>
          [   33.584630]     lr: c049e2f4:
          radeon_audio_detect+0x288/0x290
          <br>
          [   33.590429]     sp: eeb13cd0
          <br>
          [   33.593310]    msr: 29000
          <br>
          [   33.595931]    dar: 8
          <br>
          [   33.598207]  dsisr: 0
          <br>
          [   33.600480]   current = 0xeea93ac0
          <br>
          [   33.603885]     pid   = 2311, comm = Xorg
          <br>
          [   33.607922] enter ? for help
          <br>
          [   33.610806] [link register   ] c049e2f4
          radeon_audio_detect+0x288/0x290
          <br>
          [   33.617469] [eeb13cd0] c049e254
          radeon_audio_detect+0x1e8/0x290 (unreliable)
          <br>
          [   33.624571] [eeb13d00] c03dfe7c
          radeon_dvi_detect+0x388/0x3ac
          <br>
          [   33.630369] [eeb13d30] c038b9d4
          drm_helper_probe_single_connector_modes_merge_bits+0xf4/0x434
          <br>
          [   33.638954] [eeb13d70] c03a7670
          drm_mode_getconnector+0xf4/0x334
          <br>
          [   33.645022] [eeb13e10] c039a8c0 drm_ioctl+0x348/0x464
          <br>
          [   33.650135] [eeb13ed0] c00d0ca0 do_vfs_ioctl+0x52c/0x6e8
          <br>
          [   33.655507] [eeb13f20] c00d0e9c SyS_ioctl+0x40/0x68
          <br>
          [   33.660438] [eeb13f40] c000ab04 ret_from_syscall+0x0/0x3c
          <br>
          [   33.665896] --- Exception: c01 (System Call) at 6fb1b8dc
          <br>
          [   33.671253] SP (bfa56d20) is in userspace
          <br>
          [   33.675263] mon&gt;  &lt;no input ...&gt;
          <br>
        </blockquote>
        This just looks like a missing NULL check in the radeon code.
        Probably here:
        <br>
        <br>
        void radeon_audio_detect(struct drm_connector *connector,
        <br>
            enum drm_connector_status status)
        <br>
        {
        <br>
            struct radeon_device *rdev;
        <br>
            struct radeon_encoder *radeon_encoder;
        <br>
            struct radeon_encoder_atom_dig *dig;
        <br>
        <br>
            if (!connector || !connector-&gt;encoder)
        <br>
                return;
        <br>
        <br>
            rdev = connector-&gt;encoder-&gt;dev-&gt;dev_private;
        <br>
                                       ^
        <br>
        <br>
        So you could try adding "!connector-&gt;encoder-&gt;dev" to the
        if there.
        <br>
        <br>
        cheers
        <br>
        <br>
        <br>
        <br>
      </blockquote>
      Thanks.
      <br>
      <br>
      Results in the following .
      <br>
      [    3.179934] [drm] Radeon Display Connectors
      <br>
      [    3.184711] [drm] Connector 0:
      <br>
      [    3.187827] [drm]   DP-1
      <br>
      [    3.190443] [drm]   HPD1
      <br>
      [    3.193018] [drm]   DDC: 0x6470 0x6470 0x6474 0x6474 0x6478
      0x6478 0x647c 0x6                         47c
      <br>
      [    3.200502] [drm]   Encoders:
      <br>
      [    3.203510] [drm]     DFP1: INTERNAL_UNIPHY2
      <br>
      [    3.207823] [drm] Connector 1:
      <br>
      [    3.210923] [drm]   HDMI-A-1
      <br>
      [    3.213831] [drm]   HPD5
      <br>
      [    3.216381] [drm]   DDC: 0x6480 0x6480 0x6484 0x6484 0x6488
      0x6488 0x648c 0x6                         48c
      <br>
      [    3.223809] [drm]   Encoders:
      <br>
      [    3.226795] [drm]     DFP2: INTERNAL_UNIPHY2
      <br>
      [    3.231083] [drm] Connector 2:
      <br>
      [    3.234155] [drm]   DVI-I-1
      <br>
      [    3.236968] [drm]   HPD4
      <br>
      [    3.239523] [drm]   DDC: 0x6450 0x6450 0x6454 0x6454 0x6458
      0x6458 0x645c 0x6                         45c
      <br>
      [    3.246942] [drm]   Encoders:
      <br>
      [    3.249929] [drm]     DFP3: INTERNAL_UNIPHY
      <br>
      [    3.254130] [drm]     CRT1: INTERNAL_KLDSCP_DAC1
      <br>
      [    3.262872] Unable to handle kernel paging request for data at
      address 0x00000000
      <br>
      [    3.270407] Faulting instruction address: 0xc04a4280
      <br>
      [    3.275394] Vector: 300 (Data Access) at [ea847b20]
      <br>
      [    3.280286]     pc: c04a4280: radeon_audio_detect+0x1c/0x290
      <br>
      [    3.286016]     lr: c03e6170: radeon_dp_detect+0x218/0x224
      <br>
      [    3.291563]     sp: ea847bd0
      <br>
      [    3.294453]    msr: 29000
      <br>
      [    3.297084]    dar: 0
      <br>
      [    3.299366]  dsisr: 0
      <br>
      [    3.301649]   current = 0xea850000
      <br>
      [    3.305062]     pid   = 1, comm = swapper
      <br>
      [    3.309101] enter ? for help
      <br>
      [    3.311994] [ea847c00] c03e6170 radeon_dp_detect+0x218/0x224
      <br>
      [    3.317709] [ea847c20] c039160c
      drm_helper_probe_single_connector_modes_merge _bits+0xf4/0x434
      <br>
      [    3.326303] [ea847c60] c0398d68
      drm_fb_helper_probe_connector_modes+0x5c/0x70
      <br>
      [    3.333499] [ea847c80] c039ad40
      drm_fb_helper_initial_config+0x38/0x380
      <br>
      [    3.340174] [ea847cc0] c03f1848 radeon_fbdev_init+0xc8/0xfc
      <br>
      [    3.345808] [ea847ce0] c03eb1cc radeon_modeset_init+0x77c/0x94c
      <br>
      [    3.351781] [ea847d40] c03c72fc
      radeon_driver_load_kms+0xcc/0x134
      <br>
      [    3.357935] [ea847d60] c03a3cfc drm_dev_register+0x9c/0x120
      <br>
      [    3.363569] [ea847d80] c03a6538 drm_get_pci_dev+0xf4/0x190
      <br>
      [    3.369116] [ea847da0] c033d194 pci_device_probe+0x68/0xb4
      <br>
      [    3.374680] [ea847dc0] c04b8a4c driver_probe_device+0xd4/0x1f4
      <br>
      [    3.380583] [ea847df0] c04b8c48 __driver_attach+0x78/0xa0
      <br>
      [    3.386034] [ea847e10] c04b6fd8 bus_for_each_dev+0x8c/0x9c
      <br>
      [    3.391572] [ea847e40] c04b81a8 bus_add_driver+0xf8/0x1d4
      <br>
      [    3.397024] [ea847e60] c04b90fc driver_register+0xb4/0xf8
      <br>
      [    3.402475] [ea847e80] c00016f0 do_one_initcall+0x114/0x19c
      <br>
      [    3.408109] [ea847ef0] c0992a8c
      kernel_init_freeable+0x124/0x1c0
      <br>
      [    3.414176] [ea847f30] c0001cc0 kernel_init+0x14/0xf4
      <br>
      [    3.419280] [ea847f40] c000ac5c
      ret_from_kernel_thread+0x5c/0x64
      <br>
      [    3.425347] mon&gt;  &lt;no input ...&gt;
      <br>
      [    5.428725] Oops: Kernel access of bad area, sig: 11 [#1]
      <br>
      [    5.434140] PREEMPT Canyonlands
      <br>
      [    5.437301] Modules linked in:
      <br>
      [    5.440378] CPU: 0 PID: 1 Comm: swapper Not tainted
      4.0.0-rc2-Sam460ex #1
      <br>
      [    5.447182] task: ea850000 ti: ea846000 task.ti: ea846000
      <br>
      [    5.452597] NIP: c04a4280 LR: c03e6170 CTR: c03e44c0
      <br>
      [    5.457571] REGS: ea847b20 TRAP: 0300   Not tainted
      (4.0.0-rc2-Sam460ex)
      <br>
      [    5.464374] MSR: 00029000 &lt;CE,EE,ME&gt;  CR: 82000028  XER:
      00000000
      <br>
      [    5.470582] DEAR: 00000000 ESR: 00000000
      <br>
      GPR00: c03e6170 ea847bd0 ea850000 eeb6e400 00000002 00000000
      ea847a48 00000000
      <br>
      GPR08: 00000000 ffffffff 00000000 ea847c00 22000022 00000000
      c0910000 c091798f
      <br>
      GPR16: c09179a5 c09179bb c09179d1 c09179e7 c09179fc c0910000
      00000001 00004000
      <br>
      GPR24: 00004000 c0759c14 c0b40000 eeac8000 eeb671a0 eeb66400
      00000000 eeb6e400
      <br>
      [    5.503365] NIP [c04a4280] radeon_audio_detect+0x1c/0x290
      <br>
      [    5.508780] LR [c03e6170] radeon_dp_detect+0x218/0x224
      <br>
      [    5.513931] Call Trace:
      <br>
      [    5.516391] [ea847bd0] [eeb6e40c] 0xeeb6e40c (unreliable)
      <br>
      [    5.521835] [ea847c00] [c03e6170] radeon_dp_detect+0x218/0x224
      <br>
      [    5.527696] [ea847c20] [c039160c]
      drm_helper_probe_single_connector_modes_mer ge_bits+0xf4/0x434
      <br>
      [    5.536429] [ea847c60] [c0398d68]
      drm_fb_helper_probe_connector_modes+0x5c/0x 70
      <br>
      [    5.543772] [ea847c80] [c039ad40]
      drm_fb_helper_initial_config+0x38/0x380
      <br>
      [    5.550587] [ea847cc0] [c03f1848] radeon_fbdev_init+0xc8/0xfc
      <br>
      [    5.556358] [ea847ce0] [c03eb1cc]
      radeon_modeset_init+0x77c/0x94c
      <br>
      [    5.562477] [ea847d40] [c03c72fc]
      radeon_driver_load_kms+0xcc/0x134
      <br>
      [    5.568771] [ea847d60] [c03a3cfc] drm_dev_register+0x9c/0x120
      <br>
      [    5.574544] [ea847d80] [c03a6538] drm_get_pci_dev+0xf4/0x190
      <br>
      [    5.580231] [ea847da0] [c033d194] pci_device_probe+0x68/0xb4
      <br>
      [    5.585916] [ea847dc0] [c04b8a4c]
      driver_probe_device+0xd4/0x1f4
      <br>
      [    5.591948] [ea847df0] [c04b8c48] __driver_attach+0x78/0xa0
      <br>
      [    5.597547] [ea847e10] [c04b6fd8] bus_for_each_dev+0x8c/0x9c
      <br>
      [    5.603233] [ea847e40] [c04b81a8] bus_add_driver+0xf8/0x1d4
      <br>
      [    5.608831] [ea847e60] [c04b90fc] driver_register+0xb4/0xf8
      <br>
      [    5.614430] [ea847e80] [c00016f0] do_one_initcall+0x114/0x19c
      <br>
      [    5.620204] [ea847ef0] [c0992a8c]
      kernel_init_freeable+0x124/0x1c0
      <br>
      [    5.626408] [ea847f30] [c0001cc0] kernel_init+0x14/0xf4
      <br>
      [    5.631661] [ea847f40] [c000ac5c]
      ret_from_kernel_thread+0x5c/0x64
      <br>
      [    5.637864] Instruction dump:
      <br>
      [    5.640851] 80890010 38210020 4bfffb20 39610020 4bb6ced0
      9421ffd0 7c0802a6 bf                         810020
      <br>
      [    5.648732] 7c7f1b79 90010034 41820274 83df020c
      &lt;813e0000&gt; 2f890000 419e0264                         
      2b840001
      <br>
      [    5.656812] ---[ end trace bdaa0514de2b69bd ]---
      <br>
      [    5.661441]
      <br>
      [    6.663014] Kernel panic - not syncing: Attempted to kill init!
      exitcode=0x00                         00000b
      <br>
      [    6.663014]
      <br>
      [    6.672182] Rebooting in 180 seconds..
      <br>
      <br>
      <br>
    </blockquote>
    With the latest commits<br>
    <br>
    <meta http-equiv="content-type" content="text/html; charset=utf-8">
    <pre class="western">[   29.960572] Unable to handle kernel paging request for data at address 0x00000008
[   29.974350] Faulting instruction address: 0xc04a4f44
[   32.012918] Oops: Kernel access of bad area, sig: 11 [#1]
[   32.044900] PREEMPT Canyonlands
[   32.061504] Modules linked in: cfg80211 bnep rfcomm bluetooth
[   32.081023] CPU: 0 PID: 2087 Comm: Xorg Not tainted 4.0.0-rc2-Sam460ex #1
[   32.101802] task: ed6891a0 ti: ed606000 task.ti: ed606000
[   32.121175] NIP: c04a4f44 LR: c03e6a4c CTR: c03d7b6c
[   32.139995] REGS: ed607c50 TRAP: 0300   Not tainted  (4.0.0-rc2-Sam460ex)
[   32.160678] MSR: 00029000 &lt;CE,EE,ME&gt;  CR: 24004442  XER: 00000000
[   32.180922] DEAR: 00000008 ESR: 00000000
GPR00: c03e6a4c ed607d00 ed6891a0 eeac8000 00000000 0000000f ed607be8 00000000
GPR08: 0000f6a3 00000000 eeaae400 ed607cc0 24004422 b7ceeff8 b7d05c14 00000000
GPR16: 00000000 ffffffff 00000000 ed607e18 eeaae578 eebe2600 00000001 00004000
GPR24: 00004000 c075bd08 fffffff2 00000000 eeac8000 00000001 00000001 ee51a400
[   32.285496] NIP [c04a4f44] radeon_audio_enable+0x4/0x18
[   32.305509] LR [c03e6a4c] radeon_dvi_detect+0x388/0x3ac
[   32.325444] Call Trace:
[   32.342325] [ed607d00] [c03e6a4c] radeon_dvi_detect+0x388/0x3ac (unreliable)
[   32.364075] [ed607d30] [c0391cc4] drm_helper_probe_single_connector_modes_merge_bits+0xf4/0x434
[   32.387631] [ed607d70] [c03adecc] drm_mode_getconnector+0xe4/0x330
[   32.408687] [ed607e10] [c03a0bbc] drm_ioctl+0x348/0x464
[   32.428766] [ed607ed0] [c00d0aac] do_vfs_ioctl+0x52c/0x6e8
[   32.449123] [ed607f20] [c00d0ca8] SyS_ioctl+0x40/0x68
[   32.469149] [ed607f40] [c000ab04] ret_from_syscall+0x0/0x3c
[   32.489581] --- interrupt: c01 at 0x6fae92bc
[   32.489581]     LR = 0x6fae91e0
[   32.526311] Instruction dump:
[   32.543848] 8129012c 806a0018 2f890000 419e0018 81290004 2f890000 419e000c 7d2903a6
[   32.566711] 4e800420 38600000 4e800020 81231cd8 &lt;81290008&gt; 2f890000 4d9e0020 7d2903a6
[   32.741188] ---[ end trace c9d41ee106b06efa ]---
[   32.745808]</pre>
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
    <br>
  </body>
</html>

--------------090408020701000507050903--
