Return-Path: <dgibson@ozlabs.org>
Date: Thu, 22 Mar 2007 12:25:07 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jerry Van Baren <gerald.vanbaren@comcast.net>
Subject: Re: libfdt: going forward for u-boot
Message-ID: <20070322012507.GF2295@localhost.localdomain>
References: <4601C8F7.5060006@comcast.net>
	<20070322004959.GE2295@localhost.localdomain>
	<4601D7FF.1080801@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4601D7FF.1080801@comcast.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 21, 2007 at 09:12:31PM -0400, Jerry Van Baren wrote:
> David Gibson wrote:
> > On Wed, Mar 21, 2007 at 08:08:23PM -0400, Jerry Van Baren wrote:
> >> Hi David,
> >>
> >> I'm using libfdt in u-boot and getting close to pushing u-boot changes 
> >> upstream.  I'm curious what libfdt's legal status is WRT dual licensing 
> >> and the legal dogs you've unleashed.
> > 
> > Um.. still working on it.  I've been through one round with the
> > lawyers, and I've spent the last few days gathering my energy to
> > adjust my proposal for another pass.  Progress is happening, albeit
> > fairly slowly.
> 
> Good luck.
> 
> [snip]
> 
> >> fdt.h
> >> -----
> >> * See attached patchfile for trivial change to allow compiling under
> >>     linux and u-boot.
> > 
> > I'm actually more inclined to just remove the #include from fdt.h
> > entirely and require users to provide the stdint types, by whatever
> > means, before they include fdt.h.  It's a bit icky, but I think it's
> > the sanest way to allow building in multiple environment.
> 
> Yeah, chose your icky.  The icky I did was to use __KERNEL__ because 
> u-boot -D defines it.  That implies it should compile in a linux kernel 
> environment, but I didn't verify that it actually does compile.  Same 
> file, different icky.
> 
> >> libfdt_env.h
> >> ------------
> > 
> > Gah.  Let me say this again:
> > 	libfdt_env.h is *supposed* to be replaced for the environment
> > 	into which you're building libfdt.
> > 
> > 	To be replaced is libfdt_env.h's entire purpose in existence.
> > 
> > 	The provided libfdt_env.h is an example for userspace builds
> > 	only.
> 
> Understood, but if I can do a (fairly) trivial change that allows me to 
> compile under linux for regression testing and u-boot without changing 
> the file, the lazy engineer in me says Yaaaya!  Maybe I'm just working 
> to hard. :-/  Different file, same icky.

Once you have a uboot version of libfdt_env.h (which you can do by
copying the example and tweaking slightly) it shouldn't be any
harder.  Just move across all the files except libfdt_env.h.

> >> fdt_rw.c
> >> --------
> >> * Nonessential improvements to fdt_open_into()
> >>   * Validate the header (fdt_move() does the validation, but I skip
> >>       the move if buf == fdt so I needed to add the validation)
> >>   * Do the fdt_move() only if (buf != fdt) - I call this at times with
> >>       a new (longer) length but don't want to actually move the blob,
> >>       just want the longer length so I can modify the fdt in-place.  The
> >>       current code works, but it seemed silly to do a move if I'm not
> >>       actually moving it.
> > 
> > If fdt == buf, the memmove() in fdt_move() will become a no-op in any
> > case.  I don't see any point to conditionalizing the fdt_move().
> 
> But it allows me to make the blob bigger.  Ahh, it looks like all I need 
> to do is:
>          fdt_set_header(fdt, totalsize, bufsize);
> so I agree, I'm working way too hard on this one.

No, if you want to make more space to do edits in, you should
definitely be using fdt_open_into() - that's the purpose of
fdt_open_into().  I'm just saying there's no need to conditionalize
the fdt_move(), because fdt_move() *already* correctly handles the
case where fdt==buf.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
