Date: Wed, 15 Mar 2000 18:25:55 -0800 (PST)
From: "David A. Gatwood" <dgatwood@deepspace.mklinux.org>
To: "Peter M. Jansson" <petej@clickvision.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: SIGALRM can't be delivered after longjmp from handler?
In-Reply-To: <Pine.LNX.4.10.10003152106550.9912-100000@penguin.office.clickvision.com>
Message-ID: <Pine.LNX.3.96.1000315182151.32684H-100000@deepspace.mklinux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 15 Mar 2000, Peter M. Jansson wrote:

> Did that; no effect.

Well, it did for me, but I had to change the location of the signal()
line.  The installation of the signal handler has to occur before the
sigsetjmp or else the longjmp() restores an empty set of handlers.


1.  Move the if (signal(...)) line to right after the printf("Cycle...")
line

2.  Change setjmp(jmp_buf) to sigsetjmp(jmp_buf,1)

3.  Change longjmp to siglongjmp

4.  add a signal(...) line to the beginning of the signal handler

The program then works as it did on *BSD.


David


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
