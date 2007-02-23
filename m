Return-Path: <dgibson@ozlabs.org>
Date: Sat, 24 Feb 2007 09:24:19 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
Subject: Re: libfdt: a fix but still broken
Message-ID: <20070223222419.GB21625@localhost.localdomain>
References: <45DD9A41.7060900@smiths-aerospace.com>
	<20070223034734.GA18698@localhost.localdomain>
	<45DEE524.6010704@smiths-aerospace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45DEE524.6010704@smiths-aerospace.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Feb 23, 2007 at 07:59:16AM -0500, Jerry Van Baren wrote:
> David Gibson wrote:
> >On Thu, Feb 22, 2007 at 08:27:29AM -0500, Jerry Van Baren wrote:
> >>Hi Dave,
> >>
> >>I have good news and bad news. ;-)  The good news is that the 
> >>incompatibility between libfdt and jdl's dtc is that libfdt has the name 
> >>offset and the length of the name switched.  booting_without_of.txt says 
> >>the length comes first, so libfdt is in the wrong.
> >
> >Ouch.  That's.. a very embarrassing bug.  Actually, I know where it
> >came from: I was looking at flat_dt.h from dtc, which also gets this
> >wrong (but the declaration in question is unused).  Of course, I also
> >wrote flat_dt.h ...
> >
> >>The bad news is that, when I fix this, nearly all of the tests fail (but 
> >>they fail the same way for both tree.S and jdl's dtc).  I have not 
> >>started on that layer of the onion yet.
> >
> >Found it, there was a direct use of the position of the length in
> >_fdt_next_tag().  Just pushed out a fix for this in the libfdt tree,
> >along with some other small fixes which I found while tracking this
> >one down.
> >
> >Oh, incidentally, I applied your patch by eye rather than with
> >patch(1), which was handy, because it appears to have been whitespace
> >damaged.
> 
> Hi David,
> 
> Sorry about the whitespace, I actually generated it at home, emailed it 
> to my day job, and edited and forwarded it from there (I'm not 
> subscribed at home - probably should be).
> 
> It sounds like we found and fixed the same bug last night.
> 
> I went quite a bit further (before finding and fixing the real bug).  I 
> was looking at the *_type "function like" #defines that generate a 
> temporary variable of indeterminate (until compile time) type.  An example:
> 
> #define fdt_setprop_inplace_typed(fdt, nodeoffset, name, val) \
> 	({ \
> 		typeof(val) x = val; \
> 		fdt_setprop_inplace(fdt, nodeoffset, name, &x, sizeof(x)); \
> 	})
> 
> IMHO this is borderline evil and unnecessary, and I removed all of them 
> by replacing the call of the *_type macros with the equivalent actual 
> function.  What I was suspicious of is when I changed all the calls to 
> use proper endian by calling cpu_to_fdt32(), the parameter "val" is no 
> longer a simple constant or variable but is, instead, a function call or 
> macro or nothing at all, depending on the host endian and compiler 
> implementation.  It turns out that this apparently wasn't a problem, but 
> I'm still of the opinion that those #defines have minimal value and 
> makes the code baroque. ;-)

Um, I'm afraid I don't agree.  I think those typed versions make the
code using them clearer and simpler.  In fact, one of their main uses
is to be used with functions or literals directly as the argument,
which isn't possible with the raw versions, because they need to take
an address.

Now, actually, that macro *is* broken, because there should be parens
around all the macro arguments, but you'll need to work much harder to
convince me the concept is broken.

> I've attached a patch file that shouldn't be whitespace damaged this 
> time.  :-/  I can also make my git repository accessible if that is helpful.

Gah.  I really hate saying this, but please don't send me patches
until I have the situation sorted out with legal better.  I took the
last one partly because it was so broken without it, but also because
it was so trivial that even IBM's paranoid interpretation regards it
as too small to be copyrightable.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
