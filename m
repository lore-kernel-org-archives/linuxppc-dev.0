Message-ID: <40C020DC.9050607@iti.fi>
Date: Fri, 04 Jun 2004 10:12:28 +0300
From: Kate Alhola <kate@iti.fi>
MIME-Version: 1.0
To: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: fbdev_drv/xfree86 getting rid of /dev/tty0 console
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I try to use Xfree86 with fbdev_drv in embedded system and i got stuck
to "xf86OpenConsole: Cannot open /dev/tty0" or
"xf86OpenConsole: Cannot find a free VT" etc.

The problem is that the device is embedded ppc without any console at
all and least there won't never be
one in /dev/tty0 that is normally linked to serial port.

The problem is that /dev/tty0 looks a like to be hardcoded to
"xf86OpenConsole(void)" in xfree86 lnx_init.c and
it is called unconditionally from xf86Init.c . I have not found any
switch to switch console off from xfree86
config files. Also linkig /dev/tty to /dev/null or /dev/vcs0 etc does
not help, it just replaces
"can not open" error with "Cannot find a free VT".

I know that i  can hack xfree86 source and remove this dependency by
hand but it looks a like
not to be right or most elegant solution because i can't believe that i
am first one that tries to use
fbdev in embedded hw without any console.

The the linux distribution and filesystem is stantard eldk 3.0 ppc_82xx .

Kate

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
