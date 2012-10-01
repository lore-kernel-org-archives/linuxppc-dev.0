Return-Path: <jgunthorpe@obsidianresearch.com>
Received: from quartz.orcorp.ca (quartz.orcorp.ca [184.70.90.242])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 2D5AC2C0141
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Oct 2012 03:48:44 +1000 (EST)
Date: Mon, 1 Oct 2012 11:48:40 -0600
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Josh Boyer <jwboyer@gmail.com>
Subject: Re: [PATCH] PPC: Enable the Watchdog vector for 405
Message-ID: <20121001174840.GB22342@obsidianresearch.com>
References: <20120930232723.GF30637@obsidianresearch.com>
 <CA+5PVA767HNZUoFNj=UubLCdh91EtWiuK2JaY2qarMn=oCCB+A@mail.gmail.com>
 <20121001162547.GD31620@obsidianresearch.com>
 <CA+5PVA5qW-toX1_UA9wATy=q69_yK5RXd3cXKSy6-LohExJ3+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CA+5PVA5qW-toX1_UA9wATy=q69_yK5RXd3cXKSy6-LohExJ3+Q@mail.gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Oct 01, 2012 at 01:32:47PM -0400, Josh Boyer wrote:
> On Mon, Oct 1, 2012 at 12:25 PM, Jason Gunthorpe

> >> Please leave this wrapped in CONFIG_BOOKE_WDT.  I don't agree with
> >> unconditionally enabling this for every 405 chip out there.
> >
> > What are you concerned with? If some core varient does not put a
> > watchdog there, then you still get a panic from the default watchdog
> > exception handler..
> 
> I'm concerned with the fact that you've moved PIT and now enabled
> something that's been enabled for years.  There's no need to do it like
> that.

Well, just moving the ifdef still keeps the PIT change, and either the
vector is never called and it is harmless to add the new entry point,
or CPUs have been randomly calling into DTLBMiss for years, which
seems worth discovering.

FWIW, this patch has been carried in our tree since about 2.6.14,
mind you we only use two 405 varients.

> > Yes, I didn't want to use BOOKE_WDT because I have not tested that
> > driver, nor do I want that driver included in my kernel.. I think the
> > watchdog driver in use should be orthogonal to having the exception
> > wired in?
> 
> And it certainly can be.  Just make the driver a module and don't
> install it or load it.  The #ifdef will still evaluate to true.

Well, we use non-modular kernels, but I can certainly patch the driver
out.

If I resend using BOOKE_WDT will you take it?

Thanks,
Jason
