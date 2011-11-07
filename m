Return-Path: <gregkh@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 324B81007D5
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Nov 2011 07:25:19 +1100 (EST)
Date: Mon, 7 Nov 2011 12:24:51 -0800
From: Greg KH <gregkh@suse.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: Regression: patch " hvc_console: display printk messages on
 console." causing infinite loop with 3.2-rc0 + Xen.
Message-ID: <20111107202451.GA14482@suse.de>
References: <20111027053007.GA32765@phenom.dumpdata.com>
 <20111027054806.GA1377@suse.de>
 <20111102121309.4dbb0d2ac90d2879130820dd@canb.auug.org.au>
 <20111103013012.GB3449@suse.de>
 <20111107171942.fe21429583491475f245aa08@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111107171942.fe21429583491475f245aa08@canb.auug.org.au>
Cc: Rusty Russell <rusty@rustcorp.com.au>, xen-devel@lists.xensource.com,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>, miche@google.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Anton Blanchard <anton@samba.org>, Amit Shah <amit.shah@redhat.com>,
 Linus <torvalds@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 07, 2011 at 05:19:42PM +1100, Stephen Rothwell wrote:
> Hi Greg,
> 
> On Wed, 2 Nov 2011 18:30:12 -0700 Greg KH <gregkh@suse.de> wrote:
> >
> > On Wed, Nov 02, 2011 at 12:13:09PM +1100, Stephen Rothwell wrote:
> > > 
> > > On Thu, 27 Oct 2011 07:48:06 +0200 Greg KH <gregkh@suse.de> wrote:
> > > >
> > > > On Thu, Oct 27, 2011 at 01:30:08AM -0400, Konrad Rzeszutek Wilk wrote:
> > > > > Hey Miche.
> > > > > 
> > > > > The git commit 361162459f62dc0826b82c9690a741a940f457f0:
> > > > > 
> > > > >     hvc_console: display printk messages on console.
> > > > > 
> > > > > is causing an infinite loop when booting Linux under Xen, as so:
> > > > 
> > > > Ick, not good, thanks for letting us know.
> > > 
> > > Indeed. I am wondering why it was put in a tree and sent to Linus without
> > > any Acks or even being replied to by anyone.  It appeared in the tty tree
> > > between Oct 14 and Oct 25 (while I was unfortunately on vacation).  If
> > > anyone had tried to boot this on any PowerPC server, it would have been
> > > immediately obvious (as it was when I booted Linus' tree last night).
> > > 
> > > And the original author expressed doubts as to his understanding of how
> > > it should all work anyway.
> > > 
> > > Just a little more care, please.
> > > 
> > > I would vote for reverting the original and having it resubmitted with
> > > corrections at some later date.
> > 
> > You are right, I will go do that, sorry for the problems.
> 
> Ping ...
> 
> Linus can you please just revert 361162459f62dc0826b82c9690a741a940f457f0
> "hvc_console: display printk messages on console" as it breaks consoles
> for all PowerPC server machines.

Thanks for doing this, I was going to include it in my next pull request
after 3.2-rc1 was out, but you are right, it should have gone in sooner.

greg k-h
