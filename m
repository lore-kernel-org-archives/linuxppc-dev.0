Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 55A79DDDFF
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Aug 2008 02:10:33 +1000 (EST)
Message-ID: <48A30772.4030508@freescale.com>
Date: Wed, 13 Aug 2008 11:10:26 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: John Rigby <jrigby@freescale.com>
Subject: Re: [PATCH 5121 pci 1/3] powerpc: 83xx: pci: Remove need
	for	get_immrbase from mpc83xx_add_bridge.
References: <1218130587-31176-1-git-send-email-jrigby@freescale.com>
	<20080813050924.GD17587@secretlab.ca>
	<48A3068F.20409@freescale.com>
In-Reply-To: <48A3068F.20409@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Kumar Gala <kumar.gala@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

John Rigby wrote:
> As I type this I'm coming to like the primary flag more and more.
> I'm willing to change it to 'fsl,primary-pci-bridge' though I don't
> really agree with your argument against the generic name.  It is in
> the context of an 'fsl,pci-whatever' node so it does not have to be
> specific.

It *does* have to be specific; what if "primary" comes to mean something
else in a broader context?

> And maybe generic is good, a universal generic solution would be to
> require all primary pci nodes to have the property then 
> pci_process_bridge_OF_ranges could get it out of the device node
> instead of having it passed in.

The "universal generic solution" would be to encode legacy I/O devices 
in the device tree, and fix Linux to not assume that they're all on one bus.

If we must have a property, how about something like "pci-legacy-io"?

-Scott
