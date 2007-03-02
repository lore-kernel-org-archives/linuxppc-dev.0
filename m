Return-Path: <dgibson@ozlabs.org>
Date: Fri, 2 Mar 2007 16:36:40 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jerry Van Baren <gerald.vanbaren@comcast.net>
Subject: Re: RFA & Update: Using libfdt in u-boot for fdt command
Message-ID: <20070302053640.GJ1687@localhost.localdomain>
References: <45E6DCB4.3080106@smiths-aerospace.com>
	<20070302015553.GA1687@localhost.localdomain>
	<45E7A346.5080206@comcast.net>
	<20070302044815.GI1687@localhost.localdomain>
	<45E7B53D.6020603@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45E7B53D.6020603@comcast.net>
Cc: u-boot-users@lists.sourceforge.net, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 02, 2007 at 12:25:17AM -0500, Jerry Van Baren wrote:
> David Gibson wrote:
> >On Thu, Mar 01, 2007 at 11:08:38PM -0500, Jerry Van Baren wrote:
> 
> [snip]
> 
> >>to give me a pointer to the node name for node tags and property name 
> >>for property tags.  Now that I have it working, it would be trivial to 
> >>change the calls to _fdt_next_tag() to instead call fdt_next_tag() 
> >>passing NULL for the new fourth parameter **namep. ;-)
> >>
> >>The reason I need it, I'm printing an unknown tree by stepping through 
> >>the tree discovering the node and property names.  I need to have 
> >>fdt_next_tag() return the *name* of the node/property as well as the tag 
> >>so that I can print and indent for nodes or look up the property value 
> >>and print the name=value combination.
> >
> >Hrm.  And it returns NULL for tags without a name?
> 
> I was unable to generate a tag without a name using dtc (other than the 
> root node).  It should/would return null, which would be a problem. :-/

I was thinking more of tag types which don't have a name, to wit,
FDT_END_NODE and FDT_NOP.

> >That might be a useful extension for the next_tag function.  The one
> >thing I'm concerned about is who's responsible for verifying the name
> >pointer.  I'm trying to keep libfdt robust enough that evern if
> >presented with a badly corrupt blob it will fail relatively
> >gracefully.  Ideally, no matter what it's presented with, it will
> >always return at worst FDT_ERR_BADSTRUCTURE rather than crashing and
> >will under no circumstances access memory outside the given blob
> >size.
> 
> [snip]
> 
> >>Oh gaak!  What I hear you saying... if you have node a with subnode b 
> >>and property b, subnode b has a property c:
> >>/a     => node
> >>/a/b   => node
> >>/a/b   => property (inside node a)
> >>/a/b/c => property (inside node b)
> >
> >Well, yes.  Except that in OF and derived terminology, properties are
> >*never* referred to by path in this way.  It's always:
> >	"property 'fred' of node /foo/bar/baz"
> 
> I'm coming from a human interface syntax point of view and assumed that 
> the human interface is paths like linux where the last item is a 
> directory or file with the computer guessing what you really meant 
> (which _isn't_ ambiguous in file/dir paths).  Is there a better syntax 
> for distinguishing between node paths and properties?

You assumed incorrectly.  Well, unless you count /proc/device-tree as
a human interface to the device tree, which isn't entirely
unreasonable.  OF certainly doesn't use that approach, it uses state
instead, first "dev /foo/bar/baz" then ".properties" or "setprop ....".

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
