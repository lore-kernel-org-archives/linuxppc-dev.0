Message-ID: <002e01c29d74$628b03c0$0300a8c0@jockeXP>
From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: "Dan Malek" <dan@embeddededge.com>
Cc: "Matt Porter" <porter@cox.net>,
	"Pantelis Antoniou" <panto@intracom.gr>,
	<linuxppc-embedded@lists.linuxppc.org>
References: <IGEFJKJNHJDCBKALBJLLOEJHFIAA.joakim.tjernlund@lumentis.se> <3DF1018C.7080508@embeddededge.com>
Subject: Re: Regarding consistent_alloc
Date: Fri, 6 Dec 2002 23:11:11 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
> Joakim Tjernlund wrote:
>
> > Yes and no, someone changed the m8xx_cpm_hostalloc() implementation and now
> > it does not behave as it used to. Earlier both __pa(adr) and __va(__pa(adr))
> > worked on addresses returned by m8xx_cpm_hostalloc().
>
> I changed it a while back so single large pages could be used to map the
> kernel space.  Just use iopa() on the virtual address to get the physical
> address.  I don't understand the current condition of commproc.c today, but
> I'm not the only one that updates it anymore.  The bk comments are quite
> useless since all they indicate is some obscure patch was applied.
>
> > I think in it's current form it's useless and should either be changed back to what
> > it was or die.
>
> It seems quite useful to the drivers that currently use it.........It's
> only purpose is to provide small non-cached objects like uart fifos and control
> areas.  Don't try to use it for things not intended.

Exacly, I was using it as a small fifo for my SPI driver(not really mine, I found it on the net).
Since  __pa() and __va() doesn't work anymore, it should be documented becauase I think
most people expect __pa() and __va() to work on kernel memory and it did work in 2.4.2.

Anyway, I have fixed my driver now so this is not a problem for me anymore.

 Jocke

PS.
   Dan, are you still working/testing my 8xx_io/enet.c patch?


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
