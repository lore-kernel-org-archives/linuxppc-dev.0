Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C9A591A1150
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jul 2015 15:37:45 +1000 (AEST)
Message-ID: <1436333865.17490.4.camel@ellerman.id.au>
Subject: Re: [PATCH V2 2/2] powerpc/kexec: Reset HILE before kexec_sequence
From: Michael Ellerman <mpe@ellerman.id.au>
To: Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>
Cc: linuxppc-dev@ozlabs.org
Date: Wed, 08 Jul 2015 15:37:45 +1000
In-Reply-To: <1436330233-28489-2-git-send-email-sam.mj@au1.ibm.com>
References: <1436330233-28489-1-git-send-email-sam.mj@au1.ibm.com>
 <1436330233-28489-2-git-send-email-sam.mj@au1.ibm.com>
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

On Wed, 2015-07-08 at 14:37 +1000, Samuel Mendoza-Jonas wrote:
> On powernv secondary cpus are returned to OPAL, and will then enter the
> target kernel in big-endian. However if it is set the HILE bit will persist,
> causing the first exception in the target kernel to be delivered in
> litte-endian regardless of the kernel endianess.
> Make sure that the HILE bit is switched off before entering
> kexec_sequence.
> 
> Signed-off-by: Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>
> ---
>  arch/powerpc/kernel/machine_kexec_64.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/machine_kexec_64.c b/arch/powerpc/kernel/machine_kexec_64.c
> index 1a74446..2266135c 100644
> --- a/arch/powerpc/kernel/machine_kexec_64.c
> +++ b/arch/powerpc/kernel/machine_kexec_64.c
> @@ -22,8 +22,10 @@
>  #include <asm/page.h>
>  #include <asm/current.h>
>  #include <asm/machdep.h>
> +#include <asm/opal.h>
>  #include <asm/cacheflush.h>
>  #include <asm/paca.h>
> +#include <asm/firmware.h>
>  #include <asm/mmu.h>
>  #include <asm/sections.h>	/* _end */
>  #include <asm/prom.h>
> @@ -356,6 +358,10 @@ void default_machine_kexec(struct kimage *image)
>  	 * switched to a static version!
>  	 */
>  
> +	/* Reset HILE in case we kexec into an older BE kernel */
> +	if (firmware_has_feature(FW_FEATURE_OPALv3))
> +		opal_reinit_cpus(OPAL_REINIT_CPUS_HILE_BE);

It's not safe to do this here.

We are still in virtual mode and have external interrupts enabled, so you could
easily take an exception of some kind and then you'd blow up. Mashing the
keyboard during kexec might even be enough.

I think a better API would be that opal_return_cpu() deals with this under the
covers. I think we talked about that, so maybe there was some reason that
wasn't possible.

cheers
