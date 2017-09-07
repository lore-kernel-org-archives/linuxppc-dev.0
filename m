Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xntyY0FPczDqYV
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Sep 2017 18:33:40 +1000 (AEST)
Message-ID: <1504773212.12628.26.camel@kernel.crashing.org>
Subject: Re: UIO memmap of PCi devices not working?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Date: Thu, 07 Sep 2017 18:33:32 +1000
In-Reply-To: <1504768943.27247.149.camel@infinera.com>
References: <1504711235.27247.110.camel@infinera.com>
 <1504768612.12628.19.camel@kernel.crashing.org>
 <1504768943.27247.149.camel@infinera.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-09-07 at 07:22 +0000, Joakim Tjernlund wrote:
> On Thu, 2017-09-07 at 17:16 +1000, Benjamin Herrenschmidt wrote:
> > On Wed, 2017-09-06 at 15:20 +0000, Joakim Tjernlund wrote:
> > > Having problems to mmap PCI UIO devices and stumbeled over this page:
> > >  http://billfarrow.blogspot.se/2010/09/userspace-access-to-pci-memory.html
> > > it claims some adjustments are needed for UIO mmap over PCI to work.
> > > These are #if 0 ATM and trying to enable them fails build.
> > > 
> > > Can this be fixed to at least build again ?
> > > The reason for having #if 0 in the first place appears to be old X servers,
> > > is that still true? Can the special casing be removed now?
> > 
> > This article seems out of date... I *think* things should work without
> > change by just mmap'ing the appropriate sysfs files. I'm not sure why
> > the author thought that had to be ifdef'ed out...
> 
> Isn't that what the article is doing(mmaping sysfs files)?
> And the article author is #ifdefing it back, not out.

Yes sorry that's what I meant. It should work as-is.

> > 
> > Let me know if you have problems.
> 
> Sure, we still are looking 
> 
> > 
> > As far as I know, the generic code will call pci_resource_to_user()
> > which on powerpc will return a physical address that already includes
> > the offset, which is why we don't later add it.
> > 
> > Now we could probably tear all that out and use the new generic code
> > instead as I *think* X has (very) long been fixed but I'd have to spend
> > some time triple checking and testing on old HW which I don't have the
> > bandwidth for right now. 
> 
> Could you fixup the code which is now #if 0 ? I wan't to test the
> difference and I not sure how to fix the build problem after changing
> those two #if 0 to #if 1
> Even better if they could be a CONFIG option instead.

Hrm it's tricky, you shouldn't just turn that ifdef back on without
also changing pci_resource_to_user(). I'm not sure exactly what's going
on in your case, if you have a problem can you add printk to instrument
?

Cheers,
Ben.
