Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from www.etchedpixels.co.uk (earthlight.etchedpixels.co.uk
	[81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 43A65B6F87
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Jun 2011 06:32:52 +1000 (EST)
Date: Wed, 1 Jun 2011 21:34:27 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 7/7] [v2] drivers/misc: introduce Freescale hypervisor
	management driver
Message-ID: <20110601213427.0021bff7@lxorguk.ukuu.org.uk>
In-Reply-To: <4DE6A013.409@freescale.com>
References: <1306953337-15698-1-git-send-email-timur@freescale.com>
	<20110601204618.32190be9@lxorguk.ukuu.org.uk>
	<4DE6A013.409@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: kumar.gala@freescale.com, linux-kernel@vger.kernel.org, akpm@kernel.org,
	linux-console@vger.kernel.org, greg@kroah.com,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 1 Jun 2011 15:24:51 -0500
Timur Tabi <timur@freescale.com> wrote:

> Alan Cox wrote:
> > O> +	/* One partition must be local, the other must be remote.  In other
> >> +	   words, if source and target are both -1, or are both not -1, then
> >> +	   return an error. */
> >> +	if ((param.source == -1) == (param.target == -1))
> >> +		return -EINVAL;
> > 
> > Excess brackets (I just mention that one in passing)'
> 
> Do you mean excess parentheses?  If so, then I don't see how.  "(param.source ==
> -1)" and "(param.target == -1)" are expressions that return a boolean.  I'm
> comparing the two boolean results to see if they're equal

Ok - it's a bit non obvious but yes fair enough and it is commented.

> Where exactly in lib/ should it go?  lib/strings.c seems too low-level for a
> function like this.  lib/string_helpers.c is for sprintf-like functions.  And
> it's too generic for lib/powerpc/

I'd submit it to lib/string personally but I'm not sure where would be
better. If someone doesn't like lib/string they can suggest a better
place 8)

> Well, the "handles" are supposed to be just unique numbers.  In this case, they
> are IRQs, but we don't want to expose that.  The application is supposed to scan
> the device tree looking for the doorbell nodes that it wants, and in those nodes
> there is a 'reg' property that contains the handle for that doorbell.  So the
> numbers just need to match.  What they represent is not relevant.

Ok so they are always going to be exposed to users not to drivers, in
which case yes it makes sense. If they are going to get used by kernel
drivers as well an IRQ interface would probably also make sense.

Alan
