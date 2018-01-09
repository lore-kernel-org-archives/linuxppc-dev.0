Return-Path: <srs0=xg37=ee=kroah.com=greg@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zG4VP4Vy6zF0dK
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jan 2018 19:06:53 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3zG4VN7507z8syC
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jan 2018 19:06:52 +1100 (AEDT)
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3zG4VN0DBfz9sNr
 for <linuxppc-dev@ozlabs.org>; Tue,  9 Jan 2018 19:06:50 +1100 (AEDT)
Date: Tue, 9 Jan 2018 09:03:10 +0100
From: Greg KH <greg@kroah.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
 tglx@linutronix.de, peterz@infradead.org, npiggin@gmail.com,
 anton@samba.org, mikey@neuling.org, oohall@gmail.com, paulus@samba.org
Subject: Re: [PATCH 09/11] powerpc/64s: Allow control of RFI flush via sysfs
Message-ID: <20180109080310.GA9100@kroah.com>
References: <20180108165453.26066-1-mpe@ellerman.id.au>
 <20180108165453.26066-9-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180108165453.26066-9-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 09, 2018 at 03:54:51AM +1100, Michael Ellerman wrote:
> From: Nicholas Piggin <npiggin@gmail.com>
> 
> Expose the state of the RFI flush (enabled/disabled) via sysfs, and
> allow it to be enabled/dissabled at runtime.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/kernel/setup.h |  2 ++
>  arch/powerpc/kernel/sysfs.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 43 insertions(+)

You forgot a Documentation/ABI/ update for a new sysfs file :(

> diff --git a/arch/powerpc/kernel/setup.h b/arch/powerpc/kernel/setup.h
> index 21c18071d9d5..493b03b0a966 100644
> --- a/arch/powerpc/kernel/setup.h
> +++ b/arch/powerpc/kernel/setup.h
> @@ -61,4 +61,6 @@ void kvm_cma_reserve(void);
>  static inline void kvm_cma_reserve(void) { };
>  #endif
>  
> +extern bool rfi_flush;
> +
>  #endif /* __ARCH_POWERPC_KERNEL_SETUP_H */
> diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
> index b8d4a1dac39f..8c19d014cffc 100644
> --- a/arch/powerpc/kernel/sysfs.c
> +++ b/arch/powerpc/kernel/sysfs.c
> @@ -20,6 +20,7 @@
>  #include <asm/firmware.h>
>  
>  #include "cacheinfo.h"
> +#include "setup.h"
>  
>  #ifdef CONFIG_PPC64
>  #include <asm/paca.h>
> @@ -496,6 +497,43 @@ static DEVICE_ATTR(spurr, 0400, show_spurr, NULL);
>  static DEVICE_ATTR(purr, 0400, show_purr, store_purr);
>  static DEVICE_ATTR(pir, 0400, show_pir, NULL);
>  
> +#ifdef CONFIG_PPC_BOOK3S_64
> +static ssize_t show_rfi_flush(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	return sprintf(buf, "%d\n", rfi_flush ? 1 : 0);
> +}
> +
> +static ssize_t __used store_rfi_flush(struct device *dev,
> +		struct device_attribute *attr, const char *buf,
> +		size_t count)
> +{
> +	int val;
> +	int ret = 0;
> +
> +	ret = sscanf(buf, "%d", &val);
> +	if (ret != 1)
> +		return -EINVAL;
> +
> +	if (val == 1)
> +		rfi_flush_enable(true);
> +	else if (val == 0)
> +		rfi_flush_enable(false);
> +	else
> +		return -EINVAL;
> +
> +	return count;
> +}
> +
> +static DEVICE_ATTR(rfi_flush, 0600,
> +		show_rfi_flush, store_rfi_flush);

DEVICE_ATTR_RW()?  And why 0600?  That's odd.

> +
> +static void sysfs_create_rfi_flush(void)
> +{
> +	device_create_file(cpu_subsys.dev_root, &dev_attr_rfi_flush);

No error checking?

And as Thomas said, why not just use the generic infrastructure he
created instead?  That way there is some form of unity here for the same
exact issue.

At least he documented the api :)

thanks,

greg k-h
