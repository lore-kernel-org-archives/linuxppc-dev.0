Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9B32167A0E
	for <linuxppc-dev@ozlabs.org>; Fri, 19 May 2006 02:36:21 +1000 (EST)
In-Reply-To: <9FCDBA58F226D911B202000BDBAD4673062C07EC@zch01exm40.ap.freescale.net>
References: <9FCDBA58F226D911B202000BDBAD4673062C07EC@zch01exm40.ap.freescale.net>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <5B3BD0EE-D1C7-46D8-A672-5D9AC6DC98A3@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH/2.6.17-rc4 1/10] Powerpc: Add general support for mpc7
	448h pc2 (Taiga) platform
Date: Thu, 18 May 2006 11:36:33 -0500
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>
Cc: Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>,
	Paul Mackerras <paulus@samba.org>, Alexandre.Bounine@tundra.com,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 18, 2006, at 3:05 AM, Zang Roy-r61911 wrote:

>>
>>> The tsi108 serial port is not a sub node of "soc".  well, any way,
>>> I can try soc!
>>
>> What is it ? Where is it ? "soc" is a bit of a generic name for
>> something in the device-tree in fact... we might want to
>> define a way to
>> expose any bus via some kind of soc mecanism even if it's not a root
>> bus.
>>
>>
> Should I just use add_legacy_soc_port() instead of a new function
> add_legacy_tsi_port()?

I think seeing your dts will help here.  We need to have a concept of  
a "bridge" that may be similar to an "soc".

> --- arch/powerpc/kernel/legacy_serial.c.orig	Thu May 18 15:35:19 2006
> +++ arch/powerpc/kernel/legacy_serial.c	Thu May 18 15:50:38 2006
> @@ -302,6 +302,17 @@ void __init find_legacy_serial_ports(voi
>  		of_node_put(isa);
>  	}
>
> +	/* First fill our array with tsi-bridge ports */
> +	for (np = NULL; (np = of_find_compatible_node(np, "serial",  
> "ns16550")) != NULL;) {
> +		struct device_node *tsi = of_get_parent(np);
> +		if (tsi && !strcmp(tsi->type, "tsi-bridge")) {
> +			index = add_legacy_soc_port(np, np);
> +			if (index >= 0 && np == stdout)
> +				legacy_serial_console = index;
> +		}
> +		of_node_put(tsi);
> +	}
> +	
>  #ifdef CONFIG_PCI
>  	/* Next, try to locate PCI ports */
>  	for (np = NULL; (np = of_find_all_nodes(np));)
