From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: <paulus@samba.org>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: xmon over firewire on PPC
Date: Sat, 4 May 2002 19:55:06 +0100
Message-Id: <20020504185506.6940@smtp.wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ok, it's sorta working ;)

The UI of the client tool sucks, but i'm no good at termios , any
improvements welcome.

So basically, my rsync kernel has the necessary support in it as of
today (look at the bits in CONFIG_XMON_FW in arch/ppc/xmon/start.c),
and the client tool can be downloaded from
<http://penguinppc.org/~benh/firescope.tar.gz>

The protocol is a bit basic (pmu like ? :) and currently, xmon
don't like "losing" the link with firescope. That is, any xmon
output should properly reach firescope at any time, but if xmon
didn't have firescope attached when trying to _read_ (when
entered), then it will continue to either ADB or serial code
and will miss firewire completely. I will try to fix that one
of these days so that xmon can take input from all possible
sources at the same time.

To use the client tool, you need libraw1394 (available from
www.sourceforge.net/projects/libraw1394), this is the client
library for using the raw 1394 interface. You need to have the
ohci1394 module loaded on both machines, and the console machine
using firescope must have also raw1394 insmod'ed (so libraw1394
works) and /dev/raw1394 (c 171 0).

Now, what remains to do is some code to tweak the CPU reset
or EE lines so we can get force the jump to xmon remotely.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
