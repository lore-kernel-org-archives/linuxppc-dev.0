Date: Mon, 3 Mar 2003 19:54:05 -0500
From: Daniel Jacobowitz <drow@false.org>
To: Dan Malek <dan@embeddededge.com>
Cc: Joakim Tjernlund <Joakim.Tjernlund@lumentis.se>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Improved copy_page() function, about 30% speed up for mpc860!
Message-ID: <20030304005405.GA29518@nevyn.them.org>
References: <005401c2e0e4$27a1b6b0$020120b0@jockeXP> <3E63C6BE.6020002@embeddededge.com> <006a01c2e1da$e108ddd0$020120b0@jockeXP> <3E63F69C.80001@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3E63F69C.80001@embeddededge.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Mar 03, 2003 at 07:43:08PM -0500, Dan Malek wrote:
> Joakim Tjernlund wrote:
>
> >OK so this is not it then, but what is it then? Are you 100% that
> >the bug(whatever this may be) is present for mpc860, rev D4 or later?
> >How can I make it bite me on kernel space memory?
> >I can't find that info in the archives, if it's there please give me a
> >hint.
>
> I guess once again I don't understand the questions or failed to express
> my responses properly.
>
> In the previous message, you included a link that indicated a problem
> setting the DAR, cache instructions, and asked if this was a problem.
> In this case, due to the way we map kernel space and use the cache
> instructions,
> we have "fixed" this bug.  I believe it was found because of the way we
> copy instructions in the C library, and it affected user applications.
> The specific problem described in this link is not a problem with Linux.

That is, in fact, incorrect.  It's fatal from userland.  I experimented
with it just a couple of months ago.

Only way to sort it out would be to do instruction decoding on the
faulting address, which is hideous beyond words.

--
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
