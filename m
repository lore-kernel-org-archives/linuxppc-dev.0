Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 21D561A189D
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Oct 2014 16:02:38 +1000 (EST)
In-Reply-To: <1412073306-13812-16-git-send-email-mikey@neuling.org>
To: Michael Neuling <mikey@neuling.org>, greg@kroah.com, arnd@arndb.de,
 benh@kernel.crashing.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2 15/17] cxl: Userspace header file.
Message-Id: <20141002060237.E9963140180@ozlabs.org>
Date: Thu,  2 Oct 2014 16:02:37 +1000 (EST)
Cc: cbe-oss-dev@lists.ozlabs.org, mikey@neuling.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, imunsie@au.ibm.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, jk@ozlabs.org,
 anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-30-09 at 10:35:04 UTC, Michael Neuling wrote:
> From: Ian Munsie <imunsie@au1.ibm.com>
> 
> This defines structs and magic numbers required for userspace to interact with
> the kernel cxl driver via /dev/cxl/afu0.0.
> 
> diff --git a/include/uapi/misc/cxl.h b/include/uapi/misc/cxl.h
> new file mode 100644
> index 0000000..6a394b5
> --- /dev/null
> +++ b/include/uapi/misc/cxl.h
> @@ -0,0 +1,88 @@
> +/*
> + * Copyright 2014 IBM Corp.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */
> +
> +#ifndef _UAPI_ASM_CXL_H
> +#define _UAPI_ASM_CXL_H
> +
> +#include <linux/types.h>
> +#include <linux/ioctl.h>
> +
> +/* ioctls */
> +struct cxl_ioctl_start_work {
> +	__u64 wed;
> +	__u64 amr;
> +	__u64 reserved1;
> +	__u32 reserved2;
> +	__s16 num_interrupts; /* -1 = use value from afu descriptor */
> +	__u16 process_element; /* returned from kernel */
> +	__u64 reserved3;
> +	__u64 reserved4;
> +	__u64 reserved5;
> +	__u64 reserved6;

Why so many reserved fields?

What mechanism is there that will allow you to ever unreserve them?

ie. how does a new userspace detect that the kernel it's running on supports
new fields?

Or conversely how does a new kernel detect that userspace has passed it a
meaningful value in one of the previously reserved fields?

> +#define CXL_MAGIC 0xCA
> +#define CXL_IOCTL_START_WORK      _IOWR(CXL_MAGIC, 0x00, struct cxl_ioctl_start_work)

What happened to 0x1 ?

> +#define CXL_IOCTL_CHECK_ERROR     _IO(CXL_MAGIC,   0x02)
> +
> +/* events from read() */
> +
> +enum cxl_event_type {
> +	CXL_EVENT_READ_FAIL     = -1,

I don't see this used?

> +	CXL_EVENT_RESERVED      = 0,
> +	CXL_EVENT_AFU_INTERRUPT = 1,
> +	CXL_EVENT_DATA_STORAGE  = 2,
> +	CXL_EVENT_AFU_ERROR     = 3,
> +};
> +
> +struct cxl_event_header {
> +	__u32 type;
> +	__u16 size;
> +	__u16 process_element;
> +	__u64 reserved1;
> +	__u64 reserved2;
> +	__u64 reserved3;
> +};

Again lots of reserved fields?

> +struct cxl_event_afu_interrupt {
> +	struct cxl_event_header header;
> +	__u16 irq; /* Raised AFU interrupt number */
> +	__u16 reserved1;
> +	__u32 reserved2;
> +	__u64 reserved3;
> +	__u64 reserved4;
> +	__u64 reserved5;
> +};
> +
> +struct cxl_event_data_storage {
> +	struct cxl_event_header header;
> +	__u64 addr;
> +	__u64 reserved1;
> +	__u64 reserved2;
> +	__u64 reserved3;
> +};
> +
> +struct cxl_event_afu_error {
> +	struct cxl_event_header header;
> +	__u64 err;
> +	__u64 reserved1;
> +	__u64 reserved2;
> +	__u64 reserved3;
> +};
> +
> +struct cxl_event {
> +	union {
> +		struct cxl_event_header header;
> +		struct cxl_event_afu_interrupt irq;
> +		struct cxl_event_data_storage fault;
> +		struct cxl_event_afu_error afu_err;
> +	};
> +};

Rather than having the header included in every event, would it be clearer if
the cxl_event was:

struct cxl_event {
	struct cxl_event_header header;
	union {
		struct cxl_event_afu_interrupt irq;
		struct cxl_event_data_storage fault;
		struct cxl_event_afu_error afu_err;
	};
};

cheers
