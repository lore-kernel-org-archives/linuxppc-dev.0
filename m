Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 23FE0B6F77
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 18 Jul 2011 08:35:05 +1000 (EST)
Subject: Re: [PATCH 1/1] Fixup write permission of TLB on powerpc e500 core
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Shan Hai <haishan.bai@gmail.com>
In-Reply-To: <4E230270.20209@gmail.com>
References: <1310717238-13857-1-git-send-email-haishan.bai@gmail.com>
	<1310717238-13857-2-git-send-email-haishan.bai@gmail.com>
	<1310725418.2586.309.camel@twins>  <4E21A526.8010904@gmail.com>
	<1310860194.25044.17.camel@pasglop> <1310900561.13765.22.camel@twins>
	<4E22E4AC.7040600@gmail.com> <1310914117.25044.216.camel@pasglop>
	<4E230270.20209@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 18 Jul 2011 08:34:18 +1000
Message-ID: <1310942058.25044.227.camel@pasglop>
Mime-Version: 1.0
Cc: tony.luck@intel.com, Peter Zijlstra <a.p.zijlstra@chello.nl>,
	linux-kernel@vger.kernel.org, cmetcalf@tilera.com,
	dhowells@redhat.com, paulus@samba.org, tglx@linutronix.de,
	walken@google.com, linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2011-07-17 at 23:40 +0800, Shan Hai wrote:
> On 07/17/2011 10:48 PM, Benjamin Herrenschmidt wrote:
> > On Sun, 2011-07-17 at 21:33 +0800, Shan Hai wrote:
> >> On ARM you could not protect pages from supervisor-mode writes,
> >> isn't it?  That means, all writable user pages are writable for
> >> supervisor too, but its not hold for at least x86 and powerpc,
> >> x86 and powerpc can be configured to protect pages from
> >> supervisor-mode writes.
> > That doesn't sound right... how would put_user() work properly then ? A
> > cursory glance at the ARM code doesn't show it doing anything "special",
> > just stores ... but I might have missing something.
> >
> 
> That's real for ARM, for the reason put_user() work properly is that
> the first time access to the write protected page triggers a page
> fault, and the handle_mm_fault() will fix up the write permission
> for the kernel, because at this time no one disabled the page fault
> as done in the futex case.

Sorry, you don't make sense here, you first say that ARM cannot protect
pages from supervisor writes, and then you write that put_user() will
work because it triggers a page fault :-) Those are mutually exclusive.

If you have a read-only PTE present, put_user() will trigger a page
fault on writes because the supervisor sees the same "write" protection
as userspace, for user pages that is, at least that's how it works on
most archs and I didn't think ARM was any different.

Note that things are different for -kernel- pages (ie, linear mapping,
vmalloc, etc...) for some archs. For example, on hash-table based
powerpc MMUs, it's not always possible to create a kernel-only read-only
mapping. But user mappings (below PAGE_OFFSET) always honor userspace
protections regardless of whether the CPU is in supervisor or user mode.

Anyway, we are getting on a side track here. Let's sort out our original
futex problem first.

> So, for the reason the SW tracked dirty/young and supervisor protected
> pages has potential effects on not only *futex* but also on other components
> of the kernel which might access the non-dirty supervisor protected page,
> in my opinion it might be more sensible to fix it from gup instead of fixing
> it in the futex.

Well, again it depends. First let's not use "supervisor protected" here.
Those pages are user pages. The supervisor just honors the user
protection from what I can tell. Real "supervisor protected" (such as
read-only kernel text pages etc...) are a completely different beast.

Secondly, we don't need anything special for the "normal" user access
cases, which are get/put_user, copy_tofrom_user, or gup followed with
access to the pages directly via the linear mapping, kmap, etc...

The problem is specific to code path doing user accesses within
pagefault_disable() sections -and- expecting to use gup to "fixup"
things when they fail.

Do we have many more than futex here ?

I -do- tend to prefer the fix inside gup approach for different reasons,
simply because gup already walks the page tables (well, follow_pages()
does) and we already have usable "flags" arguments to both gup and
follow_pages() that we can hijack to add our "update dirty & young now"
attribute.

So it should be a simple patch, provided Peter etc... agree in principle
with the approach.

Cheers,
Ben.

> Thanks
> Shan Hai
> 
> > Cheers,
> > Ben.
> >
> >
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
