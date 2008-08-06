Return-Path: <bunk@kernel.org>
Received: from smtp5.pp.htv.fi (smtp5.pp.htv.fi [213.243.153.39])
	by ozlabs.org (Postfix) with ESMTP id C3579DE05F
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Aug 2008 02:59:00 +1000 (EST)
Date: Wed, 6 Aug 2008 19:57:30 +0300
From: Adrian Bunk <bunk@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH]: Remove bogons from the iSeries console
Message-ID: <20080806165730.GA11188@cs181140183.pp.htv.fi>
References: <20080806140629.268fcf07@lxorguk.ukuu.org.uk>
	<20080807001006.37a9fc4f.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20080807001006.37a9fc4f.sfr@canb.auug.org.au>
Cc: boutcher@us.ibm.com, linuxppc-dev@ozlabs.org, torvalds@osdl.org,
	devilbis@us.ibm.com, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 07, 2008 at 12:10:06AM +1000, Stephen Rothwell wrote:
> Hi Alan,
> 
> On Wed, 6 Aug 2008 14:06:29 +0100 Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> >
> > The iSeries driver calls into the n_tty ldisc code directly for some
> > bizarre reason. I previously tagged this with a query but this actually
> > does need fixing as n_tty methods when you have a different ldisc set are
> > not a good thing to call.
> > 
> > In n_tty mode this change should have no effect, the core tty layer has
> > always called the ldisc ioctl method *anyway* and will call the one for
> > the right ldisc.
> > 
> > Signed-off-by: Alan Cox <alan@redhat.com>
> 
> I will take your word for it as I have no idea.  This driver needs to be
> deprecated anyway (in favour of hcv_iseries).
>...

You already marked it as "Obsolete" more than 2 years ago, and due the 
kconfig dependencies most people anyway won't even see the option (since 
they have HVC_ISERIES enabled).

IMHO a candidate for a straight removal?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
