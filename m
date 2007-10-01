Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AE6FDDDE1B
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Oct 2007 08:33:00 +1000 (EST)
In-Reply-To: <20071001211120.156280@gmx.net>
References: <20071001210025.314240@gmx.net> <20071001211120.156280@gmx.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <d3eb2341d21ed1f9f7e71f097878731f@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Problem with OF interrupt parsing code
Date: Tue, 2 Oct 2007 00:33:12 +0200
To: "Gerhard Pircher" <gerhard_pircher@gmx.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> 		  	i8259: interrupt-controller@20 {
> 				device_type = "interrupt-controller";
> 				compatible = "pnpPNP,000";
> 				interrupt-controller;
> 				reg = <00000001 00000020 00000002
> 				       00000001 000000a0 00000002
> 				       00000001 000004d0 00000002>;
> 				reserved-interrupts = <2>;
> 			};

This is an interrupt controller (it has an "interrupt-controller"
property, and it has no interrupt parent (there is no "interrupt-parent"
property, for interrupt controllers you do not follow the "normal" tree
parent), so it is the root interrupt controller and there is no loop.

It seems from your description that the Linux code is using the tree
parent as interrupt parent even for interrupt controller nodes.  This
is wrong behaviour.


Segher
