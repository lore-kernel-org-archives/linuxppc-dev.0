Date: Fri, 18 Aug 2000 01:33:41 -0400 (EDT)
From: mberglund <matt@realestatesafari.com>
To: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Kernel compile errors in latest snap
Message-ID: <Pine.LNX.4.21.0008180131200.1723-100000@europa.rcinfo.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Howdy guys, writing from sunny central florida.

I'm trying to use the development kernel linuxppc_2_3.snap.tar.gz from
fsmlabs from Aug 17 (the time stamp was about 6:59am our time). This is on
a pmac 7200 which is running linuxppc 2000 and has had no real problems.

The issue: Upon compiling the kernel we found some errors, one of which
Chris (guy I work with) patched. The other is way outta my league. Where
should mac_keyb.c be compiled from within the build?

These are the errors and from where that function is referenced.

drivers/input/inputdrv.o: In function `keyboard_input':
drivers/input/inputdrv.o(.text+0x6c): undefined reference to
`input_keycode'
drivers/input/inputdrv.o(.text+0x6c): relocation truncated to
fit: R_PPC_REL24 input_keycode
drivers/input/inputdrv.o(.text+0x98): undefined reference to
`input_keycode'
drivers/input/inputdrv.o(.text+0x98): relocation truncated to
fit: R_PPC_REL24 input_keycode
make: *** [vmlinux] Error 1

[root@ linuxppc_2_3]# grep -r input_keycode drivers
drivers/macintosh/mac_keyb.c:static void input_keycode(int, int);
drivers/macintosh/mac_keyb.c:   input_keycode(data[1], 0);
drivers/macintosh/mac_keyb.c:           input_keycode(data[2], 0);
drivers/macintosh/mac_keyb.c:input_keycode(int keycode, int repeat)
drivers/macintosh/mac_keyb.c:   input_keycode(last_keycode, 1);
drivers/input/adbhid.c:static void adbhid_input_keycode(int, int, int);
drivers/input/adbhid.c: input_keycode(id, data[1], 0);
drivers/input/adbhid.c:         input_keycode(id, data[2], 0);
drivers/input/adbhid.c:adbhid_input_keycode(int id, int keycode, int
repeat)
Binary file drivers/input/adbhid.o matches
Binary file drivers/input/inputdrv.o matches

Thanks for any help,
Matt

diff:

-ur linuxppc_2_3.orig/drivers/macintosh/via-cuda.c linuxppc_2_3/drivers/macintosh/via-cuda.c
--- linuxppc_2_3.orig/drivers/macintosh/via-cuda.c	Thu Aug 17 02:46:34 2000
+++ linuxppc_2_3/drivers/macintosh/via-cuda.c	Thu Aug 17 10:57:10 2000
@@ -121,7 +121,7 @@
 };

 #ifdef CONFIG_PPC
-void
+int
 find_via_cuda()
 {
     vias = find_devices("via-cuda");
@@ -152,6 +152,8 @@

     cuda_state = idle;
     sys_ctrler = SYS_CTRLER_CUDA;
+
+    return 1;
 }
 #endif /* CONFIG_PPC */

diff:


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
