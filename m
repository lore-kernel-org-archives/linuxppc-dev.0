Date: Mon, 1 Feb 1999 00:08:00 +0000 (GMT)
From: pdh@colonel-panic.com
To: linuxppc-dev@lists.linuxppc.org
Subject: MM problems with MBX
Message-ID: <Pine.LNX.4.04.9901312337110.814-100000@berserk.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



I seem to have a major memory management problem on my MBX821. I've hacked
around with it a bit to get the IDE running, and that all seems to work
fine. Unfortunately the kernel dies in grand style (trap 0300) when the
buffer cache grows to it's limit. I tried limiting the size of the buffer
cache by adding these lines into grow_buffers(), just before the call to
__get_free_page() :-

	if(buffermem >= 0x800000)
		try_to_free_pages(GFP_BUFFER);

Great improvement. Now I've successfully managed to copy 200MB from my NFS
mounted root to the mounted hard disk (using tar). The problem is that now
when anything that uses the full size of the buffer cache (as the copy
above) returns to the shell the kernel hangs with 'Bad emulation'. The
same thing happens if I malloc a large block of memory (say 24MB) which
would mean some pages would have to be freed from the page cache/buffer
cache. The 'Bad emulation' error seems to occur in a library, so I assume
the kernel has paged out the library, and is paging it back in wrongly,
indicating a problem with page cache ?

This is all without swap, but the results were identical when I added 128M
of swap and tried the tests again.

I'm new to kernel hacking so can some kind guru give me some pointers on
how I might try and nail this down.  8-)

TIA

	P.


System info:

MBX821, 48M RAM.

Kernel 2.2.0-pre8 (from CVS) with the new IRQ code from Dan's
embedded-2.2p7.

--
+---------------------------------------------------------------+
|  Peter Horton     -    software engineer    -     Linux 2.2.1 |
+---------------------------+-----------------------------------+
|  pdh@berserk.demon.co.uk  |  http://www.berserk.demon.co.uk   |
|  pdh@colonel-panic.com    |  http://www.colonel-panic.com     |
+---------------------------+-----------------------------------+



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
