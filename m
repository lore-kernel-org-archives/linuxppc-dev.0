Message-ID: <3F0ACE50.90908@tataelxsi.co.in>
Date: Tue, 08 Jul 2003 19:29:44 +0530
From: "Omanakuttan" <omanakuttan@tataelxsi.co.in>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: ncurses problem in telnet/serial console.
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
We have developed a Brouter on mpc8260 running linux with ncurses CUI
for administrative tasks. ncurses
Requirement is that when the user telnet to the router or connect to the
serial port, the CUI should come up, and the usual telnet login prompt
should not come up.
libncurses.so.5 is the libray we use.
What I did is to modify the /etc/xinetd.d/telnet to our program. Our
telnet file now look like

[root@pandatel12 ~]# cat /mnt/bet_rd/etc/xinetd.d/telnet
# description: The telnet server serves telnet sessions; it uses \
#       unencrypted username/password pairs for authentication.
service telnet
{
         flags           = REUSE
         socket_type     = stream
         wait            = no
         user            = root
         #server         = /usr/sbin/in.telnetd
         server          = /bin/mdi
         log_on_failure  += USERID
         disable         = no
}
[root@pandatel12 ~]#
When we telnet to the port 23, the error we get it

[root@pandatel12 ~]# telnet 10.1.28.44
Trying 10.1.28.44...
Connected to 10.1.28.44 (10.1.28.44).
Escape character is '^]'.
Error opening terminal: vt100.
Connection closed by foreign host.
[root@pandatel12 ~]#

The code is

[root@pandatel12 ~/test]# cat ncursestest.c
#include <ncurses.h>
int main()
{
         initscr(); /* Start curses mode */
         printw("Hello World !!!"); /* Print Hello World */
         refresh(); /* Print it on to the real screen */
         getch(); /* Wait for user input */
         getch(); /* Wait for user input */
         getch(); /* Wait for user input */
         endwin(); /* End curses mode */
         return 0;
}
[root@pandatel12 ~/test]# gcc -o mdi -lncurses ncursestest.c
[root@pandatel12 ~/test]#


At the same time, if I login to the board (after changing telnet entry
to in.telnetd) and run the application, it works fine.
TERMINFO settings are in /etc/profile.

[root@pandatel12 ~]# cat /mnt/bet_rd/etc/profile
#!/bin/sh
export TERMINFO=/etc/terminfo

What can be the resaon for this error?

For serial I modified the /etc/inittab, but getting the same error. If I
can solve the first one, this can also be solved in similar lines I believe.

Thanks for your time,
Om.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
