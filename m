Return-Path: <glikely@secretlab.ca>
Received: from hs-out-0708.google.com (hs-out-0708.google.com [64.233.178.247])
	by ozlabs.org (Postfix) with ESMTP id F39E9DDF91
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Apr 2008 05:49:33 +1100 (EST)
Received: by hs-out-0708.google.com with SMTP id z77so160617hsz.9
	for <linuxppc-dev@ozlabs.org>; Fri, 04 Apr 2008 11:49:31 -0700 (PDT)
Message-ID: <fa686aa40804041149n7f9ebabdwd7ce33d5f4de3747@mail.gmail.com>
Date: Fri, 4 Apr 2008 12:49:31 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Valentine Barshak" <vbarshak@ru.mvista.com>
Subject: Re: [PATCH] PowerPC 44x: use machine_device_initcall() instead of
	device_initcall() for warp_nand
In-Reply-To: <20080404182437.GA18185@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080404182437.GA18185@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 4, 2008 at 12:24 PM, Valentine Barshak
<vbarshak@ru.mvista.com> wrote:
> With a multiplatform kernel, once built we always have warp_setup_nand_flash() called
>  and NDFC probed, no matter what machine we actually run on. This potentially can cause
>  problems (such as kernel crash), since NDFC is probed at a warp-predefined address.
>  Using machine_device_initcall() NAND devices are registered if we run on a warp only.
>
>  Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
Acked-by: Grant Likely <grant.likely@secretlab.ca>

>  ---
>   arch/powerpc/platforms/44x/warp-nand.c |    3 ++-
>   1 files changed, 2 insertions(+), 1 deletion(-)
>
>  --- linux-2.6.orig/arch/powerpc/platforms/44x/warp-nand.c       2008-03-06 14:39:46.000000000 +0300
>  +++ linux-2.6.bld/arch/powerpc/platforms/44x/warp-nand.c        2008-04-04 22:03:36.000000000 +0400
>  @@ -11,6 +11,7 @@
>   #include <linux/mtd/partitions.h>
>   #include <linux/mtd/nand.h>
>   #include <linux/mtd/ndfc.h>
>  +#include <asm/machdep.h>
>
>   #ifdef CONFIG_MTD_NAND_NDFC
>
>  @@ -100,6 +101,6 @@ static int warp_setup_nand_flash(void)
>
>         return 0;
>   }
>  -device_initcall(warp_setup_nand_flash);
>  +machine_device_initcall(warp, warp_setup_nand_flash);
>
>   #endif
>  _______________________________________________
>  Linuxppc-dev mailing list
>  Linuxppc-dev@ozlabs.org
>  https://ozlabs.org/mailman/listinfo/linuxppc-dev
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
