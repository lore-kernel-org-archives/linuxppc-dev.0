Date: Tue, 17 Oct 2000 04:17:52 -0700
From: Matt Porter <mporter@mvista.com>
To: Dan Malek <dan@mvista.com>
Cc: mgreer@mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: If not CONFIG_ALL_PPC, you're broken
Message-ID: <20001017041751.A9882@cx258813-a.chnd1.az.home.com>
References: <39EB8A67.E2F9C023@mvista.com> <39EBDC43.3F7E57B8@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <39EBDC43.3F7E57B8@mvista.com>; from dan@mvista.com on Tue, Oct 17, 2000 at 12:57:39AM -0400
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Oct 17, 2000 at 12:57:39AM -0400, Dan Malek wrote:
>
> "Mark A. Greer" wrote:
> >
> > I've haven't been paying attention to this but it seems as though any
> > platform that doesn't fit in CONFIG_ALL_PPC doesn't build anymore.
>
> We don't even need CONFIG_ALL_PPC anymore.  We can just rename
> arch/ppc to arch/powermac_workstation, as that is all that works
> right now.  It sucks to have to build a 2 Mbyte kernel with USB,
> keyboard, mouse, and tons of other stuff just to get a kernel that
> will link when all you want is a serial and Ethernet port......and
> then hack init functions that you didn't want anyway so they don't
> try to touch hardware you don't have.
>
> > ........  Yes, I know, I am lazy
> > and should contribute more.  Anyway, I think we all need to pay closer
> > attention to the changes that are being put in, including me.
>
> Well, putting in the time is only part of it.  I am trying to support
> about a dozen different PowerPC boards, none of which look like a
> PowerMac.  By the time I test a kernel across all of these platforms
> and check in a few changes I am completely out of date and have to
> start over.
>
> > What's the best way to get the other platforms working again?
>
> Fortunately, it looks like some people (Matt, Troy, others) have pushed
> a few PReP and CHRP updates, and Paul has a CHRP workstation for testing.
> Maybe when the PMac stuff slows down, we can catch up.  Unfortunately,
> we still have to build huge kernels with lots of stuff we don't need,
> and I don't know how to fix that (well, I do but I don't think it
> is likely to happen :-).

My solution for creating a slim embedded PPC kernel in 2.2 was to
stub out all the calls to Mac/CHRP specific routines that were made
in head.S and setup.c.  It doesn't require major surgery to the existing
code and let me generate a kernel with only the arch/ppc/kernel/ objects
that were required for the port.

I was planning on taking this same approach when I get around to
merging the K2 port into the real world.  I think it's a clean
approach if you don't mind stubbed functions.  I'm sure somebody
won't like it though...

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
