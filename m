Return-Path: <johndavi@us.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.131])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "e33.co.us.ibm.com",
	Issuer "Network Services" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 0D13367ACB
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 Feb 2005 02:22:41 +1100 (EST)
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e33.co.us.ibm.com (8.12.10/8.12.9) with ESMTP id j1AFLvGj657394
	for <linuxppc-embedded@ozlabs.org>; Thu, 10 Feb 2005 10:22:02 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay05.boulder.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id
	j1AFLuWE146248
	for <linuxppc-embedded@ozlabs.org>; Thu, 10 Feb 2005 08:21:56 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id
	j1AFLu5j005458
	for <linuxppc-embedded@ozlabs.org>; Thu, 10 Feb 2005 08:21:56 -0700
Received: from d03nm113.boulder.ibm.com (d03nm113.boulder.ibm.com
	[9.17.195.139])
	by d03av01.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id
	j1AFLu35005435
	for <linuxppc-embedded@ozlabs.org>; Thu, 10 Feb 2005 08:21:56 -0700
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Message-ID: <OFA2E26976.CFCEB025-ON87256FA4.00534A2F-85256FA4.0054E321@us.ibm.com>
From: John F Davis <johndavi@us.ibm.com>
Date: Thu, 10 Feb 2005 10:21:57 -0500
Content-Type: text/plain; charset="US-ASCII"
Subject: another datapoint on ide dma issue with via
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello

Another thing I have noticed is that if I copy the files to and from disk 
prior to starting xine playback it will work.

ie. This works:


hdparm -d1 /dev/hda
mount /dev/hda2 /mnt/disk

Run in four windows simulataneously:

while true; do
        /root/driver Super.mpg $1     " This program uses mmap io to copy 
the src file to the dest file."
        sync
        md5sum Super.mpg
        sync;
        md5sum $1;
        rm $1;
        sync;
done

Kill all the scripts.

startx
start xine
run the super.mpg video from /mnt/disk.  It works flawlessly.



and This doesn't:

reboot
hdparm -d1 /dev/hda
mount /dev/hda2 /mnt/disk
startx
start xine
run the super.mpg video from /mnt/disk.  I will 
get nfsroot errors about nfs server not responding.
then ksymoops with xine making the last system call.

JD
