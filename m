Return-Path: <robin.gilks@tait.co.nz>
Received: from gatekeeper.tait.co.nz (tel096021.tait.co.nz [202.37.96.21])
	by ozlabs.org (Postfix) with ESMTP id 3D627684D6
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Oct 2005 11:47:19 +1000 (EST)
Received: from gatekeeper.tait.co.nz (merlin.tait.co.nz [127.0.0.1])
	by localhost.tait.co.nz (Postfix) with ESMTP id 8B4FA15B6A0
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Oct 2005 14:17:59 +1300 (NZDT)
Received: from sunstrike.tait.co.nz (unknown [172.25.40.92])by
	gatekeeper.tait.co.nz (Postfix) with ESMTP id EECE315B68Ffor
	<linuxppc-embedded@ozlabs.org>; Tue, 11 Oct 2005 14:17:58 +1300 (NZDT)
Received: from conversion-daemon.sunstrike.tait.co.nz by
	sunstrike.tait.co.nz(Sun Java System Messaging Server 6.1 (built Apr 28
	2004))id <0IO600F013XXI200@sunstrike.tait.co.nz>(original mail from
	robin.gilks@tait.co.nz) for linuxppc-embedded@ozlabs.org;
	Tue, 11 Oct 2005 14:17:58 +1300 (NZDT)
Date: Tue, 11 Oct 2005 14:17:57 +1300
From: Robin Gilks <robin.gilks@tait.co.nz>
In-reply-to: <434B03A2.8060608@rftechnology.com.au>
To: linuxppc-embedded@ozlabs.org
Message-id: <434B12C5.2050809@tait.co.nz>
MIME-version: 1.0
Content-type: text/plain;
	format=flowed;
	charset=ISO-8859-1
References: <20051010234614.1FE2A353D84@atlas.denx.de><434B03A2.8060608@rfte
	chnology.com.au>
Subject: Re: boot-time partitions and bootargs for 2.6.14
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dmytro Bablinyuk wrote:

>> Are you sure that your flash device name in Linux is just "0" ? 
>
> I think you are right. I missed the point.
>
> => flinfo
>
> Bank # 1: Sharp 28F016SC (16 Mbit, 32 x 64K)
>   Size: 8 MB in 32 Sectors
>   Sector Start Addresses:
>     FF800000      FF840000      FF880000      FF8C0000      FF900000
>     FF940000      FF980000      FF9C0000      FFA00000      FFA40000
>     FFA80000      FFAC0000      FFB00000      FFB40000      FFB80000
>     FFBC0000      FFC00000      FFC40000      FFC80000      FFCC0000
>     FFD00000      FFD40000      FFD80000      FFDC0000      FFE00000
>     FFE40000      FFE80000      FFEC0000      FFF00000 (RO) FFF40000 (RO)
>     FFF80000      FFFC0000
>
> So I have
> mtdparts=1:1024k(Linux),4096k(FS),2048k(Unused),512k(U-Boot),512()
>
> But problem remains...
> Kernel panic - not syncing: VFS: Unable to mount root fs on 
> unknown-block(31,1)

Are you using physmap as the means of creating the mtd devices? If so 
there is a bug in many variants of the kernel that defines the map 
structure as follows:
struct map_info physmap_map = {
    .name = "Physically mapped flash",
    .size = WINDOW_SIZE,
    .buswidth = BUSWIDTH,
    .phys = WINDOW_ADDR,
};

Note that the name has embedded spaces - something I've never managed to 
get U-Boot to pass across on the kernel command line (I'm sure Wolfgang 
will correct me if I'm wrong here!!). The '1' in your 
"mtdparts=1:1024k(Linux)" should match the name of this map. In this 
case the code needs to be changed to NOT have spaces in it (and perhaps 
a more user friendly name) and the kernel config values for WINDOW_SIZE, 
BUSWIDTH and WINDOW_ADDR set correctly. That way you'd end up with 
something like:
struct map_info physmap_map = {
    .name = "fred",
    .size = WINDOW_SIZE,
    .buswidth = BUSWIDTH,
    .phys = WINDOW_ADDR,
};
and a command line something like:
mtdparts=fred:1024k(Linux),4096k(FS),2048k(Unused),512k(U-Boot),512()

I'd also suggest that you mount a known good fs using NFS (if you have 
ethernet on your target) and then try manually mounting the flash fs - 
that will check out its structure (endian-ness?) and the jffs2 drivers 
on your target.

-- 
Robin Gilks
Senior Design Engineer          Phone: (+64)(3) 357 1569
Tait Electronics                Fax  :  (+64)(3) 359 4632
PO Box 1645 Christchurch        Email : robin.gilks@tait.co.nz
New Zealand


=======================================================================
This email, including any attachments, is only for the intended
addressee.  It is subject to copyright, is confidential and may be
the subject of legal or other privilege, none of which is waived or
lost by reason of this transmission.
If the receiver is not the intended addressee, please accept our
apologies, notify us by return, delete all copies and perform no
other act on the email.
Unfortunately, we cannot warrant that the email has not been
 altered or corrupted during transmission.
=======================================================================
