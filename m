Return-Path: <sauron@morannon.org>
Received: from post-22.mail.nl.demon.net (post-22.mail.nl.demon.net
	[194.159.73.192]) by ozlabs.org (Postfix) with ESMTP id 249D367A46
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Mar 2005 21:53:54 +1100 (EST)
Received: from morannon.demon.nl ([212.238.244.57]:38231 helo=elessar.arda)
	by post-22.mail.nl.demon.net with esmtp (Exim 4.43)
	id 1DBsdV-0001CF-4x
	for linuxppc-embedded@ozlabs.org; Thu, 17 Mar 2005 10:53:53 +0000
Received: from [192.168.1.19] (ip3e833697.speed.planet.nl [62.131.54.151])
	(authenticated bits=0)
	by elessar.arda (8.12.10/8.12.10) with ESMTP id j2HArl6e000926
	for <linuxppc-embedded@ozlabs.org>; Thu, 17 Mar 2005 11:53:47 +0100
Message-ID: <423961C0.40704@morannon.org>
Date: Thu, 17 Mar 2005 11:53:52 +0100
From: Wouter Thielen <sauron@morannon.org>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: Ext2fs on a MPC850 running BusyBox Linux and a 2.4.27 kernel
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

I am trying to get a 128K read/write partition on the 4M NAND flash chip 
to store configuration data for the system in ext2 format. mke2fs and 
mounting works fine. The problem starts when I write to the partition: I 
can write to it fine, but without proper umounting the data written 
won't be saved. I tried the following things:
- mounting with -o sync
- checking the fs/ext2/* code and trying to get fs update operations to 
call the functions that umount calls (ext2_put_super and 
ext2_sync_super), but that only results in kernel oopses and no saved 
data either.

I have been suggested to use a flash filesystem like jffs2, but the 
problem is that I have only 1 block to work with. Flash filesystems 
require more, jffs2 requires 6 blocks for 1 usable block and that would 
be an inacceptable overhead of 83%. So I'd like to try to use ext2 (or 
minixfs which is slimmer than ext2, but still has the same problem) for 
that small read/write partition. Anyone got any ideas/suggestions on how 
to make ext2 sync to disk after write operations in the buffer?

Wouter Thielen
MuLogic B.V. Netherlands
