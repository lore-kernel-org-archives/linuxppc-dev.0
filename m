Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 38DEDDDE01
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Feb 2007 09:00:56 +1100 (EST)
Subject: Re: [PATCH 2.6.21-rc1] powerpc: Make of_device_uevent() compatible
	with ibmebus
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
In-Reply-To: <200702171728.15597.hnguyen@linux.vnet.ibm.com>
References: <200702171728.15597.hnguyen@linux.vnet.ibm.com>
Content-Type: text/plain
Date: Sun, 18 Feb 2007 08:56:39 +1100
Message-Id: <1171749399.5644.145.camel@localhost.localdomain>
Mime-Version: 1.0
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

On Sat, 2007-02-17 at 17:28 +0100, Hoang-Nam Nguyen wrote:
> ibmebus has a fake root device that's not associated with an ofdt node.
> Filter out any such devices in of_device_uevent().

Doh ! You are creating an of_device with no attached device-node ? That
is totally evil ! Why do you need that ?

Ben.

> 
> Signed-off-by: Joachim Fenkes <fenkes@de.ibm.com>
> ---
> 
> 
>  of_device.c |    4 ++++
>  1 files changed, 4 insertions(+)
> 
> 
> diff -urp a/arch/powerpc/kernel/of_device.c b/arch/powerpc/kernel/of_device.c
> --- a/arch/powerpc/kernel/of_device.c	2007-02-17 16:36:32.116368480 +0100
> +++ b/arch/powerpc/kernel/of_device.c	2007-02-17 16:44:01.319366352 +0100
> @@ -180,6 +180,10 @@ int of_device_uevent(struct device *dev,
>  
>  	ofdev = to_of_device(dev);
>  
> +	/* e.g. ibmebus has a fake root device w/o ofdt node -- filter that */
> +	if (!ofdev->node)
> +		return -ENODEV;
> +
>  	if (add_uevent_var(envp, num_envp, &i,
>  			   buffer, buffer_size, &length,
>  			   "OF_NAME=%s", ofdev->node->name))
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
