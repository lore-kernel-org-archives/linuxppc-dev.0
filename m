Return-Path: <paul.gortmaker@gmail.com>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
 [209.85.160.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4D8CBB6EFE
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Jan 2012 02:50:05 +1100 (EST)
Received: by ghbz2 with SMTP id z2so718940ghb.38
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Jan 2012 07:50:02 -0800 (PST)
MIME-Version: 1.0
Sender: paul.gortmaker@gmail.com
In-Reply-To: <1327157528-12312-1-git-send-email-paul.gortmaker@windriver.com>
References: <1327157528-12312-1-git-send-email-paul.gortmaker@windriver.com>
Date: Sat, 21 Jan 2012 10:50:02 -0500
Message-ID: <CAP=VYLrjismj5PBfm=3LcVtC7pL4EXkt+JGKQNUuSJu1OU68MA@mail.gmail.com>
Subject: Re: [PATCH] powerpc/85xx: fix build failure from p1022 in SMP
 defconfig
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: galak@kernel.crashing.org
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Jan 21, 2012 at 9:52 AM, Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:
> Using the configs/mpc85xx_smp_defconfig shows this build error:
>
> arch/powerpc/platforms/85xx/p1022_ds.c:341: error: 'udbg_progress' undecl=
ared here (not in a function)
>
> Adding in the obvious missing header <asm/udbg.h> fixes it.

I just noticed this fix is a duplicate, it seems that it was already
queued back in Dec 11th last year:

http://patchwork.ozlabs.org/patch/130620/

...but for one reason or another didn't make it into 3.3-rc1.

P.

>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
>
> diff --git a/arch/powerpc/platforms/85xx/p1022_ds.c b/arch/powerpc/platfo=
rms/85xx/p1022_ds.c
> index bb3d84f..aa4022e 100644
> --- a/arch/powerpc/platforms/85xx/p1022_ds.c
> +++ b/arch/powerpc/platforms/85xx/p1022_ds.c
> @@ -26,6 +26,7 @@
> =A0#include <sysdev/fsl_soc.h>
> =A0#include <sysdev/fsl_pci.h>
> =A0#include <asm/fsl_guts.h>
> +#include <asm/udbg.h>
> =A0#include "smp.h"
>
> =A0#include "mpc85xx.h"
> --
> 1.7.7.2
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
