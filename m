Date: Thu, 26 Oct 2000 01:27:21 +0000
From: nathan wagner <nw@granicus.if.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: can't get mouse working under latest devel
Message-ID: <20001026012721.A1812@granicus.if.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've rsynced and compiled the latest 2.4.0-test10 kernel from
penguinppc.org, but can't for the life of me get my trackpad working.

The hardware is a 500 MHz G3 Pismo powerbook.  If i plug in a usb mouse into
the back, it is detected and works fine.  So i'm thinking that there is
either a bug in the recent adb mouse code, or i have missed a module or
other compile option.

Also, i needed to modify the #includes in trackpad.c, evidently adb.h,
cuda.h, and adb_mouse.h aren't in <asm/*> with the latest kernels and are
now in <linux/*>.  Then the struct net_device changed a char * to a char[]
for the device name, so i had to change an assignment to a strcpy().

I can send a diff if desired.

The trackpad app, once compiled, claims that i don't have a trackpad.
However, the kernel detects one and sets a handler.  I've been reading the
mac device driver code, and see a couple of places were i could turn on
debugging and log the event bytes.

At any rate, i can recompile and/or post more info, but i'm not sure where
to begin.

There were a couple of problems compiling the 0.9.3 airport module as well,
but i got those fixed, and they aren't relevant to the mouse problem.

--
Chance is irrelevant.  We will succeed.  -- Seven of Nine

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
