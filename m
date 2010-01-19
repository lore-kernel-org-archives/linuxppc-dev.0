Return-Path: <felix@embedded-sol.com>
Received: from vega.surpasshosting.com (vega.surpasshosting.com [72.29.83.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 512FFB7CA1
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Jan 2010 09:52:19 +1100 (EST)
Message-ID: <4B5637A6.5070600@embedded-sol.com>
Date: Wed, 20 Jan 2010 00:52:22 +0200
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/4xx: Add support for type 1 pci transactions
	on 4xx boards
References: <4CD35CD1F8085945B597F80EEC89421303B8AD11@exc01.bk.prodrive.nl>	<1263338326.724.216.camel@pasglop>
	<1263444961.724.343.camel@pasglop>
In-Reply-To: <1263444961.724.343.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Stef van Os <stef.van.os@Prodrive.nl>, Stefan Roese <sr@denx.de>,
	Feng Kan <fkan@amcc.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Wed, 2010-01-13 at 10:18 +1100, Benjamin Herrenschmidt wrote:
>   
>> On Tue, 2010-01-12 at 15:09 +0100, Stef van Os wrote:
>>     
>>> This patch adds type 1 PCI transactions to 4xx PCI code, enabling the
>>> discovery of
>>> devices behind a PCI bridge.
>>>       
>> Your patch appears word wrapped and whitespace damaged...
>>
>> I'll fix it up manually this time around but please check your mailer
>> setup :-)
>>     
>
> Allright, it's not quite that.
>
> I've looked at my docs, and it looks like older parts such as the 440EP
> do -not- take the config type in the low bit.
>
> More interestingly, they only generate config 0 cycles if you pass a bus
> number of 0 :-)
>
> So we'll need do do something a little bit different here. We probably
> need to indicate in the device-tree what kind of SoC we have (whether
> it supports the explicit bit to choose between type 0 and type 1 or
> not).
>
> If not, we should then set the "self_busno" field of the bridge to 0,
> causing indirect_pci to always use bus number 0 when trying to talk
> to the bus segment behind the bridge, whatever the linux bus number
> for it actually is.
>
> Now, we need to make a precise list here of what SoC uses what. 460xx
> seem to all support the explicit bit. 440EP doesn't. What else ?
>
> Somebody from AMCC can dbl check that ?
>   

I've checked what platforms take configuration type in the lower bit:

405XX - no
440EP - no
440GR - no
440EPx/440GRx - no

440GP - yes
440GX - yes
440SP - yes
440SPe - yes
460XX - yes

The distinction between these groups is pretty clear in the device trees.
The members of the first group all have "ibm,plb-pci" property, and all
members of second group have "ibm,plb-pcix" property.

So only ppc4xx_probe_pcix_bridge() routine should be fixed.

Felix.
