Return-Path: <dgibson@ozlabs.org>
Date: Mon, 4 Dec 2006 10:55:39 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
Subject: Re: libfdt - flat tree manipulation library
Message-ID: <20061203235539.GA32722@localhost.localdomain>
References: <20061127055905.GA6428@localhost.localdomain>
	<20061129055904.GA11883@localhost.localdomain>
	<20061201060038.GA25476@localhost.localdomain>
	<45702A07.2030303@smiths-aerospace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45702A07.2030303@smiths-aerospace.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Dec 01, 2006 at 08:11:35AM -0500, Jerry Van Baren wrote:
> David Gibson wrote:
> > On Wed, Nov 29, 2006 at 04:59:04PM +1100, David Gibson wrote:
> >> On Mon, Nov 27, 2006 at 04:59:05PM +1100, David Gibson wrote:
> >> [snip]
> >>> The code, such as it is, is at:
> >>> 	git://ozlabs.org/home/dgibson/git/libfdt.git
> >> Code for writing device trees from scratch, sequentially, is now
> >> implemented.
> > 
> > And now support for random access read-write is implemented.  The
> > library is now close to feature-complete, cleanups and convenience
> > wrappers remain.
> 
> Hi David,
> 
> You have not gotten any feedback on your library efforts.  

Not until now :).

> I just 
> thought I would let you know I am interested in your code for possibly 
> using it in u-boot.  I have not had time to review it carefully and 
> compare it to (a) existing u-boot fdt code and (b) current linux fdt 
> support but intend to do that soon.

Excellent.

> The existing u-boot fdt code is pretty crude (IMHO - makes (a) above a 
> nobrainer) and could bear replacing with something that has more 
> widespread support and is more flexible.  Easier to use would be a big 
> bonus. :-)
> 
> Size looks pretty comparable.
> $ wc -l libfdt/*.c
>    124 fdt.c
>    237 fdt_ro.c
>    310 fdt_rw.c
>    226 fdt_sw.c
>    115 fdt_wip.c
>   1012 total
> 
> $ wc -l arch/powerpc/boot/flatdevtree*.c
>    880 flatdevtree.c
>     51 flatdevtree_misc.c
>    931 total
> 
> For u-boot purposes, I would like to create a command that can dump a 
> fdt starting at a give node (a string, e.g. "/" for the whole thing, 
> "/cpus" for the entire CPU node and subnodes, or "/cpus/#cpus" to get 
> just one property).  I don't see a way of doing that directly with your 
> current interface.  Am I missing something or would I have to add 
> something?  The kernel doesn't need to support interactive fdt 
> manipulation, but that would be very beneficial for a bootrom like 
> u-boot.  (FWIIW, I've done a "prototype" ;-) version of this command 
> with the existing u-boot code.)

You're right: there's no support for traversing a tree - it's all
based on knowing the names in advance, so far.  Well, except for the
_fdt_next_tag() function which is only really intended for internal
use.  I'd been vaguely intending to add another module with traversal
support functions.

What interface would suit for you?  Would
first_subnode()/next_subnode(), first_property()/next_property() be
what you want?  Or would a depth first approach, something like
_fdt_next_tag() be better?  Or an explicit walk_tree() interface, with
a function pointer callbacks?

> If the linux kernel were to adopt your library, how do you envision this 
> happening?  Replace the existing code with wrappers (your "convenience 
> wrappers"?) to provide a backwards compatible interface (looks nasty and 
> negates your simplification advantages) or rip out 'n replace?

Rip out and replace.  Or possibly, make the PReP code in the pipeline
use the new code.  Then a bit later rip out the flatdevtree code.
Because of the existing dt_ops abstraction in the zImage code, the two
flat tree libraries could co-exist, though I think more than very
briefly would not be a great idea.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
