Return-Path: <srs0=b5tj=el=gmail.com=npiggin@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zLXwb2p58zF0YV
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jan 2018 01:41:35 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3zLXwb1ttGz8t6d
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jan 2018 01:41:35 +1100 (AEDT)
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3zLXwZ4z1lz9s7n
 for <linuxppc-dev@ozlabs.org>; Wed, 17 Jan 2018 01:41:34 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id y26so2219431pfi.10
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Jan 2018 06:41:34 -0800 (PST)
Date: Wed, 17 Jan 2018 00:41:11 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc/64s: Allow control of RFI flush via debugfs
Message-ID: <20180117004111.56fd9c4c@roar.ozlabs.ibm.com>
In-Reply-To: <20180116112431.1737-1-mpe@ellerman.id.au>
References: <20180116112431.1737-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 16 Jan 2018 22:24:31 +1100
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Expose the state of the RFI flush (enabled/disabled) via debugfs, and
> allow it to be enabled/disabled at runtime.
> 
> eg: $ cat /sys/kernel/debug/powerpc/rfi_flush
>     1
>     $ echo 0 > /sys/kernel/debug/powerpc/rfi_flush
>     $ cat /sys/kernel/debug/powerpc/rfi_flush
>     0
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  arch/powerpc/kernel/setup_64.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
> index 624d2a62d05d..e67413f4a8f0 100644
> --- a/arch/powerpc/kernel/setup_64.c
> +++ b/arch/powerpc/kernel/setup_64.c
> @@ -38,6 +38,7 @@
>  #include <linux/memory.h>
>  #include <linux/nmi.h>
>  
> +#include <asm/debugfs.h>
>  #include <asm/io.h>
>  #include <asm/kdump.h>
>  #include <asm/prom.h>
> @@ -902,6 +903,35 @@ void __init setup_rfi_flush(enum l1d_flush_type types, bool enable)
>  		rfi_flush_enable(enable);
>  }
>  
> +#ifdef CONFIG_DEBUG_FS
> +static int rfi_flush_set(void *data, u64 val)
> +{
> +	if (val == 1)
> +		rfi_flush_enable(true);
> +	else if (val == 0)
> +		rfi_flush_enable(false);
> +	else
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int rfi_flush_get(void *data, u64 *val)
> +{
> +	*val = rfi_flush ? 1 : 0;
> +	return 0;
> +}
> +
> +DEFINE_SIMPLE_ATTRIBUTE(fops_rfi_flush, rfi_flush_get, rfi_flush_set, "%llu\n");
> +
> +static __init int rfi_flush_debugfs_init(void)
> +{
> +	debugfs_create_file("rfi_flush", 0600, powerpc_debugfs_root, NULL, &fops_rfi_flush);
> +	return 0;
> +}
> +device_initcall(rfi_flush_debugfs_init);
> +#endif
> +
>  ssize_t cpu_show_meltdown(struct device *dev, struct device_attribute *attr, char *buf)
>  {
>  	if (rfi_flush)
