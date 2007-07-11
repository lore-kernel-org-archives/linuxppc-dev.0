Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 89464DDE20
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 03:50:09 +1000 (EST)
In-Reply-To: <1184162389.32199.65.camel@weaponx.rchland.ibm.com>
References: <1184161957.32199.52.camel@weaponx.rchland.ibm.com>
	<1184162389.32199.65.camel@weaponx.rchland.ibm.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <4EAC985A-2F04-465D-AB69-C67807310D7B@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC][PATCH 6/8] Walnut DTS
Date: Wed, 11 Jul 2007 19:49:59 +0200
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +	UIC0: interrupt-controller0 {

Why not just "interrupt-controller"?

> +		#address-cells = <0>;
> +		#size-cells = <0>;

No need for these.
>
> +	plb {
> +		ranges;

Please make the valid address ranges explicit here.

> +		SDRAM0: memory-controller {
> +			compatible = "ibm,sdram-405gp", "ibm,sdram-440gp";

It's a bit weird to mention 440 here, since 405 is older.
Not a real problem, but if you still can change all relevant
OS code and device trees, I'd swap it around (make 440 trees
include the 405 "compatible" value).  Can you still do that
or is there a too big installed base already?

> +		POB0: opb {
> +			ranges;

Similar question as for PLB here.

> +			UART0: serial@ef600300 {
> +				current-speed = <2580>;

Write this in decimal?

Quite a nice tree btw :-)


Segher
