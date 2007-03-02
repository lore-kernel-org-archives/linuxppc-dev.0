Return-Path: <dgibson@ozlabs.org>
Date: Fri, 2 Mar 2007 15:48:15 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jerry Van Baren <gerald.vanbaren@comcast.net>
Subject: Re: RFA & Update: Using libfdt in u-boot for fdt command
Message-ID: <20070302044815.GI1687@localhost.localdomain>
References: <45E6DCB4.3080106@smiths-aerospace.com>
	<20070302015553.GA1687@localhost.localdomain>
	<45E7A346.5080206@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45E7A346.5080206@comcast.net>
Cc: u-boot-users@lists.sourceforge.net, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 01, 2007 at 11:08:38PM -0500, Jerry Van Baren wrote:
[snip] 
> >> 2) The official libfdt uses two header files that are not in u-boot.  I 
> >> "fixed" this by substituting u-boot headers with equivalent functionality.
> >> * I need to address this and see what the best compromise for header 
> >> files is...
> >>    a) If the u-boot headers are acceptable for the stand-alone version
> >>         of libfdt, that would be the simplest.
> >>    b) It may be more effective to add the necessary linux headers to
> >>         u-boot.
> >>    c) We could use #ifdefs to conditionally include the right files. (but
> >>         does u-boot have a distinctive configuration def?  Probably...)
> > 
> > Ok, the way this is supposed to work is that the environment into
> > which you're building should provide a replacement version of
> > libfdt_env.h.  The supplied version of libfdt_env.h is just for
> > userland builds.  u-boot's version will obviously use u-boot headers
> > instead of standard library headers.
> > 
> > I should provide a comprehensive list of what libfdt_env.h needs to
> > provide, but I haven't gotten around to it.  From memory it's
> > basically just the fixed-with integer types, a smallish subset of the
> > str*() and mem*() functions, and the endian conversion functions.
> > 
> > I've really tried to keep libfdt's environment dependencies down, so I
> > suggest you just start with an empty libfdt_env.h and add stuff based
> > on the error messages until the compiler stops whinging about
> > undefined things.  It shouldn't take long.
> 
> Yes, all the functionality is in both linux headers and u-boot headers 
> that it stole^Winherited from linux.  The problem is, the set is 
> disjoint.  If libfdt is willing to change its headers to use 
> linux/types.h, asm/byteorder.h, and linux/string.h, the problem would go 
> away:
> 
> fdt.h:
> -#include <stdint.h>
> +#include <linux/types.h>
> 
> libfdt_env.h:
> -#include <stdint.h>
> -#include <string.h>
> -#include <endian.h>
> -#include <byteswap.h>
> +#include <linux/types.h>
> +#include <asm/byteorder.h>
> +#include <linux/string.h>

Well, as I say, libfdt_env.h is supposed to be replaced in any case.
That leaves only stdint.h as a problem (it's used in the actual
declarations of the flat tree structures).  I'm not entirely sure how
to address that one.  Possibly just omit it from fdt.h and require the
user to include something defining the fixed-width integer types.

> Note that asm/byteorder.h provides __be32_to_cpu(x) and friends, which 
> can be used directly rather than having to synthesize swap/noswap (i.e. 
> bswap_32(x)) based on #if __BYTE_ORDER == __BIG_ENDIAN.  They can be 
> used directly, or fdt32_to_cpu and friends can be defined in terms 
> of__be32_to_cpu(x) and friends:
> +#define fdt32_to_cpu(x)                __be32_to_cpu(x)
> +#define cpu_to_fdt32(x)                __cpu_to_be32(x)
> +#define fdt64_to_cpu(x)                __be64_to_cpu(x)
> +#define cpu_to_fdt64(x)                __cpu_to_be64(x)

Yes, that's what I'd expect to be done in the context of the kernel,
or something similar (which I gather u-boot is).

> When I did the above change and tried to compile it natively under 
> linux, there were problems with unresolved types.  I did not pursue the 
> resolution of the problem since I am currently concentrating on u-boot 
> usage.
> 
> >> 3) I added a "fdt_next_tag()" function to fdt_ro.c to allow me to step 
> >> through the blob's tags:
> >>    uint32_t fdt_next_tag(const void *fdt, int offset,
> >>                          int *nextoffset, char **namep);
> >>
> >> This is similar to "_fdt_next_tag()" (a "private" function, note the 
> >> leading underscore) in fdt.c, but with a related but different purpose - 
> >>   the "_fdt_next_tag()" steps through _node_ tags (skipping property 
> >> tags) where I need to step through all tags sequentially.
> > 
> > Um... no.  _fdt_next_tag() steps through all tags (how else could it
> > be used internally to find properties...?).  If you really need this,
> > we can change the function to be exported, which I've considered
> > before.  However, what are you using this function for?  I had some
> > node and property traversal functions on the drawing board.
> 
> Yes, I copied and augmented _fdt_next_tag():
> 
> uint32_t fdt_next_tag(const void *fdt, int offset, int *nextoffset, char 
> **namep)
> 
> to give me a pointer to the node name for node tags and property name 
> for property tags.  Now that I have it working, it would be trivial to 
> change the calls to _fdt_next_tag() to instead call fdt_next_tag() 
> passing NULL for the new fourth parameter **namep. ;-)
> 
> The reason I need it, I'm printing an unknown tree by stepping through 
> the tree discovering the node and property names.  I need to have 
> fdt_next_tag() return the *name* of the node/property as well as the tag 
> so that I can print and indent for nodes or look up the property value 
> and print the name=value combination.

Hrm.  And it returns NULL for tags without a name?

That might be a useful extension for the next_tag function.  The one
thing I'm concerned about is who's responsible for verifying the name
pointer.  I'm trying to keep libfdt robust enough that evern if
presented with a badly corrupt blob it will fail relatively
gracefully.  Ideally, no matter what it's presented with, it will
always return at worst FDT_ERR_BADSTRUCTURE rather than crashing and
will under no circumstances access memory outside the given blob
size.

> >> Usability trivia for David: libfdt distinguishes between nodes and 
> >> properties, which makes sense since that is how the fdt is structured. 
> >>  From a usability standpoint, however, it is annoying to have to 
> >> separate the property name from the node, find the node, then find the 
> >> property.  I will probably create Yet Another Function:
> >>    int fdt_split(char *path, char **property);
> >> Call it with a path string and the function will separate it into the 
> >> node portion and the property name.  If the path is invalid, it will 
> >> return an error.  If the path is a node, it will set **property to NULL 
> >> and return the node's offset.  If the path is a property, it will return 
> >> the owning node's offset and set the **property pointer to point to the 
> >> start of the property portion of the path (i.e. the next character after 
> >> the last '/').
> > 
> > I don't like combining property and node name into a single path,
> > because technically the property names occupy a different namespace
> > from subnode names.  Insane though it is, there exist some Apple
> > device trees where a node has both a property and a subnode of the
> > same name.
> 
> Oh gaak!  What I hear you saying... if you have node a with subnode b 
> and property b, subnode b has a property c:
> /a     => node
> /a/b   => node
> /a/b   => property (inside node a)
> /a/b/c => property (inside node b)

Well, yes.  Except that in OF and derived terminology, properties are
*never* referred to by path in this way.  It's always:
	"property 'fred' of node /foo/bar/baz"

> Where I am right now is I created a new function fdt_fullpath_offset:
> 
> int fdt_fullpath_offset(const void *fdt, const char *path, char **prop);
> 
> which will return the _node_ /a/b in the gaak illustration above.  It 
> looks up nodes until it either runs out of path to look up or there is 
> an error.  On a lookup error, it tries again with the last part of the 
> path used as a property name.  As a result, if you pass in /a it will 
> return the node "a", if you pass in /a/b it will return the _node_ "b". 
>   This is unchanged behavior compared to fdt_path_offset().  (Getting 
> property "b" is unchanged: you would have to look up node /a with either 
> fdt_fullpath_offset(... "/a" ...) or fdt_path_offset(... "/a" ...) and 
> then use that offset with fdt_property() to get the property "b".)

I really don't like this idea much.  I don't think it's sufficiently
useful to justify the increased implementation complexity and semantic
confusion.

> I've changed the original fdt_path_offset() to simply call 
> fdt_fullpath_offset() passing in NULL for **prop and everything (should) 
> work the same as before ("should" because I haven't debugged it yet).
> 
> For my u-boot commands, I have "fdt get <prop>" and "fdt print <node>" 
> and was going to consolidate them into one, but the gaak illustration 
> says I should _not_ consolidate them.  (Trivia: my "fdt print" of "/" 
> and "/a" will (should anyway ;-) print the gaak tree properly.)
> 
> What are the odds that someone will pull an Apple on hardware supported 
> by u-boot?  Hmmm... extra code to handle stupidity.

I don't know.  But I do know the chances are pretty reasonable of
libfdt being used in the kexec-tools on Apple machines, so regardless
of what u-boot does, the libfdt core should not promote this
confusion.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
