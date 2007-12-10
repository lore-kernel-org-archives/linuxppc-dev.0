Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BF9DDDE156
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Dec 2007 05:48:06 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	lBAIm1el013032
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Dec 2007 11:48:02 -0700 (MST)
Message-ID: <475D89E1.4040107@freescale.com>
Date: Mon, 10 Dec 2007 12:48:01 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Poonam_Aggrwal-b10812 <b10812@freescale.com>
Subject: Re: [PATCH 2/3] arch/ : Platform changes for UCC TDM driver
	for	MPC8323ERDB.Also includes related QE changes.
References: <Pine.LNX.4.64.0712101734490.29623@linux121>
In-Reply-To: <Pine.LNX.4.64.0712101734490.29623@linux121>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Poonam_Aggrwal-b10812 wrote:

> +			qe = of_find_node_by_type(NULL, "qe");
> +			if (qe) {
> +				unsigned int size;
> +				prop = of_get_property
> +						(qe, "brg-frequency", &size);
> +				of_node_put(qe);
> +				of_node_put(brg);
> +				return *prop;
> +			}

Only very recent versions of U-Boot set the brg-frequency property, so you need 
to check for situations where "*prop" is 0.  If it is, then you need to take the 
QE's bus-frequency property and divide it by two.  See my ucc_uart driver for an 
example.

And PowerPC-specific patches should not be cross-posted to linux-kernel.

-- 
Timur Tabi
Linux kernel developer at Freescale
