Date: Wed, 22 Jan 2003 15:17:12 +0530
From: Chirag Kantharia <kantharia@hathway.com>
To: Prakash kanthi <pkanthi@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux Kernel hangs after execve("/bin/sh")
Message-ID: <20030122094712.GA5406@timesys.com>
Reply-To: Chirag Kantharia <kantharia@hathway.com>
References: <20030122055708.ED27DC608E@atlas.denx.de> <20030122091532.1705.qmail@web41202.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030122091532.1705.qmail@web41202.mail.yahoo.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Jan 22, 2003 at 01:15:32AM -0800, Prakash kanthi wrote:
| I wrote a small standalone program hello.c to test, if
| i can dynamically load it from init() instead of
| loading /bin/sh. I compiled the program added it to my
| ramdisk and called from init(). Following is the
| output. You can see that, it did all of it that it did
| for /bin/sh and also tried to open /etc/ld.so.preload
| and /etc/ld.so.cache and failed. But again towards the
| end, it tries to open /lib/libc.so.6 and succeds but
| still no output is displayed that hello.c is trying to
| print.

Quite sometime back, I had run into similar problem. init=/bin/bash
would not work, but init=/bin/helloworld would work. Later, I realized
that the board did not have FPU, and I had to pass relevant flags to
glibc, while compilation. The same might be the case with your board.

--
Chirag Kantharia, symonds.net/~chyrag/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
