Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EFE0FDDE1C
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Sep 2007 05:02:08 +1000 (EST)
Date: Thu, 27 Sep 2007 23:01:54 +0400
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: Nethra <nethra_gmit@yahoo.co.in>
Subject: Re: jffs2 file system on MPC8272ADS board
Message-ID: <20070927230154.4b761450@kernel.crashing.org>
In-Reply-To: <12900017.post@talk.nabble.com>
References: <12873530.post@talk.nabble.com>
	<20070925202257.559a78c5@ru.mvista.com>
	<12900017.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Nethra,

On Wed, 26 Sep 2007 05:34:14 -0700 (PDT)
Nethra wrote:

> 
> 
> Hello ,
> 
> >> 
> >> hi everyone,
> >> 
> >> I m using custom board similar to MPC8272ADS board...
> >> 
> >> 1) For the first time it boots up properly in case if we overwrite any
> >> existing binaries using nfs mounted file system on the board, after
> >> rebooting it displays fallowing message...
> >> 
> >> Further such events for this erase block will not be printed
> >> Eep. Child "null" (ino #1346) of dir ino #3 doesn't exist!
> >> Eep. Child "autocomm" (ino #463) of dir ino #461 doesn't exist!
> >> Eep. Child "calibration" (ino #464) of dir ino #461 doesn't exist!
> >> Eep. Child "coredsp_driver.ko" (ino #939) of dir ino #336 doesn't exist!
> >> Inode #1307 was a directory with children - removing those too...
> >> Inode #564 was a directory with children - removing those too...
> >> Inode #565 was a directory with children - removing those too...
> >> Inode #1112 was a directory with children - removing those too...
> >> Inode #1115 was a directory with children - removing those too...
> >> Inode #1118 was a directory with children - removing those too...
> >> Inode #1123 was a directory with children - removing those too...
> >> 
> >> after this board boots up properly....but it not be having overwritten
> >> files
> >> 
> 
> >Have you created jffs2 file system on flash prior to mounting it?
> 
> Yes I created jffs2 filesytem using mkfs.jffs2 prior to mounting and then I 
> am over-writing some of the binaries.  In case of overwrites from NFS after
> reboot
> I see the above errors & the binaries/directories gets deleted from the
> jffs2 partition.
> 
> >> 3) when board is running properly in between it starts printing on
> >> console
> >> repeatedly...
> >> 
> 
> >Do the proper MTD partitions setup, erase the partition and create jffs2
> filesystem on it.
> >If after all those steps you're still getting output, that is prolly flakey
> flash.
> 
> >> Header CRC failed on REF_PRISTINE node at 0x00638a6c: Read 0xffffffff,
> >> calculated 0x44660075
> >> Node totlen on flash (0xffffffff) != totlen from node ref (0x00000254)
> >> Header CRC failed on REF_PRISTINE node at 0x00638cc0: Read 0xffffffff,
> >> calculated 0x44660075
> [...]
> >>  and 
> >> 
> >> file system is created using fallowing command..
> >> 
> >> mkfs.jffs2 -r RFS_NEW/ -e 0x20000 -o /tftpboot/jffs2_img -b
> >> 
> >I am recalling playing with the options upper also cured the jffs2 warnings
> (not as many as yours but anyway)
> 
> The other options I am wondering about,
>   -c, --cleanmarker=SIZE Size of cleanmarker (default 12)
>   -n, --no-cleanmarkers  Don't add a cleanmarker to every eraseblock
> cleanmaker size will it help the cause?

well, try to get rid of padding first.

are you sure about -e? please try 

mkfs.jffs2 -e 128 -d ./myimage -b -o out.jffs2 instead.
-- 
Sincerely, Vitaly
