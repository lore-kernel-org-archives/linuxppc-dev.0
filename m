Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p04-ob.smtp.rzone.de (mo6-p04-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5304::12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s4rbl74WnzDqQs
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Aug 2016 23:37:55 +1000 (AEST)
Subject: [pasemi] Radeon HD graphics card not recognised after the
 powerpc-4.8-1 commit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 luigi burdo <intermediadc@hotmail.com>,
 Darren Stevens <darren@stevens-zone.net>, Julian Margetson
 <runaway@candw.ms>, Steven Jeffery <sajeffer@gmail.com>,
 "R.T.Dickinson" <rtd@a-eon.com>, "R.T.Dickinson" <rtd2@xtra.co.nz>,
 Pat Wall <pjwall@mac.com>, Pat Wall <pjwall@me.com>,
 "contact@a-eon.com" <contact@a-eon.com>,
 "matthew@a-eon.biz" <matthew@a-eon.biz>, Kevin Saunders <kfs1971@gmail.com>,
 Lyle Hazelwood <lylehaze@gmail.com>, EntwicklerX <mail@entwickler-x.de>,
 "xray@relec.ch" <xray@relec.ch>, Steve-David Marguet <steve@esdeem.ch>,
 George Sokianos <walkero@gmail.com>, =?UTF-8?Q?Sinan_G=c3=bcrkan?=
 <sinan.amigaone@gmail.com>, Mike <michael.heltne@gmail.com>,
 Thomas Ferreira <macsociety@me.com>, Christian Zigotzky <info@xenosoft.de>,
 "pjs@pjsa.net" <pjs@pjsa.net>, Ben Cato Malkenes <ben.cato@gmail.com>,
 Olof Johansson <olof@lixom.net>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org
References: <86E27593-C6C2-4BBA-995E-95A97BB8CB12@xenosoft.de>
 <57752BB3.9060306@xenosoft.de>
 <7072d7cf-4d73-d424-af20-f5e94c8b399e@xenosoft.de>
 <816DC2B4-5B33-4C5E-A09A-F5BF7C7BF1FD@xenosoft.de>
 <aed83bc1-e574-1a9f-de58-480c9164865c@xenosoft.de>
 <2d94a278-d1d8-b484-e9ca-aedf18051e1a@xenosoft.de>
 <a84c2b93-4dac-9148-9ae2-0824491d1f50@xenosoft.de>
 <ae855392-570c-e125-b71f-2d5bf0c33eef@xenosoft.de>
 <d869fc32-ba80-529e-06dd-481ecf533642@xenosoft.de>
 <8b0682d3-866a-31dd-f01b-3510f84307dc@xenosoft.de>
 <2847029a-e3a4-8099-b72f-89d5731baaed@xenosoft.de>
 <4e97a4dd-3fe0-84aa-47f0-29d1544c9f8c@xenosoft.de>
 <72eed836-767c-402a-576a-8049db34d281@xenosoft.de>
 <8878883b-bd51-b7c9-ee5b-927e481e5d30@xenosoft.de>
 <8a3764d2-7fc1-1967-f557-146a3df16894@xenosoft.de>
 <1d98af3c-f585-967b-1413-58d34fad20af@xenosoft.de>
 <f6a4c3c1-f452-f4fc-1d36-b2bed81f32a3@xenosoft.de>
 <3fd5ecda-7e1f-52ec-6f11-ed603d2dcd76@xenosoft.de>
 <1470221638.12584.82.camel@kernel.crashing.org>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <57A34254.6090702@xenosoft.de>
Date: Thu, 4 Aug 2016 15:25:40 +0200
MIME-Version: 1.0
In-Reply-To: <1470221638.12584.82.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi All,

I figured out that the Git kernel (4.8) successfully detected my Radeon 
HD6870 but Xorg can't access it.

The reason is, that the BusID has changed between the kernel 4.7 and 4.8.

Kernel 4.7:

01:00.0 VGA compatible controller: Advanced Micro Devices, Inc. 
[AMD/ATI] Barts XT [Radeon HD 6870]

xorg.conf:

Section "Device"
BusID       "PCI:1:0:0"

Git kernel (4.8):

e900:01:00.0 VGA compatible controller: Advanced Micro Devices, Inc. 
[AMD/ATI] Barts XT [Radeon HD 6870]

How does the new BusID look like in the xorg.conf?

dmesg | grep -i radeon

     [    0.997471] [drm] radeon kernel modesetting enabled.
     [    1.171136] radeon e900:01:00.0: VRAM: 1024M 0x0000000000000000 
- 0x000000003FFFFFFF (1024M used)
     [    1.171141] radeon e900:01:00.0: GTT: 1024M 0x0000000040000000 - 
0x000000007FFFFFFF
     [    1.171270] [drm] radeon: 1024M of VRAM memory ready
     [    1.171273] [drm] radeon: 1024M of GTT memory ready.
     [    1.176557] [drm] radeon: dpm initialized
     [    1.212690] radeon e900:01:00.0: WB enabled
     [    1.212697] radeon e900:01:00.0: fence driver on ring 0 use gpu 
addr 0x0000000040000c00 and cpu addr 0xc00000026dbdbc00
     [    1.212702] radeon e900:01:00.0: fence driver on ring 3 use gpu 
addr 0x0000000040000c0c and cpu addr 0xc00000026dbdbc0c
     [    1.219475] radeon e900:01:00.0: fence driver on ring 5 use gpu 
addr 0x0000000000072118 and cpu addr 0xd0000800901b2118
     [    1.219485] radeon e900:01:00.0: radeon: MSI limited to 32-bit
     [    1.219530] [drm] radeon: irq initialized.
     [    2.070343] [drm] Radeon Display Connectors
     [    2.917509] radeon e900:01:00.0: fb0: radeondrmfb frame buffer 
device
     [    2.923810] [drm] Initialized radeon 2.46.0 20080528 for 
e900:01:00.0 on minor 0

dmesg | grep -i e900:01:00.0

     [    0.152680] pci e900:01:00.0: [1002:6738] type 00 class 0x030000
     [    0.152694] pci e900:01:00.0: calling .pci_dev_pdn_setup+0x0/0x3c
     [    0.152710] pci e900:01:00.0: reg 0x10: [mem 
0x90000000-0x9fffffff 64bit pref]
     [    0.152722] pci e900:01:00.0: reg 0x18: [mem 
0xa0020000-0xa003ffff 64bit]
     [    0.152731] pci e900:01:00.0: reg 0x20: [io  0x2000-0x20ff]
     [    0.152744] pci e900:01:00.0: reg 0x30: [mem 
0xa0000000-0xa001ffff pref]
     [    0.152755] pci e900:01:00.0: calling 
.pcibios_fixup_resources+0x0/0x110
     [    0.152763] pci e900:01:00.0: calling .quirk_no_pm_reset+0x0/0x40
     [    0.152804] pci e900:01:00.0: supports D1 D2
     [    0.494871] pci e900:01:00.0: calling .fixup_vga+0x0/0x3c
     [    1.171136] radeon e900:01:00.0: VRAM: 1024M 0x0000000000000000 
- 0x000000003FFFFFFF (1024M used)
     [    1.171141] radeon e900:01:00.0: GTT: 1024M 0x0000000040000000 - 
0x000000007FFFFFFF
     [    1.212690] radeon e900:01:00.0: WB enabled
     [    1.212697] radeon e900:01:00.0: fence driver on ring 0 use gpu 
addr 0x0000000040000c00 and cpu addr 0xc00000026dbdbc00
     [    1.212702] radeon e900:01:00.0: fence driver on ring 3 use gpu 
addr 0x0000000040000c0c and cpu addr 0xc00000026dbdbc0c
     [    1.219475] radeon e900:01:00.0: fence driver on ring 5 use gpu 
addr 0x0000000000072118 and cpu addr 0xd0000800901b2118
     [    1.219485] radeon e900:01:00.0: radeon: MSI limited to 32-bit
     [    2.917509] radeon e900:01:00.0: fb0: radeondrmfb frame buffer 
device
     [    2.923810] [drm] Initialized radeon 2.46.0 20080528 for 
e900:01:00.0 on minor 0

FBDEV with the Git kernel (4.8):

Fatal server error:
xf86MapLegacyIO(): domain out of range

Cheers,

Christian

On 03 August 2016 at 12:53 PM, Benjamin Herrenschmidt wrote:
> On Wed, 2016-08-03 at 11:03 +0200, Christian Zigotzky wrote:
>> I reverted the commit "powerpc-4.8-1" and Xorg works. The commit
>> "powerpc-4.8-1" is the problem.
>>
>> Link:
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=bad60e6f259a01cf9f29a1ef8d435ab6c60b2de9
>>
>> Which source code modification in the commit "powerpc-4.8-1" could be
>> the problem?
> This is a merge, not a commit. Can you bisect down that branch ? Also
> include the kernel dmesg log.
>
> Cheers,
> Ben.
>
>
