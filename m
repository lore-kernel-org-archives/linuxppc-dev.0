Message-ID: <3D530222.7040303@redswitch.com>
Date: Thu, 08 Aug 2002 16:43:30 -0700
From: "Xiaogeng (Shawn) Jin" <xjin@redswitch.com>
MIME-Version: 1.0
To: linux-mtd@lists.infradead.org,
	linuxppc-embedded@lists.linuxppc.org
Subject: MTD/JFFS2 on Intel 28F160F3
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi *,

I'm trying to enable MTD and JFFS2 on an Intel 28F160F3 chip but have
some problems.

The basic problem is what the physical start address of flash mapping
is? While on PPCBoot, I got flash information using command 'flinfo'.
The start address is FFE00000. Is this address the one used to configure
CFI flash device in physical memeory map? I tried using this address but
  'physmap' couldn't find flash device.

-----------------clip-----------------------------------------
root@ib8sw:~# modprobe -a physmap
physmap flash device: 100000 at ffe00000
CFI: Found no Physically mapped flash device at location zero
-----------------clip-----------------------------------------
-----------------clip-----------------------------------------
=> flinfo

Bank # 1: INTEL 28F160F3 (16 Mbit, top boot sector)
   Size: 2 MB in 39 Sectors
   Sector Start Addresses:
     FFE00000      FFE10000      FFE20000      FFE30000      FFE40000
     FFE50000      FFE60000      FFE70000      FFE80000      FFE90000
     FFEA0000      FFEB0000      FFEC0000      FFED0000      FFEE0000
     FFEF0000      FFF00000 (RO) FFF10000 (RO) FFF20000 (RO) FFF30000 (RO)
     FFF40000      FFF50000      FFF60000      FFF70000      FFF80000
     FFF90000      FFFA0000      FFFB0000      FFFC0000      FFFD0000
     FFFE0000      FFFF0000      FFFF2000      FFFF4000      FFFF6000
     FFFF8000      FFFFA000      FFFFC000      FFFFE000
=>
-----------------clip-----------------------------------------

I haven't dived into the routine 'do_cfi_probe()' yet since I'm not sure
if the start address I specified is correct. Any help is greatly
appreciated.

- Shawn.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
