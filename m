Date: Thu, 27 Sep 2001 00:55:41 +0200
From: Stefan Pfetzing <dreamind@dreamind.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: Dmasound for iBook2
Message-ID: <20010927005541.A10663@server>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="LQksG6bCIzRHxTLp"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

i recently tested the Dmasound patch for the ibook2, which is now in benh's
tree. I noticed that the volume got really loud even if at approx 10%...
Hope this little patch solves that, for me it does.

bye

dreamind

--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmasound_for_ibook2_volume_fix.patch"

diff -urN linux-benh.orig/drivers/sound/dmasound/tas3001c.c linux-benh/drivers/sound/dmasound/tas3001c.c
--- linux-benh.orig/drivers/sound/dmasound/tas3001c.c	Mon Sep 24 22:24:31 2001
+++ linux-benh/drivers/sound/dmasound/tas3001c.c	Tue Sep 25 02:09:10 2001
@@ -52,11 +52,13 @@
 #define VOL_MAX ((1<<20) - 1)

 void tumbler_get_volume(uint * left_vol, uint  *right_vol) {
-  *left_vol = cur_left_vol>>4;
-  *right_vol = cur_right_vol>>4;
+  *left_vol = cur_left_vol;
+  *right_vol = cur_right_vol;
 }

 int tumbler_set_volume(uint left_vol, uint right_vol) {
+  uint left_vol_pers = left_vol;
+  uint right_vol_pers = right_vol;
   unsigned char block[6];

   if (! tumbler_client) {
@@ -64,8 +66,11 @@
     return -1;
   }

-  left_vol<<=4;
-  right_vol<<=4;
+  left_vol>>=6;
+  right_vol>>=6;
+
+  left_vol*=left_vol;
+  right_vol*=right_vol;

   if (left_vol > VOL_MAX)
     left_vol = VOL_MAX;
@@ -85,8 +90,8 @@
     printk("tumbler: failed to set volume \n");
     return -1;
   } else {
-    cur_left_vol = left_vol;
-    cur_right_vol = right_vol;
+    cur_left_vol = left_vol_pers;
+    cur_right_vol = right_vol_pers;
   }

   return 0;

--LQksG6bCIzRHxTLp--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
