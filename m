Return-Path: <bzolnier@gmail.com>
Received: from mu-out-0910.google.com (mu-out-0910.google.com [209.85.134.186])
	by ozlabs.org (Postfix) with ESMTP id ACE42DDF97
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 04:38:27 +1000 (EST)
Received: by mu-out-0910.google.com with SMTP id w8so3584773mue.1
	for <linuxppc-dev@ozlabs.org>; Wed, 09 Apr 2008 11:38:23 -0700 (PDT)
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] siimage: fix kernel oops on PPC 44x
Date: Wed, 9 Apr 2008 20:14:01 +0200
References: <200804080005.03683.sshtylyov@ru.mvista.com>
	<200804072330.00610.bzolnier@gmail.com>
	<47FB6EA5.4070606@ru.mvista.com>
In-Reply-To: <47FB6EA5.4070606@ru.mvista.com>
MIME-Version: 1.0
Message-Id: <200804092014.01643.bzolnier@gmail.com>
Content-Type: text/plain;
  charset="iso-8859-1"
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 08 April 2008, Sergei Shtylyov wrote:
> Bartlomiej Zolnierkiewicz wrote:
> 
> >>Fix kernel oops due to machine check occuring in init_chipset_siimage() on PPC
> >>44x platforms.  These 32-bit CPUs have 36-bit physical address and PCI I/O and
> >>memory spaces are mapped beyond 4 GB; arch/ppc/ code has a fixup in ioremap()
> >>that creates an illusion of the PCI I/O and memory resources being mapped below
> >>4 GB, while arch/powerpc/ code got rid of this fixup with PPC 44x having instead
> >>CONFIG_RESOURCES_64BIT=y -- this causes the resources to be truncated to 32-bit
> >>'unsigned long' type in this driver, and so non-existant memory being ioremap'ed
> >>and then accessed...
> 
> >>Thanks to Valentine Barshak for providing an initial patch and explanations.
> 
> >>Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
> 
> > applied and pushed to Linus, thanks!
> 
> > I guess that it would be worth to audit the rest of IDE code for
> 
>     Already done. Some drivers, like sgiioc4, scc_pata, and pmac are prone to
> that at least in theory.  Although I doubt that they ever get used in such
> environments as PPC 44x platform kernels, i.e. 32-bit kernel and PCI mapped 
> beyond 4 GB.
> 
> > pci_resource_{start,end}() vs 'unsigned long' occurences and fix them.
> 
>     There are quite a lot of those overall but they only pose danger if the 
> resource in question is in memory space since the I/O space always uses 
> 'unsigned long' addresses. So, IDE core and drivers using only I/O resources 
> should not be prone to that kind of issue.

Thanks for taking a look (good to hear that we are fine for now).

> > [ Even if they work at the moment they are just bugs waiting to happened
> >   when we add support for some new platforms or rewrite the code... ]

I still think that it is worth to switch to always using resource_size_t
with pci_resource{start,end}() - increase of the code size should be minimal
and negligable (also it would happen only for CONFIG_RESOURCES_64BIT=y)
but in the return we will keep the code consistent and hint people who're
writing new code (and are looking at the existing code as a base).

[ this is kernel-wide comment, w.r.t. to IDE - I'll try updating it when
  I have some time (unless of course somebody sends me a patch earlier :) ]

Thanks,
Bart
