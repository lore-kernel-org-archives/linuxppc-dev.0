Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A10A3DDDFB
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jan 2008 17:33:43 +1100 (EST)
Message-Id: <8642742F-E8BF-43C7-9FE4-AAF54855ECF7@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: benh@kernel.crashing.org
In-Reply-To: <1201156120.6815.48.camel@pasglop>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH] [POWERPC] Always build setup-bus.c on powerpc
Date: Thu, 24 Jan 2008 00:33:34 -0600
References: <Pine.LNX.4.64.0801240006380.21347@blarg.am.freescale.net>
	<1201156120.6815.48.camel@pasglop>
Cc: Greg KH <greg@kroah.com>, linux-pci@atrey.karlin.mff.cuni.cz,
	Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 24, 2008, at 12:28 AM, Benjamin Herrenschmidt wrote:

>
> On Thu, 2008-01-24 at 00:07 -0600, Kumar Gala wrote:
>> The common arch/powerpc code calls in to functions in setup-bus.c
>> so some builds of ppc32 would fail.
>>
>> Note, ppc32 usage of setup-irq.c is limited to arch/ppc and should be
>> removed when arch/ppc goes away.
>
> I don't understand... the old code would build setup-bus.o for both
> PPC32 and PPC64 cases, how did you make it fail ?

The patch is bogus.  The old makefile rules looked like:

obj-$(CONFIG_PPC64) += setup-bus.o
obj-$(CONFIG_PPC32) += setup-irq.o

pmac most like builds because CONFIG_HOTPLUG pulls in setup-bus.o

(I'll fix my foobar'd patch and send this via Paul).

- k
