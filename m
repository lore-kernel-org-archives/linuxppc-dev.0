Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtai101.cox.net (fed1rmmtai101.cox.net [68.230.241.4])
	by ozlabs.org (Postfix) with ESMTP id A2C39DDF91
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Jan 2009 06:23:05 +1100 (EST)
Date: Tue, 20 Jan 2009 11:47:02 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Eric Sesterhenn <snakebyte@gmx.de>
Subject: Re: [Patch] NULL pointer deref with corrupted squashfs image
Message-ID: <20090120184702.GB30203@smtp.west.cox.net>
References: <20090113124027.GB16333@alice> <20090116174525.GA31869@alice>
	<20090116190725.GA19453@logfs.org>
	<20090116230700.GP6710@smtp.west.cox.net>
	<20090117134916.GA29641@logfs.org> <20090120163957.GA21339@alice>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20090120163957.GA21339@alice>
Cc: chris@zankel.net, phillip@lougher.demon.co.uk,
	=?iso-8859-1?Q?J=F6rn?= Engel <joern@logfs.org>,
	linuxppc-dev@ozlabs.org, rpurdie@rpsys.net, linux-fsdevel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jan 20, 2009 at 05:47:14PM +0100, Eric Sesterhenn wrote:
> * Jörn Engel (joern@logfs.org) wrote:
> > On Fri, 16 January 2009 16:07:00 -0700, Tom Rini wrote:
> > > 
> > > Sounds like a plan to me, except maybe zlib_inflate_unsafe() and a
> > > comment above the wrapper saying what/why is going on?
> > 
> > Eric, will you do the honors?  Since you did all the hard work before,
> > you derserve the fame as well. :)
> 
> Since I am not sure either about xtensa I added chris to the cc list.

How about we just change all callers from arch/*/boot to use the _unsafe
version?  Then..

> +/*
> +    These two wrappers decide wheter strm->next_out gets checked for NULL.
> +    The zlib_inflate_unsafe() version got added because the PPC zImage
> +    gets extracted to memory address 0 and therefore
> +    we avoid this check for zlib_inflate_unsafe()

These two wrappers decide wheter strm->next_out gets checked for NULL.
The zlib_inflate_unsafe() version is primarily used in the pre-Linux
'boot' directory code to allow for extraction to memory address 0 and
therefore we avoid this check.

-- 
Tom Rini
