Message-ID: <3885E072.19105531@netx4.com>
Date: Wed, 19 Jan 2000 11:04:02 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Alan Mimms <alan@packetengines.com>
CC: Christer Weinigel <wingel@cendio.se>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: WARNING OFF TOPIC SLIGHTLY: 8xx MMU w/8MB pages
References: <200001181828.TAA23940@dumburk.cendio.se> <3884B779.25C15918@netx4.com> <0001181114300A.00752@alan.corp.packetengines.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Alan Mimms wrote:


> I would like to suggest that using one or two 512MB pages


That isn't what I would do.  You can map the entire kernel
instruction space with a single 8M entry.  You can map the
entire static data space with another 8M entry.  You can
map frequently used I/O with another 8M data entry.

You have to move the VM map so dynamically allocated data
doesn't overlap the 8M page.  You have to make sure dynamically
loaded modules don't overlap the 8M instruction map.  Or, make
sure they overlap entirely (either way is fine, just don't mix
it up).  You can modify the ioremap() functions to operate more
like they do on the processors with BATs.

All of these are likely to be useful in most applications.  They
don't require any Linux VM or TLB software changes.  All you
need to change are some #define configuration vaules in a couple
of VM/MMU header files and slightly change the MMU initialization.

Maybe I'll do this later today.....I have been thinking about it
long enough.



	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
