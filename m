Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DA106DDFE7
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jan 2009 02:59:57 +1100 (EST)
Message-Id: <79345A7E-E3C3-4945-8B63-5873EE6F16C1@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1233135072.6963.34.camel@pasglop>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] Restore PCI IO space behind Freescale pseudo-bridge
Date: Wed, 28 Jan 2009 09:59:08 -0600
References: <200901271813.n0RIDBHq023872@pogo.cesa.opbu.xerox.com>
	<E601679F-F6E5-4DE0-A6AB-B7191F496C49@freescale.com>
	<1233135072.6963.34.camel@pasglop>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Andrew Klossner <andrew@cesa.opbu.xerox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 28, 2009, at 3:31 AM, Benjamin Herrenschmidt wrote:

>
>>> We are using the patch I emailed.  It's ugly in that it hard-codes  
>>> the
>>> Freescale vendor ID, but it works for us.
>>
>> I guess I'm confused what the actual breakage is beyond some printk
>> messages.
>>
>> We "fixup" the resources in fsl_pcibios_fixup_bus() so Ben's change
>> shouldn't have an impact.  Does something actually stop functioning?
>
> I think the problem comes from my patch that "detects" closed bridge
> windows, which uses the PCI_COMMAND register as a clue, and it seems
> that your bridges don't properly support IO enable in there..

Yeah but I don't see why that's an issue.

Because after your code (pcibios_uninitialized_bridge_resource) we'll  
call ppc_md.pcibios_fixup_bus() and that will fix things up.

So I'm wondering if this is really a bug or just annoying printk's  
that are confusing.

- k
