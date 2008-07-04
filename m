Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 79169DDED3
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Jul 2008 08:46:09 +1000 (EST)
In-Reply-To: <20080703141845.af88fd51.kim.phillips@freescale.com>
References: <20080703141845.af88fd51.kim.phillips@freescale.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <4278f6a4bcd22a0d3e185c47e6c76bab@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v3] powerpc: update crypto node definition and device tree
	instances
Date: Sat, 5 Jul 2008 00:45:50 +0200
To: Kim Phillips <kim.phillips@freescale.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +- compatible : Should contain entries for this and backward compatible
> +  SEC versions, high to low, e.g., "fsl,sec2.1", "fsl,sec2.0"

First entry should state the _exact_ version of the device.  "sec-N.M"
isn't good enough; there can be implementation bugs.

There can be more entries; you make it sound like each device tree
should list _all_ compatible devices, which isn't the case.

A device binding should not (and can not) say how "compatible"
should be used; instead, it should list what values of "compatible"
this binding applies to.  You can give recommendations of course.

> +- interrupts : <a b> where a is the interrupt number and b is a
> +  field that represents an encoding of the sense and level
> +  information for the interrupt.  This should be encoded based on
> +  the information in section 2) depending on the type of interrupt
> +  controller you have.

#interrupt-cells isn't always 2.  Your device binding shouldn't describe
how interrupt encoding works (that's described in the imap recommended
practice, already); instead, it should describe which device interrupts
are listed here, and in what order.  Sounds like you only have one
interrupt, so that should be easy ;-)

> +- interrupt-parent : the phandle for the interrupt controller that
> +  services interrupts for this device.

"interrupt-parent" isn't a required property.  It isn't part of this
device binding, either.


Segher
