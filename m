Message-ID: <7283DE19D141D111AD0E00A0C95B195502C5F5F2@mail2.aiinet.com>
From: "Whitney, John" <johnw@aiinet.com>
To: "'linuxppc-embedded@lists.linuxppc.org'"
	 <linuxppc-embedded@lists.linuxppc.org>
Subject: Image caching/swap bugs
Date: Mon, 26 Jun 2000 17:16:55 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Given the following situation, I am seeing my embedded linux system on an
MPC860 crash and was
wondering if anyone else has experienced the same problem (and possibly have
a fix):

I have a 2.2.15 kernel running on a proprietary board with 32MB of RAM.  The
image includes a 16MB
ramdisk distribution I have created from scratch.  Periodically, after
uploading a new 4MB image to the
running system (via FTP), and burning into onboard flash, the system would
crash.

After looking into it, I found then when I started copying the image from
the ramdisk to flash, the kernel was caching
it in memory ("MemFree" went down, "Cached" went up).  When the kernel hit
the low freepages mark, kswapd was
kicked off to recover memory, and immediately thereafter the kernel crashed
(in various tasks, usually with
*NIP being 0x00000000).  (This is easily reproduced by copying the image to
/dev/null, eliminating the flash
driver as a suspect).

I eventually found out that something in try_to_swap_out() (mm/vmscan.c) was
causing this.  If I put an
immediate "return 0;" in this routine kswapd recovered nicely.  When the
routine was allowed to execute,
the kernel crashed.  I don't know if something is being incorrectly
overwritten in memory, or the kernel is
just flushing parts of different tasks' images and this isn't being handled
correctly.

I've noticed that if I ifdef out the "if (!pte_dirty(pte)) { ... }" section
of code in try_to_swap_out(), I again don't
crash.  Unfortunately, I am not (yet) a VM expert, so I am not sure what
this code is doing.

In the short term, I can prevent kswapd from attempting to swap out
processes (since I have no swap space
anyway) and run just fine, but it would be nice to have a "correct"
solution.  I just wanted to know if anyone
else had experienced this problem before I go delving into it (whenever I
get the time).

John Whitney
johnw@aiinet.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
