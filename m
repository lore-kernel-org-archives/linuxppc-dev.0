Return-Path: <linas@austin.ibm.com>
Date: Tue, 21 Aug 2007 12:22:41 -0500
To: Phil Terry <pterry@micromemory.com>
Subject: Re: Patches for ppc?
Message-ID: <20070821172241.GN4261@austin.ibm.com>
References: <46C5519E.6010300@dutchspace.nl>
	<1187353616.2778.358.camel@shinybook.infradead.org>
	<46C5B288.2010308@dutchspace.nl>
	<1187361603.2778.382.camel@shinybook.infradead.org>
	<46C5B40F.5040209@dutchspace.nl>
	<acbcf3840708171628k242e96ffl2b65011bf6d39512@mail.gmail.com>
	<20070821052514.GC21169@localhost.localdomain>
	<ae3d7296a5c3e83f19817a04841d099f@kernel.crashing.org>
	<1187712684.13726.32.camel@pterry-fc6.micromemory.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1187712684.13726.32.camel@pterry-fc6.micromemory.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: Linuxppc-dev@ozlabs.org, David Woodhouse <dwmw2@infradead.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Aug 21, 2007 at 09:11:24AM -0700, Phil Terry wrote:
> On Tue, 2007-08-21 at 17:14 +0200, Segher Boessenkool wrote:
> > > It's not a question of indivudual files being copied over - things are
> > > done differently in arch/powerpc.  Things are gradually being ported
> > > over to arch/powerpc as people get the time - that's why arch/ppc
> > > isn't gone yet.
> > 
> > And to be blunt, one of the points of arch/powerpc vs. arch/ppc is
> > to actually leave behind some stuff.  "If no one ports it, no one
> > wants it".
> 
> So am I alone in getting a mixed message from "Linux community" to
> "embedded community"? 
> 
> On the one hand we have people like GKH telling embedded people to stop
> being private company/device specific forks but to submit their hardware
> to the tree where it will be supported "for free" by the kernel hackers,
> saving us the "chore" of supporting "our" code through all the kernel
> changes and forever chasing it.
> 
> On the other hand we have people telling us that because we are too lazy
> to support "our" code the kernel guys aren't going to pull it forward
> for us.

You've got to keep things in perspective. Some devices do get old and
stale, and no one ever uses them any more. These devices do disappear
from the kernel tree over time. Its not unreasonable to have a "sunset"
policy for old stuff.  Some devices continue to have an active, interested 
community that helps maintain them.

Some kernel changes are big, and some are small. Sometimes big changes
are so big that they can't be done without having everybody pitch in
and help out.  The transition from ppc to powerpc is like that.  To 
cross over such humps, its not just a matter of laziness -- I have
enough work to keep ten of me occupied -- but its also access to
equipment: someone needs to verify that old hardware still works 
with the new changes.  Embedded is particularly dicey: there are so 
many platforms, most developers will never have seen the one in question.

> So in fact people 3rd party people like me are in between real problems,
> we base our code on say a Freescale chip, who submit to the kernel to
> save their support issues and we base our code on that. Now, the
> Freescale guys are too busy porting their "latest" chips across the
> PPC/Powerpc divide to port the "old" stuff so it gets "left behind".
> That old stuff is still selling and the people who based code on it had
> the expectation that the code would continue to be supported. 

For example, Redhat RHEL 4 is based on the 2.6.9 kernel, and god
help me I'm *still* posting patches and fixes to that, although
its a rather unpleasent task. There's a real economic motivation
to do this  --- and its called "support".  Someone out there cares
enough to want this old stuff to work across a whole range of h/w.

> So now I'm
> being told not only to "port my stuff or lose it" but now also port
> freescale's stuff or lose it.
> 
> And then we get beaten up because we "stayed" with "ancient stuff" like
> 2.6.21!!!

You get beaten up if you are trying to get new stuff to work on old
code bases -- for good reason. 

> Not picking on Freescale, or Segher, just trying to wave the flag, lots
> of people want it, they are just not all in a position to save it
> because we "embedded" people are by nature a fractured community of
> niche players with products that don't turn over with out customers
> every six months, some people will want to buy a product for years...

RHEL 4 is several years old, and it will be around for years more,
and its based on the 2.6.9 kernel, and, if it works for your customers,
they should use that. Once you've got a working software installation,
don't upgrade it! Upgrades do break things, so if it works, don't mess
with it.

But if you are building a new product, and adding new features, then
it does not make sense to try to do that to an old kernel.  And, yes,
there's a non-trivial effort to stay current and surf the cutting edge.
And, yes, there can be dangerous rip-tides, like the ppc->powerpc
migration, that can catch ahold of you.

--linas
