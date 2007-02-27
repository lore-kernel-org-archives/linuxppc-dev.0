Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-06.arcor-online.net (mail-in-06.arcor-online.net
	[151.189.21.46])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AF491DDDFD
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Feb 2007 10:41:29 +1100 (EST)
In-Reply-To: <200702272254.l1RMsjt2030709@ld0164-tx32.am.freescale.net>
References: <200702272254.l1RMsjt2030709@ld0164-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <6d55dd0f38d35c0b938acf26abff62ec@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC] powerpc: Document new property called interrupt-parents 
Date: Wed, 28 Feb 2007 00:40:31 +0100
To: Stuart Yoder <b08248@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +For devices that generate interrupts to multiple interrupt
> +controllers, the  interrupt-parent representation
> +is not sufficient because it only describes a single
> +interrupt parent. The 'interrupt-parents' property should be used
> +to represent this (note the plural in the property name).

s/should be used/can be used/

> +   pic0: pic@700 {
> +       interrupt-controller;
> +       #address-cells = <0>;
> +       #interrupt-cells = <2>;
> +       reg = <700 100>;
> +       device_type = "open-pic";
> +   };

I still say the #address-cells should be removed.

> +   ethernet@25000 {
> +       #address-cells = <1>;
> +       #size-cells = <0>;
> +       device_type = "network";
> +       model = "fsl,TSEC";
> +       compatible = "gianfar";
> +       reg = <25000 1000>;
> +       mac-address = [ 00 E0 0C 00 73 01 ];
> +       interrupt-parents = <&pic0 &pic0 &pic1>;
> +       interrupts = <13 3 14 3 18 3>;
> +       phy-handle = <2452001>;
> +   };

Maybe write this like

ethernet@25000 {
         device_type = "network";
         reg = <25000 1000>;
         ...
         interrupt-parents = <&pic0 &pic0 &pic1>;
         interrupts = <13 3 14 3 18 3>;
};

to make the example more readable?  And some spacing in
the properties, so maybe

ethernet@25000 {
         device_type = "network";
         reg = <25000 1000>;
         ...
         interrupt-parents = <&pic0 &pic0 &pic1>;
         interrupts        = <13 3  14 3  18 3 >;
};

> +Note: each interrupt parent in the interrupt-parents array can
> +potentially specify a different value for #interrupt-cells.  The 
> number
> +of #interrupt-cells for each parent must be determined to correctly
> +parser the interrupts property.

s/parser/parse/


Segher
