Date: Fri, 29 Jan 1999 00:02:52 -0500 (EST)
From: Hollis R Blanchard <hollis+@andrew.cmu.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: getopt (__USE_POSIX2?)
Message-ID: <Pine.LNX.3.96L.990128235558.6379F-100000@unix48.andrew.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi. I went to compile Mixer.app (a dockable app for WindowMaker) just now, and
I got the error that getopt was implicitly declared, and optarg was an
undeclared variable.

With a little digging, 'man 3 getopt' found that both the function and the
variable live in unistd.h, which was not included in the (single) source file.
So, happy to have found the problem, I included <unistd.h>, and promptly got
the same error.

I opened up /usr/include/unistd.h, and found the "missing" declarations fine,
but noticed that they were declared inside an '#ifdef  __USE_POSIX2' block.

Now:
What do I do about this? Apparently __USE_POSIX2 isn't defined, so those
things aren't getting declared. Can/should I #define __USE_POSIX2 in Mixer.h
(there are two files, .h and .cc)? That seems very hackish. The Makefile was
generated with xmkmf (and thus imake) - should I be passing some arguments to
xmkmf that will define it?

This is with:
egcs-1.0-2e
egcs-as-gcc-1.0-2e
egcs-c++-1.0-2e
egcs-objc-1.0-2e

-Hollis


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
