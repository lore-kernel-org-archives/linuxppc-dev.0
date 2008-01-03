Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BE74ADDEE1
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jan 2008 04:56:35 +1100 (EST)
Message-ID: <477D2214.1020900@freescale.com>
Date: Thu, 03 Jan 2008 11:57:40 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
References: <11981089894052-git-send-email-timur@freescale.com>	
	<9e4733910801012027p4be16b92r43af773f4e5ae531@mail.gmail.com>	
	<477BADF5.9060003@freescale.com>
	<9e4733910801020756p18e12ce8o618b8eae5e7c5a53@mail.gmail.com>
In-Reply-To: <9e4733910801020756p18e12ce8o618b8eae5e7c5a53@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jon Smirl wrote:

> For this model to work you need to split your driver. fsl-ssi and
> mpc8610_hpcd need to be in  two separate drivers. 

They are two separate drivers.  sound/soc/fsl/fsl_ssi.c and 
sound/soc/fsl/mpc8610_hpcd.c

 > fsl-ssi  is easy
> enough to load since it has a device tree entry.
> 
> mpc8610_hpcd is the harder one to load since it doesn't have a device
> tree entry. What you want to do it match on the compatible field of
> the root node.
> 
> static struct of_device_id fabric_of_match[] = {
> 	{
> 		.compatible	= "fsl,MPC8610HPCD",
> 	},
> 	{},
> };
> 
> But this doesn't work since the root is the device tree isn't passed
> down into the device probe code. (Could this be fixed?)

I don't understand that sentence.  Is there a typo?

> Instead we could make the separated mpc8610_hpcd fabric driver attach
> to fsl,ssi.
> 
> static struct of_device_id fabric_of_match[] = {
> 	{
> 		.compatible	= "fsl,ssi",
> 	},
> 	{},
> };
> 
> Then in it's probe code check for the right platform.

That's what I do.  I attach to fsl,ssi, gather the information from the device 
tree, and then call a private API to initialize the SSI driver.


-- 
Timur Tabi
Linux Kernel Developer @ Freescale
