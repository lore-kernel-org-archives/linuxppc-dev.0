Date: Tue, 27 Nov 2001 13:21:41 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Michael Sokolov <msokolov@ivan.Harhan.ORG>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Please make K2 Linux bootable without PeeMON again
Message-ID: <20011127132141.N13091@cpe-24-221-152-185.az.sprintbbd.net>
References: <0111271846.AA24695@ivan.Harhan.ORG>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0111271846.AA24695@ivan.Harhan.ORG>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Nov 27, 2001 at 10:46:17AM -0800, Michael Sokolov wrote:
>
> Tom Rini <trini@kernel.crashing.org> wrote:
>
> > Because it's only a slightly less magical location than the current one
> > (in the wrapper, I don't know where yours puts it).
>
> No, with my solution you don't need to know the kernel size, you just simply
> point it at where you've put the bi_recs.

Yes, but where is what I'm asking.

>
> The point is, you broke what worked. I was able to run public Linux on my K2
> prior to your change of 2001-11-19, I am not able to any more. You cannot break
> code that people use. You must fix it. I have already offered one easy fix.

Right.  And I don't want to just fix it, I want to make it better if
possible.

> > Well, that's the fun part.  No one really like the current magic
> > location, but no one's come up with a better one.
>
> But why have any magic location at all? I have no problem with your zImage goo
> putting bi_recs where it does (hell, I'll never use it anyway, so I don't care
> what it does in general), just please don't make the kernel look in any fixed
> location and let the booter tell it where it put them.

Right.  And what's a good place to put them?

> My booter, for example, doesn't use any magic locations. My booter is a plain
> standalone C program built with the GNU toolchain, and I store the bi_recs in
> my program's memory. You don't need to worry about what physical address it is,
> as I set R3 to point to them when I start vmlinux.

If it's not a constant, it's somehow 'magical', in the above contexts.

> You are welcome to look at my code:
>
> cvs -d :pserver:anoncvs@ivan.Harhan.ORG:/fs3/IFCTF-cvs co ppc-linux-boot

Okay.  If I'm reading all of this your bi_recs end up in the middle of
where you're run from, yes?  This has the same problem that the wrapper
does in that it's possible to overwrite these, if you're run in a bad
spot.  If I'm reading things right.

> > After reading the
> > pmac/chrp stuff which shoves the initrd at the end of RAM (we _could_
> > overwrite our initrds that we place right after the kernel, if we have a
> > big kernel and low link addresss).  Not that i've tried it yet, it just
> > poped out at me.
>
> OK, so now you want to make the kernel look for stuff only at the end of RAM
> and nowhere else, right?

No, I want to have the wrapper put the bi_recs there and suggest that
other people who're doing bootloaders do likewise in 2.5, IF this makes
sense as a good place to put them and they can't be overwriten by the
kernel bss.

> Then how is it going to know where the end of RAM is
> if the memory size is one of the things communicated via bi_recs in the first
> place?

I've been thinking, and one of two things could happen, at least in the
wrapper, we know mem size (Firmware, res data, magic).  Or assume
there's at least XX megs of ram on the system (I _think_ 16mb is the
'normal' min, but of course we have lots of systems breaking that rule).

What I'd like to see, and at least I think would be a good thing to
figure out is a general 'safe' location to store these in.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
