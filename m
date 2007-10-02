Return-Path: <axboe@kernel.dk>
Received: from kernel.dk (brick.kernel.dk [87.55.233.238])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "A common name", Issuer "A common name" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 7FEDBDDE43
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Oct 2007 16:33:33 +1000 (EST)
Date: Tue, 2 Oct 2007 08:35:23 +0200
From: Jens Axboe <jens.axboe@oracle.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v2 2/6] Sysace: Use the established platform bus api
Message-ID: <20071002063523.GM5303@kernel.dk>
References: <20070930225112.2476.49914.stgit@trillian.cg.shawcable.net>
	<20070930225707.2476.24080.stgit@trillian.cg.shawcable.net>
	<20070930230557.GA17654@infradead.org>
	<fa686aa40709301633q32c7bd9epf07b5a78acb4380e@mail.gmail.com>
	<20071001115954.GD5303@kernel.dk>
	<1191304710.6310.97.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1191304710.6310.97.camel@pasglop>
Cc: Christoph Hellwig <hch@infradead.org>, paulus@samba.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Oct 02 2007, Benjamin Herrenschmidt wrote:
> 
> On Mon, 2007-10-01 at 13:59 +0200, Jens Axboe wrote:
> > On Sun, Sep 30 2007, Grant Likely wrote:
> > > On 9/30/07, Christoph Hellwig <hch@infradead.org> wrote:
> > > > On Sun, Sep 30, 2007 at 04:57:09PM -0600, Grant Likely wrote:
> > > > > +     if ((rc = platform_driver_register(&ace_platform_driver)) != 0)
> > > > > +             goto err_plat;
> > > >
> > > >         rc = platform_driver_register(&ace_platform_driver);
> > > >         if (rc)
> > > >                  goto err_plat;
> > > >
> > > > please.
> > > 
> > > Okay, will do.
> > > 
> > > >
> > > > > +      err_plat:
> > > > > +     unregister_blkdev(ace_major, "xsysace");
> > > > > +      err_blk:
> > > >
> > > > labels should be indented zero or one space, but not more.
> > > 
> > > scripts/Lindent does this.  Originally, I *didn't* have my labels
> > > indented.  :-)   Does Lindent need to be fixed?
> > 
> > Seems so, if it idents labels.
> > 
> > Just send a fixup patch for that, I'll add your series to the block tree
> > for 2.6.24.
> 
> It's actually better off living in the powerpc tree I think as it's
> really about adding support for a new powerpc platform and somewhat
> needs to sync with other things in there. Unless you really want the
> whole thing in your tree :-)

I already included it yesterday, it'll go up once 2.6.24 opens. Let me
know if you want me to rip it out, though.

-- 
Jens Axboe
