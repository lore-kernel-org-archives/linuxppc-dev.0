Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 964E3DDDF8
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Dec 2007 02:37:19 +1100 (EST)
Message-Id: <1E5FF6FC-E905-4FAF-84ED-A96B0E0ACCA8@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <20071209233654.2327.18925.stgit@terra.home>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH 3/4] Convert PowerPC MPC i2c to of_platform_driver from
	platform_driver
Date: Mon, 10 Dec 2007 09:34:53 -0600
References: <20071209233648.2327.14584.stgit@terra.home>
	<20071209233654.2327.18925.stgit@terra.home>
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 9, 2007, at 5:36 PM, Jon Smirl wrote:

> Convert MPC i2c driver from being a platform_driver to an open  
> firmware version. Error returns were improved. Routine names were  
> changed from fsl_ to mpc_ to make them match the file name.
>
> Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
> ---
>
> arch/powerpc/sysdev/fsl_soc.c |   96 ---------------------
> drivers/i2c/busses/i2c-mpc.c  |  190 +++++++++++++++++++++++++++ 
> +-------------
> 2 files changed, 129 insertions(+), 157 deletions(-)

this patch breaks arch/ppc users which are platform_driver based and  
I'm guessing a number of arch/powerpc users which don't  
of_platform_bus_probe().

Also, you should split out the conversion and error fixing into  
separate patches.

- k
