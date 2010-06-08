Return-Path: <cbouatmailru@gmail.com>
Date: Tue, 8 Jun 2010 23:48:09 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 6/6] of/device: populate platform_device (of_device)
	resource table on allocation
Message-ID: <20100608194809.GA32732@oksana.dev.rtsoft.ru>
References: <20100608142152.26088.1108.stgit@angua>
	<20100608142643.26088.61366.stgit@angua>
	<20100608155702.GA5419@oksana.dev.rtsoft.ru>
	<AANLkTinZT4z93SWxjce5oRZzmaQHtVnO96zsXO9OX2UZ@mail.gmail.com>
	<20100608164645.GA15216@oksana.dev.rtsoft.ru>
	<AANLkTinHH-YhdWpH60Z2BYsiEjzLb_imrk6KUmQRH07P@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <AANLkTinHH-YhdWpH60Z2BYsiEjzLb_imrk6KUmQRH07P@mail.gmail.com>
Cc: sfr@canb.auug.org.au, monstr@monstr.eu, devicetree-discuss@lists.ozlabs.org,
	microblaze-uclinux@itee.uq.edu.au, jeremy.kerr@canonical.com,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 08, 2010 at 12:41:47PM -0600, Grant Likely wrote:
[...]
> >> This is a common pattern.
> >
> > This can't be true because it produces ugly casts and fragile
> > code all over the place -- which is exactly what everybody
> > tries to avoid in the kernel.
> 
> Fragile?  How?  &var[1] *always* gives you a pointer to the first
> address after a structure.  If the structure changes, then so does the
> offset.  Heck, if the type of 'var' changes, then the offset changes
> in kind too.  If anything, I should have also used sizeof(*res) in the
> kzalloc call so that the allocated size is protected against a type
> change to 'res' too.

You just introduced an unnamed structure of device + resources,
it isn't declared anywhere but in the code itself (either via
&foo[1] or buf + sizeof(*foo)).

You're not the only one who hacks (or at least have to
understand) the OF stuff, so let's try keep this stuff
readable?

I told you several ways of how to improve the code (based on
the ideas from drivers/base/, so the ideas aren't even mine,
fwiw).

> If you prefer, I can move the dev->resource assignment to immediately
> after the kzalloc to keep everything contained within 4 lines of each
> other.

Sure, that would be better, but I already said what would I
really prefer, i.e.

- A dedicated allocation;
- Or, at least, the same thing as drivers/base/platform.c does:
  platform_object { platform_device; name[1]; };

> > But I heard of no such pattern for 'struct device + struct
> > resources' allocation without even some kind of _priv struct,
> > which is surely something new, and ugly.
> 
> git grep '\*).*&[a-z1-9_]*\[1\]'

Ugh? This produces a lot of false positives. But OK, let's run it.

~/linux-2.6$ git grep '\*).*&[a-z1-9_]*\[1\]' | wc -l
164

^^^ Now let's presume that half of it (and not just a few hits)
    is the ugly hacks that we're talking about. Then compare:

~/linux-2.6$ git grep 'struct.*_priv' | wc -l
22448

^^^ this is a common pattern.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
