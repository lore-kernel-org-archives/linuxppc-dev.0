Return-Path: <dgibson@ozlabs.org>
Date: Fri, 8 Dec 2006 17:09:37 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [LIBFDT] Fixup byteswapping code
Message-ID: <20061208060937.GB32700@localhost.localdomain>
References: <11650491414017-git-send-email-grant.likely@secretlab.ca>
	<20061204015329.GA4790@localhost.localdomain>
	<528646bc0612032118i689e9c83gdfc841a3d7b91fcf@mail.gmail.com>
	<20061204055217.GA32026@localhost.localdomain>
	<528646bc0612032233y573dfbcdk29a969e19540242a@mail.gmail.com>
	<20061204071629.GC32026@localhost.localdomain>
	<528646bc0612040655j60a7e93emb151ddd55e6db984@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <528646bc0612040655j60a7e93emb151ddd55e6db984@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Dec 04, 2006 at 07:55:59AM -0700, Grant Likely wrote:
> On 12/4/06, David Gibson <david@gibson.dropbear.id.au> wrote:
> > I do have one idea for better error handling: I'd like to put in
> > something defined in the the libfdt_env.h (which is designed to be
> > replaced when libfdt is compiled in different environments) to report
> > an error.  That would be invoked every time a libfdt function exits
> > with an error - I would envisage it calling through to a user supplied
> > function pointer.
> >
> > In many practical situations, I think most libfdt errors would be the
> > result of something unrecoverable problem (such as a corrupted device
> > tree blob), the callback could just print an error (by whatever means
> > is appropritate for the environment) and bail out, avoiding the need
> > for checking return values.  At least for the "serious" errors
> > (BADMAGIC, BADSTRUCTURE and so forth).  NOTFOUND (and maybe TRUNCATED)
> > would need to be passed back as a return value still, since that can
> > certainly occur in a legitimate test.
> 
> Yeah, that's not a bad idea.  That way the complexity of making it
> thread safe is left with the execution environment, not with libfdt,
> and it still leaves the possibility of application code retrieving the
> error code if it is interested....  Still not ideal, but of the
> options presented, I like this one best.

Actually, I had some more thought about this.  There really aren't
that many functions returning pointers there's:
	_fdt_getprop()	(which I'm thinking about renaming and making 
			 externally visible)
	fdt_getprop()
	fdt_create()
	fdt_open_into()
	fdt_pack()
	fdt_move()

fdt_pack() doesn't actually move anything, so it could just return an
error code instead.

fdt_open_into(), fdt_create() and fdt_move() all return a device tree
at the beginning of the given buffer.  So, they too could return just
an error code instead.  That's a little ugly from the user's POV
because they'd have to manually cast the (void *) buffer pointer into
(struct fdt_header *).  However, I was thinking in any case about
changing all the fdt parameters to just be void * and doing the casts
inside the library, which removes that problem.  In addition it
re-emphasises the idea of the blob as a blob, whose internal structure
the caller need not understand.

That leaves _fdt_getprop() and fdt_getprop().  Those both take an int
pointer to return the length.  So, I was thinking they could instead
return NULL for errors, and store the detailed error code in the
length parameter:  both structure offsets and lengths have the nice
property that negative values are "naturally" out-of-bounds.

What do you think?

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
