Message-ID: <EFB813091B18D511BD3600508B644F820A617EBB@tx14exm06.ftw.mot.com>
From: Zajac Adam-AAZ004 <Adam.Zajac@motorola.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Question on the fs choice
Date: Tue, 11 May 2004 18:20:06 -0500
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

We've built a custom board based on MPC8540 that runs Linux OS and utilizes
compact flash card to store the kernel on a raw-data partition (read-only)
and root file system on an Ext2 partition (read-write). As Ext2 is not a
journaling FS, in case of any power failure the file system is not cleanly
unmounted and the fscheck complains upon a system start-up.
Also, sometimes the file system partition gets corrupted when we power-cycle
the card instead of shutting the system down gracefully (the card is build
to be "hot-swappable" so we test it on purpose).

I saw Wolfgang Denx's post discouraging any use of the CF cards for an
embedded platform where write operations are performed under power-failure
prone environment. Unfortunately, this is the reality we're facing on our
card.

I'm seeking some help with selecting the file system that would survive
power failure if the CF card didn't get damaged during a write cycle (we're
gonna perform a thorough testing to assess the severity of that issue).

I've seen some articles suggesting one of the journaling systems, like Ext3,
XFS or ReiserFS.

Has anybody successfully implemented any of these FS systems on an embedded
platform equipped with a compact flash card working as a main storage
medium?

Any help would be greatly appreciated.

Adam Zajac
Motorola Inc, Global Telecom Solutions Sector
5555 N Beach St, Mailstop 8E, Fort Worth, TX 76137-2794
Phone: (817) 245-7963


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
