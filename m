To: Alex Zeffertt <ajz@cambridgebroadband.com>
Cc: markc@mail.com,
	"linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Control-C in bash ??? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "14 Jan 2003 13:31:45 GMT."
             <1042551106.8605.109.camel@zambia>
Date: Tue, 14 Jan 2003 15:50:41 +0100
Message-Id: <20030114145047.03432C608E@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <1042551106.8605.109.camel@zambia> you wrote:
>
> I had exactly the same problem with ash (busybox version), but I found
> it went away when I replaced
>
> ttyS0::respawn:-/bin/sh
>
> in /etc/inittab with
>
> ttyS0::respawn:/sbin/login
>
> I have no idea why....

I explained this a couple of times before on the list:

Signal handling depends on a controlling tty. If you  start  a  shell
directly, you don't get one, so ^C will not work.

We modified the login in our ELDK a bit to assign a controlling  tty,
so any shell started from login will behave as expected.

This is all the magic that it takes:

-> cat /opt/eldk/build/target_rpms/util-linux/SOURCES/login-eldk.patch
--- util-linux-2.11f/login-utils/login.c.orig   Fri Jun 21 14:17:36 2002
+++ util-linux-2.11f/login-utils/login.c        Fri Jun 21 14:18:34 2002
@@ -259,6 +259,7 @@

     flags &= ~O_NONBLOCK;
     fcntl(fd, F_SETFL, flags);
+    ioctl(fd, TIOCSCTTY);

     for (i = 0 ; i < fd ; i++)
       close(i);


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"Free markets select for winning solutions."        - Eric S. Raymond

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
