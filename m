Return-Path: <christoph@schroedinger.engr.sgi.com>
Received: from omx2.sgi.com (omx2-ext.sgi.com [192.48.171.19])
	by ozlabs.org (Postfix) with ESMTP id DF233679E0
	for <linuxppc-dev@ozlabs.org>; Thu, 18 May 2006 03:24:04 +1000 (EST)
Date: Wed, 17 May 2006 10:24:00 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Eric Paris <eparis@redhat.com>
Subject: Re: [PATCH] Fix do_mlock so page alignment is to hugepage boundries
	when needed
In-Reply-To: <1147885316.26468.15.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0605171020390.13767@schroedinger.engr.sgi.com>
References: <1147885316.26468.15.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: Christoph Lameter <christoph@schroedinger.engr.sgi.com>
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org, wli@holomorphy.com,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 17 May 2006, Eric Paris wrote:

> --- linux-2.6.16.14/include/asm-sparc64/page.h.paris
> +++ linux-2.6.16.14/include/asm-sparc64/page.h
> @@ -104,6 +104,8 @@ typedef unsigned long pgprot_t;
>  #define HUGETLB_PAGE_ORDER	(HPAGE_SHIFT - PAGE_SHIFT)
>  #define ARCH_HAS_SETCLEAR_HUGE_PTE
>  #define ARCH_HAS_HUGETLB_PREFAULT_HOOK
> +/* to align the pointer to the (next) page boundary when dealing with hugepages*/
> +#define HPAGE_ALIGN(addr)       (((addr)+HPAGE_SIZE-1)&HPAGE_MASK)
>  #endif

Could you put the definition of HPAGE_ALIGN into include/linux/hugetlb.h 
to avoid modifying all the page.h files?
