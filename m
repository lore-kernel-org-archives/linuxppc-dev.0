Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 17FC12C0099
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Sep 2013 09:56:52 +1000 (EST)
Message-ID: <1378079740.3978.13.camel@pasglop>
Subject: Re: [PATCH] hvc_vio: Do not override preferred console set by
 kernel parameter
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ben Hutchings <ben@decadent.org.uk>
Date: Mon, 02 Sep 2013 09:55:40 +1000
In-Reply-To: <1378052656.25743.33.camel@deadeye.wl.decadent.org.uk>
References: <1378052656.25743.33.camel@deadeye.wl.decadent.org.uk>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Bastian Blank <waldi@debian.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>,
 linuxppc-dev@lists.ozlabs.org,
 Debian kernel maintainers <debian-kernel@lists.debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2013-09-01 at 17:24 +0100, Ben Hutchings wrote:
> The original version of this was done by Bastian Blank, who wrote:
> 
> > The problem is the following:
> > - Architecture specific code sets preferred console to something bogus.
> > - Command line handling tries to set preferred console but is overruled
> >   by the old setting.
> > 
> > The udbg0 console is a boot console and independant.
> 
> References: http://bugs.debian.org/492703
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> ---
> We've been carrying this in Debian for 5 years now, so it's about time
> it got reviewed.
> 
> I'm not convinced strstr() is the right way to check the command line
> (what if there's also a 'netconsole='?).

Also I think the problem should be solved elsewhere :-)

In the end, what that code is trying to do (as are all the other similar
instances) is to set "this is a good default in case nothing is
specified *or* what is specified doesn't actually exist".

Of course "doesn't exist" is tricky since the console could be provided
by a module loaded god knows when ... but in that case, maybe it does
make sense to stick to one of the known good defaults. After all, init
will fail without a tty ...

So I'm thinking we should in kernel/printk.c keep track of all those
"arch defaults" when console= is specified as "latent" consoles, and
right before starting init, if the specified one didn't work out (we
have no console with an associated tty), then go through those latent
ones and pick one that works.

Cheers,
Ben.
