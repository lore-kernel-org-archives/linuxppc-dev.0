Message-ID: <008201c2e2a8$1afc4a40$020120b0@jockeXP>
From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: "Tom Rini" <trini@kernel.crashing.org>
Cc: "Dan Malek" <dan@embeddededge.com>,
	"Daniel Jacobowitz" <drow@false.org>,
	<linuxppc-dev@lists.linuxppc.org>
References: <3E64DB91.4050508@embeddededge.com> <IGEFJKJNHJDCBKALBJLLEEMPFKAA.joakim.tjernlund@lumentis.se> <20030304233558.GA17093@ip68-0-152-218.tc.ph.cox.net>
Subject: Re: Improved copy_page() function, about 30% speed up for mpc860!
Date: Wed, 5 Mar 2003 00:45:14 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Which change in particular are you talking about?
This, in head_8xx.S:
* Addendum: The EA of a data TLB error is _supposed_ to be stored
* in DAR, but it seems that this doesn't happen in some cases, such
* as when the error is due to a dcbi instruction to a page with a
* TLB that doesn't have the changed bit set. In such cases, there
* does not appear to be any way to recover the EA of the error
* since it is neither in DAR nor MD_EPN. As a workaround, the
* _PAGE_HWWRITE bit is set for all kernel data pages when the PTEs
* are initialized in mapin_ram(). This will avoid the problem,
* assuming we only use the dcbi instruction on kernel addresses.

from http://lists.linuxppc.org/linuxppc-dev/200303/msg00022.html

> But I think as Dan
> has said, it's best to just accept this and move along. :)  It's known
> to be horribly broken in some cases, but not admited to by Motorola, and
> distinguishing between 8xx's at runtime is not trivial.

Regarding dcbz on user space yes, but not kernel space. I will do some more digging/testing and
maybe something could go into 2.5 eventally

 Jocke

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
