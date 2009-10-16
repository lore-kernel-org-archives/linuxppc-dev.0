Return-Path: <roberto.j.guerra@gmail.com>
Received: from mail-qy0-f187.google.com (mail-qy0-f187.google.com
	[209.85.221.187]) by ozlabs.org (Postfix) with ESMTP id C43F3B7BBC
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 17 Oct 2009 02:37:36 +1100 (EST)
Received: by qyk17 with SMTP id 17so2382415qyk.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 16 Oct 2009 08:37:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4AD6454C.60705@freescale.com>
References: <7c4144600910090714g524bad07ubf6cad3aaf8085ff@mail.gmail.com>
	<20091009170433.GA17372@b07421-ec1.am.freescale.net>
	<7c4144600910091059o492c870cn3ea1c1a96d2f0823@mail.gmail.com>
	<20091009181617.GA14304@loki.buserror.net>
	<7c4144600910141434y26972dbbnb776c4ef89d15a17@mail.gmail.com>
	<4AD6454C.60705@freescale.com>
Date: Fri, 16 Oct 2009 11:37:33 -0400
Message-ID: <7c4144600910160837y3d70ccd2yeeeb220da7e556c3@mail.gmail.com>
Subject: Re: Support for S29JL064 in MPC8272ADS?
From: Roberto Guerra <roberto.j.guerra@gmail.com>
To: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In the last few days, I made this progress (<snip> indicates where I
cropped the file to the relevant sections):

$ cat myboard.dts
<snip>
        localbus@f0010100 {
                compatible =3D "fsl,mpc8280-localbus",
                             "fsl,pq2-localbus";
                #address-cells =3D <2>;
                #size-cells =3D <1>;
                reg =3D <f0010100 60>;

                ranges =3D <0 0 ffe00000 00800000>;

                flash@0,0 {
                        compatible =3D "cfi-flash";
                        reg =3D <0 0 800000>;
                        bank-width =3D <2>;
                        device-width =3D <2>;
                };
        };
<snip>

$ cat linux/.config
<snip>
#
# Generic Driver Options
#
CONFIG_MTD=3Dy
CONFIG_MTD_DEBUG=3Dy
CONFIG_MTD_DEBUG_VERBOSE=3D3
# CONFIG_MTD_CONCAT is not set
CONFIG_MTD_PARTITIONS=3Dy
# CONFIG_MTD_REDBOOT_PARTS is not set
CONFIG_MTD_CMDLINE_PARTS=3Dy
# CONFIG_MTD_OF_PARTS is not set
#
# User Modules And Translation Layers
#
# CONFIG_MTD_CHAR is not set
# CONFIG_MTD_BLKDEVS is not set
# CONFIG_MTD_BLOCK is not set
# CONFIG_MTD_BLOCK_RO is not set
# CONFIG_FTL is not set
# CONFIG_NFTL is not set
# CONFIG_INFTL is not set
# CONFIG_RFD_FTL is not set
# CONFIG_SSFDC is not set
# CONFIG_MTD_OOPS is not set
#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=3Dy
# CONFIG_MTD_JEDECPROBE is not set
CONFIG_MTD_GEN_PROBE=3Dy
CONFIG_MTD_CFI_ADV_OPTIONS=3Dy
# CONFIG_MTD_CFI_NOSWAP is not set
# CONFIG_MTD_CFI_BE_BYTE_SWAP is not set
CONFIG_MTD_CFI_LE_BYTE_SWAP=3Dy
CONFIG_MTD_CFI_GEOMETRY=3Dy
# CONFIG_MTD_MAP_BANK_WIDTH_1 is not set
CONFIG_MTD_MAP_BANK_WIDTH_2=3Dy
# CONFIG_MTD_MAP_BANK_WIDTH_4 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
CONFIG_MTD_CFI_I1=3Dy
# CONFIG_MTD_CFI_I2 is not set
# CONFIG_MTD_CFI_I4 is not set
# CONFIG_MTD_CFI_I8 is not set
# CONFIG_MTD_OTP is not set
# CONFIG_MTD_CFI_INTELEXT is not set
CONFIG_MTD_CFI_AMDSTD=3Dy
# CONFIG_MTD_CFI_STAA is not set
CONFIG_MTD_CFI_UTIL=3Dy
# CONFIG_MTD_RAM is not set
# CONFIG_MTD_ROM is not set
# CONFIG_MTD_ABSENT is not set
#
# Mapping drivers for chip access
#
# CONFIG_MTD_COMPLEX_MAPPINGS is not set
CONFIG_MTD_PHYSMAP=3Dy
CONFIG_MTD_PHYSMAP_START=3D0xff800000
CONFIG_MTD_PHYSMAP_LEN=3D0x800000
CONFIG_MTD_PHYSMAP_BANKWIDTH=3D2
# CONFIG_MTD_PHYSMAP_OF is not set
# CONFIG_MTD_INTEL_VR_NOR is not set
# CONFIG_MTD_PLATRAM is not set
#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
# CONFIG_MTD_SLRAM is not set
# CONFIG_MTD_PHRAM is not set
# CONFIG_MTD_MTDRAM is not set
# CONFIG_MTD_BLOCK2MTD is not set
<snip>

=3D> tftpboot 200000 uImage
=3D> tftpboot 400000 myboard.dtb
=3D> echo $bootargs
console=3DttyCPM0,115200 root=3D/dev/mtdblock1 rw
mtdparts=3Dphys:1600K(ROM)ro,6M(root),512K(U-Boot)ro,512K(unused)
rootfstype=3Djffs2
=3D> bootm 200000 - 400000
<snip>
physmap platform flash device: 00800000 at ff800000
physmap-flash.0: Found 1 x16 devices at 0x0 in 16-bit bank
 Amd/Fujitsu Extended Query Table at 0x0040
physmap-flash.0: CFI does not contain boot bank location. Assuming
top.
number of CFI chips: 1
cfi_cmdset_0002: Disabling erase-suspend-program due to code
brokenness.
RedBoot partition parsing not available
mtd: Giving out device 0 to physmap-flash.0
mice: PS/2 mouse device common for all mice
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
Root-NFS: No NFS server available, giving up.
VFS: Unable to mount root fs via NFS, trying floppy.
MTDSB: dev_name "/dev/root"
MTDSB: path_lookup() returned 0, inode c1400aa0
List of all partitions:
0100       4096 ram0 (driver?)
0101       4096 ram1 (driver?)
0102       4096 ram2 (driver?)
0103       4096 ram3 (driver?)
0104       4096 ram4 (driver?)
0105       4096 ram5 (driver?)
0106       4096 ram6 (driver?)
0107       4096 ram7 (driver?)
0108       4096 ram8 (driver?)
0109       4096 ram9 (driver?)
010a       4096 ram10 (driver?)
010b       4096 ram11 (driver?)
010c       4096 ram12 (driver?)
010d       4096 ram13 (driver?)
010e       4096 ram14 (driver?)
010f       4096 ram15 (driver?)
No filesystem could mount root, tried:  jffs2
Kernel panic - not syncing: VFS: Unable to mount root fs on
unknown-block(2,0)
Rebooting in 180 seconds..

The key change in my kernel config was the BIG_ENDIAN=3DY.
The kernel probes the AMD chip, but it can't see the partitions.
I guess now I will have to define my mtd partitions in either FDT or
in the kernel arguments.
Which is the best way to define them? If the partitions are defined in
both FDT and bootargs, which one takes precedence?

-Roberto


On Wed, Oct 14, 2009 at 5:40 PM, Scott Wood <scottwood@freescale.com> wrote=
:
> Roberto Guerra wrote:
>>
>> I've been learning how to modify the dts from
>>
>> http://www.mjmwired.net/kernel/Documentation/powerpc/dts-bindings/mtd-ph=
ysmap.txt#49
>> The original mpc8272ads.dts represents four 8-bit JEDEC Sharp flash
>> chips in 1 SIMM module:
>> [snip] =A0 =A0 =A0 =A0localbus@f0010100 {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "fsl,mpc8280-localbus",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "fsl,pq2-localbu=
s";
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#address-cells =3D <2>;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#size-cells =3D <1>;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D <f0010100 60>;
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ranges =3D <0 0 fe000000 00800000
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A01 0 f4500000 00008000
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A08 0 f8200000 00008000=
>;
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0flash@0,0 {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "jedec-fla=
sh";
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0 0 800000>;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bank-width =3D <4>;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0device-width =3D <1>;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0};
>> [snip]
>> My board (based on the PQ2FADS, using the MPC8272ADS BSP)
>
> Don't base anything on the BSPs, unless there's something in them that yo=
u
> really need that isn't upstream. =A0There is pq2fads support in current
> upstream kernels.
>
>> uses one
>> 16-bit Spansion (AMD) CFI chip at addresses FF800000 through FFFFFFFF.
>> It probably needs to be represented this way (I've only made changes
>> to the "flash" section.
>> [snip]
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0flash@0,0 {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "amd, s29j=
l064h", "cfi-flash";
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0 0 800000>;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bank-width =3D <2>;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0device-width =3D <2>;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0};
>> [snip]
>> However, I don't know what would be the correct addresses to type
>> after "localbus", "flash" and "reg". Is this enough information to
>> define my dts?
>
> The flash node looks good, other than that there shouldn't be a space aft=
er
> "amd,".
>
> In the localbus node, change fe000000 to ff800000. =A0Remove or change th=
e
> other ranges entries if they don't describe your board's chipselects.
>
> If your IMMR is somewhere other than 0xf0000000, update the f0010100 to
> match.
>
> -Scott
>
>
