Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7C3C2E0592
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 11:39:51 +1000 (EST)
Subject: Re: [PATCH] Add StorCenter DTS first draft.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jon Loeliger <jdl@jdl.com>
In-Reply-To: <E1IAnwC-0003Xm-6U@jdl.com>
References: <E1IAnwC-0003Xm-6U@jdl.com>
Content-Type: text/plain
Date: Wed, 18 Jul 2007 11:39:13 +1000
Message-Id: <1184722754.25235.183.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> +		PowerPC,603e {			/* Really 8241 */
> +			device_type = "cpu";
> +			reg = <0>;
> +			clock-frequency = <d# 200000000>;	/* Hz */
> +			timebase-frequency = <d# 33333333>;	/* Hz */
> +			bus-frequency = <0>;
> +			/* Following required by dtc but not used */
> +			i-cache-line-size = <0>;
> +			d-cache-line-size = <0>;
> +			i-cache-size = <4000>;
> +			d-cache-size = <4000>;
> +		};

The 32 bits kernel may not be using those yet, but it will. 64 bits does
already and I plan to merge those bits at one point. Get your cache line
size right (0 is wrong, though I will provide a fallback to the cputable
when the device-tree looks obviously wrong).

Cheers,
Ben.
