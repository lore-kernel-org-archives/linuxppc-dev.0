Message-ID: <39CF73D6.DC5E3DEB@emc.com>
Date: Mon, 25 Sep 2000 11:48:38 -0400
From: Zhaobin Zhu <zzhu@emc.com>
MIME-Version: 1.0
To: "ZHANG,HAI-TAO (Non-A-China,ex1)" <hai-tao_zhang@non.agilent.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Sandpoint/PPMC750 MPPMC7400
References: <2F67A63DFFB1D31185D90090278CBB2D01679D7D@apmail6.chn.agilent.com>
Content-Type: text/plain; charset=gb2312
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"ZHANG,HAI-TAO (Non-A-China,ex1)" wrote:

> > I has been trying to boot Hardhat (CDK1.2)linux kernel on
> > Sandpoint/PPMC750. Everytime the boot gets stuck at
> > .......
> > >Uncompressing Linux...done.
> > >Now booting the kernel
> Do you use 2.3.16 kernel ? The kernel stops here may be caused by MMU_init,
> please check the arch/ppc/kernel/head.S and arch/ppc/mm/init.c. (you can use
> ppc_md.progress for printing messages)
>

Hi  HAI-TAO,

The kernel I use is Linux version 2.4.0-test2 .

I enabled Sandpoint_debug. Here is the __most farther__ the boot goes:
-----
DINK32_ARTHUR >>go 900000
loaded at:     00900000 00914E20
relocated to:  00800000 00814E20
zimage at:     0090B000 00989621
avail ram:     00400000 00800000

Linux/PPC load: root=nfs
Uncompressing Linux...done.
Now booting the kernel
id mach(): doneMMU:enterMMU:hash inithash:enterhash:find
piecehash:patchhash:doneMMU:mapinMMU:setbatMMU:exitsetup_arch
: entersetup_arch: bootmemarch: exit
------
Observed problems:
1) The boot is no consistent.
     Sometime it hangs at
     Now booting the kernel
     id mach():

     Sometime it hangs at
     Now booting the kernel
     id mach(): doneMMU:enterMMU:hash inithash:enterhash:find piece

2) By luck, the most farther it reaches
     Now booting the kernel
     id mach(): doneMMU:enterMMU:hash inithash:enterhash:find
     piecehash:patchhash:doneMMU:mapinMMU:setbatMMU:exitsetup_arch
     : entersetup_arch: bootmemarch: exit

     It hangs there after entering free_area_init().

     I can't find the rountine under /arch/ppc/. So it must be an arch
independent
     rountine.

     Is it defined in mm/page_alloc.c:void __init free_area_init(unsigned long
*zones_size) ?

>From what I described, does anybody have a hint on what the problem is with
PPMC750 ?

The boot goes fine with PPMC7400 on Sandpoint.

Thanks,

--
 Zhaobin Zhu
 zzhu@emc.com 508-435-1000 x12823
 Hardware Engineering, EMC Corporation


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
