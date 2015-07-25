Return-Path: <linuxuser330250@gmx.net>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AD1141A02A5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Jul 2015 22:57:59 +1000 (AEST)
Received: from [192.168.45.124] ([91.115.106.141]) by mail.gmx.com (mrgmx101)
 with ESMTPSA (Nemesis) id 0MNdxu-1ZGFuf3ihO-0079S5 for
 <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Jul 2015 14:52:48 +0200
Message-ID: <55B3869E.6020706@gmx.net>
Date: Sat, 25 Jul 2015 14:52:46 +0200
From: Linux User #330250 <linuxuser330250@gmx.net>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: nouveau modeset no longer works with kernel 4.0 on Power Mac G4
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello linuxppc-dev mailing list!

I come right to the point.
My computer is a Power Mac G4 Quicksilver (original, 2001) with the a flashed PC graphics card Nvidia 6200 AGP. It is correctly supported in Mac OS X 10.4/10.5 and it was working in Linux with the Debian kernels 3.16. I use Debian testing.

> lspci -nn | grep VGA
> 0000:00:10.0 VGA compatible controller [0300]: NVIDIA Corporation
>              NV44A [GeForce 6200] [10de:0221] (rev a1)

These are only the relevant output lines of dmesg from the working 3.16 kernel (no additional kernel parameters):
> [    0.000000] Using PowerMac machine description
> [    0.000000] Total memory = 512MB; using 1024kB for hash table (at
>                cff00000)
> [    0.000000] Linux version 3.16.0-4-powerpc-smp
>                (debian-kernel@lists.debian.org) (gcc version 4.8.4
>                (Debian 4.8.4-1) ) #1 SMP Debian 3.16.7-ckt7-1
> [   15.001520] fb: switching to nouveaufb from OFfb NVDA,Displ
> [   15.001732] Console: switching to colour dummy device 80x25
> [   15.003446] nouveau  [  DEVICE][0000:00:10.0] BOOT0  : 0x04a100a1
> [   15.003461] nouveau  [  DEVICE][0000:00:10.0] Chipset: NV44A (NV4A)
> [   15.003469] nouveau  [  DEVICE][0000:00:10.0] Family : NV40
> [   15.004087] nouveau  [   VBIOS][0000:00:10.0] checking OpenFirmware
>                for image...
> [   15.004168] nouveau  [   VBIOS][0000:00:10.0] ... checksum invalid
> [   15.004176] nouveau  [   VBIOS][0000:00:10.0] checking PRAMIN for
>                image...
> [   15.004187] nouveau  [   VBIOS][0000:00:10.0] ... signature not found
> [   15.004195] nouveau  [   VBIOS][0000:00:10.0] checking PROM for
>                image...
> [   15.138480] nouveau  [   VBIOS][0000:00:10.0] ... checksum invalid
> [   15.138493] nouveau  [   VBIOS][0000:00:10.0] checking ACPI for
>                image...
> [   15.138501] nouveau  [   VBIOS][0000:00:10.0] ... signature not found
> [   15.138510] nouveau  [   VBIOS][0000:00:10.0] checking PCIROM for
>                image...
> [   15.138700] nouveau 0000:00:10.0: Invalid ROM contents
> [   15.138744] nouveau  [   VBIOS][0000:00:10.0] ... signature not found
> [   15.138753] nouveau  [   VBIOS][0000:00:10.0] checking PLATFORM for
>                image...
> [   15.138761] nouveau  [   VBIOS][0000:00:10.0] ... signature not found
> [   15.138770] nouveau  [   VBIOS][0000:00:10.0] using image from
>                OpenFirmware
> [   15.138903] nouveau  [   VBIOS][0000:00:10.0] BIT signature found
> [   15.138919] nouveau  [   VBIOS][0000:00:10.0] version 05.43.02.75.00
> [   15.139766] nouveau  [     PFB][0000:00:10.0] RAM type: DDR2
> [   15.139775] nouveau  [     PFB][0000:00:10.0] RAM size: 256 MiB
> [   15.139784] nouveau  [     PFB][0000:00:10.0]    ZCOMP: 0 tags
> [   15.313497] nouveau  [  PTHERM][0000:00:10.0] FAN control: toggle
> [   15.313567] nouveau  [  PTHERM][0000:00:10.0] fan management: automatic
> [   15.313579] nouveau  [  PTHERM][0000:00:10.0] internal sensor: yes
> [   15.335251] nouveau  [     CLK][0000:00:10.0] 20: core 300 MHz
>                shader 300 MHz memory 500 MHz
> [   15.335283] nouveau  [     CLK][0000:00:10.0] --: core 200 MHz
>                memory 400 MHz
> [   15.335651] [TTM] Zone  kernel: Available graphics memory: 255336 kiB
> [   15.335660] [TTM] Initializing pool allocator
> [   15.335727] nouveau  [     DRM] VRAM: 252 MiB
> [   15.335734] nouveau  [     DRM] GART: 128 MiB
> [   15.335752] nouveau  [     DRM] TMDS table version 1.1
> [   15.335762] nouveau  [     DRM] DCB version 3.0
> [   15.335773] nouveau  [     DRM] DCB outp 00: 01000100 00000028
> [   15.335784] nouveau  [     DRM] DCB outp 01: 02011210 00000028
> [   15.335792] nouveau  [     DRM] DCB outp 02: 01011212 00000000
> [   15.335801] nouveau  [     DRM] DCB outp 03: 020112f1 0084c080
> [   15.335811] nouveau  [     DRM] DCB conn 00: 0000
> [   15.335821] nouveau  [     DRM] DCB conn 01: 2230
> [   15.341937] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
> [   15.341957] [drm] Driver supports precise vblank timestamp query.
> [   15.341981] nouveau  [     DRM] 0x14D3: Parsing digital output
>                script table
> [   15.417692] nouveau  [     DRM] MM: using M2MF for buffer copies
> [   15.417744] nouveau  [     DRM] Setting dpms mode 3 on TV encoder
>                (output 3)
> [   15.499592] nouveau  [     DRM] allocated 1280x1024 fb: 0x9000, bo
>                df033400
> [   15.530424] Console: switching to colour frame buffer device 160x64
> [   15.557360] nouveau 0000:00:10.0: fb0: nouveaufb frame buffer device
> [   15.557372] nouveau 0000:00:10.0: registered panic notifier
> [   15.579021] [drm] Initialized nouveau 1.1.2 20120801 for
>                0000:00:10.0 on minor 0

And this is the output of kernel 4.0, with kernel parameter nouveau.config=NvBios=OpenFirmware:
> [    0.000000] Using PowerMac machine description
> [    0.000000] Total memory = 512MB; using 1024kB for hash table (at
>                cff00000)
> [    0.000000] Linux version 4.0.0-2-powerpc-smp
>                (debian-kernel@lists.debian.org) (gcc version 4.9.3
>                (Debian 4.9.3-1) ) #1 SMP Debian 4.0.8-1 (2015-07-11)
> [    1.374136] Using unsupported 1024x768 NVDA,Display-A at a0020000,
>                depth=8, pitch=1024
> [    1.387174] Console: switching to colour frame buffer device 128x48
> [    1.399575] fb0: Open Firmware frame buffer device on
>                /pci@f0000000/NVDA,Parent@10/NVDA,Display-A@0
> [   14.857047] [drm] Initialized drm 1.1.0 20060810
> [   15.529968] checking generic (a0020000 c0000) vs hw (a0000000 10000000)
> [   15.529987] fb: switching to nouveaufb from OFfb NVDA,Displ
> [   15.530179] Console: switching to colour dummy device 80x25
> [   15.532652] nouveau  [  DEVICE][0000:00:10.0] BOOT0  : 0x04a100a1
> [   15.532668] nouveau  [  DEVICE][0000:00:10.0] Chipset: NV44A (NV4A)
> [   15.532676] nouveau  [  DEVICE][0000:00:10.0] Family : NV40
> [   15.533337] nouveau E[   VBIOS][0000:00:10.0] OpenFirmware invalid
> [   15.800467] nouveau  [   VBIOS][0000:00:10.0] using image from PROM
> [   15.801584] nouveau  [   VBIOS][0000:00:10.0] BIT signature found
> [   15.801598] nouveau  [   VBIOS][0000:00:10.0] version 00.00.00.10.10
> [   15.801703] nouveau W[   VBIOS][0000:00:10.0] DCB table not found
> [   15.801715] nouveau W[   VBIOS][0000:00:10.0] DCB table not found
> [   15.801755] nouveau E[   VBIOS][0000:00:10.0] 0xa4fa[ ]: unknown
>                opcode 0x09
> [   15.801783] nouveau E[ DEVINIT][0000:00:10.0] init failed, -22
> [   15.801804] nouveau E[     DRM] failed to create 0x00000080, -22
> [   15.802774] nouveau: probe of 0000:00:10.0 failed with error -22

With a configuration like this the display freezes with this messages on
the screen. The system however is responding via ssh and if I login
blind on the Mac itself. For example, I was able to save the dmesg and
reboot the computer, typing everything in blind.

I tried to boot with the parameters nouveau.config=NvBios=OpenFirmware,
but with the same result. (Even though the above dmesg is with this
kernel parameter, if ommited the same thing happens, only that the
probing of PROM and so on is happening in a different order.)

Is there a way to make nouveau force use the OpenFirmware BIOS, even
with an invalid checksum?

As an intermediate workaround I am able to use the text console if I
disable modeset, i.e. kernel parameter nouveau.modeset=0, in which case
X.org is unusable.

Similar reports:
https://lists.debian.org/debian-powerpc/2015/06/msg00049.html
And concerning the invalid checksum:
https://bugs.freedesktop.org/show_bug.cgi?id=62190
http://lists.freedesktop.org/archives/dri-devel/2015-April/081573.html

Andreas  aka  Linux User #330250
