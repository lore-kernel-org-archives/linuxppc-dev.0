Message-Id: <4.2.0.58.20001104202814.009b7180@pplus.shell9.ba.best.com>
Date: Sat, 04 Nov 2000 20:50:20 -0800
To: linuxppc-dev@lists.linuxppc.org
From: Ron Avisa <ravisa@base2software.com>
Subject: MMU probs in head.S w/821
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hopefully someone's seen this show,

Trying to get linux up and running on an 821 on some custom hardware.
Got ppcboot all set up and happy, and thought linux should happily boot up
via bootm 2a000000.

The bootm code uncompresses and relocates linux nicely to 0x000000000
and then jumps to 0x0000000c. Board info is good, starts setting up the mmu,
sets up an entry for IMMR at recommended 0xF0000000, branches to
:turn_on_mmu, loads up 0xc00021b8 for return address and msr with MMU enabled,
hits the rfi and disappears only to show up with a machine exception at 0x220.

Strangely I did see it actually run once and was able to watch (via
vision-ice BDM) the
pc zip around 0xC000xxxx space values before finally crashing.

I've tried cutting out just the head.S section, making it standalone srec
format and using
the LOADS feature of ppcboot and then just running it. strangely enough the
code seems
to work when loaded at 0x0 (runs, jumps to infinite loop in virtual
0xc0002000). Though dies
when started from 0xC generating machine exceptions or just freezing.

At this point I'm wondering...
Vision-ICE BDM might be problematic?
821 has some strange MMU/cache problems (possibly related to alignment)?

Any ideas or suggestions?

Thanks,

Ron


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
