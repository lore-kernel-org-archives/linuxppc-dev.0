Return-Path: <B04825@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5C825B7CCD
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Mar 2010 07:04:36 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o2PK4XLu002403
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Mar 2010 13:04:33 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id o2PK4bK1018410
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Mar 2010 15:04:37 -0500 (CDT)
Message-ID: <4BABC1CF.1000306@freescale.com>
Date: Thu, 25 Mar 2010 15:04:31 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
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
	<4BABBF54.3010104@freescale.com>
In-Reply-To: <4BABBF54.3010104@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Mitch Bradley <wmb@firmworks.com>, devicetree-discuss@lists.ozlabs.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott Wood wrote:

> I don't know that it's strictly necessary in this case --  it looks like 
> there is a magic number in the firmware blob -- but I don't understand 
> the objection as a matter of principle.  These device tree discussions 
> have a tendency to get awfully bikesheddy.

I don't want this discussion, and any binding definitions that come from it, to be limited to the specifics of a QE firmware.  I want to make sure that any binding that we come up with can be easily extended to any kind of firmware, including firmware that has no headers.

Many companies will distribute their firmware as a generic sequence of bytes (no header), and a simple code fragment that demonstrates uploading the binary to the hardware.  The license for these files sometimes precludes the option of wrapping that microcode inside or with another binary.  That is, if you want to distribute this firmware, it must be distributed as-is.  

Example:

Freescale buys a chip from some vendor and puts the chip on a reference board.  The chip requires some microcode to be uploaded, and the vendor distributes some binary blob and a code snippet.  Freescale embeds the code snippet in Linux, and puts the microcode somewhere in flash.  The license for the microcode says, "thou shalt not merge this microcode with any other binary".  Freescale decides, for whatever reason, that putting a header around the microcode and putting *that* in flash is a violation of the license, but having U-Boot dynamically embed it into a DTB isn't.  Ok, maybe that's a bit ridiculous, but just humor me.  In this case, it would useful to have the microcode in its own node with properties describing the microcode.

Anyway, I may have gone off in the weeds with this discussion.

-- 
Timur Tabi
Linux kernel developer at Freescale
