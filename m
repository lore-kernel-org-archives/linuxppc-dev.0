Message-ID: <3B72C2C8.F8685834@mvista.com>
Date: Thu, 09 Aug 2001 10:05:12 -0700
From: Scott Anderson <scott_anderson@mvista.com>
MIME-Version: 1.0
To: Joe Green <jgreen@mvista.com>
Cc: Michael Fischer <fischi@epygi.de>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Memory optimization of diskless system
References: <OEEHJMIIDJHHMFGGDNGDCEPACEAA.fischi@epygi.de> <01080909352601.18546@minotaur.mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Joe Green wrote:
> How big is you ramdisk?  That's included in the buffers.

and unfortunately, the kernel thinks the ramdisk buffers can be freed
up to make more room, but of course, they can't be freed (the data in
them has no place to go).  I've seen this cause the system to deadlock
under 2.2.  Under 2.4 I would assume the out of memory killer would
get invoked.

Gory details:
mm/mmap.c:vm_enough_memory() assumes that all buffermem_pages can be
freed up to make more space, drivers/block/rd.c:rd_make_request() marks
buffers as protected, and kswapd calls do_try_to_free_pages which calls
page_launder which calls fs/buffer.c:try_to_free_buffers() to try to get
more space, but try_to_free_buffers refuses to free busy (dirty, locked
or protected) buffers.

In my opinion, the fix is to teach vm_enough_memory() that protected
buffers can't be freed up.  Fixing this is one of those things I hope
to get around to; unless of course, someone else fixes it first.

    Scott Anderson
    scott_anderson@mvista.com   MontaVista Software Inc.
    (408)328-9214               1237 East Arques Ave.
    http://www.mvista.com       Sunnyvale, CA  94085

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
