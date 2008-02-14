Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound8-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 32129DE0BF
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Feb 2008 05:55:42 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] [POWERPC] Enable correct operation of serial ports
	withnonzero regshift.
Date: Thu, 14 Feb 2008 10:55:31 -0800
In-Reply-To: <47B35ED8.7020404@ru.mvista.com>
References: <47B35ED8.7020404@ru.mvista.com>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Pavel Kiryukhin" <pkiryukhin@ru.mvista.com>,
	<linuxppc-dev@ozlabs.org>
Message-Id: <20080214185534.81F625F808D@mail186-dub.bigfish.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> --- a/arch/powerpc/kernel/legacy_serial.c
> +++ b/arch/powerpc/kernel/legacy_serial.c
> +	/* get regshift if present*/
> +	regshift =3D get_property(np, "reg-shift", NULL);

of_get_property, presumably?

--- a/drivers/serial/of_serial.c
+++ b/drivers/serial/of_serial.c
> +	regshift =3D get_property(np, "reg-shift", NULL);

ditto...

Otherwise,=20

Acked-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>

Also, can you post a patch to the Xilinx portion of
booting-without-of.txt that has the device tree entries necessary to get
the uart to work?  (Since I happened to be tracking down what I assume
is the same issue when you posted the patch!)

Steve
