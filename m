Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3A002DE3B5
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Oct 2008 00:31:44 +1100 (EST)
Message-Id: <DAB34CED-1278-4ECE-8043-7E727D3232F7@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <1222449610-14672-1-git-send-email-timur@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] powerpc: fix conflict with Elo DMA driver in MPC8610
	device tree
Date: Fri, 10 Oct 2008 08:30:02 -0500
References: <1222449610-14672-1-git-send-email-timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 26, 2008, at 12:20 PM, Timur Tabi wrote:

> The Freescale Elo DMA driver binds to all DMA channels in the device  
> tree that
> are compatible with "fsl,eloplus-dma-channel".  This conflicts with  
> the sound
> drivers for the MPC8610.  To avoid the conflict, change the  
> compatible property
> for the DMA channels needed by the sound drivers to "fsl,ssi-dma- 
> channel".
> This works because the sound drivers don't actually check the  
> compatible
> property when it grabs DMA channels.
>
> Also update dma.txt and ssi.txt with this information.
>
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
> Documentation/powerpc/dts-bindings/fsl/dma.txt |   13 +++++++++++--
> Documentation/powerpc/dts-bindings/fsl/ssi.txt |   12 ++++++++++--
> arch/powerpc/boot/dts/mpc8610_hpcd.dts         |    4 ++--
> 3 files changed, 23 insertions(+), 6 deletions(-)

Break this into two patches.  The second one should just be the .dts  
and specifically say "on the MPC8610 HPCD board we use SSI and thus  
the dma channel is not available for general purpose use"...

- k
