Return-Path: <chenglcl@cn.ibm.com>
Received: from ausmtp04.au.ibm.com (ausmtp04.au.ibm.com [202.81.18.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D17A667A3A
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Aug 2006 15:57:45 +1000 (EST)
Received: from sd0208e0.au.ibm.com (d23rh904.au.ibm.com [202.81.18.202])
	by ausmtp04.au.ibm.com (8.13.6/8.13.5) with ESMTP id k7863wjZ125464
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Aug 2006 16:03:58 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.250.242])
	by sd0208e0.au.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k7860qXE196954
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Aug 2006 16:00:53 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k785vRQW014076
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Aug 2006 15:57:27 +1000
Received: from d23m0017.cn.ibm.com (cnnco04.cn.ibm.com [9.181.122.142])
	by d23av01.au.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k785vPFC013924
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Aug 2006 15:57:26 +1000
Subject: Umount reiserfs partition caused crash on 2.6.18-rc3-mm2
To: linuxppc-dev@ozlabs.org
Message-ID: <OFBE03114B.A48C7930-ON482571C4.001E80F2-482571C4.0020774E@cn.ibm.com>
From: Lei CL Cheng <chenglcl@cn.ibm.com>
Date: Tue, 8 Aug 2006 13:57:19 +0800
MIME-Version: 1.0
Content-type: multipart/alternative;
	Boundary="0__=C7BBFB57DF8D06628f9e8a93df938690918cC7BBFB57DF8D0662"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--0__=C7BBFB57DF8D06628f9e8a93df938690918cC7BBFB57DF8D0662
Content-type: text/plain; charset=US-ASCII

Hi,

I installed latest mm kernel 2.6.18-rc3-mm2 on ppc64 with RHEL4-U3.
And I made a reiserfs partition by mkfs command in this kernel.
But when I tried to umount this reiserfs partition, the kernel
crashed and xmon will be entered.

the steps:
 1. mkfs -t reiserfs -f --format 3.6 /dev/sdb
 2. mount /dev/sdb /mnt/tmp
 3. umount /mnt/tmp

Additional information:
./mkreiserfs -V
mkreiserfs 3.6.19 (2003 www.namesys.com)

The error message printed by xmon is like:
---------------------------------------------
  BUG: Dentry c0000000718178a0{i=3,n=.reiserfs_priv} still in use (1)
    [unmount
  of reiserfs sdb]
  kernel BUG in shrink_dcache_for_umount_subtree at fs/dcache.c:611!
  cpu 0x3: Vector: 700 (Program Check) at [c0000001667ef690]
    pc: c0000000000e06cc: .shrink_dcache_for_umount_subtree+0x214/0x364
    lr: c0000000000e06c8: .shrink_dcache_for_umount_subtree+0x210/0x364
    sp: c0000001667ef910
    msr: 8000000000029032
    current = 0xc00000007180b040
    paca    = 0xc000000000567800
    pid   = 5220, comm = umount
  kernel BUG in shrink_dcache_for_umount_subtree at fs/dcache.c:611!
  enter ? for help

  2:mon> t
  [c0000001667ef9a0] c0000000000e086c .shrink_dcache_for_umount+0x50/0x78
  [c0000001667efa20] c0000000000c9c74 .generic_shutdown_super+0x40/0x230
  [c0000001667efab0] c0000000000cb07c .kill_block_super+0x30/0x60
  [c0000001667efb40] c0000000000c9be0 .deactivate_super+0x8c/0xe0
  [c0000001667efbd0] c0000000000e69e8 .mntput_no_expire+0x84/0xcc
  [c0000001667efc60] c0000000000d36c4 .path_release_on_umount+0x30/0x48
  [c0000001667efcf0] c0000000000e75dc .sys_umount+0x264/0x294
  [c0000001667efe30] c00000000000861c syscall_exit+0x0/0x40
  --- Exception: c01 (System Call) at 000000000ff31f84
  SP (ffca1750) is in userspace

  2:mon> r
  R00 = c0000000000e06c8   R16 = 00000000ffffffff
  R01 = c0000001667ef910   R17 = 0000000010020000
  R02 = c000000000748448   R18 = 0000000000000000
  R03 = 0000000000000061   R19 = 00000000ffca1df8
  R04 = 8000000000001032   R20 = 0000000000000000
  R05 = 0000000000000000   R21 = 0000000000000000
  R06 = 8000000000b10393   R22 = 00000000100c0000
  R07 = 0000000000000000   R23 = 0000000000000000
  R08 = 0000000000000001   R24 = 0000000000000000
  R09 = c000000000594660   R25 = 0000000000000000
  R10 = c00000016763bbd8   R26 = c0000001667efdf0
  R11 = c000000000594660   R27 = 0000000000000000
  R12 = 0000000000004000   R28 = c000000169e0f800
  R13 = c000000000567800   R29 = c000000071817980
  R14 = 00000000ffca18d0   R30 = c0000000005bd348
  R15 = 0000000010020000   R31 = c0000000718178a0
  pc  = c0000000000e06cc .shrink_dcache_for_umount_subtree+0x214/0x364
  lr  = c0000000000e06c8 .shrink_dcache_for_umount_subtree+0x210/0x364
  msr = 8000000000029032   cr  = 24004424
  ctr = 8000000000132d10   xer = 000000000000000f   trap =  700

  2:mon> S
  msr  = 8000000000001032  sprg0= 0000000000000000
  pvr  = 00000000003a0201  sprg1= c000000000567600
  dec  = 00000000ad4830a1  sprg2= c000000000567600
  sp   = c00000016691ad50  sprg3= c000000000567600
  toc  = c000000000748448  dar  = c000000071794010

  -Thanks
--0__=C7BBFB57DF8D06628f9e8a93df938690918cC7BBFB57DF8D0662
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline

<html><body>
<p><font face="Courier New">Hi,</font><br>
<br>
<font face="Courier New">I installed latest mm kernel 2.6.18-rc3-mm2 on ppc64 with RHEL4-U3.</font><br>
<font face="Courier New">And I made a reiserfs partition by mkfs command in this kernel.</font><br>
<font face="Courier New">But when I tried to umount this reiserfs partition, the kernel</font><br>
<font face="Courier New">crashed and xmon will be entered.</font><br>
<br>
<font face="Courier New">the steps:</font><br>
<font face="Courier New">1. mkfs -t reiserfs -f --format 3.6 /dev/sdb</font><br>
<font face="Courier New">2. mount /dev/sdb /mnt/tmp</font><br>
<font face="Courier New">3. umount /mnt/tmp</font><br>
<br>
<font face="Courier New">Additional information:</font><br>
<font face="Courier New">./mkreiserfs -V</font><br>
<font face="Courier New">mkreiserfs 3.6.19 (2003 www.namesys.com)</font><br>
<br>
<font face="Courier New">The error message printed by xmon is like:</font><br>
<font face="Courier New">---------------------------------------------</font>
<ul><font face="Courier New">BUG: Dentry c0000000718178a0{i=3,n=.reiserfs_priv} still in use (1) [unmount</font><br>
<font face="Courier New">of reiserfs sdb]</font><br>
<font face="Courier New">kernel BUG in shrink_dcache_for_umount_subtree at fs/dcache.c:611!</font><br>
<font face="Courier New">cpu 0x3: Vector: 700 (Program Check) at [c0000001667ef690]</font><br>
<font face="Courier New">pc: c0000000000e06cc: .shrink_dcache_for_umount_subtree+0x214/0x364</font><br>
<font face="Courier New">lr: c0000000000e06c8: .shrink_dcache_for_umount_subtree+0x210/0x364</font><br>
<font face="Courier New">sp: c0000001667ef910</font><br>
<font face="Courier New">msr: 8000000000029032</font><br>
<font face="Courier New">current = 0xc00000007180b040</font><br>
<font face="Courier New">paca    = 0xc000000000567800</font><br>
<font face="Courier New">pid   = 5220, comm = umount</font><br>
<font face="Courier New">kernel BUG in shrink_dcache_for_umount_subtree at fs/dcache.c:611!</font><br>
<font face="Courier New">enter ? for help</font><br>
<br>
<font face="Courier New">2:mon&gt; t</font><br>
<font face="Courier New">[c0000001667ef9a0] c0000000000e086c .shrink_dcache_for_umount+0x50/0x78</font><br>
<font face="Courier New">[c0000001667efa20] c0000000000c9c74 .generic_shutdown_super+0x40/0x230</font><br>
<font face="Courier New">[c0000001667efab0] c0000000000cb07c .kill_block_super+0x30/0x60</font><br>
<font face="Courier New">[c0000001667efb40] c0000000000c9be0 .deactivate_super+0x8c/0xe0</font><br>
<font face="Courier New">[c0000001667efbd0] c0000000000e69e8 .mntput_no_expire+0x84/0xcc</font><br>
<font face="Courier New">[c0000001667efc60] c0000000000d36c4 .path_release_on_umount+0x30/0x48</font><br>
<font face="Courier New">[c0000001667efcf0] c0000000000e75dc .sys_umount+0x264/0x294</font><br>
<font face="Courier New">[c0000001667efe30] c00000000000861c syscall_exit+0x0/0x40</font><br>
<font face="Courier New">--- Exception: c01 (System Call) at 000000000ff31f84</font><br>
<font face="Courier New">SP (ffca1750) is in userspace</font><br>
<br>
<font face="Courier New">2:mon&gt; r</font><br>
<font face="Courier New">R00 = c0000000000e06c8   R16 = 00000000ffffffff</font><br>
<font face="Courier New">R01 = c0000001667ef910   R17 = 0000000010020000</font><br>
<font face="Courier New">R02 = c000000000748448   R18 = 0000000000000000</font><br>
<font face="Courier New">R03 = 0000000000000061   R19 = 00000000ffca1df8</font><br>
<font face="Courier New">R04 = 8000000000001032   R20 = 0000000000000000</font><br>
<font face="Courier New">R05 = 0000000000000000   R21 = 0000000000000000</font><br>
<font face="Courier New">R06 = 8000000000b10393   R22 = 00000000100c0000</font><br>
<font face="Courier New">R07 = 0000000000000000   R23 = 0000000000000000</font><br>
<font face="Courier New">R08 = 0000000000000001   R24 = 0000000000000000</font><br>
<font face="Courier New">R09 = c000000000594660   R25 = 0000000000000000</font><br>
<font face="Courier New">R10 = c00000016763bbd8   R26 = c0000001667efdf0</font><br>
<font face="Courier New">R11 = c000000000594660   R27 = 0000000000000000</font><br>
<font face="Courier New">R12 = 0000000000004000   R28 = c000000169e0f800</font><br>
<font face="Courier New">R13 = c000000000567800   R29 = c000000071817980</font><br>
<font face="Courier New">R14 = 00000000ffca18d0   R30 = c0000000005bd348</font><br>
<font face="Courier New">R15 = 0000000010020000   R31 = c0000000718178a0</font><br>
<font face="Courier New">pc  = c0000000000e06cc .shrink_dcache_for_umount_subtree+0x214/0x364</font><br>
<font face="Courier New">lr  = c0000000000e06c8 .shrink_dcache_for_umount_subtree+0x210/0x364</font><br>
<font face="Courier New">msr = 8000000000029032   cr  = 24004424</font><br>
<font face="Courier New">ctr = 8000000000132d10   xer = 000000000000000f   trap =  700</font><br>
<br>
<font face="Courier New">2:mon&gt; S</font><br>
<font face="Courier New">msr  = 8000000000001032  sprg0= 0000000000000000</font><br>
<font face="Courier New">pvr  = 00000000003a0201  sprg1= c000000000567600</font><br>
<font face="Courier New">dec  = 00000000ad4830a1  sprg2= c000000000567600</font><br>
<font face="Courier New">sp   = c00000016691ad50  sprg3= c000000000567600</font><br>
<font face="Courier New">toc  = c000000000748448  dar  = c000000071794010</font><br>
<br>
<font face="Courier New">-Thanks</font></ul>
</body></html>
--0__=C7BBFB57DF8D06628f9e8a93df938690918cC7BBFB57DF8D0662--
