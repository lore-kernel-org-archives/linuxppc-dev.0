Date: Tue, 16 Jan 2001 04:17:43 +0100
From: Olaf Hering <olh@suse.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: up_read/up_write redefinitions in asm/semaphore.h and linux/usbdevice_fs.h
Message-ID: <20010116041743.A9315@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I have some redefinitions when I compile usbdevfs:

gcc -D__KERNEL__ -I/usr/src/linux-2.4.0.SuSE/include -Wall
-Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing
-D__powerpc__ -fsigned-char -msoft-float -pipe -ffixed-r2
-Wno-uninitialized -mmultiple -mstring    -c -o inode.o inode.c
In file included from inode.c:41:
/usr/src/linux-2.4.0.SuSE/include/linux/usbdevice_fs.h:173: warning:
`up_read' redefined
/usr/src/linux-2.4.0.SuSE/include/asm/semaphore.h:186: warning: this is
the location of the previous definition
/usr/src/linux-2.4.0.SuSE/include/linux/usbdevice_fs.h:174: warning:
`up_write' redefined


We had this patch in the linuxppc_2_3 tree:

diff -urN linux-2.4.0-ac4/include/linux/usbdevice_fs.h
linux-2.4.0-ac4-ppc/include/linux/usbdevice_fs.h
--- linux-2.4.0-ac4/include/linux/usbdevice_fs.h        Thu Jan  4
23:52:32 2001
+++ linux-2.4.0-ac4-ppc/include/linux/usbdevice_fs.h    Mon Jan  8
10:44:29 2001
@@ -166,13 +166,14 @@
  * sigh. rwsemaphores do not (yet) work from modules
  */

+#if 0
 #define rw_semaphore semaphore
 #define init_rwsem init_MUTEX
 #define down_read down
 #define down_write down
 #define up_read up
 #define up_write up
-
+#endif

 struct dev_state {
        struct list_head list;      /* state list */


It is gone in linuxppc_2_4 tree.

The USB layer should proably not use these generic names.
How can we fix that?



Gruss Olaf

--
 $ man clone

BUGS
       Main feature not yet implemented...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
