Message-ID: <3DF1018C.7080508@embeddededge.com>
Date: Fri, 06 Dec 2002 14:59:08 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: joakim.tjernlund@lumentis.se
Cc: Matt Porter <porter@cox.net>,
	Pantelis Antoniou <panto@intracom.gr>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Regarding consistent_alloc
References: <IGEFJKJNHJDCBKALBJLLOEJHFIAA.joakim.tjernlund@lumentis.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Joakim Tjernlund wrote:

> Yes and no, someone changed the m8xx_cpm_hostalloc() implementation and now
> it does not behave as it used to. Earlier both __pa(adr) and __va(__pa(adr))
> worked on addresses returned by m8xx_cpm_hostalloc().

I changed it a while back so single large pages could be used to map the
kernel space.  Just use iopa() on the virtual address to get the physical
address.  I don't understand the current condition of commproc.c today, but
I'm not the only one that updates it anymore.  The bk comments are quite
useless since all they indicate is some obscure patch was applied.

> I think in it's current form it's useless and should either be changed back to what
> it was or die.

It seems quite useful to the drivers that currently use it.........It's
only purpose is to provide small non-cached objects like uart fifos and control
areas.  Don't try to use it for things not intended.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
