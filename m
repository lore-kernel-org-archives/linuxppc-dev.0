Date: Sun, 17 Jan 1999 14:35:57 +0100
To: linuxppc-dev@lists.linuxppc.org, Paul Mackerras <paulus@cs.anu.edu.au>
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: wrong termbits.h vs. tty_io.c
Message-Id: <19990117143557.001993@smtp.calvacom.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi !

During my explorations of the serial driver, I've discovered something
strange for which I would like your point of view:

It looks like the definitions here on PPC are just wrong and break
"normal" tty_io.c code of the kernel.

Specifically, here is the problem:

#define  B38400	0000017
#define EXTA B19200
#define EXTB B38400
#define CBAUDEX 0000020
#define  B57600   00020
#define  B115200  00021
#define  B230400  00022
#define  B460800  00023

This should be:

#define  B38400	0000017
#define EXTA B19200
#define EXTB B38400
#define CBAUDEX 0000020
#define  B57600   00021
#define  B115200  00022
#define  B230400  00023
#define  B460800  00024

Note that ((B57600 & CBAUD) & ~CBAUDEX) should be 1, not 0.

The current definition breaks the tty_get_baud_rate() function in
tty_io.c, which is called by other drivers, like serial.c (for PC-style
or PCMCIA serial ports). 
macserial.c uses it's own table that works, but it's not a solution.

The problem is that changing termbits requires recompiling userland apps too.

Currently, any serial driver other than macserial.c will use wrong speeds
if they are > than 38400.

I also suggest using hex instead of octal like sparc does ;-)


-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>




[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
