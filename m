Date: Fri, 9 Nov 2001 11:44:03 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 405 -- a little console help, part 2
Message-ID: <20011109114403.J27549@zax>
References: <3BEA8A5D.50A75CE7@midrivers.com> <3BEAA8D3.51ADDCC8@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3BEAA8D3.51ADDCC8@mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Nov 08, 2001 at 09:46:27AM -0600, Mark Hatle wrote:
>
> Mark Pilon wrote:
> >
> > I've got a little more info -- /bin/sash doesn't produce any
> > output and just sits there, echoing charachters typed.  I'll try poking
> > around w/ gdb/abatron but am not sure how to find the exec'd shell.
> >
> > if I spawn ash w/ init=/bin/ash:
> > ...
>
> That is very odd, I don't know why ash would work and sash does not.
> Very strange indeed.

Ah, I think I know why this might be - are you using the 2_4_devel
tree?

All static executables segfaulted before reaching main until very
recently: the 4xx's MMU makes it possible to actually enforce the
execute permission bit on pages.  Since most processors don't allow
this, however, there are heaps of bugs in userland (binutils etc.)
where pages aren't marked executable that need to be.  In this case
there was instruction just before the got that wasn't marked
executable.

For now, at least, I've disabled enforcement of the page execute
permissions, because there's just too much stuff that breaks with it
on.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
