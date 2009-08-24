Return-Path: <sachinp@in.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 69F37B6F31
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 24 Aug 2009 17:01:52 +1000 (EST)
Message-ID: <4A923AD3.1020507@in.ibm.com>
Date: Mon, 24 Aug 2009 12:31:39 +0530
From: Sachin Sant <sachinp@in.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: 2.6.31-rc7 : kernel BUG at drivers/rtc/rtc-ps3.c:36!
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

While trying to boot 2.6.31-rc7 on a power6 machine came
across the following Bug. 

Starting udev: ------------[ cut here ]------------
kernel BUG at drivers/rtc/rtc-ps3.c:36!
cpu 0x0: Vector: 700 (Program Check) at [c0000000f70f3570]
    pc: c00000000059a020: .ps3_get_time+0x3c/0x84
    lr: c00000000059a018: .ps3_get_time+0x34/0x84
    sp: c0000000f70f37f0
   msr: 8000000000029032
  current = 0xc0000000f8d14ee0
  paca    = 0xc0000000012cc300
    pid   = 159, comm = hwclock
kernel BUG at drivers/rtc/rtc-ps3.c:36!
enter ? for help
[c0000000f70f3890] c000000000593918 .rtc_read_time+0xac/0xe8
[c0000000f70f3930] c000000000594508 .rtc_dev_ioctl+0x358/0x5a4
[c0000000f70f3a40] c0000000001df868 .vfs_ioctl+0x70/0x10c
[c0000000f70f3af0] c0000000001e00a0 .do_vfs_ioctl+0x6d8/0x748
[c0000000f70f3be0] c0000000001e0198 .SyS_ioctl+0x88/0xd0
[c0000000f70f3ca0] c000000000221fc8 .do_ioctl32_pointer+0x3c/0x5c
[c0000000f70f3d40] c000000000226ef0 .compat_sys_ioctl+0x43c/0x4c4
[c0000000f70f3e30] c0000000000085f0 syscall_exit+0x0/0x40
--- Exception: c01 (System Call) at 000000000fee33e8
SP (ffe0c7d0) is in userspace
0:mon> 
0:mon> di $.ps3_get_time
c000000000599fe4  7c0802a6      mflr    r0
c000000000599fe8  f8010010      std     r0,16(r1)
c000000000599fec  fb81ffe0      std     r28,-32(r1)
c000000000599ff0  fba1ffe8      std     r29,-24(r1)
c000000000599ff4  fbe1fff8      std     r31,-8(r1)
c000000000599ff8  f821ff61      stdu    r1,-160(r1)
c000000000599ffc  7c3f0b78      mr      r31,r1
c00000000059a000  7c9d2378      mr      r29,r4
c00000000059a004  60000000      nop
 ...
c00000000059a00c  387f0070      addi    r3,r31,112
c00000000059a010  389f0078      addi    r4,r31,120
c00000000059a014  4baf1235      bl      c00000000008b248        #
._lv1_get_rtc+0x0/0x3c
c00000000059a018  60000000      nop
c00000000059a01c  7c6307b4      extsw   r3,r3
c00000000059a020  0b030000      tdnei   r3,0
0:mon> 
0:mon> r
R00 = c00000000059a018   R16 = 0000000000000000
R01 = c0000000f70f37f0   R17 = 00000000ffe0cb50
R02 = c000000001274d30   R18 = 0000000000000000
R03 = fffffffffffffffe   R19 = 0000000010020000
R04 = c0000000f70f3868   R20 = 0000000000000000
R05 = 0000000000000004   R21 = 0000000000033790
R06 = c0000000f70f39d4   R22 = 000000004a923592
R07 = 0000000000000000   R23 = 0000000000000001
R08 = 07c0000000000000   R24 = 0000000040247009
R09 = c00000000125d708   R25 = c000000000783208
R10 = c0000000f742cf80   R26 = ffffffffffffffea
R11 = c0000000f70f3868   R27 = c0000000f70f39b0
R12 = 0000000000004000   R28 = c0000000f742cd10
R13 = c0000000012cc300   R29 = c0000000f70f39b0
R14 = 0000000010019d40   R30 = c000000001213148
R15 = 00000000ffe0cc7b   R31 = c0000000f70f37f0
pc  = c00000000059a020 .ps3_get_time+0x3c/0x84
lr  = c00000000059a018 .ps3_get_time+0x34/0x84
msr = 8000000000029032   cr  = 44222424
ctr = c000000000599fe4   xer = 0000000000000001   trap =  700
0:mon>

Corresponding c code is :

static u64 read_rtc(void)
{
....
result = lv1_get_rtc(&rtc_val, &tb_val);
BUG_ON(result);

I had never tried enabling CONFIG_RTC_DRV_PS3 option before
so not sure if this is a new problem or an old one. 

Thanks
-Sachin


-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
