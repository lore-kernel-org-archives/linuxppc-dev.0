Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12]) by ozlabs.org (Postfix) with ESMTP id C5A8E2C033B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 07:22:56 +1000 (EST)
Date: Thu, 26 Sep 2013 14:22:54 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] hvc_vio: Do not override preferred console set by kernel
 parameter
Message-ID: <20130926212254.GA12564@kroah.com>
References: <1378052656.25743.33.camel@deadeye.wl.decadent.org.uk>
 <1378079740.3978.13.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1378079740.3978.13.camel@pasglop>
Cc: Bastian Blank <waldi@debian.org>, Jiri Slaby <jslaby@suse.cz>,
 Ben Hutchings <ben@decadent.org.uk>, linuxppc-dev@lists.ozlabs.org,
 Debian kernel maintainers <debian-kernel@lists.debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 02, 2013 at 09:55:40AM +1000, Benjamin Herrenschmidt wrote:
> On Sun, 2013-09-01 at 17:24 +0100, Ben Hutchings wrote:
> > The original version of this was done by Bastian Blank, who wrote:
> > 
> > > The problem is the following:
> > > - Architecture specific code sets preferred console to something bogus.
> > > - Command line handling tries to set preferred console but is overruled
> > >   by the old setting.
> > > 
> > > The udbg0 console is a boot console and independant.
> > 
> > References: http://bugs.debian.org/492703
> > Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> > ---
> > We've been carrying this in Debian for 5 years now, so it's about time
> > it got reviewed.
> > 
> > I'm not convinced strstr() is the right way to check the command line
> > (what if there's also a 'netconsole='?).
> 
> Also I think the problem should be solved elsewhere :-)
> 
> In the end, what that code is trying to do (as are all the other similar
> instances) is to set "this is a good default in case nothing is
> specified *or* what is specified doesn't actually exist".
> 
> Of course "doesn't exist" is tricky since the console could be provided
> by a module loaded god knows when ... but in that case, maybe it does
> make sense to stick to one of the known good defaults. After all, init
> will fail without a tty ...
> 
> So I'm thinking we should in kernel/printk.c keep track of all those
> "arch defaults" when console= is specified as "latent" consoles, and
> right before starting init, if the specified one didn't work out (we
> have no console with an associated tty), then go through those latent
> ones and pick one that works.

So, I shouldn't apply this patch?  We should do something to fix this,
if Debian has to drag this patch on for 5 years, that's an indication
that this might be one solution we should use, right?

thanks,

greg k-h
