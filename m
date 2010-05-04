Return-Path: <B04825@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E79DFB7D2F
	for <linuxppc-dev@ozlabs.org>; Wed,  5 May 2010 01:11:38 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o44FBZRL023098
	for <linuxppc-dev@ozlabs.org>; Tue, 4 May 2010 08:11:36 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o44FLHcB020274
	for <linuxppc-dev@ozlabs.org>; Tue, 4 May 2010 10:21:17 -0500 (CDT)
Message-ID: <4BE03926.4050900@freescale.com>
Date: Tue, 04 May 2010 10:11:34 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] powerpc/8610: add probing for individual DMA channels,
	not just DMA controllers
References: <1272923655-31807-1-git-send-email-timur@freescale.com>
	<20100504145430.GC3651@opensource.wolfsonmicro.com>
In-Reply-To: <20100504145430.GC3651@opensource.wolfsonmicro.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, kumar.gala@freescale.com,
	alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Mark Brown wrote:
> On Mon, May 03, 2010 at 04:54:15PM -0500, Timur Tabi wrote:
> 
>>  	{ .compatible = "simple-bus", },
>> -	{ .compatible = "gianfar", },
>> +	/* So that the DMA channel nodes can be probed individually: */
>> +	{ .compatible = "fsl,eloplus-dma", },
>>  	{}
> 
> The removal of gianfar looks a bit surprising here - if it's not a
> mistake a note in the changelog would be useful.

The changelog says this:

Also remove the "gianfar" compatible from mpc8610_ids[], since there is no
gianfar (or any other networking device) on the 8610.

The 8610 is almost unique among our high-end PowerPC chips in that it
literally has no on-board networking.  The board provides networking via a
PCI device.

-- 
Timur Tabi
Linux kernel developer at Freescale
