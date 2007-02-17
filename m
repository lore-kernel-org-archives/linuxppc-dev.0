Return-Path: <tnt@246tNt.com>
Received: from outmx022.isp.belgacom.be (outmx022.isp.belgacom.be
	[195.238.4.203])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 87A5EDDDF7
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Feb 2007 20:37:23 +1100 (EST)
Received: from outmx022.isp.belgacom.be (localhost [127.0.0.1])
	by outmx022.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id l1H9b6Vj013419
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Feb 2007 10:37:10 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <45D6CC81.1040004@246tNt.com>
Date: Sat, 17 Feb 2007 10:36:01 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
Subject: Re: [PATCH 2.6.21-rc1] ibmebus: Use of_device_uevent()
References: <200702170356.12600.hnguyen@linux.vnet.ibm.com>
In-Reply-To: <200702170356.12600.hnguyen@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: pmac@au1.ibm.com, fenkes@de.ibm.com, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, paulus@samba.org, johnrose@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hoang-Nam Nguyen wrote:
> This patch replaces ibmebus_uevent() by Sylvain's generic function.
>
>  struct bus_type ibmebus_bus_type = {
> -	.name = "ibmebus",
> -	.uevent = ibmebus_uevent,
> -	.match = ibmebus_bus_match,
> +	.name   = "ibmebus",
> +	.uevent = of_device_uevent,
> +	.match  = ibmebus_bus_match,
>  };
>  EXPORT_SYMBOL(ibmebus_bus_type);
>   
Doesn't that oops when called with the fake parent device ?

Either you do a wrapper that test for it (that's what I did when I
posted the patch).
Or, an even better approach is to add this

+	if (!ebus_dev->ofdev.node)
+		return -ENODEV;

inside the code of of_device_uevent itself.


	Sylvain
