Return-Path: <jochen@scram.de>
Received: from mail0.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail0.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 80524DDECB
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jan 2008 05:04:15 +1100 (EST)
Message-ID: <4797818F.2080603@scram.de>
Date: Wed, 23 Jan 2008 19:03:59 +0100
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCHv2 5/8] [POWERPC] Remove sysdev/commproc.h
References: <479764B8.4010909@scram.de>
	<83FEE161-D10D-4E21-BDB3-D0B6D49668CE@kernel.crashing.org>
In-Reply-To: <83FEE161-D10D-4E21-BDB3-D0B6D49668CE@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Cc: Scott Wood <scottwood@freescale.com>, "Kernel,
	Linux" <linux-kernel@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Kumar,

> Do we really need the prototypes you moved into asm/mpc8xx.h here?  can 
> they just live in platforms/8xx/8xx.h or something like that?

At least drivers/pcmcia/m8xx_pcmcia.c uses the symbol m8xx_pcmcia_ops
which is conditionally defined in platforms/8xx/m8xx_setup.c. However,
this driver currently seems to be broken (doesn't compile neither as
built-in nor as module).

Other drivers that include asm/mpc8xx.c are:

drivers/net/fec.c (the include seems to be obsolete, as according to Kconfig
                    the driver is only built on MPC52xx platforms)
drivers/net/fec_8xx (unused, depends on non-existant CONFIG_8XX)
drivers/net/fs_enet (i need to check if the include is needed, at all)

I'll have a closer look at this.

Thanks,
Jochen
