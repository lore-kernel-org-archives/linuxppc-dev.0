Message-ID: <378B1D0F.2B0D8A67@agelectronics.co.uk>
Date: Tue, 13 Jul 1999 12:03:43 +0100
From: Adrian Cox <apc@agelectronics.co.uk>
MIME-Version: 1.0
To: LinuxPPC-Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Assumption in drivers/char/serial.c
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


While porting Linux to my embedded system, I've come across an
unfortunate assumption in the standard serial driver. The change_speed
routine casts the  port address of the uart from an int to a unsigned
short, then compares it to zero. This means that the uart code will not
work on systems where the uart is mapped with a 64K alignment. As my
uart is not on an ISA bus, it isn't within the ISA address range. In
fact, my uart is at an IO address of 128k.

The patch below (against 2.2.10 from the CVS) compares all 32-bits of
the uart address with zero, instead of just the least significant 16.
Can anybody think of any systems where the uart being at a 64k aligned
address is a significant error condition (and if so, isn't change_speed
a bit late to detect it)?

- Adrian Cox, AG Electronics

--- linuxppc-2.2.10/drivers/char/serial.c       Wed Mar 24 01:01:17 1999
+++ linux/drivers/char/serial.c Tue Jul 13 11:41:41 1999
@@ -1236,7 +1236,6 @@
 static void change_speed(struct async_struct *info,
                         struct termios *old_termios)
 {
-       unsigned short port;
        int     quot = 0, baud_base, baud;
        unsigned cflag, cval, fcr = 0;
        int     bits;
@@ -1245,7 +1244,7 @@
        if (!info->tty || !info->tty->termios)
                return;
        cflag = info->tty->termios->c_cflag;
-       if (!(port = info->port))
+        if (! info->port)
                return;

        /* byte size and parity */

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
