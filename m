Date: Sat, 10 Nov 2001 18:57:47 -0500
From: Joseph Manojlovich <manojlov@cse.psu.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: Gxt2000p Patch
Message-ID: <20011110185747.D28196@cardassian.cse.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Here's the patch which I think fixes the video card issues I described
in my last email.

Joe Manojlovich
manojlov@cse.psu.edu

--- linuxppc/drivers/video/offb.c	Sat Nov 10 18:04:42 2001
+++ offb.c	Sat Nov 10 18:43:36 2001
@@ -393,7 +393,8 @@
     unsigned long res_size = pitch*height*depth/8;

     if (!request_mem_region(res_start, res_size, "offb"))
-	return;
+		if (!(dp && device_is_compatible(dp, "pci1014,b7")))
+        	return;

     printk(KERN_INFO "Using unsupported %dx%d %s at %lx, depth=%d, pitch=%d\n",
 	   width, height, name, address, depth, pitch);

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
