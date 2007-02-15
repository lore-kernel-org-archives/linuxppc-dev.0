Return-Path: <tnt@246tNt.com>
Received: from outmx024.isp.belgacom.be (outmx024.isp.belgacom.be
	[195.238.4.128])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B7901DDE29
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 07:12:41 +1100 (EST)
Received: from outmx024.isp.belgacom.be (localhost [127.0.0.1])
	by outmx024.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id l1FKCV06011414
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 21:12:34 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <45D4BE7E.7000109@246tNt.com>
Date: Thu, 15 Feb 2007 21:11:42 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
Subject: Re: [PATCH 2.6.21-rc1] ibmebus: Support dynamic addition and removal
	of	adapters
References: <200702151755.13009.hnguyen@linux.vnet.ibm.com>
In-Reply-To: <200702151755.13009.hnguyen@linux.vnet.ibm.com>
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
> Additionally, the uevent interface is now implemented in the driver.
>   
Mmmh, I posted a patch that added a common uevent interface for all
of_device based
bus. And that kinda clash with this one.

I think it's a much cleaner approach to make it as common as possible.
But as
"ibm,loc_code" is local to this bus it's not handled by my code. Is it
necessary
to match the correct driver ?

By the way you generate your uevent string is wrong imho:
 - it doesn't account for the fact that there can be multiple strings in
"compatible".
 - it can be a lot nicer if you use the helper add_uevent_var to fill
the event.
 - you generate a string "ibmebus:T%s:S%s:L%s" but did you just invent that
string ? I see no support for the "ibmebus" marker in mod_devicetable.h, nor
in file2alias.c nor any where else for that matter.


    Sylvain


>  
> +static int ibmebus_uevent(struct device *dev, char **envp, int num_envp,
> +			char *buffer, int buffer_size)
> +{
> +	const struct ibmebus_dev *ebus_dev = to_ibmebus_dev(dev);
> +	char *name, *cp, *loc_code;
> +	int length;
> +
> +	if (!num_envp)
> +		return -ENOMEM;
> +
> +	if (!ebus_dev->ofdev.node)
> +		return -ENODEV;
> +
> +	name = (char *)get_property(ebus_dev->ofdev.node, "name", NULL);
> +	cp = (char *)get_property(ebus_dev->ofdev.node, "compatible", NULL);
> +	loc_code = (char *)get_property(ebus_dev->ofdev.node,
> +					"ibm,loc-code", NULL);
> +	if (!(name && cp && loc_code))
> +		return -ENODEV;
> +
> +	envp[0] = buffer;
> +	length = scnprintf(buffer, buffer_size,
> +			   "MODALIAS=ibmebus:T%s:S%s:L%s",
> +			   name, cp, loc_code);
> +	if (buffer_size - length <= 0)
> +		return -ENOMEM;
> +	envp[1] = NULL;
> +
> +	return 0;
> +}
> +
>   
