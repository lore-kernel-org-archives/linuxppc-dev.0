Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id A42FFDDE06
	for <linuxppc-dev@ozlabs.org>; Wed,  7 May 2008 12:35:26 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1JtZV5-0001vM-LU
	for linuxppc-dev@ozlabs.org; Tue, 06 May 2008 19:35:23 -0700
Message-ID: <17093824.post@talk.nabble.com>
Date: Tue, 6 May 2008 19:35:23 -0700 (PDT)
From: Nethra <nethra_gmit@yahoo.co.in>
To: linuxppc-dev@ozlabs.org
Subject: jffs2 on imx21ads board
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


hi all, 

I m using imx21ads board, Bootloader is Redboot. 
linux is linux-2.6.22 version. Board with Jffs2 root filesystem as root is
not working. 
But Ramdisk booting is working...so i tried to mount jffs2 root file system
after 
booting board with ramdisk using mount command. It boots up with some error
message as given below. 

With df command it shows 100%... 


mx27# cat /proc/mtd 
dev:    size   erasesize  name 
mtd0: 00040000 00010000 "Bootloader" 
mtd1: 00200000 00040000 "nor.Kernel1" 
mtd2: 00200000 00040000 "nor.kernel2" 
mtd3: 00d00000 00040000 "nor.rootfs1" 
mtd4: 00d00000 00040000 "nor.rootfs2" 
mtd5: 00040000 00040000 "Parameter" 
mtd6: 00003000 00010000 "FIS directory" 
mtd7: 00001000 00010000 "Redboot config" 
mx27# cd /dev/ 
/dev/input/  /dev/net/    /dev/pts/    /dev/shm/ 
mx27# mount -t jffs2 /dev/mtdblock3 /mnt 
<6>MTDSB: dev_name "/dev/mtdblock3" 
[   27.820000] MTDSB: path_lookup() returned 0, inode c3c50100 
[   27.820000] MTDSB: New superblock for device 3 ("nor.rootfs1") 
mx27# [   30.240000] Erase at 0x00b80000 failed immediately: -EROFS. Is the
sector locked? 
[   30.240000] Erase at 0x00b40000 failed immediately: -EROFS. Is the sector
locked? 
[   30.250000] Erase at 0x00b00000 failed immediately: -EROFS. Is the sector
locked? 
[   30.260000] Erase at 0x00ac0000 failed immediately: -EROFS. Is the sector
locked? 
[   30.270000] Erase at 0x00a80000 failed immediately: -EROFS. Is the sector
locked? 
[   30.270000] Erase at 0x00a40000 failed immediately: -EROFS. Is the sector
locked? 
[   30.280000] Erase at 0x00a00000 failed immediately: -EROFS. Is the sector
locked? 
[   30.290000] Erase at 0x009c0000 failed immediately: -EROFS. Is the sector
locked? 
[   30.300000] Erase at 0x00980000 failed immediately: -EROFS. Is the sector
locked? 
[   30.300000] Erase at 0x00940000 failed immediately: -EROFS. Is the sector
locked? 
[   30.310000] Erase at 0x00900000 failed immediately: -EROFS. Is the sector
locked? 
[   30.320000] Erase at 0x008c0000 failed immediately: -EROFS. Is the sector
locked? 
[   30.330000] Erase at 0x00880000 failed immediately: -EROFS. Is the sector
locked? 
[   30.340000] Erase at 0x00840000 failed immediately: -EROFS. Is the sector
locked? 
[   30.340000] Erase at 0x00800000 failed immediately: -EROFS. Is the sector
locked? 
[   30.350000] Erase at 0x007c0000 failed immediately: -EROFS. Is the sector
locked? 
[   30.360000] Erase at 0x00780000 failed immediately: -EROFS. Is the sector
locked? 
[   30.370000] Erase at 0x00740000 failed immediately: -EROFS. Is the sector
locked? 
[   30.370000] Erase at 0x00700000 failed immediately: -EROFS. Is the sector
locked? 
[   30.380000] Erase at 0x006c0000 failed immediately: -EROFS. Is the sector
locked? 
[   30.390000] Erase at 0x00680000 failed immediately: -EROFS. Is the sector
locked? 
[   30.400000] Erase at 0x00640000 failed immediately: -EROFS. Is the sector
locked? 
[   30.410000] Erase at 0x00600000 failed immediately: -EROFS. Is the sector
locked? 
[   30.410000] Erase at 0x005c0000 failed immediately: -EROFS. Is the sector
locked? 
[   30.420000] Erase at 0x00580000 failed immediately: -EROFS. Is the sector
locked? 
[   30.430000] Erase at 0x00540000 failed immediately: -EROFS. Is the sector
locked? 
[   30.440000] Erase at 0x00500000 failed immediately: -EROFS. Is the sector
locked? 
[   30.440000] Erase at 0x004c0000 failed immediately: -EROFS. Is the sector
locked? 
mx27# 
mx27# 
mx27# df 
Filesystem           1k-blocks      Used Available Use% Mounted on 
/dev/ram0                 7280      4963      1948  72% / 
df: /mnt/rwfs: No such file or directory 
rwfs                       512       232       280  45% /tmp 
rwfs                       512       232       280  45% /etc 
rwfs                       512       232       280  45% /var 
shm                      31560         0     31560   0% /dev/shm 
/dev/mtdblock3           13312     13312         0 100% /mnt 
mx27# 
mx27# 

waiting for inputs 

tnks, 
Nethra
-- 
View this message in context: http://www.nabble.com/jffs2-on-imx21ads-board-tp17093824p17093824.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
