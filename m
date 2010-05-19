Return-Path: <B07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0EE9BB7D49
	for <linuxppc-dev@ozlabs.org>; Thu, 20 May 2010 07:37:39 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o4JLbbRo019427
	for <linuxppc-dev@ozlabs.org>; Wed, 19 May 2010 14:37:37 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id o4JLmWu9012440
	for <linuxppc-dev@ozlabs.org>; Wed, 19 May 2010 16:48:32 -0500 (CDT)
Message-ID: <4BF45A1F.70100@freescale.com>
Date: Wed, 19 May 2010 16:37:35 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/2] powerpc/mpc5121: add initial support for PDM360NG
	board
References: <1272659448-23302-1-git-send-email-agust@denx.de>
	<1272659448-23302-2-git-send-email-agust@denx.de>
	<g2tfa686aa41005020754t46934f13hbd5c75a6b7668a54@mail.gmail.com>
	<4BDEFB13.5060407@freescale.com>
	<AANLkTilBveOR1aJTgunOq0aqnsGtf1vWHfn8A6uXyoPU@mail.gmail.com>
In-Reply-To: <AANLkTilBveOR1aJTgunOq0aqnsGtf1vWHfn8A6uXyoPU@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Detlev Zundel <dzu@denx.de>, Markus Fischer <markus.fischer.ec@ifm.com>,
	devicetree-discuss@lists.ozlabs.org,
	Michael Weiss <michael.weiss@ifm.com>, linuxppc-dev@ozlabs.org,
	Anatolij Gustschin <agust@denx.de>, Wolfgang Grandegger <wg@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/19/2010 04:27 PM, Grant Likely wrote:
> On Mon, May 3, 2010 at 10:34 AM, Scott Wood<scottwood@freescale.com>  wrote:
>> Grant Likely wrote:
>>>>
>>>> +               // IPIC
>>>> +               // interrupts cell =<intr #, sense>
>>>> +               // sense values match linux IORESOURCE_IRQ_* defines:
>>>> +               // sense == 8: Level, low assertion
>>>> +               // sense == 2: Edge, high-to-low change
>>>> +               //
>>>> +               ipic: interrupt-controller@c00 {
>>>> +                       compatible = "fsl,mpc5121-ipic", "fsl,ipic";
>>>> +                       interrupt-controller;
>>>> +                       #address-cells =<0>;
>>>
>>> Don't need #address-cells here
>>
>> #address-cells is required by ePAPR for interrupt controllers if an
>> interrupt-map is used.
>
> Why?
>
> /me is too lazy to dig out ePAPR and look.

Address cells are part of the interrupt identification.  Typically with 
interrupt maps this is only used on the child end (e.g. to select a 
particular PCI slot), but if the parent interrupt controller's address 
cells are non-zero it will be expected in the parent interrupt specifier 
as well.

I believe the only part of this that is new with ePAPR is that it asks 
that the interrupt controller address cells be explicitly specified, as 
it's a bit icky for it to default to 2 in some contexts and 0 in others.

-Scott
