Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6589DDDE17
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Dec 2007 02:55:54 +1100 (EST)
Message-Id: <054B7122-6815-4483-96FE-7B4098198FA1@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <20071218023915.8530.67500.stgit@terra.home>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH 1/7] Copy mpc-i2c to preserve support for ARCH=ppc and
	allow changes on ARCH=powerpc
Date: Tue, 18 Dec 2007 09:53:28 -0600
References: <20071218023913.8530.46661.stgit@terra.home>
	<20071218023915.8530.67500.stgit@terra.home>
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 17, 2007, at 8:39 PM, Jon Smirl wrote:

> Temporarily copy the mpc-i2c driver to continue support for the ppc  
> architecture until it is removed in mid-2008. This file should be  
> deleted as part of ppc's final removal.
>
> Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
>
> Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
>
> Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
> ---
>
> arch/ppc/configs/TQM8540_defconfig     |    2
> arch/ppc/configs/TQM8541_defconfig     |    2
> arch/ppc/configs/TQM8555_defconfig     |    2
> arch/ppc/configs/TQM8560_defconfig     |    2
> arch/ppc/configs/mpc834x_sys_defconfig |    2
> arch/ppc/configs/mpc8540_ads_defconfig |    2
> arch/ppc/configs/mpc8548_cds_defconfig |    2
> arch/ppc/configs/mpc8555_cds_defconfig |    2
> arch/ppc/configs/mpc8560_ads_defconfig |    2
> drivers/i2c/busses/Kconfig             |   16 +
> drivers/i2c/busses/Makefile            |    1
> drivers/i2c/busses/i2c-mpc-ppc.c       |  418 +++++++++++++++++++++++ 
> +++++++++
> 12 files changed, 443 insertions(+), 10 deletions(-)
> create mode 100644 drivers/i2c/busses/i2c-mpc-ppc.c

Nak.

Just ifdef the probe functionality in i2c-mpc.c based on  
CONFIG_PPC_MERGE.  Your patch set shows the reason you should do  
this.  You provide fixes to the error path handling, but only for i2c- 
mpc.c and not i2c-mpc-ppc.c.

- k
