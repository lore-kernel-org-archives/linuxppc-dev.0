Message-ID: <37C56A75.95058049@wanadoo.fr>
Date: Thu, 26 Aug 1999 18:25:25 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: vger-2.3.15 and ADB_MOUSE
References: <37C4FD7C.BBEC0F1@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Trying to make the vger kernel 2.3.15 work on my Pmac 6400, I found how
to make my screen work and how to make the kernel read the partition map
on my HDs (see my previous post). So now it boots.

It does not, however, start a driver for my adb-mouse. Therefore gpm and
also X don't work. Does anyone know if this is a configuration problem
or is it known that the adbmouse driver is still broken in 2.3.15?

I had to patch drivers/char/Makefile in order to compile
drivers/char/busmouse. otherwise there were undefined symbols (see patch
below).

The other thing I can see is seriously broken is hfs. But there I guess
we'll have to wait until Adrian Sun finishes his thesis :-) Anyway, I
was pleasantly surprised to see that hfsutils work without hfs support
compiled into the kernel. So I was able to hcopy -r vmlinux to my MacOS
system folder and reboot with BootX without first passing by an older
kernel.

--
Martin
Index: drivers/char/Makefile
===================================================================
RCS file: /cvs/linux/linux/drivers/char/Makefile,v
retrieving revision 1.98
diff -u -r1.98 Makefile
--- drivers/char/Makefile       1999/08/08 01:35:10     1.98
+++ drivers/char/Makefile       1999/08/25 18:49:37
@@ -198,11 +198,11 @@
   endif
 endif
 
-ifeq ($(CONFIG_MOUSE),y)
+ifeq ($(CONFIG_BUSMOUSE),y)
 M = y
 OX_OBJS += busmouse.o
 else
-  ifeq ($(CONFIG_MOUSE),m)
+  ifeq ($(CONFIG_BUSMOUSE),m)
   MM = m
   MX_OBJS += busmouse.o
   endif

===================================================================

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
