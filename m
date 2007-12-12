Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 6D62BDDF44
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Dec 2007 09:16:45 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH/RFC] CPM1: implement GPIO API
Date: Wed, 12 Dec 2007 23:16:33 +0100
References: <47600F5E.8060907@scram.de>
In-Reply-To: <47600F5E.8060907@scram.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200712122316.34354.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 12 December 2007, Jochen Friedrich wrote:

> +static spinlock_t *cpm1_port_locks;
> +static int cpm1_num_ports;

Having an array of spinlocks is rather unusual and normally not necessary.
Did you measure a significant performance impact by using a global lock
for all ports?

If not, I would recommend simplifying this.

> +EXPORT_SYMBOL_GPL(gpio_request);
> +EXPORT_SYMBOL_GPL(gpio_direction_input);
> +EXPORT_SYMBOL_GPL(gpio_direction_output);
> +EXPORT_SYMBOL_GPL(gpio_get_value);
> +EXPORT_SYMBOL_GPL(gpio_set_value);

All these function names are rather generic identifiers, but you export them
from a platform specific file. I'd say they should either have a more specific
name space (e.g. cpm1_gpio_request), or should be implemented in a more
generic way.

	Arnd <><
