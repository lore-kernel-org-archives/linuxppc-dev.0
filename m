Return-Path: <benh@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ssFm32GfzzDrWP
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  9 Oct 2016 18:50:10 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u997mhsx137635
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 9 Oct 2016 03:50:07 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25xvswperc-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 09 Oct 2016 03:50:07 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Sun, 9 Oct 2016 17:50:04 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id E8DA63578056
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  9 Oct 2016 18:50:03 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u997o3iS50724924
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 9 Oct 2016 18:50:03 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u997o2dI009772
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 9 Oct 2016 18:50:03 +1100
Subject: Re: PowerPC agpmode issues
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: "Herminio Hernandez, Jr." <herminio.hernandezjr@gmail.com>, Michel
 =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc: Mathieu Malaterre <malat@debian.org>, Mike <michael.heltne@gmail.com>,
 "debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Pranith Kumar <bobby.prani@gmail.com>, "open list:LINUX FOR POWERPC..."
 <linuxppc-dev@lists.ozlabs.org>
Date: Sun, 09 Oct 2016 18:49:52 +1100
In-Reply-To: <CAJRA9dwwiOYfJR7fGUtZp2FYfqagw+Fq8QKj9H8tA7y97Qq0wg@mail.gmail.com>
References: <CANtoAtPSgkxEvAdOs-gZGOECYN8OFTvwRrsg+US41ji1fGEDLA@mail.gmail.com>
 <969BB53B-CB30-49DC-B6C5-4D2381ECE6EE@gmail.com>
 <CANtoAtN1K3OAoXsgeMOWui_jEZO3X1fJAmRX-LeO_Du8h3T9kg@mail.gmail.com>
 <1472122446.2246.93.camel@kernel.crashing.org> <57DF23C4.20508@gmail.com>
 <CAJRA9dwyJ+5XuD7i0ktwvx3Md9p_Z9tiVZCWvO_gK1kfG-+ccA@mail.gmail.com>
 <CA+7wUsyOSCJzymLe7vyub8dvyvsEDuVU0auO2rGi6ohkBKBEoQ@mail.gmail.com>
 <28807f61-b73e-b695-ea6a-cb51c1554144@daenzer.net>
 <CAJRA9dydVbEB3HdL_YMZPBkhtiq-REVZTtoK7gTEgdb8MMOxLg@mail.gmail.com>
 <260ec14e-c103-0f1d-e459-2ef421f2a207@daenzer.net>
 <CAJRA9dzE4UehiMRfA0-MPfEVjyxgGLdg=SKN_w_19q4YtdHHtQ@mail.gmail.com>
 <CAJRA9dwwiOYfJR7fGUtZp2FYfqagw+Fq8QKj9H8tA7y97Qq0wg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1475999392.2471.19.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2016-10-08 at 12:05 -0700, Herminio Hernandez, Jr. wrote:
> Performed an apt dist-upgrade and rebooted with agpmode=4 and still
> the GPU is failing with errors. Should I proceed to place a bug
> report on this?

I wouldn't even try to be honest. The HW issues in Apple AGP
implementation pretty much guarantee that things will crash
with the recent DRIs. Back when AGP memory was just a single
chunk of memory we got it to limp along but since DRI2 it's
pretty much hopeless.

I would stick to PCI GART even if it sucks for performances.

Cheers,
Ben.

> Herminio
> 
> On Tue, Sep 20, 2016 at 11:20 PM, Herminio Hernandez, Jr. <herminio.h
> ernandezjr@gmail.com> wrote:
> > I am still getting errors even with radeon.agpmode=4 is set
> > 
> > rican-linux@Debian-G5:~$ dmesg |grep -e radeom -e drm -e
> > radeon.agpmode
> > [    0.000000] Kernel command line: root=UUID=aeca9a67-31d7-4c4b-
> > a0f8-4db328b33305  radeon.agpmode=4
> > [    9.734366] [drm] Initialized drm 1.1.0 20060810
> > [   10.934519] [drm] radeon kernel modesetting enabled.
> > [   10.943743] fb: switching to radeondrmfb from OFfb ATY,Simone
> > [   10.954622] fb: switching to radeondrmfb from OFfb ATY,Simone
> > [   10.956515] [drm] initializing kernel modesetting (RV350
> > 0x1002:0x4150 0x1002:0x4150 0x00).
> > [   10.956552] [drm] register mmio base: 0xA0000000
> > [   10.956558] [drm] register mmio size: 65536
> > [   11.046327] [drm] Not an x86 BIOS ROM, not using.
> > [   11.046358] [drm] Using device-tree clock info
> > [   11.046369] [drm] AGP mode requested: 4
> > [   11.046528] [drm] Generation 2 PCI interface, using max
> > accessible memory
> > [   11.046582] [drm] Detected VRAM RAM=256M, BAR=256M
> > [   11.046587] [drm] RAM width 128bits DDR
> > [   11.046858] [drm] radeon: 64M of VRAM memory ready
> > [   11.046866] [drm] radeon: 256M of GTT memory ready.
> > [   11.046935] [drm] radeon: 1 quad pipes, 1 Z pipes initialized.
> > [   11.061306] [drm] Supports vblank timestamp caching Rev 2
> > (21.10.2013).
> > [   11.061312] [drm] Driver supports precise vblank timestamp
> > query.
> > [   11.061363] [drm] radeon: irq initialized.
> > [   11.061405] [drm] Loading R300 Microcode
> > [   11.110467] [drm] radeon: ring at 0x0000000000010000
> > [   11.257952] [drm:.r100_ring_test [radeon]] *ERROR* radeon: ring
> > test failed (scratch(0x15E4)=0xCAFEDEAD)
> > [   11.258060] [drm:.r100_cp_init [radeon]] *ERROR* radeon: cp
> > isn't working (-22).
> > [   11.404548] [drm:.r100_cp_fini [radeon]] *ERROR* Wait for CP
> > idle timeout, shutting down CP.
> > [   11.551199] [drm] radeon: cp finalized
> > [   12.547388] [drm] radeon: cp finalized
> > [   12.553854] [drm] radeon: ttm finalized
> > [   12.553861] [drm] Forcing AGP to PCI mode
> > [   12.643384] [drm] Not an x86 BIOS ROM, not using.
> > [   12.643406] [drm] Using device-tree clock info
> > [   12.643414] [drm] Generation 2 PCI interface, using max
> > accessible memory
> > [   12.643446] [drm] Detected VRAM RAM=256M, BAR=256M
> > [   12.643452] [drm] RAM width 128bits DDR
> > [   12.643712] [drm] radeon: 64M of VRAM memory ready
> > [   12.643719] [drm] radeon: 512M of GTT memory ready.
> > [   12.643761] [drm] GART: num cpu pages 8192, num gpu pages 131072
> > [   12.645324] [drm] radeon: 1 quad pipes, 1 Z pipes initialized.
> > [   12.645343] [drm] PCI GART of 512M enabled (table at
> > 0x0000000062F80000).
> > [   12.645462] [drm] Supports vblank timestamp caching Rev 2
> > (21.10.2013).
> > [   12.645468] [drm] Driver supports precise vblank timestamp
> > query.
> > [   12.645512] [drm] radeon: irq initialized.
> > [   12.645689] [drm] radeon: ring at 0x0000000090010000
> > [   12.793131] [drm:.r100_ring_test [radeon]] *ERROR* radeon: ring
> > test failed (scratch(0x15E4)=0xCAFEDEAD)
> > [   12.793235] [drm:.r100_cp_init [radeon]] *ERROR* radeon: cp
> > isn't working (-22).
> > [   12.939961] [drm:.r100_cp_fini [radeon]] *ERROR* Wait for CP
> > idle timeout, shutting down CP.
> > [   12.940193] [drm] radeon: cp finalized
> > [   12.944581] [drm] Connector Table: 12 (mac g5 9600)
> > [   12.944609] [drm] No valid Ext TMDS info found in BIOS
> > [   12.944621] [drm] No TV DAC info found in BIOS
> > [   12.944798] [drm] No TMDS info found in BIOS
> > [   12.944974] [drm] Radeon Display Connectors
> > [   12.944981] [drm] Connector 0:
> > [   12.944985] [drm]   DVI-I-1
> > [   12.944990] [drm]   HPD1
> > [   12.944995] [drm]   DDC: 0x64 0x64 0x64 0x64 0x64 0x64 0x64 0x64
> > [   12.945000] [drm]   Encoders:
> > [   12.945005] [drm]     DFP2: INTERNAL_DVO1
> > [   12.945010] [drm]     CRT2: INTERNAL_DAC2
> > [   12.945015] [drm] Connector 1:
> > [   12.945019] [drm]   DVI-I-2
> > [   12.945023] [drm]   HPD2
> > [   12.945028] [drm]   DDC: 0x60 0x60 0x60 0x60 0x60 0x60 0x60 0x60
> > [   12.945033] [drm]   Encoders:
> > [   12.945037] [drm]     DFP1: INTERNAL_TMDS1
> > [   12.945042] [drm]     CRT1: INTERNAL_DAC1
> > [   12.945046] [drm] Connector 2:
> > [   12.945051] [drm]   SVIDEO-1
> > [   12.945055] [drm]   Encoders:
> > [   12.945059] [drm]     TV1: INTERNAL_DAC2
> > [   13.028211] [drm] fb mappable at 0xB0040000
> > [   13.028229] [drm] vram apper at 0xB0000000
> > [   13.028234] [drm] size 8323072
> > [   13.028238] [drm] fb depth is 24
> > [   13.028243] [drm]    pitch is 7680
> > [   13.122329] radeon 0000:f0:10.0: fb0: radeondrmfb frame buffer
> > device
> > [   13.175092] [drm] Initialized radeon 2.43.0 20080528 for
> > 0000:f0:10.0 on minor 0
> > rican-linux@Debian-G5:~$ 
> > 
> > 
> > On Mon, Sep 19, 2016 at 11:20 PM, Michel Dänzer <michel@daenzer.net
> > > wrote:
> > > On 20/09/16 12:43 PM, Herminio Hernandez, Jr. wrote:
> > > >
> > > > Yes to both, however when I set radeon.agpmode=1 most of the
> > > time the
> > > > kernel freezes when booting. When I do get past that I get
> > > these errors:
> > > 
> > > [...]
> > > 
> > > > *[   11.415769] [drm:.radeon_agp_init [radeon]] *ERROR* Illegal
> > > AGP
> > > > Mode: 1 (valid 4, 8), leaving at 8*
> > > 
> > > As you can see, AGP 1x isn't supported by your setup, only 4x or
> > > 8x. How
> > > about radeon.agpmode=4?
> > > 
> > > 
> > > --
> > > Earthling Michel Dänzer               |               http://www.
> > > amd.com
> > > Libre software enthusiast             |             Mesa and X
> > > developer
> > > 
> > 
> > 
> 
