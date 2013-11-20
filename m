Return-Path: <scottwood@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0252.outbound.messaging.microsoft.com [213.199.154.252])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CAF792C010A
 for <linuxppc-dev@ozlabs.org>; Thu, 21 Nov 2013 03:41:34 +1100 (EST)
Message-ID: <1384965671.1403.414.camel@snotra.buserror.net>
Subject: Re: [RFC][PATCH] powerpc/CoreNet64: compile with
 CONFIG_E{5,6}500_CPU well
From: Scott Wood <scottwood@freescale.com>
To: Tiejun Chen <tiejun.chen@windriver.com>
Date: Wed, 20 Nov 2013 10:41:11 -0600
In-Reply-To: <1384936551-8494-1-git-send-email-tiejun.chen@windriver.com>
References: <1384936551-8494-1-git-send-email-tiejun.chen@windriver.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-11-20 at 16:35 +0800, Tiejun Chen wrote:
> CONFIG_ALTIVEC is always enabled for CoreNet64.

In the defconfig perhaps, but this isn't a generally true statement.

> And if we select CONFIG_E{5,6}500_CPU this may introduce -mcpu=e500mc64
> into $CFLAGS. But Altivec and Spe options not allowed with
> e500mc64, so :

Sigh.

>   CC      arch/powerpc/lib/xor_vmx.o
> arch/powerpc/lib/xor_vmx.c:1:0: error: AltiVec not supported in this target
> make[1]: *** [arch/powerpc/lib/xor_vmx.o] Error 1
> make: *** [arch/powerpc/lib] Error 2
> 
> Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
> ---
>  arch/powerpc/lib/Makefile |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
> index 95a20e1..641a77d 100644
> --- a/arch/powerpc/lib/Makefile
> +++ b/arch/powerpc/lib/Makefile
> @@ -40,5 +40,8 @@ obj-y			+= code-patching.o
>  obj-y			+= feature-fixups.o
>  obj-$(CONFIG_FTR_FIXUP_SELFTEST) += feature-fixups-test.o
>  
> +# Altivec and Spe options not allowed with e500mc64 in GCC.
> +ifeq ($(call cc-option-yn,-mcpu=e500mc64),n)
>  obj-$(CONFIG_ALTIVEC)	+= xor_vmx.o
>  CFLAGS_xor_vmx.o += -maltivec -mabi=altivec
> +endif

This does not seem like the right fix.  What if GCC supports both
-mcpu=e500mc64 and -mcpu=e6500, and we're using the latter?  Or for that
matter, if we're using -mcpu=whatever-ibm-chip-has-this?

Plus, wouldn't you need to do something to prevent code in that file
from being called?

-Scott
