In-Reply-To: <19990117143557.001993>
Date: Sun, 17 Jan 1999 16:28:19 +0100
To: linuxppc-dev@lists.linuxppc.org, Paul Mackerras <paulus@cs.anu.edu.au>,
        Cort Dougan <cort@ladron.cs.nmt.edu>, dgatwood@globegate.utm.edu
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: wrong termbits.h vs. tty_io.c
Message-Id: <19990117162819.018616@smtp.calvacom.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Jan 17, 1999, Benjamin Herrenschmidt <bh40@calva.net> wrote:


>The current definition breaks the tty_get_baud_rate() function in tty_io.c,
>which is called by other drivers, like serial.c (for PC-style or PCMCIA
serial
>ports). 
>macserial.c uses it's own table that works, but it's not a solution.
>
>The problem is that changing termbits requires recompiling userland apps too.
>
>Currently, any serial driver other than macserial.c will use wrong speeds if
>they are > than 38400.
>
>I also suggest using hex instead of octal like sparc does ;-)

I've looked at other archs and I think the problem is actually

#define CBAUDEX 0000020

should be

#define CBAUDEX 0000000

It looks like PPC constants come from alpha, which use the same linear
range of (octal ;-) values. But alpha defines CBAUDEX to 0, which makes
it work since this way, tty_get_baud_rate will _not_ go to the special
case of masking CBAUDEX out and adding 15 to the resulting index when
it's between 1 and 4. With CBAUDEX defined to be 0, things should work fine.

So we can:

 - Add a special PPC case to tty_io.c but this is bad, I think.

 - Keep CBAUDEX and change the B57600 to B460800 constants, but this will
break existing userland apps and is finally not the best solution.

 - fix CBAUDEX to be 0. This should hopefully not break userland apps
since the curent bit defined for CBAUDEX is already set in the "high"
baudrate values. Except if I missed something else, I only looked at the
kernel side of things.
 
So, except if I missed something, the correct fix is to change :

--- linux.orig/include/asm-ppc/termbits.h
+++ linux.dev/include/asm-ppc/termbits.h
@@ -122,5 +122,5 @@
#define EXTA B19200
#define EXTB B38400
-#define CBAUDEX 0000020
+#define CBAUDEX 0000000
#define  B57600   00020
#define  B115200  00021

Finally, note that the problem is also in MkLinux.

-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>




[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
