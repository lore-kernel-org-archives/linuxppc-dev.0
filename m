Return-Path: <dgibson@ozlabs.org>
Date: Thu, 1 Nov 2007 09:55:23 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Yoder Stuart-B08248 <stuart.yoder@freescale.com>
Subject: Re: RFC:  replace device_type with new "class" property?
Message-ID: <20071031225523.GA16119@localhost.localdomain>
References: <9696D7A991D0824DBA8DFAC74A9C5FA30359F9BB@az33exm25.fsl.freescale.net>
	<20071029212213.GA28073@lixom.net>
	<20071030005146.GF29263@localhost.localdomain>
	<9696D7A991D0824DBA8DFAC74A9C5FA3035F26EE@az33exm25.fsl.freescale.net>
	<20071030232730.GD2784@localhost.localdomain>
	<9696D7A991D0824DBA8DFAC74A9C5FA3035F2AC3@az33exm25.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9696D7A991D0824DBA8DFAC74A9C5FA3035F2AC3@az33exm25.fsl.freescale.net>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Oct 31, 2007 at 08:31:02AM -0700, Yoder Stuart-B08248 wrote:
>  
> > > I think what we should do is keep device_type, including
> > > permitting new uses of it in a limited way-- only permitting
> > > the use of device_type when there is an official binding
> > > (like in the power.org ePAPR) defined.    
> > 
> > That's what I was thinking when we first started defining flat tree
> > bindings.  But the more time I've spent thinking about it, and the
> > more time I've spent reviewing people's proposed bindings, the less
> > useful I think it is.
> > 
> > The *only* reason I'm suggesting leaving device_type values for
> > IEEE1275 defined classes is so that flat trees written as flat trees
> > look more similar to OF derived trees.
> > 
> > > > Explicitly specifying what device class bindings / conventions the
> > > > node complies with is cute, but not actually all that useful in
> > > > practice.  If it looks like a "duck" class device node, and it
> > > > quacks^Whas the properties of a "duck" class device node, 
> > it's "duck"
> > > > class compliant.
> > > > 
> > > > Or to look at it another way, "class bindings" aren't 
> > really bindings,
> > > > but rather a set of conventions that device bindings for specific
> > > > devices in that class ought to follow.
> > > 
> > > I tend to think of a 'binding' as a 'set of conventions'.
> > 
> > Well, whatever.  My point is that conventions are most flexible if you
> > don't have to explicitly announce that you're following them - you
> > just go ahead and follow as many conventions as make sense for your
> > device.
> 
> Let me repeat what I think you are advocating--  we should
> treat the collection of properties for 'established' device
> classes like like "network", "serial", etc as a set of useful 
> conventions.  That is, there are no set of _required_ properties
> per se, but the device tree creator picks from the established
> properties plus supplementing with "company,xyz" properties
> in whatever way they think makes sense for them.

Not the device tree creater, the device binding creator (though for
"one-off" type devices those may be the same person).

> This works...but certainly is weaker with respect to
> standardization.  My previous argument had the assumption
> that something like "mac-address" in a network node was
> _required_, and thus needed a class id of some sort to tie
> the standardized node to.

Not for a network device type that represented a point-to-point link..

(Well, technically most nodes should lack 'mac-address', but I think
'local-mac-address' is what you meant)

> If we relax things so there are no required properties for
> device nodes, then I agree that a device class property
> has limited or no value.

There are required properties, but the requrements are done at the
device binding (i.e. compatible property) level.  Those bindings might
in turn reference class requirements ("A foobaz-ethernet node must
have all the standard properties for a network node described in
Sx.y.z, and in addition must have foobaz,frobnication-quotient").

> However, maybe we do want to keep device_type in 
> a very limited way to define requirements for what you
> call 'fundamental' types of nodes.  It may be that certain
> properties in a "cpu" node (like cache-size?) should be
> _required_ so that an OS that consumes the device tree
> can really count on certain properties being there.  Or,
> I guess we could use "compatible" for that...?

No, I'm saying keep device_type for cpu and memory - we could do
otherwise but it would be a gratuitous divergence from OF trees.  And
yes they should have their required properties, too.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
