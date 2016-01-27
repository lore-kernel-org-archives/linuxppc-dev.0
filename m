Return-Path: <heiko.carstens@de.ibm.com>
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7E01C1A0174
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jan 2016 20:56:10 +1100 (AEDT)
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <heiko.carstens@de.ibm.com>;
 Wed, 27 Jan 2016 09:56:06 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id B5D2E17D8062
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jan 2016 09:55:55 +0000 (GMT)
Received: from d06av09.portsmouth.uk.ibm.com (d06av09.portsmouth.uk.ibm.com
 [9.149.37.250])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0R9tkNL63045718
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jan 2016 09:55:46 GMT
Received: from d06av09.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av09.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0R9tjUq024324
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jan 2016 02:55:46 -0700
Date: Wed, 27 Jan 2016 10:55:43 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 linux-mm@kvack.org, linux-arch@vger.kernel.org,
 linux-s390@vger.kernel.org, x86@kernel.org,
 linuxppc-dev@lists.ozlabs.org, davem@davemloft.net,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, davej@codemonkey.org.uk
Subject: Re: [PATCH v2 3/3] s390: query dynamic DEBUG_PAGEALLOC setting
Message-ID: <20160127095543.GB4439@osiris>
References: <1453884618-33852-1-git-send-email-borntraeger@de.ibm.com>
 <1453884618-33852-4-git-send-email-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1453884618-33852-4-git-send-email-borntraeger@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 27, 2016 at 09:50:18AM +0100, Christian Borntraeger wrote:
> We can use debug_pagealloc_enabled() to check if we can map
> the identity mapping with 1MB/2GB pages as well as to print
> the current setting in dump_stack.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/kernel/dumpstack.c |  8 ++++----
>  arch/s390/mm/vmem.c          | 10 ++++------
>  2 files changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/s390/kernel/dumpstack.c b/arch/s390/kernel/dumpstack.c
> index dc8e204..3f352e9 100644
> --- a/arch/s390/kernel/dumpstack.c
> +++ b/arch/s390/kernel/dumpstack.c
> @@ -11,6 +11,7 @@
>  #include <linux/export.h>
>  #include <linux/kdebug.h>
>  #include <linux/ptrace.h>
> +#include <linux/mm.h>
>  #include <linux/module.h>
>  #include <linux/sched.h>
>  #include <asm/processor.h>
> @@ -184,10 +185,9 @@ void die(struct pt_regs *regs, const char *str)
>  #endif
>  #ifdef CONFIG_SMP
>  	printk("SMP ");
> -#endif
> -#ifdef CONFIG_DEBUG_PAGEALLOC
> -	printk("DEBUG_PAGEALLOC");
> -#endif
> +#endif	
> +if (debug_pagealloc_enabled())
> +		printk("DEBUG_PAGEALLOC");
>  	printk("\n");

Indentation is broken ("if").
Besides that

Reviewed-by: Heiko Carstens <heiko.carstens@de.ibm.com>
