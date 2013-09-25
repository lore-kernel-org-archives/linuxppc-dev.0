Return-Path: <mingo.kernel.org@gmail.com>
Received: from mail-ee0-x22e.google.com (mail-ee0-x22e.google.com
 [IPv6:2a00:1450:4013:c00::22e])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CAF262C0098
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Sep 2013 17:30:57 +1000 (EST)
Received: by mail-ee0-f46.google.com with SMTP id c13so2976095eek.33
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Sep 2013 00:30:53 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Wed, 25 Sep 2013 09:30:49 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Timothy Pepper <timothy.c.pepper@linux.intel.com>
Subject: Re: mm: insure topdown mmap chooses addresses above security minimum
Message-ID: <20130925073048.GB27960@gmail.com>
References: <1380057811-5352-1-git-send-email-timothy.c.pepper@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1380057811-5352-1-git-send-email-timothy.c.pepper@linux.intel.com>
Cc: linux-mips@linux-mips.org, Russell King <linux@arm.linux.org.uk>,
 Andrew Morton <akpm@linux-foundation.org>, Paul Mundt <lethal@linux-sh.org>,
 linux-sh@vger.kernel.org, x86@kernel.org, Ralf Baechle <ralf@linux-mips.org>,
 linux-mm@kvack.org, Linus Torvalds <torvalds@linux-foundation.org>,
 Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
 "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* Timothy Pepper <timothy.c.pepper@linux.intel.com> wrote:

> A security check is performed on mmap addresses in
> security/security.c:security_mmap_addr().  It uses mmap_min_addr to insure
> mmaps don't get addresses lower than a user configurable guard value
> (/proc/sys/vm/mmap_min_addr).  The arch specific mmap topdown searches
> look for a map candidate address all the way down to a low_limit that is
> currently hard coded as PAGE_SIZE.  Depending on compile time options
> and userspace setting the procfs tunable, the security check's view of
> the minimum allowable address may be something greater than PAGE_SIZE.
> This leaves a gap where get_unmapped_area()'s call to get_area() might
> return an address above PAGE_SIZE, but below mmap_min_addr, and thus
> get_unmapped_area() fails.
> 
> This was seen on x86_64 in the case of a topdown address space and a large
> stack rlimit, with mmap_min_addr having been set to 32k by the distro.
> This left a 28k gap where the get area search intends to place a small
> mmap, but then get_unmapped_area() stumbles at the security check.
> 
> What should have happened is the address search wraps back to a higher
> address, the search continues and perhaps succeeds.  Indeed an mmap of
> a larger size gets a topdown search that does wrap around back up into
> the rlimit stack reserve and succeeds assuming suitable free space.
> But a small mmap fits in the low gap and always fails.  It becomes
> possible to make large mmaps but not small ones.
> 
> When an explicit address hint is given, mm/mmap.c's round_hint_to_min()
> will round up to mmap_min_addr.
> 
> A topdown search's low_limit should similarly consider mmap_min_addr
> instead of just PAGE_SIZE.
> 
> Signed-off-by: Tim Pepper <timothy.c.pepper@linux.intel.com>
> Cc: linux-mm@kvack.org
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: x86@kernel.org
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: Paul Mundt <lethal@linux-sh.org>
> Cc: linux-sh@vger.kernel.org
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: sparclinux@vger.kernel.org
> --
>  arch/arm/mm/mmap.c               | 3 ++-
>  arch/mips/mm/mmap.c              | 3 ++-
>  arch/powerpc/mm/slice.c          | 3 ++-
>  arch/sh/mm/mmap.c                | 3 ++-
>  arch/sparc/kernel/sys_sparc_64.c | 3 ++-
>  arch/x86/kernel/sys_x86_64.c     | 3 ++-
>  6 files changed, 12 insertions(+), 6 deletions(-)
> 
> +	info.low_limit = max(PAGE_SIZE, PAGE_ALIGN(mmap_min_addr));
>  	info.high_limit = mm->mmap_base;
>  	info.align_mask = do_align ? (PAGE_MASK & (SHMLBA - 1)) : 0;
>  	info.align_offset = pgoff << PAGE_SHIFT;

>  		info.flags = VM_UNMAPPED_AREA_TOPDOWN;
> -		info.low_limit = PAGE_SIZE;
> +		info.low_limit = max(PAGE_SIZE, PAGE_ALIGN(mmap_min_addr));
>  		info.high_limit = mm->mmap_base;
>  		addr = vm_unmapped_area(&info);

> -		info.low_limit = addr;
> +		info.low_limit = max(addr, PAGE_ALIGN(mmap_min_addr));

>  	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
>  	info.length = len;
> -	info.low_limit = PAGE_SIZE;
> +	info.low_limit = max(PAGE_SIZE, PAGE_ALIGN(mmap_min_addr));
>  	info.high_limit = mm->mmap_base;
>  	info.align_mask = do_colour_align ? (PAGE_MASK & shm_align_mask) : 0;
>  	info.align_offset = pgoff << PAGE_SHIFT;

>  	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
>  	info.length = len;
> -	info.low_limit = PAGE_SIZE;
> +	info.low_limit = max(PAGE_SIZE, PAGE_ALIGN(mmap_min_addr));
>  	info.high_limit = mm->mmap_base;
>  	info.align_mask = do_color_align ? (PAGE_MASK & (SHMLBA - 1)) : 0;
>  	info.align_offset = pgoff << PAGE_SHIFT;

>  	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
>  	info.length = len;
> -	info.low_limit = PAGE_SIZE;
> +	info.low_limit = max(PAGE_SIZE, PAGE_ALIGN(mmap_min_addr));
>  	info.high_limit = mm->mmap_base;
>  	info.align_mask = filp ? get_align_mask() : 0;
>  	info.align_offset = pgoff << PAGE_SHIFT;

There appears to be a lot of repetition in these methods - instead of 
changing 6 places it would be more future-proof to first factor out the 
common bits and then to apply the fix to the shared implementation.

Thanks,

	Ingo
