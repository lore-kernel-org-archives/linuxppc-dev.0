Date: Tue, 4 Mar 2003 17:05:42 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Joakim Tjernlund <Joakim.Tjernlund@lumentis.se>
Cc: Dan Malek <dan@embeddededge.com>,
	Daniel Jacobowitz <drow@false.org>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Improved copy_page() function, about 30% speed up for mpc860!
Message-ID: <20030305000542.GC17093@ip68-0-152-218.tc.ph.cox.net>
References: <3E64DB91.4050508@embeddededge.com> <IGEFJKJNHJDCBKALBJLLEEMPFKAA.joakim.tjernlund@lumentis.se> <20030304233558.GA17093@ip68-0-152-218.tc.ph.cox.net> <008201c2e2a8$1afc4a40$020120b0@jockeXP>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <008201c2e2a8$1afc4a40$020120b0@jockeXP>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Mar 05, 2003 at 12:45:14AM +0100, Joakim Tjernlund wrote:
> > Which change in particular are you talking about?
> This, in head_8xx.S:
> * Addendum: The EA of a data TLB error is _supposed_ to be stored
> * in DAR, but it seems that this doesn't happen in some cases, such
> * as when the error is due to a dcbi instruction to a page with a
> * TLB that doesn't have the changed bit set. In such cases, there
> * does not appear to be any way to recover the EA of the error
> * since it is neither in DAR nor MD_EPN. As a workaround, the
> * _PAGE_HWWRITE bit is set for all kernel data pages when the PTEs
> * are initialized in mapin_ram(). This will avoid the problem,
> * assuming we only use the dcbi instruction on kernel addresses.
>
> from http://lists.linuxppc.org/linuxppc-dev/200303/msg00022.html

Well, the whole change is at:
http://ppc.bkbits.net:8080/linuxppc_2_4_devel/cset@1.118.1.428?nav=index.html|ChangeSet@-1d

So, that should give it more context and make it clearer, I hope..

> > But I think as Dan
> > has said, it's best to just accept this and move along. :)  It's known
> > to be horribly broken in some cases, but not admited to by Motorola, and
> > distinguishing between 8xx's at runtime is not trivial.
>
> Regarding dcbz on user space yes, but not kernel space.

I have this feeling Dan is right and it's luck, not a lack of a real
issue.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
