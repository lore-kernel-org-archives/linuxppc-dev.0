Date: Fri, 8 Dec 2000 18:40:24 +0100
From: Andi Kleen <ak@suse.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: [PATCH] Make ibook open console without options
Message-ID: <20001208184024.A23357@gruyere.muc.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


The following patch against linux-pmac-stable allows an ibook to open the initial
console without any command line options. It fixes a trivial bug.


-Andi



--- linux-pmac-stable/drivers/video/aty128fb.c-o	Tue Oct 31 03:05:34 2000
+++ linux-pmac-stable/drivers/video/aty128fb.c	Thu Feb 11 09:08:39 1904
@@ -1753,12 +1766,15 @@

 #ifdef CONFIG_FB_OF
 	/* New iBook */
-	if (machine_is_compatible("PowerBook2,2"))
+	if (machine_is_compatible("PowerBook2,2")) {
+		mac_vmode_to_var(VMODE_800_600_60, default_cmode, &var);
 		default_vmode = VMODE_800_600_60;
+	}
     } else {
 	if (mac_vmode_to_var(default_vmode, default_cmode, &var))
 	    var = default_var;
     }
+
 #endif /* CONFIG_FB_OF */


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
