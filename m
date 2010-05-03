Return-Path: <B07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3EEC9B7D2D
	for <linuxppc-dev@ozlabs.org>; Tue,  4 May 2010 02:34:47 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o43GYToD009094
	for <linuxppc-dev@ozlabs.org>; Mon, 3 May 2010 09:34:39 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id o43GYXG5002555
	for <linuxppc-dev@ozlabs.org>; Mon, 3 May 2010 11:34:33 -0500 (CDT)
Message-ID: <4BDEFB13.5060407@freescale.com>
Date: Mon, 03 May 2010 11:34:27 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/2] powerpc/mpc5121: add initial support for PDM360NG
	board
References: <1272659448-23302-1-git-send-email-agust@denx.de>
	<1272659448-23302-2-git-send-email-agust@denx.de>
	<g2tfa686aa41005020754t46934f13hbd5c75a6b7668a54@mail.gmail.com>
In-Reply-To: <g2tfa686aa41005020754t46934f13hbd5c75a6b7668a54@mail.gmail.com>
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

Grant Likely wrote:
>> +               // IPIC
>> +               // interrupts cell = <intr #, sense>
>> +               // sense values match linux IORESOURCE_IRQ_* defines:
>> +               // sense == 8: Level, low assertion
>> +               // sense == 2: Edge, high-to-low change
>> +               //
>> +               ipic: interrupt-controller@c00 {
>> +                       compatible = "fsl,mpc5121-ipic", "fsl,ipic";
>> +                       interrupt-controller;
>> +                       #address-cells = <0>;
> 
> Don't need #address-cells here

#address-cells is required by ePAPR for interrupt controllers if an 
interrupt-map is used.  While there isn't one in this tree, it's best to 
just always include #address-cells in interrupt controller nodes.

-Scott
