Date: Mon, 22 Nov 1999 15:06:53 -0700
From: Cort Dougan <cort@fsmlabs.com>
To: Benjamin Herrenschmidt <bh40@calva.net>
Cc: linuxppc-dev@lists.linuxppc.org, paulus@linuxcare.com
Subject: Re: bootloader & head.S weirdness (patch)
Message-ID: <19991122150653.A13066@hq.fsmlabs.com>
References: <19991122124702.006073@mailhost.mipsys.com> <19991122180721.017837@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <19991122180721.017837@mailhost.mipsys.com>; from Benjamin Herrenschmidt on Mon, Nov 22, 1999 at 06:07:21PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I applied the patch (with some changes necessary to get it into
2.2.14pre7).  It breaks pmac netboot during the jump from
__secondary_stat() to clear_bats().  There must be some I mappings we need
to preserve in order to get to non-pc relative code.  It's worth noting
that OF loads us and gives us mappings for 0xc000000 since that's where
we're linked at.  BootX and Quik don't do that so that's probably why they
work.  Netboot is really useful so I'd prefer to not break it (definitely
not in 2.2).  Any ideas for workarounds?

Chrp and prep netboot works fine.  Boot via quik on chrp works, too.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
