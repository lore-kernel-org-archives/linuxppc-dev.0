Return-Path: <olaf@aepfle.de>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 629E71A02D2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2015 02:31:14 +1000 (AEST)
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 97EE91400A0
 for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2015 02:31:11 +1000 (AEST)
Date: Wed, 22 Apr 2015 18:00:46 +0200
From: Olaf Hering <olaf@aepfle.de>
To: linuxppc-dev@ozlabs.org, dri-devel@lists.freedesktop.org
Subject: Re: nouveau regression on G5 Dual Core
Message-ID: <20150422160046.GA15743@aepfle.de>
References: <20150328125916.GA29649@aepfle.de>
 <20150328135449.GA29661@aepfle.de>
 <20150330130918.GA25748@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20150330130918.GA25748@aepfle.de>
Cc: Ben Skeggs <bskeggs@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 30, Olaf Hering wrote:

> On Sat, Mar 28, Olaf Hering wrote:
> 
> > On Sat, Mar 28, Olaf Hering wrote:
> > 
> > > I just updated the kernel from some 3.18 based state to 4.0-rc5+. The
> > 
> > 3.19 is already broken, will bisect next week.
> 
> After a first run I was able to boot prior the first bad commit, which caused a
> crash on boot.  Now I have to find the commit which actually allows boot again,
> but with the white screen.
> 
> Ben, was ad4a362635353f7ceb66f4038269770fee1025fa tested on a pmac?

c7e873f85fb60b1af589ac1b0c62353cfe0bbb29 fixed the crash, but not the
failure to read the ROM contents.

So what exactly did ad4a362635353f7ceb66f4038269770fee1025fa change?

A kernel build from ad4a362635353f7ceb66f4038269770fee1025fa plus the fix
c7e873f85fb60b1af589ac1b0c62353cfe0bbb29 gives this in dmesg:

[   29.621628] nouveau  [  DEVICE][0000:0a:00.0] BOOT0  : 0x043100a4
[   29.621635] nouveau  [  DEVICE][0000:0a:00.0] Chipset: NV43 (NV43)
[   29.621638] nouveau  [  DEVICE][0000:0a:00.0] Family : NV40
[   29.713302] nouveau  [   VBIOS][0000:0a:00.0] using image from PROM
[   29.713616] nouveau  [   VBIOS][0000:0a:00.0] version 00.00.00.00.00
[   29.713689] nouveau W[   VBIOS][0000:0a:00.0] DCB table not found
[   29.713698] nouveau W[   VBIOS][0000:0a:00.0] DCB table not found
[   29.713733] nouveau W[   VBIOS][0000:0a:00.0] 0x0000[ ]: init data not found
[   29.713783] u3msi: allocated virq 0x1a (hw 0x9) addr 0xf8004090
[   29.713808] nouveau  [     PMC][0000:0a:00.0] MSI interrupts enabled
[   29.713868] nouveau  [     PFB][0000:0a:00.0] RAM type: DDR1
[   29.713871] nouveau  [     PFB][0000:0a:00.0] RAM size: 256 MiB
[   29.713874] nouveau  [     PFB][0000:0a:00.0]    ZCOMP: 378880 tags
[   29.740738] nouveau W[   VBIOS][0000:0a:00.0] DCB table not found
[   29.740746] nouveau W[   VBIOS][0000:0a:00.0] DCB table not found
[   29.740755] nouveau W[   VBIOS][0000:0a:00.0] DCB table not found
[   29.740760] nouveau W[   VBIOS][0000:0a:00.0] DCB table not found
[   29.740763] nouveau W[   VBIOS][0000:0a:00.0] DCB table not found
[   29.740767] nouveau  [  PTHERM][0000:0a:00.0] FAN control: none / external
[   29.740770] nouveau W[   VBIOS][0000:0a:00.0] DCB table not found
[   29.740773] nouveau W[   VBIOS][0000:0a:00.0] DCB table not found
[   29.740788] nouveau  [  PTHERM][0000:0a:00.0] internal sensor: no
[   29.760655] nouveau  [     CLK][0000:0a:00.0] --: core 300 MHz shader 300 MHz memory 500 MHz
[   29.760722] nouveau W[   VBIOS][0000:0a:00.0] DCB table not found
[   29.760796] nouveau 0000:0a:00.0: Using 32-bit DMA via iommu
[   29.760891] [TTM] Zone  kernel: Available graphics memory: 1003278 kiB
[   29.760894] [TTM] Initializing pool allocator
[   29.760928] nouveau  [     DRM] VRAM: 252 MiB
[   29.760931] nouveau  [     DRM] GART: 512 MiB
[   29.760959] [TTM] Finalizing pool allocator
[   29.760989] [TTM] Zone  kernel: Used memory at exit: 0 kiB
[   29.762856] insmod (775) used greatest stack depth: 6080 bytes left


I will see which commit leads to the failure that exists since v3.19-rc4.


Olaf


> root@g5:~/work/kernel/linux # git bisect log 
> git bisect start
> # good: [b2776bf7149bddd1f4161f14f79520f17fc1d71d] Linux 3.18
> git bisect good b2776bf7149bddd1f4161f14f79520f17fc1d71d
> # bad: [bfa76d49576599a4b9f9b7a71f23d73d6dcff735] Linux 3.19
> git bisect bad bfa76d49576599a4b9f9b7a71f23d73d6dcff735
> # good: [54850e73e86e3bc092680d1bdb84eb322f982ab1] zram: change parameter from vaild_io_request()
> git bisect good 54850e73e86e3bc092680d1bdb84eb322f982ab1
> # bad: [dab363f938a53ddaee60bfecc1aebdbb3d3af5f0] Merge tag 'staging-3.19-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging
> git bisect bad dab363f938a53ddaee60bfecc1aebdbb3d3af5f0
> # good: [26178ec11ef3c6c814bf16a0a2b9c2f7242e3c64] x86: mm: consolidate VM_FAULT_RETRY handling
> git bisect good 26178ec11ef3c6c814bf16a0a2b9c2f7242e3c64
> # good: [1b4bcf1fedbe7dcd98d9d35dfc947f033a398c4d] staging: comedi: addi_tcw.h: provide generic defines for the ADDI-DATA TCW
> git bisect good 1b4bcf1fedbe7dcd98d9d35dfc947f033a398c4d
> # good: [030794a368946b98a8252d3172f5f2a1b0e4fb0e] drm/exynos: Fix DSI resuming fail because power domain being off
> git bisect good 030794a368946b98a8252d3172f5f2a1b0e4fb0e
> # bad: [59ea90543f57a40827d7d1e528d657b8cc7161b1] drm/i915: Implement GPU reset for 915/945
> git bisect bad 59ea90543f57a40827d7d1e528d657b8cc7161b1
> # bad: [37025602f6abc5919c7d5a8517bc7d6ea08acc57] drm/nouveau/platform: add GPU speedo information to nouveau platform
> git bisect bad 37025602f6abc5919c7d5a8517bc7d6ea08acc57
> # good: [33f86ff62c4368c8d6bf3c76dc2fa416e3f90213] Merge branch 'amdkfd-next-3.19' of git://people.freedesktop.org/~gabbayo/linux into drm-next
> git bisect good 33f86ff62c4368c8d6bf3c76dc2fa416e3f90213
> # bad: [1f89b4756fb83f385ac0e277b092774c01a5ab9c] drm/gm204/disp: initial support
> git bisect bad 1f89b4756fb83f385ac0e277b092774c01a5ab9c
> # bad: [c2c2f6cb79141ca22f84c36887fd867373c35c4e] drm/nouveau/bios: fetch images beyond the first one in the rom
> git bisect bad c2c2f6cb79141ca22f84c36887fd867373c35c4e
> # good: [9c8af882bf1230bb85c1dbf67e0dde6888223ceb] drm: Add adv7511 encoder driver
> git bisect good 9c8af882bf1230bb85c1dbf67e0dde6888223ceb
> # good: [4894f6628e1ae04b2cc6222df692364c1ac1250f] drm/nouveau: a, somehow, missed hunk of "fix regression on agp boards"
> git bisect good 4894f6628e1ae04b2cc6222df692364c1ac1250f
> # bad: [ad4a362635353f7ceb66f4038269770fee1025fa] drm/nouveau/bios: split out shadow methods
> git bisect bad ad4a362635353f7ceb66f4038269770fee1025fa
> # good: [e8972421623cd10a12cc7343da029b58777fdd2f] drm/nouveau/bios: fix thinko when parsing extdev table
> git bisect good e8972421623cd10a12cc7343da029b58777fdd2f
> # first bad commit: [ad4a362635353f7ceb66f4038269770fee1025fa] drm/nouveau/bios: split out shadow methods
> 
> Olaf
