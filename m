Return-Path: <jonsmirl@gmail.com>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.191])
	by ozlabs.org (Postfix) with ESMTP id C25B4DDE1D
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jan 2008 02:56:48 +1100 (EST)
Received: by rv-out-0910.google.com with SMTP id c27so3857773rvf.9
	for <linuxppc-dev@ozlabs.org>; Wed, 02 Jan 2008 07:56:47 -0800 (PST)
Message-ID: <9e4733910801020756p18e12ce8o618b8eae5e7c5a53@mail.gmail.com>
Date: Wed, 2 Jan 2008 10:56:47 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Timur Tabi" <timur@freescale.com>
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
In-Reply-To: <477BADF5.9060003@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <11981089894052-git-send-email-timur@freescale.com>
	<9e4733910801012027p4be16b92r43af773f4e5ae531@mail.gmail.com>
	<477BADF5.9060003@freescale.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/2/08, Timur Tabi <timur@freescale.com> wrote:
> Are you saying that you want to use the same kernel on four different
> systems?  If so, then you need to find a way to compile all fabric
> drivers together, and at boot time each fabric driver will decide
> whether it will do anything.

Yes, I have four different but similar systems. They only differer in
the codec chips used. I want to make a single kernel image and then
use the device tree to dynamically load the correct codec driver from
initrd. That will let me ship a single kernel image that services all
four machines. The codecs implement different sound systems from low
end to high end.

The correct solution for this is to use kernel modules and trigger
their loading based on the device tree. This is the same mechanism
used by USB and PCI.

For this model to work you need to split your driver. fsl-ssi and
mpc8610_hpcd need to be in  two separate drivers. fsl-ssi  is easy
enough to load since it has a device tree entry.

mpc8610_hpcd is the harder one to load since it doesn't have a device
tree entry. What you want to do it match on the compatible field of
the root node.

static struct of_device_id fabric_of_match[] = {
	{
		.compatible	= "fsl,MPC8610HPCD",
	},
	{},
};

But this doesn't work since the root is the device tree isn't passed
down into the device probe code. (Could this be fixed?)

Instead we could make the separated mpc8610_hpcd fabric driver attach
to fsl,ssi.

static struct of_device_id fabric_of_match[] = {
	{
		.compatible	= "fsl,ssi",
	},
	{},
};

Then in it's probe code check for the right platform.

unsigned long node = of_get_flat_dt_root();
if (!of_flat_dt_is_compatible(node, "fsl,MPC8610HPCD"))
	return 0;
.. activate the code ...

You also need a static flag to make sure you don't active the driver
more than once.

This isn't the best solution since my four fabric drivers will still
load and check what platform they are on before exiting but at least
it works.

-- 
Jon Smirl
jonsmirl@gmail.com
