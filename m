Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D5B13DDE41
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Sep 2007 22:34:17 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1IaW5m-0001f5-8T
	for linuxppc-dev@ozlabs.org; Wed, 26 Sep 2007 05:34:14 -0700
Message-ID: <12900017.post@talk.nabble.com>
Date: Wed, 26 Sep 2007 05:34:14 -0700 (PDT)
From: Nethra <nethra_gmit@yahoo.co.in>
To: linuxppc-dev@ozlabs.org
Subject: Re: jffs2 file system on MPC8272ADS board
In-Reply-To: <20070925202257.559a78c5@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <12873530.post@talk.nabble.com>
	<20070925202257.559a78c5@ru.mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



Hello ,

>> 
>> hi everyone,
>> 
>> I m using custom board similar to MPC8272ADS board...
>> 
>> 1) For the first time it boots up properly in case if we overwrite any
>> existing binaries using nfs mounted file system on the board, after
>> rebooting it displays fallowing message...
>> 
>> Further such events for this erase block will not be printed
>> Eep. Child "null" (ino #1346) of dir ino #3 doesn't exist!
>> Eep. Child "autocomm" (ino #463) of dir ino #461 doesn't exist!
>> Eep. Child "calibration" (ino #464) of dir ino #461 doesn't exist!
>> Eep. Child "coredsp_driver.ko" (ino #939) of dir ino #336 doesn't exist!
>> Inode #1307 was a directory with children - removing those too...
>> Inode #564 was a directory with children - removing those too...
>> Inode #565 was a directory with children - removing those too...
>> Inode #1112 was a directory with children - removing those too...
>> Inode #1115 was a directory with children - removing those too...
>> Inode #1118 was a directory with children - removing those too...
>> Inode #1123 was a directory with children - removing those too...
>> 
>> after this board boots up properly....but it not be having overwritten
>> files
>> 

>Have you created jffs2 file system on flash prior to mounting it?

Yes I created jffs2 filesytem using mkfs.jffs2 prior to mounting and then I 
am over-writing some of the binaries.  In case of overwrites from NFS after
reboot
I see the above errors & the binaries/directories gets deleted from the
jffs2 partition.

>> 3) when board is running properly in between it starts printing on
>> console
>> repeatedly...
>> 

>Do the proper MTD partitions setup, erase the partition and create jffs2
filesystem on it.
>If after all those steps you're still getting output, that is prolly flakey
flash.

>> Header CRC failed on REF_PRISTINE node at 0x00638a6c: Read 0xffffffff,
>> calculated 0x44660075
>> Node totlen on flash (0xffffffff) != totlen from node ref (0x00000254)
>> Header CRC failed on REF_PRISTINE node at 0x00638cc0: Read 0xffffffff,
>> calculated 0x44660075
[...]
>>  and 
>> 
>> file system is created using fallowing command..
>> 
>> mkfs.jffs2 -r RFS_NEW/ -e 0x20000 -o /tftpboot/jffs2_img -b
>> 
>I am recalling playing with the options upper also cured the jffs2 warnings
(not as many as yours but anyway)

The other options I am wondering about,
  -c, --cleanmarker=SIZE Size of cleanmarker (default 12)
  -n, --no-cleanmarkers  Don't add a cleanmarker to every eraseblock
cleanmaker size will it help the cause?

Nethra
 
-- 
View this message in context: http://www.nabble.com/jffs2-file-system-on-MPC8272ADS-board-tf4513530.html#a12900017
Sent from the linuxppc-dev mailing list archive at Nabble.com.
