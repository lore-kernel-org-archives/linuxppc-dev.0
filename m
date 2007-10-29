Return-Path: <stuart.yoder@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 13673DE00E
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Oct 2007 01:37:08 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l9TEb3IO005627
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Oct 2007 07:37:03 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l9TEb2jm016585
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Oct 2007 09:37:03 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RFC:  replace device_type with new "class" property?
Date: Mon, 29 Oct 2007 07:37:04 -0700
Message-ID: <9696D7A991D0824DBA8DFAC74A9C5FA30359F9BB@az33exm25.fsl.freescale.net>
From: "Yoder Stuart-B08248" <stuart.yoder@freescale.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


We've had some discussions internally here at Freescale among=20
various PPC Linux developers about the device_type property
and how 'classes' of devices should be represented in the
device tree.

Taking a long term view, the question I'd like to pose is
how should classes of device should be identified in the
flat device tree model?   A device class, as I'm using it,
refers basically to general categories of devices-- devices
that share common properties.   Examples in current device
would be "cpu", "memory", "pci", "network", "serial".

Today the device_type property serves this purpose to some
degree.  However, the original meaning of device_type in
Open Firmware is related to the method interface of a node
it has a recent history of abuse in the Linux kernel DTS
files, with a plethora of types made up in an ad hoc way.
In addition, an OS can match on "compatible" and in the
absence of method interfaces really doesn't need
device_type anyway.

However, one good thing about device_type (if properly used)
is that it could identify which device nodes follow an official
binding, vs proprietary devices or one-off device node definitions.
Without something like device_type the _human_ reader of a DTS
file has to infer from the name or compatible what the device
type is.  So, device class identifiers like "memory", "cpu",
"serial", "pci", "network" provide that clarity.

So, what should the long term approach be?  Here are a couple
of options:

1.  Keep device_type, with it's use specifically defined to
    mean that the node with that property implements an
    'official' binding.   In the flat device tree model a
    binding is just a defined set of required (and optional
    properties.

2.  Get rid of device_type and create a _new_ property like
    "class".  The only nodes permitted to have this property
    are those with 'official' bindings.  These nodes would
    have a set of required (and optional) properties.

    The benefit of a new property is cutting all baggage
    associated with the old device_type property.

One other point-- the intent of a device class is not
necessarily to specify a sufficient set of properties
to implement drivers.  The "network" class would have
a base set of required properties (e.g. mac-address,etc),
but most likely would need additional properties
to implement a driver for a specific device.  The value
in the class is when a developer needs to represent
a new device that fits into an existing class he has a base
set of properties to start with that has had some good
thinking put into defining it.  A device class would
facilitate and encourage consistent use of properties
names, which would be a good thing.

The initial list of official classes would be small--
"cpu","memory", "cache", "pci", "serial", "network",
"open-pic"(?).  As other types get codified in actual use
and have official bindings specified (perhaps through
power.org) new types would be supported--e.g. "i2c",
"jdec-flash".

Thoughts?

Stuart Yoder
Freescale Semiconductor, Inc.
