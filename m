Return-Path: <olaf@aepfle.de>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7C41F1A0BF1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2015 02:43:31 +1000 (AEST)
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7283714011D
 for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2015 02:43:28 +1000 (AEST)
Date: Wed, 22 Apr 2015 18:43:21 +0200
From: Olaf Hering <olaf@aepfle.de>
To: linuxppc-dev@ozlabs.org, dri-devel@lists.freedesktop.org
Subject: Re: nouveau regression on G5 Dual Core
Message-ID: <20150422164321.GA28006@aepfle.de>
References: <20150328125916.GA29649@aepfle.de>
 <20150328135449.GA29661@aepfle.de>
 <20150330130918.GA25748@aepfle.de>
 <20150422160046.GA15743@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20150422160046.GA15743@aepfle.de>
Cc: Ben Skeggs <bskeggs@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 22, Olaf Hering wrote:

> I will see which commit leads to the failure that exists since v3.19-rc4.

c2c2f6cb79141ca22f84c36887fd867373c35c4e +
c7e873f85fb60b1af589ac1b0c62353cfe0bbb29 leads to this output:

[   47.367618] nouveau  [  DEVICE][0000:0a:00.0] BOOT0  : 0x043100a4
[   47.367626] nouveau  [  DEVICE][0000:0a:00.0] Chipset: NV43 (NV43)
[   47.367629] nouveau  [  DEVICE][0000:0a:00.0] Family : NV40
[   47.367894] nouveau 0000:0a:00.0: Invalid ROM contents
[   47.367929] nouveau ![   VBIOS][0000:0a:00.0] unable to locate usable image
[   47.367933] nouveau E[  DEVICE][0000:0a:00.0] failed to create 0x10000001, -22
[   47.367937] nouveau E[     DRM] failed to create 0x00000080, -22
[   47.368852] nouveau: probe of 0000:0a:00.0 failed with error -22


And using the commit prior the breakage ad4a362^ (which is e897242) leads to
this output and a working console:

[   28.099484] nouveau  [  DEVICE][0000:0a:00.0] BOOT0  : 0x043100a4
[   28.099491] nouveau  [  DEVICE][0000:0a:00.0] Chipset: NV43 (NV43)
[   28.099494] nouveau  [  DEVICE][0000:0a:00.0] Family : NV40
[   28.099610] nouveau  [   VBIOS][0000:0a:00.0] checking OpenFirmware for image...
[   28.099636] nouveau  [   VBIOS][0000:0a:00.0] ... checksum invalid
[   28.099639] nouveau  [   VBIOS][0000:0a:00.0] checking PRAMIN for image...
[   28.099645] nouveau  [   VBIOS][0000:0a:00.0] ... signature not found
[   28.099648] nouveau  [   VBIOS][0000:0a:00.0] checking PROM for image...
[   28.191159] nouveau  [   VBIOS][0000:0a:00.0] ... signature not found
[   28.191162] nouveau  [   VBIOS][0000:0a:00.0] checking ACPI for image...
[   28.191166] nouveau  [   VBIOS][0000:0a:00.0] ... signature not found
[   28.191169] nouveau  [   VBIOS][0000:0a:00.0] checking PCIROM for image...
[   28.191207] nouveau 0000:0a:00.0: Invalid ROM contents
[   28.191229] nouveau  [   VBIOS][0000:0a:00.0] ... signature not found
[   28.191232] nouveau  [   VBIOS][0000:0a:00.0] checking PLATFORM for image...
[   28.191236] nouveau  [   VBIOS][0000:0a:00.0] ... signature not found
[   28.191239] nouveau  [   VBIOS][0000:0a:00.0] using image from OpenFirmware
[   28.191279] nouveau  [   VBIOS][0000:0a:00.0] BIT signature found
[   28.191284] nouveau  [   VBIOS][0000:0a:00.0] version 05.43.02.75.00
[   28.191629] u3msi: allocated virq 0x1a (hw 0x9) addr 0xf8004090
[   28.191647] nouveau  [     PMC][0000:0a:00.0] MSI interrupts enabled
[   28.191705] nouveau  [     PFB][0000:0a:00.0] RAM type: DDR1
[   28.191708] nouveau  [     PFB][0000:0a:00.0] RAM size: 256 MiB
[   28.191711] nouveau  [     PFB][0000:0a:00.0]    ZCOMP: 378880 tags
[   28.250490] nouveau  [  PTHERM][0000:0a:00.0] FAN control: toggle
[   28.250515] nouveau  [  PTHERM][0000:0a:00.0] internal sensor: no
[   28.270373] nouveau  [     CLK][0000:0a:00.0] 20: core 300 MHz shader 300 MHz memory 500 MHz
[   28.270398] nouveau  [     CLK][0000:0a:00.0] --: core 300 MHz shader 300 MHz memory 500 MHz
[   28.270556] nouveau 0000:0a:00.0: Using 32-bit DMA via iommu
[   28.270649] [TTM] Zone  kernel: Available graphics memory: 1003278 kiB
[   28.270652] [TTM] Initializing pool allocator
[   28.270687] nouveau  [     DRM] VRAM: 252 MiB
[   28.270690] nouveau  [     DRM] GART: 512 MiB
[   28.270712] nouveau  [     DRM] TMDS table version 1.1
[   28.270716] nouveau  [     DRM] DCB version 3.0
[   28.270720] nouveau  [     DRM] DCB outp 00: 01000100 00000028
[   28.270723] nouveau  [     DRM] DCB outp 01: 03000102 00000000
[   28.270727] nouveau  [     DRM] DCB outp 02: 04011210 00000028
[   28.270730] nouveau  [     DRM] DCB outp 03: 02111212 02000100
[   28.270733] nouveau  [     DRM] DCB outp 04: 02011211 0020c070
[   28.270736] nouveau  [     DRM] DCB conn 00: 1030
[   28.270740] nouveau  [     DRM] DCB conn 01: 2130
[   28.272297] nouveau  [     I2C][0000:0a:00.0] detected TMDS transmitter: sil164
[   28.277738] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[   28.277742] [drm] Driver supports precise vblank timestamp query.
[   28.277750] nouveau  [     DRM] 0x14C5: Parsing digital output script table
[   28.331954] nouveau  [     DRM] MM: using M2MF for buffer copies
[   28.331997] nouveau  [     DRM] Setting dpms mode 3 on TV encoder (output 4)
[   28.377539] nouveau  [     DRM] allocated 1920x1080 fb: 0x9000, bo c00000007b911400
[   28.400310] nouveau  [     DRM] 0x14C5: Parsing digital output script table
[   28.450037] Console: switching to colour frame buffer device 240x67
[   28.451900] nouveau 0000:0a:00.0: fb0: nouveaufb frame buffer device
[   28.451903] nouveau 0000:0a:00.0: registered panic notifier
[   28.456097] [drm] Initialized nouveau 1.2.1 20120801 for 0000:0a:00.0 on minor 0


Olaf
