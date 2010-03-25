Return-Path: <B04825@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A217DB7CEE
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Mar 2010 09:20:11 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o2PMJvJf008449
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Mar 2010 15:19:57 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o2PMSJJR016270
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Mar 2010 17:28:19 -0500 (CDT)
Message-ID: <4BABE18C.4030302@freescale.com>
Date: Thu, 25 Mar 2010 17:19:56 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] powerpc/fsl: add device tree binding for QE firmware
References: <1269380552-10418-1-git-send-email-timur@freescale.com>
	<4BAB7E67.6040707@freescale.com> <4BAB816F.5060405@firmworks.com>
	<fa686aa41003250916t3d0839e5m42d7f7f6540e821a@mail.gmail.com>
	<4BAB9120.1060600@freescale.com>
	<fa686aa41003250959v401d14e0g151aa54a57eea39@mail.gmail.com>
	<4BAB9755.2080408@freescale.com>
	<fa686aa41003251035h3574a2bahce183ca6056e5f7e@mail.gmail.com>
	<4BABBF54.3010104@freescale.com> <4BABC1CF.1000306@freescale.com>
	<fa686aa41003251454y94f787fva07c5c73fc2d7874@mail.gmail.com>
In-Reply-To: <fa686aa41003251454y94f787fva07c5c73fc2d7874@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Scott Wood <scottwood@freescale.com>, Mitch Bradley <wmb@firmworks.com>,
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

> No, this isn't off in the weeds.  I concede the point of needing to
> store firmware in a separate node, but I still don't agree with the
> argument that it needs to be anything more than an anonymous named
> blob.

I still don't understand what's so *bad* about having some kind of binding documentation and a compatible property for this node.  Yes, I understand that compatible==device argument, but do we really have to be so strict about it?  I would like to be able to use the built-in OF functions in the kernel to validate the node (e.g. of_device_is_compatible).

And yes, I just realized the irony of using a function called of_device_is_compatible to test a node for something that isn't a device.  I'd prefer if you just ... overlooked that.

>  The fact that another node references it implicitly defines the
> format the blob needs to be in.  If the blob format changes, then in
> practice the existing binding is no longer compatible because older
> drivers just won't work.

Not necessarily.  There could be a new format for the microcode, or some new instructions for how to upload the microcode, and the driver could use the compatible format to learn how to process the microcode.  This would isolate all of the microcode-isms to the blob node.

>  It probably doesn't justify creation of a
> new compatible value, but I would handle firmware in a different
> format with a different property name to reference it.

I think it would be nicer if the property name could stay the same.  Then I wouldn't need to modify the property if I'm trying to upload a different kind of firmware.  I could then do this in the DTS:

qe@e0080000 {
	compatible = "fsl,qe";
	fsl,firmware-phandle = <&qe_firmware>;
	...
}	

qe_firmware:qe-firmware {
}

See how the qe-firmware node is blank?  It's just a placeholder for the firmware.  U-Boot would then just need to update that node when it embeds the microcode.  It would not need to modify the qe@e0080000 node.

-- 
Timur Tabi
Linux kernel developer at Freescale
