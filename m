Return-Path: <dgibson@ozlabs.org>
Date: Fri, 15 Dec 2006 15:15:38 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Grant Likely <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org
Subject: Re: [LIBFDT] Fixup byteswapping code
Message-ID: <20061215041538.GD880@localhost.localdomain>
References: <11650491414017-git-send-email-grant.likely@secretlab.ca>
	<20061204015329.GA4790@localhost.localdomain>
	<528646bc0612032118i689e9c83gdfc841a3d7b91fcf@mail.gmail.com>
	<20061204055217.GA32026@localhost.localdomain>
	<528646bc0612032233y573dfbcdk29a969e19540242a@mail.gmail.com>
	<20061204071629.GC32026@localhost.localdomain>
	<528646bc0612040655j60a7e93emb151ddd55e6db984@mail.gmail.com>
	<20061208060937.GB32700@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061208060937.GB32700@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Dec 08, 2006 at 05:09:37PM +1100, David Gibson wrote:
> On Mon, Dec 04, 2006 at 07:55:59AM -0700, Grant Likely wrote:
> > On 12/4/06, David Gibson <david@gibson.dropbear.id.au> wrote:
> > > I do have one idea for better error handling: I'd like to put in
> > > something defined in the the libfdt_env.h (which is designed to be
> > > replaced when libfdt is compiled in different environments) to report
> > > an error.  That would be invoked every time a libfdt function exits
> > > with an error - I would envisage it calling through to a user supplied
> > > function pointer.
> > >
> > > In many practical situations, I think most libfdt errors would be the
> > > result of something unrecoverable problem (such as a corrupted device
> > > tree blob), the callback could just print an error (by whatever means
> > > is appropritate for the environment) and bail out, avoiding the need
> > > for checking return values.  At least for the "serious" errors
> > > (BADMAGIC, BADSTRUCTURE and so forth).  NOTFOUND (and maybe TRUNCATED)
> > > would need to be passed back as a return value still, since that can
> > > certainly occur in a legitimate test.
> > 
> > Yeah, that's not a bad idea.  That way the complexity of making it
> > thread safe is left with the execution environment, not with libfdt,
> > and it still leaves the possibility of application code retrieving the
> > error code if it is interested....  Still not ideal, but of the
> > options presented, I like this one best.
> 
> Actually, I had some more thought about this.  There really aren't
> that many functions returning pointers there's:

And I just pushed up a batch of patches which cleans up the errorr
handling as suggested there.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
