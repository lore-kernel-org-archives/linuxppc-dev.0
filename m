Message-ID: <19990525024524.D26885@radicalmedia.com>
Date: Tue, 25 May 1999 02:45:24 -0400
From: Mark Abene <phiber@radicalmedia.com>
To: bh40@calva.net
Cc: linuxppc-dev@lists.linuxppc.org
Subject: turbo mouse driver fix...
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hey!  Please test the following patch to mac_keyb.c which fixes the TurboMouse
support you added based on my "mousehack" program.  I tested my changes on a
2.2.7 kernel.  The problem is that once you determine we are working with a
TurboMouse 5 (thanks for adding the reg 1 ID detection, btw!), we need to write
to id 3, which is how you control the TurboMouse 5's modes, not to id 15.
Observe:

--- mac_keyb.c.orig     Tue May 25 02:07:29 1999
+++ mac_keyb.c  Tue May 25 02:25:36 1999
@@ -908,13 +908,10 @@
 
        adb_request(&req, NULL, ADBREQ_SYNC, 1, ADB_FLUSH(id));
 
-       adb_request(&req, NULL, ADBREQ_SYNC, 3,
-               ADB_WRITEREG(id,3), 0x20 | id, 4);
-
-       adb_request(&req, NULL, ADBREQ_SYNC, 1, ADB_FLUSH(id));
+       adb_request(&req, NULL, ADBREQ_SYNC, 1, ADB_FLUSH(3));
 
        adb_request(&req, NULL, ADBREQ_SYNC, 9,
-       ADB_WRITEREG(id,2),
+       ADB_WRITEREG(3,2),
            0xe7,
            0x8c,
            0,
@@ -924,10 +921,10 @@
            0xff,
            0x94);
 
-       adb_request(&req, NULL, ADBREQ_SYNC, 1, ADB_FLUSH(id));
+       adb_request(&req, NULL, ADBREQ_SYNC, 1, ADB_FLUSH(3));
 
        adb_request(&req, NULL, ADBREQ_SYNC, 9,
-       ADB_WRITEREG(id,2),
+       ADB_WRITEREG(3,2),
            0xa5,
            0x14,
            0,


That should work fine.  If it does for everyone else, it should be committed!

-Mark


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
