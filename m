Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 580A567CDD
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Dec 2006 05:38:42 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] ps3: add vuart support
Date: Thu, 7 Dec 2006 19:37:21 +0100
References: <45775D89.7030904@am.sony.com>
In-Reply-To: <45775D89.7030904@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200612071937.22607.arnd@arndb.de>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 07 December 2006 01:17, Geoff Levand wrote:
> Adds support for the PS3 virtual UART (vuart).  The vuart provides a
> bi-directional byte stream data link between logical partitions.

Looks good now, just a few minor comments:

> +struct ports_bmp
> +{
> +	u64 status;
> +	u64 unused[3];
> +} __attribute__ ((packed));

Do you really want to have this structure packed? It will produce
better code if it isn't.
For structure definitions, the common way is to write the opening
braces in the same line as the name, i.e.

struct ports_bmp {
	...
};

> +	default:
> +		BUG();
> +		*port_number = UINT_MAX;
> +		return -EINVAL;

No need to return after BUG(), the process is dead anyway. It should
probably be WARN_ON(1) instead of BUG().


> +static int get_rx_bytes_waiting(struct ps3_vuart_port_device *dev,
> +	unsigned long *bytes_waiting)
> +{
> +	int result = lv1_get_virtual_uart_param(dev->port_number,
> +		PARAM_RX_BYTES, bytes_waiting);
> +
> +	if (result)
> +		pr_debug("%s:%d: port_%u: rx_bytes failed: %s\n", __func__,
> +			__LINE__, dev->port_number, ps3_result(result));
> +
> +	pr_debug("%s:%d: port_%u: %lxh\n", __func__, __LINE__,
> +		dev->port_number, *bytes_waiting);

In places where you carry around a device pointer (probably most places),
it's nicer to use dev_dbg instead of pr_debug.

> +static int raw_write(struct ps3_vuart_port_device *dev, const void* buf,
> +	unsigned int bytes, unsigned long *bytes_written)

I'd give the function names a prefix, e.g. ps3_vuart_raw_write here, even
if they are static. This makes reading oops messages easier if you are
not familiar with the code, raw_write is a pretty common function name.


	Arnd <><
