Return-Path: <dgibson@ozlabs.org>
Date: Tue, 7 Aug 2007 14:12:59 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/6] PowerPC 440EPx: Sequoia DTS
Message-ID: <20070807041259.GF13522@localhost.localdomain>
References: <20070730150648.GA5005@ru.mvista.com>
	<20070801020836.GB31391@localhost.localdomain>
	<65ff446478a9fd0a48061079d5f04f8f@kernel.crashing.org>
	<20070801050422.GI31391@localhost.localdomain>
	<20070801054751.GM31391@localhost.localdomain>
	<46B1F6D4.3070707@ru.mvista.com>
	<20070803031349.GD6418@localhost.localdomain>
	<46B34E1F.5060009@ru.mvista.com>
	<20070806042109.GB6103@localhost.localdomain>
	<163e1bcdc507ddcde3193e842c96da43@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <163e1bcdc507ddcde3193e842c96da43@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Aug 06, 2007 at 10:54:33PM +0200, Segher Boessenkool wrote:
> > Aha!  Ok, now I understand the sorts of situations you're talking
> > about.  By "not direct mapped", I thought you were talking about some
> > kind of access via address/data registers on some indirect bus
> > controller, rather than weird variations on endianness and
> > bit-swizzling.
> >
> > Hrm.. this is a property of how the flash is wired onto the bus,
> > rather than of the flash chips themselves, so I'm not entirely sure
> > where description of it belongs.
> >
> > Simplest option seems to me to add a property "endianness" or
> > "bit-swizzling" or something which can be defined to describe some odd
> > connections.  If absent we'd default to direct mapping.  Segher, is
> > that idea going to cause you to scream?
> 
> No, that's fine with me.  I would recommend either using a
> _good_ _descriptive_ name for such a property describing the
> swizzling, if this swizzling is common; or just put the whole
> bloody weirdo address permutation into some nice big array,
> something like
> 
> address-permutation = <0 1 3 2 4 5 7 6 e f d c a b 9 8>;

Yes, I was contemplating something like that.

[snip]
> > So I left out ranges, on the grounds that there isn't actually
> > anything at present which will attempt to access flash partitions
> > "generically" as a device tree device.
> 
> It looks good to me like this.
> 
> In a real OF, the "register" access for the flash partition
> node would be handled by its parent node, which would know
> to do the direct-mapping thing (at least mapping it to _its_
> parent, which typically asks the nodes further up, etc.)
> 
> For the kernel world, we should just document it in the binding.
> 
> > I'm not sold on this approach, but I haven't heard you give a better
> > argument yet.
> 
> I haven't heard or thought of anything better either.  Using "ranges"
> is conceptually wrong, even ignoring the technical problems that come
> with it.

Why is "ranges" conceptually wrong?

To be honest this looks rather to me like another case where having
overlapping 'reg' and 'ranges' would actually make sense.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
