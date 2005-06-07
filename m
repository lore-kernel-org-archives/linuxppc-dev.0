Return-Path: <zwane@arm.linux.org.uk>
Received: from fsmlabs.com (fsmlabs.com [168.103.115.128])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 93F99679F9
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  7 Jun 2005 15:52:55 +1000 (EST)
Date: Mon, 6 Jun 2005 23:19:50 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Matt Porter <mporter@kernel.crashing.org>
In-Reply-To: <11180976151713@foobar.com>
Message-ID: <Pine.LNX.4.61.0506062302440.10441@montezuma.fsmlabs.com>
References: <11180976151713@foobar.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org, gregkh@kroah.com,
	linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH][3/5] RapidIO support: core enum
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, 6 Jun 2005, Matt Porter wrote:

> +spinlock_t rio_global_list_lock = SPIN_LOCK_UNLOCKED;

spin_lock_init?

> +extern struct rio_route_ops __start_rio_route_ops[];
> +extern struct rio_route_ops __end_rio_route_ops[];

rio.h?

> +static void
> +rio_set_device_id(struct rio_mport *port, u16 destid, u8 hopcount, u16 did)

Shouldn't those be on the same line?

> +static int rio_device_has_destid(struct rio_mport *port, int src_ops,
> +				 int dst_ops)
> +{
> +	if (((src_ops & RIO_SRC_OPS_READ) ||
> +	     (src_ops & RIO_SRC_OPS_WRITE) ||
> +	     (src_ops & RIO_SRC_OPS_ATOMIC_TST_SWP) ||
> +	     (src_ops & RIO_SRC_OPS_ATOMIC_INC) ||
> +	     (src_ops & RIO_SRC_OPS_ATOMIC_DEC) ||
> +	     (src_ops & RIO_SRC_OPS_ATOMIC_SET) ||
> +	     (src_ops & RIO_SRC_OPS_ATOMIC_CLR)) &&
> +	    ((dst_ops & RIO_DST_OPS_READ) ||
> +	     (dst_ops & RIO_DST_OPS_WRITE) ||
> +	     (dst_ops & RIO_DST_OPS_ATOMIC_TST_SWP) ||
> +	     (dst_ops & RIO_DST_OPS_ATOMIC_INC) ||
> +	     (dst_ops & RIO_DST_OPS_ATOMIC_DEC) ||
> +	     (dst_ops & RIO_DST_OPS_ATOMIC_SET) ||
> +	     (dst_ops & RIO_DST_OPS_ATOMIC_CLR))) {
> +		return 1;

Why not just;

mask = (RIO_DST_OPS_READ | RIO_DST_OPS_WRITE....)
return !!((dst_ops & mask) && (src_ops & mask))


> +	rdev->dev.dma_mask = (u64 *) 0xffffffff;
> +	rdev->dev.coherent_dma_mask = 0xffffffffULL;

Shouldn't that be dma_set_mask?

	Zwane
