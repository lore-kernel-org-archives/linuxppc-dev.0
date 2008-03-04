Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1EFB4DE268
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Mar 2008 07:39:59 +1100 (EST)
In-Reply-To: <1204612384.21545.50.camel@pasglop>
References: <1204588953.7921.13.camel@basalt>
	<20080303213718.12291eee@zod.rchland.ibm.com>
	<200803040715.22301.sr@denx.de> <1204612384.21545.50.camel@pasglop>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <9eeb7e8e1acf8a9217a5121fe4ec69d8@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Bamboo PCI interrupt issues
Date: Tue, 4 Mar 2008 21:39:29 +0100
To: benh@kernel.crashing.org
Cc: kvm-ppc-devel <kvm-ppc-devel@lists.sourceforge.net>,
	linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>,
	Hollis Blanchard <hollisb@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Using '8' is correct. PCI interrupts are *always* level sensitive and
>> active
>> low.
>
> Unless you use one of those strange bridges that stick not gates on the
> PCI IRQ inputs :-) But I don't think that's the case on the 440EP.

More generally, the target interrupt descriptors (sense values, in
particular) in a device tree interrupt map describe the interrupts as
seen on the target interrupt controller, *not* as seen on this (source)
interrupt domain.  This should be obvious, but since the source 
interrupt
descriptor for PCI doesn't have a sense value (it's always level low,
after all), it can be confusing.  Well, interrupts always are confusing 
:-)


Segher
