Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: "Elan Feingold" <elan@nxnetworks.com>
To: "Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Linux 2.4.4 on 860 custom board
Date: Fri, 24 Aug 2001 15:46:07 -0500
Message-ID: <NDBBLJKOJGKDOFBHNPGEMEIICEAA.elan@nxnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I'm still trying to get Wolfgang's Linux 2.4.4 to come up on my custom 860
board.  I started with a bootrom that normally boots VxWorks, so I thought
I'd have no problem.  The IMMR is at the right place (0xff000000), and in
general the kernel boots up fine, but it dies with a "kernel access of bad
area" where the actual address is question is usually strange (e.g.
0x40000004, or 0x00000004).  It seems like it dies when it's trying to
access data, either kmalloc()ed or static, and it's never consistent where
it dies.  Sometimes it's inside a printk() where the print is trying to
print out some member of some structure.  And sometimes it does until it
mounts my root file system via NFS and then does the same oops down in the
NFS code.  Generally just very flaky!

I'd usually think it was a memory timing setup problem, right?  But VxWorks
runs fine, and has for years on the board.

Any ideas?  Is it possible that VxWorks just has less strict timing
requirements to run?

Best regards,

-elan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
