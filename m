From: gopi@india.tejasnetworks.com
Date: Thu, 31 Jan 2002 20:58:58 +0000 (GMT)
To: linuxppc-dev@lists.linuxppc.org
Subject: why is tty->pgrp set to -1 for console?
In-Reply-To: <Pine.LNX.4.21.0201301141250.25516-100000@tn100build.india.tejasnetworks.com>
Message-ID: <Pine.LNX.4.21.0201312050570.1490-100000@tn100build.india.tejasnetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


hi..

  We had a problem that ctrl-c was not working on the console.  I
figured out that, ctrl-c was getting recognized as the 'intr' signal,
but the function isig (in drivers/char/n_tty.c) sends a signal only if
the tty->pgrp > 0.

  I have put a print stmt in this function and checked that the value
  is 'tty->pgrp = ffffffff' (which is -1).

  What is the correct procedure to follow to get around this problem
and get ctrl-c working on console?

thanx
gopi

following is the output of stty -a on the console
---------------------------------------------------------------------
speed 9600 baud; rows 0; columns 0; line = 0;
intr = ^C; quit = ^\; erase = ^?; kill = ^X; eof = ^D; eol = <undef>;
eol2 = <undef>; start = ^Q; stop = ^S; susp = ^Z; rprnt = ^R; werase =
^W;
lnext = ^V; flush = ^U; min = 1; time = 0;
-parenb -parodd cs8 hupcl -cstopb -cread clocal -crtscts
-ignbrk -brkint ignpar -parmrk -inpck -istrip -inlcr -igncr icrnl ixon -ixoff
-iuclc ixany -imaxbel
opost -olcuc -ocrnl onlcr -onocr -onlret -ofill -ofdel nl0 cr0 tab0 bs0 vt0 ff0
isig icanon -iexten echo -echoe -echok -echonl -noflsh -xcase -tostop echoprt
echoctl echoke
---------------------------------------------------------------------

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
