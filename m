Return-Path: <leisun124@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.175])
	by ozlabs.org (Postfix) with ESMTP id 4356567B56
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Jul 2006 14:24:54 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id j40so150381ugd
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Jul 2006 21:24:51 -0700 (PDT)
Message-ID: <f9a7e7a80607112123t7e93221fx37d83245622d4368@mail.gmail.com>
Date: Wed, 12 Jul 2006 00:23:10 -0400
From: "Lei Sun" <leisun124@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: weird behavior for jffs2 on PQ2FADS-VR board
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all:
    I brought up linux-2.4.30 on PQ2FADS-VR board, everything was fine
untill i try to mount the jffs2.  My mtd partition looks like this:

dev:    size   erasesize  name
mtd0: 00800000 00040000 "Flash SIMM"
mtd1: 00080000 00040000 "u-boot"
mtd2: 00100000 00040000 "Kernel"
mtd3: 00580000 00040000 "Rootfs"
mtd4: 00080000 00040000 "u-boot env"
mtd5: 00080000 00040000 "unused"

Basically, I tried
"eraseall /dev/mtd3", and then
"mount -t jffs2 /dev/mtdblock3 /mnt", it showed as mounted, then I
issued "echo "hello,world" > test.txt" to create a file,
a warning was printed out
"Node totlen on flash (0x44000000) != totlen in node ref (0x00000044)"
, but subsequent
"cat test.txt " still showed the correct string from that newly created file".
However, after I umount the  file and remount it again, it give me
lots of errors"
Magic bitmask 0x1985 not found at 0x00240004: 0x0c00 instead"
Then the moutn operation failed.
    I am suspecting it is mtd driver problem (the board use
LH28F016SCT-L95 from sharp). But don't know how to proceed , e.g. how
to verify the content was written into flash in a mounted jffs2 file
system?
    Has anybody experienced similar issue? Any suggestion?
    Forgive me if this is wrong list to post, and very appreciate if
anybody can direct me to the right place.

Thanks!
lei
