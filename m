Message-ID: <38172075.EC2839C2@netx4.com>
Date: Wed, 27 Oct 1999 11:55:33 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: wung_y@263.net
CC: linux-ppc <linuxppc-dev@lists.linuxppc.org>,
        linuxppc embedded mail list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: What's MMU context?
References: <3816E6FD.481FA27D@263.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Wang Yong wrote:
> 
> as the source code of linuxPPC, there is a global variable named
> next_mmu_context which is increased by one at each time of create a new
> process. what does this mean and what is mmu context?


I intened to use it on the 8xx processors, as they have an address
space id that allows a TLB optimization so you don't have to
invalidate the entire TLB on context switches.  I assume the
MIPS folks use it as well, since that is where I first used
such an optimization (in an OS other than Linux).  Unfortunately,
the ratio of entries to ASIDs is wrong for my original MIPS-like
algorithm to work, and I never got around to writing something
new.

This was already part of the Linux/PPC port when I started the 8xx
work, and I don't know if other processors use it or if it was
just part of the generic port that was maintained.


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
