Return-Path: <yur@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7361ADDDF6
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Feb 2008 03:22:40 +1100 (EST)
From: Yuri Tikhonov <yur@emcraft.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Unaligned LocalPlus Bus access on MPC5200
Date: Tue, 19 Feb 2008 19:21:03 +0300
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200802191921.03705.yur@emcraft.com>
Cc: linuxppc-dev@ozlabs.org, Detlev Zundel <dzu@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


 Hello,

 I've encountered with the problem of unaligned word access to external 
devices (Flash memory) connected to Local Plus bus of MPC5200 processor. Any 
comments on this would be very appreciated.

 And the essence of the issue is as follows:

- when I try to read a data word from LPB-connected Flash using some even 
address (0xFF000000, 0xFF000002, 0xFF000004, etc), then everything works fine 
(it's not a typo, 2bytes-aligned word accesses pass well too);

- when I try to read a data word from LPB-connected Flash using some odd 
address (0xFF000001, 0xFF000003, ...) then LP returns only 1 byte of word 
correctly (the 3 bytes remained are filled with zeros).

(a) Here is what I have when I read from LPB using word-aligned accesses with 
MPC5200 rev.A and LPB configured in Non_Multiplexed mode + 8-bit data bus:

lwz from 0xc3082000:	0xba476bc7
lwz from 0xc3082004:	0xb95d77de
 ...

 Now I try the unaligned reads:
lwz from 0xc3082000:	0xba476bc7
lwz from 0xc3082001:	0x000000b9
lwz from 0xc3082002:	0x6bc7b95d
lwz from 0xc3082003:	0xc7000000

(b) With MPC5200 rev.B situation is similar, and different only in fact that 
unaligned read results to 2-bytes reading for 0x1 addresses cases (LPB again 
configured in Non_Multiplexed mode + 8-bit data bus):

lwz from 0xd1082000:	0x2f459eaf
lwz from 0xd1082004:	0x388ff68d
...

lwz from 0xd1082000:	0x2f459eaf
lwz from 0xd1082001:	0x0000af38
lwz from 0xd1082002:	0x9eaf388f
lwz from 0xd1082003:	0xaf000000

(c) When LPB operates in the Multiplexed mode with 32-bit data bus, the 
erroneous result is observed for 0x3 addresses cases only (MPC5200 has rev.A 
in these tests):
lwz from 0xc3082000:	0x7e9043a6
lwz from 0xc3082004:	0x7eb143a6
...

lwz from 0xc3082000:	0x7e9043a6
lwz from 0xc3082001:	0x9043a67e
lwz from 0xc3082002:	0x43a67eb1
lwz from 0xc3082003:	0xa6000000

 I used the following platforms for tests:

- TQM5200 board, which is based on MPC5200rev.A CPU, and has AMD Flash 
connected to LPB configured in Multiplexed mode with 32-bit data bus;

- some customed board, which is based on MPC5200rev.A CPU, and has Intel Flash 
connected to LPB configured in Non-Multiplexed mode with 8-bit data bus;

- Lite5200B board, which is based on MPC5200rev.B CPU, and has AMD Flash 
connected to LPB configured in Non-Multiplexed mode with 8-bit data bus.

 The Linux source tree I used is linux-2.6.23.16 (DENX linux-2.6.23-stable 
branch). The toolchain is ELDK-4.2.


 As an example, these LPB-related issue leads to the incorrect operation of 
JFFS2 file-system created on the top of MTD device built on a Flash chip from 
Intel/Sharp (drivers/mtd/chips/cfi_cmdset_0001.c).

 With these Flash chips implementation of point/unpoint API is possible, so 
the cfi_cmdset_0001.c driver exports the corresponding point/unpoint methods 
for the MTD device, and JFFS2 then uses these methods to operate with data 
directly from Flash (without copying them to RAM memory).

 One of these operations is memcpy() in the jffs2_scan_dirent_node() function, 
which copies the file name from some address at Flash (aligned) to, 
unfortunately, unaligned destination in RAM ("name" field of the 
jffs2_full_dirent structure).

 The implementation of memcpy() in lib_powerpc first does byte-to-byte 
transfers to achieve the aligned destination, and then does word-to-word 
transfers, but by this moment the source is unaligned, so memcpy() does lwz-s 
from unaligned addresses on LPB.

 Just FYI, a simple work-around for the issue with the Intel/Sharp Flash chips 
connected to LPB of MPC5200 is to mark your struct map_info as .phys = 
NO_XIP, and implement read/write/copy_from/copy_to byte-to-byte functions (in 
your drivers/mtd/maps/ board file).

 Regards, Yuri

-- 
Yuri Tikhonov, Senior Software Engineer
Emcraft Systems, www.emcraft.com
