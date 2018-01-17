Return-Path: <srs0=dxb3=em=infradead.org=rdunlap@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zMFph6zDtzF0RN
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jan 2018 05:23:56 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3zMFph5QQvz8tPJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jan 2018 05:23:56 +1100 (AEDT)
Subject: Re: [PATCH 2/5] powerpc/ftw: Define FTW_SETUP ioctl API
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
 hbabu@us.ibm.com, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
References: <1516157443-17716-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1516157443-17716-3-git-send-email-sukadev@linux.vnet.ibm.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <2eb418ec-afaf-3f03-40a2-ff9220e3d91f@infradead.org>
Date: Wed, 17 Jan 2018 10:23:50 -0800
MIME-Version: 1.0
In-Reply-To: <1516157443-17716-3-git-send-email-sukadev@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/16/18 18:50, Sukadev Bhattiprolu wrote:
> Define the FTW_SETUP ioctl interface for fast thread wakeup (FTW). A
> follow-on patch will implement the FTW driver and ioctl.
> 
> Thanks to input from Ben Herrenschmidt, Michael Neuling, Michael Ellerman.
> 
> Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> ---
> Changelog[v2]
> 	- [Michael Neuling] Use a single VAS_FTW_SETUP ioctl and simplify
> 	  the interface.
> ---
>  include/uapi/misc/ftw.h | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 include/uapi/misc/ftw.h
> 
> diff --git a/include/uapi/misc/ftw.h b/include/uapi/misc/ftw.h
> new file mode 100644
> index 0000000..f233f51
> --- /dev/null
> +++ b/include/uapi/misc/ftw.h
> @@ -0,0 +1,31 @@
> +/*
> + * Copyright 2018 IBM Corp.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */
> +
> +#ifndef _UAPI_MISC_FTW_H
> +#define _UAPI_MISC_FTW_H
> +
> +#include <linux/types.h>
> +#include <linux/ioctl.h>
> +
> +#define FTW_FLAGS_PIN_WINDOW	0x1
> +
> +#define FTW_SETUP		_IOW('v', 1, struct ftw_setup_attr)

ioctls should be documented in Documentation/ioctl/ioctl-number.txt.
Please update that file.

> +
> +struct ftw_setup_attr {
> +	__s16	version;
> +	__s16	vas_id;		/* specific instance of vas or -1 for default */
> +	__u32	reserved;
> +
> +	__u64	reserved1;
> +
> +	__u64	flags;
> +	__u64	reserved2;
> +};
> +
> +#endif /* _UAPI_MISC_FTW_H */
> 


-- 
~Randy
