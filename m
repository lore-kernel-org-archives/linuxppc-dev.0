Return-Path: <dgibson@ozlabs.org>
Date: Thu, 22 Mar 2007 11:49:59 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jerry Van Baren <gerald.vanbaren@comcast.net>
Subject: Re: libfdt: going forward for u-boot
Message-ID: <20070322004959.GE2295@localhost.localdomain>
References: <4601C8F7.5060006@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4601C8F7.5060006@comcast.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 21, 2007 at 08:08:23PM -0400, Jerry Van Baren wrote:
> Hi David,
> 
> I'm using libfdt in u-boot and getting close to pushing u-boot changes 
> upstream.  I'm curious what libfdt's legal status is WRT dual licensing 
> and the legal dogs you've unleashed.

Um.. still working on it.  I've been through one round with the
lawyers, and I've spent the last few days gathering my energy to
adjust my proposal for another pass.  Progress is happening, albeit
fairly slowly.

> One thought that occurred to me since we last discussed this is to 
> relicense it LGPL.  That way it could be linked into proprietary code 
> without having to maintain a dual license and the copyright assignment 
> headaches that come with outside contributors.

Heh.  The lawyers suggested that too, but I talked them out of it.
The trouble with LGPL is that to satisfy its conditions you need to be
pretty careful about how you link things together.  Working in the
constrained environment of a bootloader also puts technical conditions
on how you can link things.

Satisfying both at once might be possibly, but it's fiddly at the very
least.  I don't want to make life that difficult for libfdt users.  I
think what we'll end up with is GPL with a special exception allowing
fairly unrestricted use of libfdt.  This is like the license on bison,
though the exception text will probably be different.

> I made some trivial changes to fdt.h and libfdt_env.h to allow libfdt to 
> compiler both on linux and for u-boot.  I've attached a patch since it 
> _is_ trivial.

> Here is the thumbnail sketch of my current changes to use libfdt in u-boot:
> 
> Makefile
> --------
> * Replaced with a u-boot version, unavoidable.
> 
> fdt.h
> -----
> * See attached patchfile for trivial change to allow compiling under
>     linux and u-boot.

I'm actually more inclined to just remove the #include from fdt.h
entirely and require users to provide the stdint types, by whatever
means, before they include fdt.h.  It's a bit icky, but I think it's
the sanest way to allow building in multiple environment.

> libfdt_env.h
> ------------

Gah.  Let me say this again:
	libfdt_env.h is *supposed* to be replaced for the environment
	into which you're building libfdt.

	To be replaced is libfdt_env.h's entire purpose in existence.

	The provided libfdt_env.h is an example for userspace builds
	only.

[snip]
> fdt_rw.c
> --------
> * Nonessential improvements to fdt_open_into()
>   * Validate the header (fdt_move() does the validation, but I skip
>       the move if buf == fdt so I needed to add the validation)
>   * Do the fdt_move() only if (buf != fdt) - I call this at times with
>       a new (longer) length but don't want to actually move the blob,
>       just want the longer length so I can modify the fdt in-place.  The
>       current code works, but it seemed silly to do a move if I'm not
>       actually moving it.

If fdt == buf, the memmove() in fdt_move() will become a no-op in any
case.  I don't see any point to conditionalizing the fdt_move().

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
