Message-ID: <20001106032750.5523.qmail@kunk.jriver.com>
Subject: controlfb and X
To: linuxppc-dev@lists.linuxppc.org
Date: Sun, 5 Nov 2000 21:27:50 -0600 (CST)
From: Robert E Brose II <bob@kunk.jriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've been doing some testing of the controlfb driver in the
2.2.17 tree as well as the 2.4.0-test10 paulus tree.

The problem is that the controlfb driver doesn't recognize more than
2 megs of vram. This particular Mac 7500 has 4 megs installed which
works perfectly in MacOS.

With 2.2.18pre18, 2 megs only is available. Running XFree86-3.3.6-11.2
on the Mac 7500 will do 800x600 in 24 bits as expected and 1024x768 in
16 bits but not 1024x768 in 24 bits (not enough ram).

With 2.4.0-test10 (which includes dma and parameter line changes in
controlfb) forcing the video ram to 4 megs works fine for console
modes (for example vmode 17 32) HOWEVER when the XF86_FBdev server
is run it locks up the machine with a black screen of death. (not
pingable, keyboard is dead, etc).
Also, building my own Xfree 4.01 server results in the same black
screen of death.
OTOH Xpmac rev 10 works fine (but doesn't support serial mice AFAIK).

I'm assuming the problem is in the dma code added to controlfb.c in the
2.4.x version. Has anyone run into this or had different results?

Bob
--
Robert E. Brose II    N0QBJ
http://www.jriver.com/~bob/
bob@kunk.jriver.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
