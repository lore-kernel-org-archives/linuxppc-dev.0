Return-Path: <geoff@infradead.org>
Message-ID: <4E39CC67.2060606@infradead.org>
Date: Wed, 3 Aug 2011 15:32:07 -0700
From: Geoff Levand <geoff@infradead.org>
MIME-Version: 1.0
To: Andre Heider <a.heider@gmail.com>
Subject: Re: [PATCH 01/15] [PS3] Add udbg driver using the PS3 gelic Ethernet
	device
References: <1312228986-32307-1-git-send-email-a.heider@gmail.com>
	<1312228986-32307-2-git-send-email-a.heider@gmail.com>
In-Reply-To: <1312228986-32307-2-git-send-email-a.heider@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: cbe-oss-dev@lists.ozlabs.org, Hector Martin <hector@marcansoft.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/01/2011 01:02 PM, Andre Heider wrote:
> --- /dev/null
> +++ b/arch/powerpc/platforms/ps3/gelic_udbg.c
> @@ -0,0 +1,272 @@
> +/*
> + * arch/powerpc/platforms/ps3/gelic_udbg.c

Don't put file names in files.  When the file gets moved, then this will
no longer be correct.

> + *
> + * udbg debug output routine via GELIC UDP broadcasts
> + * Copyright (C) 2010 Hector Martin <hector@marcansoft.com>
> + * Copyright (C) 2011 Andre Heider <a.heider@gmail.com>

Some of this seems to be taken from the gelic driver, so shouldn't
the copyright info from there be included here?

> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + *
> + */
> +
> +#include <asm/io.h>
> +#include <asm/udbg.h>
> +#include <asm/lv1call.h>
> +
> +#define GELIC_BUS_ID 1
> +#define GELIC_DEVICE_ID 0
> +#define GELIC_DEBUG_PORT 18194
> +#define GELIC_MAX_MESSAGE_SIZE 1000
> +
> +#define GELIC_LV1_GET_MAC_ADDRESS 1
> +#define GELIC_LV1_GET_VLAN_ID 4
> +#define GELIC_LV1_VLAN_TX_ETHERNET_0 2
> +
> +#define GELIC_DESCR_DMA_STAT_MASK 0xf0000000
> +#define GELIC_DESCR_DMA_CARDOWNED 0xa0000000
> +
> +#define GELIC_DESCR_TX_DMA_IKE 0x00080000
> +#define GELIC_DESCR_TX_DMA_NO_CHKSUM 0x00000000
> +#define GELIC_DESCR_TX_DMA_FRAME_TAIL 0x00040000
> +
> +#define GELIC_DESCR_DMA_CMD_NO_CHKSUM (GELIC_DESCR_DMA_CARDOWNED | \
> +				       GELIC_DESCR_TX_DMA_IKE | \
> +				       GELIC_DESCR_TX_DMA_NO_CHKSUM)
> +
> +static u64 bus_addr;
> +
> +struct gelic_descr {
> +	/* as defined by the hardware */

These are BE from the hardware, so should be __beXX types.

> +	u32 buf_addr;
> +	u32 buf_size;
> +	u32 next_descr_addr;
> +	u32 dmac_cmd_status;
> +	u32 result_size;
> +	u32 valid_size;	/* all zeroes for tx */
> +	u32 data_status;
> +	u32 data_error;	/* all zeroes for tx */
> +} __attribute__((aligned(32)));

...

> +static void gelic_debug_init(void)
> +{

...

> +	result = lv1_net_control(GELIC_BUS_ID, GELIC_DEVICE_ID,
> +				 GELIC_LV1_GET_VLAN_ID,
> +				 GELIC_LV1_VLAN_TX_ETHERNET_0, 0, 0,
> +				 &vlan_id, &v2);
> +	if (result == 0) {

This should be 'if (!result)'

-Geoff
