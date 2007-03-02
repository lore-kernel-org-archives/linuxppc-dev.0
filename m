Return-Path: <dgibson@ozlabs.org>
Date: Fri, 2 Mar 2007 12:55:53 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
Subject: Re: RFA & Update: Using libfdt in u-boot for fdt command
Message-ID: <20070302015553.GA1687@localhost.localdomain>
References: <45E6DCB4.3080106@smiths-aerospace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45E6DCB4.3080106@smiths-aerospace.com>
Cc: u-boot-users@lists.sourceforge.net, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 01, 2007 at 09:01:24AM -0500, Jerry Van Baren wrote:
> Hi all,
> 
> This is a Request for Advice.
> 
> First off, for those on both the u-boot and linuxppc-dev lists, sorry 
> for cross posting.  :-)
> 
> Git repo pointers...
> libfdt hacks:
> <http://www.cideas.us/cgi-bin/gitweb.cgi?p=linux/libfdt.git;a=summary>
> u-boot hacks:
> <http://www.cideas.us/cgi-bin/gitweb.cgi?p=u-boot/u-boot-mpc83xx;a=summary>
> 
> I have a proof-of-concept (actually, somewhat more than PoC) fdt command 
> built using libfdt.  Now I'm looking for advice on the best way to turn 
> the PoC into Real Code[tm].
> 
> Current commands:
> -----------------
> fdt address        - set the base address of the blob
> fdt get <property> - get a property
> fdt print <node>   - print the subtree starting at <node>[1]
> 
> Planned commands:
> -----------------
> fdt set <property> <value> - set a property value (do we want an
>                         "=" as in <property> = <value>?)
> fdt ?synthesize?   - create the "chosen" branch and optionally the
>                         u-boot variables branch.  The OF code/calls
>                         currently in bootm would be moved to this
>                         command.  I'm open to suggestions for a good
>                         subcommand name.
> 
> Other commands:
> ---------------
> fdt node <name>    - create a node that can then be populated with 
> properties (have not thought about this in any detail yet).
> 
> [1] If <node> is actually a <property> (which is a usage error, but I 
> expect will happen all the time), "fdt print" actually does a "fdt get 
> <property>"  This makes "fdt get" redundant and likely will make it go away.
> 
> Philosophy question primarily for David Gibson and Wolfgang Denk:  What 
> is the best way to integrate libfdt with u-boot?  Currently it is in its 
> own git repository.  Options?
> 1) Do we want to capture the source in the u-boot git repository?  If 
> so, it becomes a snapshot and will require cross pushing/pulling between 
> the libfdt repo and the u-boot repo or they will drift apart.  However, 
> it makes problems #1 and #2 (below) simpler to solve but causes drift.

> 2) Not capturing libfdt in the u-boot repo makes it more difficult for 
> integrating it with and maintaining it in u-boot, I'm not sure how to 
> actually do it in a useful/usable manner.

I think ultimately, you'll have to pull libfdt into the u-boot
sources.  libfdt is supposed to run in many possible environments, and
there's no realistic way it can be compiled independently of thost
environments.

That said, any changes to the guts of libfdt that you need should go
upstream (in the end; right now, there are bureaucratic problems with
that, more below).  That should reduce things to a one way pull, with
some trivial tweaks to integrate with the u-boot environment.

> There are three problem areas with libfdt:
> 1) The official Makefile is stand-alone which doesn't work well with 
> u-boot.  I took the expedient route for the PoC of simply replacing it 
> with a u-boot style Makefile from a different lib* subdirectory.  There 
> should be a better way.

I think it might well be necessary to replace the Makefile for
building libfdt into other packages.  It would be nice to avoid that
if possible, but a sensible method is not obvious to me.

> 2) The official libfdt uses two header files that are not in u-boot.  I 
> "fixed" this by substituting u-boot headers with equivalent functionality.
> * I need to address this and see what the best compromise for header 
> files is...
>    a) If the u-boot headers are acceptable for the stand-alone version
>         of libfdt, that would be the simplest.
>    b) It may be more effective to add the necessary linux headers to
>         u-boot.
>    c) We could use #ifdefs to conditionally include the right files. (but
>         does u-boot have a distinctive configuration def?  Probably...)

Ok, the way this is supposed to work is that the environment into
which you're building should provide a replacement version of
libfdt_env.h.  The supplied version of libfdt_env.h is just for
userland builds.  u-boot's version will obviously use u-boot headers
instead of standard library headers.

I should provide a comprehensive list of what libfdt_env.h needs to
provide, but I haven't gotten around to it.  From memory it's
basically just the fixed-with integer types, a smallish subset of the
str*() and mem*() functions, and the endian conversion functions.

I've really tried to keep libfdt's environment dependencies down, so I
suggest you just start with an empty libfdt_env.h and add stuff based
on the error messages until the compiler stops whinging about
undefined things.  It shouldn't take long.

> 3) I added a "fdt_next_tag()" function to fdt_ro.c to allow me to step 
> through the blob's tags:
>    uint32_t fdt_next_tag(const void *fdt, int offset,
>                          int *nextoffset, char **namep);
> 
> This is similar to "_fdt_next_tag()" (a "private" function, note the 
> leading underscore) in fdt.c, but with a related but different purpose - 
>   the "_fdt_next_tag()" steps through _node_ tags (skipping property 
> tags) where I need to step through all tags sequentially.

Um... no.  _fdt_next_tag() steps through all tags (how else could it
be used internally to find properties...?).  If you really need this,
we can change the function to be exported, which I've considered
before.  However, what are you using this function for?  I had some
node and property traversal functions on the drawing board.

> Usability trivia for David: libfdt distinguishes between nodes and 
> properties, which makes sense since that is how the fdt is structured. 
>  From a usability standpoint, however, it is annoying to have to 
> separate the property name from the node, find the node, then find the 
> property.  I will probably create Yet Another Function:
>    int fdt_split(char *path, char **property);
> Call it with a path string and the function will separate it into the 
> node portion and the property name.  If the path is invalid, it will 
> return an error.  If the path is a node, it will set **property to NULL 
> and return the node's offset.  If the path is a property, it will return 
> the owning node's offset and set the **property pointer to point to the 
> start of the property portion of the path (i.e. the next character after 
> the last '/').

I don't like combining property and node name into a single path,
because technically the property names occupy a different namespace
from subnode names.  Insane though it is, there exist some Apple
device trees where a node has both a property and a subnode of the
same name.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
