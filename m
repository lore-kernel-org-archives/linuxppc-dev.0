To: Brian Waite <waite@skycomputers.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: NFS root woes: No init found
References: <200212041635.31861.waite@skycomputers.com>
	<200212041711.04032.waite@skycomputers.com>
	<3DEE7FA8.7000908@bluewin.ch>
	<200212041730.00480.waite@skycomputers.com>
From: Roland Dreier <roland@topspin.com>
Date: 04 Dec 2002 14:49:30 -0800
In-Reply-To: <200212041730.00480.waite@skycomputers.com>
Message-ID: <523cpdbds5.fsf@topspin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>>>>> "Brian" == Brian Waite <waite@skycomputers.com> writes:

    Brian> I tried loading the ash shell statically linked., along
    Brian> with a dynamically linked bash. No executables seem to
    Brian> load. I have traced the execve call and it progresses as
    Brian> far as walking the format list to determine what format the
    Brian> file is in. After walking all the available formats, it
    Brian> can't find one and fails.

    Brian> Any thoughts? I see the packets getting revieved by the
    Brian> gt64260_eth driver and passed up to the higher layers. I
    Brian> also look at the various MIB counters and see no errant
    Brian> packets so I can't why NFS is so cranky.

This is just a wild guess, but maybe there is a data corruption
problem somewhere.  (Maybe cache-coherency?  I know the 74xx/gt64260
is a cache-coherent platform but maybe the snooping isn't wired up or
set up correctly??)

You could try printing out the data the kernel thinks it read for init
and compare it with what's actually on the disk.  (It seems likely it
will be different, since the kernel can't tell that it's an ELF file)

Just as a data point, we have had good success running Linux with NFS
root on both the Galileo Discovery eval board and our own custom board
(both used the Galileo internal ethernet).

Best,
  Roland

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
