Return-Path: <B04825@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EE813B7CF1
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Mar 2010 05:05:09 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o2PI561J025807
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Mar 2010 11:05:06 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id o2PI5AhY003904
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Mar 2010 13:05:10 -0500 (CDT)
Message-ID: <4BABA5D1.7030000@freescale.com>
Date: Thu, 25 Mar 2010 13:05:05 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] powerpc/fsl: add device tree binding for QE firmware
References: <1269380552-10418-1-git-send-email-timur@freescale.com>
	<fa686aa41003241007mf6052d5s4643795f4a87cdcf@mail.gmail.com>
	<4BAA4C8A.70104@freescale.com>
	<65327.84.105.60.153.1269481760.squirrel@gate.crashing.org>
	<4BAB7E67.6040707@freescale.com> <4BAB816F.5060405@firmworks.com>
	<fa686aa41003250916t3d0839e5m42d7f7f6540e821a@mail.gmail.com>
	<4BAB9120.1060600@freescale.com>
	<fa686aa41003250959v401d14e0g151aa54a57eea39@mail.gmail.com>
	<4BAB9755.2080408@freescale.com>
	<fa686aa41003251035h3574a2bahce183ca6056e5f7e@mail.gmail.com>
In-Reply-To: <fa686aa41003251035h3574a2bahce183ca6056e5f7e@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Mitch Bradley <wmb@firmworks.com>, Scott Wood <scottwood@freescale.com>,
	devicetree-discuss@lists.ozlabs.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Grant Likely wrote:

> Compatible is for devices.  This is not a device.  Drivers cannot bind
> against it.  Use a different mechanism if you have metadata about the
> blob.  If your driver doesn't know how to validate its own firmware
> blobs, then you've got bigger problems.

Perhaps.  I left the door open to have additional firmware-specific properties in the firmware node that the driver can use to interpret the firmware blob.  Not everyone can have a nice, complete header for the firmware.  Sometimes the firmware is distributed as just raw microcode words, without any header or anything like that.

> So?  If your data has a structure that the device tree cares about,
> the break it out into the device tree nodes/properties structure.  If
> it is a blob, then only the driver cares.  The format of the blob
> doesn't have any bearing on how it is encapsulated into the tree.

Yes, the QE firmware format does include a bunch of information, but who says that will always be the case?  And what happens if we want to extend this binding to include non-QE firmware?  What happens if, down the road, we need to add properties to help us interpret the firmware?

In other words, we can't depend on the contains of the firmware blob to tell the driver everything he needs to know.

> It's a name, not a pseudo compatible string, and your device node will
> explicitly reference it by name.  There is not backwards compatibility
> or fuzzy binding issues at play here.  It is a way for your driver
> node to state, "I want *that exact* firmware blob".  You could make
> the property name "george" and it would still be completely clear (if
> a little weird) because all the references are contained within the
> tree.

Eh, I don't know.  Maybe if you bought me dinner first, you could talk me into it.

-- 
Timur Tabi
Linux kernel developer at Freescale
