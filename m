Message-ID: <38E665E2.6AC1353F@wanadoo.fr>
Date: Sat, 01 Apr 2000 23:10:58 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: [BUG] macmodes.c in 2.3.99-pre3-pre8
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Starting from about a week ago, the 2.3.99 bitkeeper kernels screw up
the colors in Xpmac, making it unusable (8-bit color, valkyriefb
driver). XF_FBDev is working fine.

I tracked this down to what I think is a typo in the big code crossover
from offb.c to macmodes.c. In any case, the following patch fixes the
problem for me:

-- drivers/video/macmodes.c.ori	Sat Mar 25 08:25:22 2000
+++ drivers/video/macmodes.c	Sat Apr  1 22:08:08 2000
@@ -271,7 +271,7 @@
         n = n_entries - i;
         if (n > 16)
             n = 16;
-        palette_cmap.start = 1;
+        palette_cmap.start = i;
         palette_cmap.len = n;

         for (j = 0; j < n; j++) {

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
