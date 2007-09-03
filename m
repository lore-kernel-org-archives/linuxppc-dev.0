Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id 2752FDDE11
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  4 Sep 2007 00:59:49 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by protonic.prtnl (Postfix) with ESMTP id 0349229EC8
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  3 Sep 2007 16:28:30 +0200 (CEST)
Received: from protonic.prtnl ([127.0.0.1])
	by localhost (protonic [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 06023-10 for <linuxppc-embedded@ozlabs.org>;
	Mon,  3 Sep 2007 16:28:27 +0200 (CEST)
Received: from archvile.prtnl (archvile.prtnl [192.168.1.153])
	by protonic.prtnl (Postfix) with ESMTP id 3FDBE29EB9
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  3 Sep 2007 16:28:27 +0200 (CEST)
From: David Jander <david.jander@protonic.nl>
To: linuxppc-embedded@ozlabs.org
Subject: eraseblock-size independent flash rootfs
Date: Mon, 3 Sep 2007 16:32:12 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200709031632.13146.david.jander@protonic.nl>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi,

I have been looking for a practical way to build an embedded system with a 
root filesystem which can be modified file-by-file eventually (to apply small 
software patches for example), but is independent of flash attributes such as 
erase-block size (which happens to change sometimes from one production 
series to another without much notice, for instance S29GL256M11 with 64k 
blocks to S29GL256N90 with 128k blocks).

The problem with using plain jffs2 until now is that we cannot make one jffs2 
image for both hardware versions, since the image has to be generated 
specifying the erase-block size.

I am considering on using a read-only filesystem like squashfs or cramfs and, 
layered on top of it, a read-only filesystem like jffs2 for modifications.
The jffs2 partition could just start out as empty flash, so it doesn't matter 
much if the device has 64k erase-blocks or 128k eraseblocks... it just has to 
start at an 128k boundary.

I have to make the following choices and I am curious if anybody has something 
to tell against or in favour of any of them:

1.- Which read-only fs to use: squashfs or cramfs?
Squashfs seems newer and better performing, so I guess I'll go with that one.

2.- Which union-fs to use: unionfs, aufs or mini_fo?
Don't know which to choose. Unionfs is in latest -mm trees and also supports 
2.4 kernels (one of our products still runs on 2.4.xx), so chances are it 
gets part of the main tree some day... but aufs seems more popular, and many 
developers seem to switch from unionfs to aufs lately, but I don't seem to 
find much information about this.

Any suggestions are welcome.

Greetings,

-- 
David Jander
