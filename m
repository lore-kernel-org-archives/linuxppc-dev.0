Message-ID: <20030429214955.47605.qmail@web40909.mail.yahoo.com>
Date: Tue, 29 Apr 2003 14:49:55 -0700 (PDT)
From: Brian Kuschak <bkuschak@yahoo.com>
Subject: Re: console not responding on walnut 405gp
To: Darin.Johnson@nokia.com, linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <F0B628F30F48064289D8CCC1EE21B7A80C486F@mvebe001.americas.nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Darin,

/sbin/init may need to be patched and rebuilt.  CREAD
flag is required for linux kernels > 2.4.3.

Regards,
Brian

--- init.c.old     Sat Jan 13 02:45:33 2001
+++ init.c         Sat Mar  8 11:45:20 2003
@@ -684,7 +684,7 @@
                (void) tcgetattr(fd, &tty);

                tty.c_cflag &=
CBAUD|CBAUDEX|CSIZE|CSTOPB|PARENB|PARODD;
-               tty.c_cflag |= HUPCL|CLOCAL;
+               tty.c_cflag |= HUPCL|CLOCAL|CREAD;

                tty.c_cc[VINTR]  = 3;   /* ctrl('c')
*/
                tty.c_cc[VQUIT]  = 28;  /* ctrl('\\')
*/


--- Darin.Johnson@nokia.com wrote:
>
> After booting up on a walnut 405gp board, the
> console prints
> the shell prompt, but does not respond to input.
> This works
> ok when I used an older hardhat 1.2 release, but is
> failing
> when I try to use something newer.  I can telnet in
> to the
> system, and can send output to /dev/console or
> /dev/ttyS0,
> and I can even open up a shell on /dev/ttyS1.  Thus
> the uart
> code appears to be correct.  Terminal flow control
> is turned
> off.  Other hints from the mail archives didn't
> provide any
> leads.
>
> The relevant line from inittab is
>    /bin/sh < /dev/console > /dev/console 2>
> /dev/console
>
> This problem occurs with kernel 2.4.21-pre6 (via
> linuxppc-2.4-devel) and 2.4.20-2002-12-04 (from
> ftp.denx.de).
>
> Darin Johnson
>
>


The New Yahoo! Search - Faster. Easier. Bingo.
http://search.yahoo.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
