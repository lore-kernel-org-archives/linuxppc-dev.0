Date: Mon, 14 Aug 2000 20:04:08 -0700 (PDT)
From: howarth@bromo.med.uc.edu (Jack Howarth)
Message-Id: <200008150304.UAA31773@bromo.med.uc.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: bk 2.4-test7 broken
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,
    There are several problems with the current bitkeeper unstable
kernel tree. The first two our compilation problems which can be
fixed if someone with write access to bitkeeper will submit these
two patches...

--- linuxppc_2_3/drivers/input/adbhid.c.org	Mon Aug 14 22:59:01 2000
+++ linuxppc_2_3/drivers/input/adbhid.c	Mon Aug 14 22:59:36 2000
@@ -129,9 +129,9 @@
 	if (nb != 3 || (data[0] & 3) != KEYB_KEYREG)
 		return;		/* ignore it */
 	kbd_pt_regs = regs;
-	input_keycode(id, data[1], 0);
+	adbhid_input_keycode(id, data[1], 0);
 	if (!(data[2] == 0xff || (data[2] == 0x7f && data[1] == 0x7f)))
-		input_keycode(id, data[2], 0);
+		adbhid_input_keycode(id, data[2], 0);
 }

 static void



--- linuxppc_2_3/include/asm-ppc/fcntl.h.org	Mon Aug 14 22:54:35 2000
+++ linuxppc_2_3/include/asm-ppc/fcntl.h	Mon Aug 14 22:55:56 2000
@@ -35,6 +35,10 @@
 #define F_SETSIG	10	/*  for sockets. */
 #define F_GETSIG	11	/*  for sockets. */

+#define F_GETLK64	12	/*  using 'struct flock64' */
+#define F_SETLK64	13
+#define F_SETLKW64	14
+
 /* for F_[GET|SET]FL */
 #define FD_CLOEXEC	1	/* actually anything with low bit set goes */

@@ -66,6 +70,14 @@
 	off_t l_start;
 	off_t l_len;
 	pid_t l_pid;
+};
+
+struct flock64 {
+	short  l_type;
+	short  l_whence;
+	loff_t l_start;
+	loff_t l_len;
+	pid_t  l_pid;
 };

 #endif

The third problem is more serious. The resulting kernel gets stuck in
the Freeing unused kernel memory stage. This is similar to the problem
Geert mentioned earlier on the mailing list.

http://lists.linuxppc.org/listarcs/linuxppc-dev/200008/msg00094.html

Unfortunately Geert's purposed patch doesn't solve the problem.
                                 Jack

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
