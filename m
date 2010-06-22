Return-Path: <B07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1EE3EB6F17
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 07:39:42 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o5MLdeal020793
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jun 2010 14:39:40 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id o5MLplYp004054
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jun 2010 16:51:47 -0500 (CDT)
Message-ID: <4C212D9A.5020908@freescale.com>
Date: Tue, 22 Jun 2010 16:39:38 -0500
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
	<4BF45A1F.70100@freescale.com>
	<AANLkTinxuFz3SSLZtF3yGYtRN8nsW8_6EDiqzmJilYE9@mail.gmail.com>
In-Reply-To: <AANLkTinxuFz3SSLZtF3yGYtRN8nsW8_6EDiqzmJilYE9@mail.gmail.com>
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

On 05/19/2010 04:47 PM, Grant Likely wrote:
> On Wed, May 19, 2010 at 3:37 PM, Scott Wood<scottwood@freescale.com>  wrote:
>> I believe the only part of this that is new with ePAPR is that it asks that
>> the interrupt controller address cells be explicitly specified, as it's a
>> bit icky for it to default to 2 in some contexts and 0 in others.
>
> Hmmm.  I've not seen that before.  On the 5200 the value of
> #address-cells for interrupt controllers has apparently defaulted to
> <0>  so I've never encountered or thought about it.  I'm not even sure
> what #address-cells != 0 would mean in the context of interrupt
> mapping, or where it would be relevant.

The address component is mainly used in PCI interrupt mapping, where 
each slot has a distinct wiring.

It would be weird to see it on a normal interrupt controller, but 
explicitly setting it to zero helps avoid someone deciding that an 
interrupt controller ought to have a child node for whatever reason 
(this was an issue with MPIC), setting address cells to something 
non-zero, and messing up interrupt maps.

-Scott
