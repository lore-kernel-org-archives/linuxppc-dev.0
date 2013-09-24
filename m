Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [IPv6:2002:4e20:1eda::1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 3249D2C00CF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Sep 2013 07:35:40 +1000 (EST)
Date: Tue, 24 Sep 2013 22:28:53 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Timothy Pepper <timothy.c.pepper@linux.intel.com>
Subject: Re: mm: insure topdown mmap chooses addresses above security minimum
Message-ID: <20130924212853.GK12758@n2100.arm.linux.org.uk>
References: <1380057811-5352-1-git-send-email-timothy.c.pepper@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1380057811-5352-1-git-send-email-timothy.c.pepper@linux.intel.com>
Sender: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-mips@linux-mips.org, Paul Mundt <lethal@linux-sh.org>,
 linux-sh@vger.kernel.org, x86@kernel.org, Ralf Baechle <ralf@linux-mips.org>,
 linux-mm@kvack.org, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
 sparclinux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 24, 2013 at 02:23:31PM -0700, Timothy Pepper wrote:
> diff --git a/arch/arm/mm/mmap.c b/arch/arm/mm/mmap.c
> index 0c63562..0e7355d 100644
> --- a/arch/arm/mm/mmap.c
> +++ b/arch/arm/mm/mmap.c
> @@ -9,6 +9,7 @@
>  #include <linux/io.h>
>  #include <linux/personality.h>
>  #include <linux/random.h>
> +#include <linux/security.h>
>  #include <asm/cachetype.h>
>  
>  #define COLOUR_ALIGN(addr,pgoff)		\
> @@ -146,7 +147,7 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
>  
>  	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
>  	info.length = len;
> -	info.low_limit = PAGE_SIZE;
> +	info.low_limit = max(PAGE_SIZE, PAGE_ALIGN(mmap_min_addr));
>  	info.high_limit = mm->mmap_base;
>  	info.align_mask = do_align ? (PAGE_MASK & (SHMLBA - 1)) : 0;
>  	info.align_offset = pgoff << PAGE_SHIFT;

This looks sane for ARM.

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

Thanks.
