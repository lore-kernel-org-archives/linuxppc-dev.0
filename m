Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4E161DDE0E
	for <linuxppc-dev@ozlabs.org>; Tue,  6 May 2008 10:26:48 +1000 (EST)
Subject: Re: [PATCH 2/4] [POWERPC] Xilinx: Virtex: Enable dcr for MMIO and
	NATIVE
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
In-Reply-To: <20080505175646.BDF3D11806D@mail196-wa4.bigfish.com>
References: <20080421080353.5d2b3bb9@zod.rchland.ibm.com>
	<1210010201-28436-1-git-send-email-stephen.neuendorffer@xilinx.com>
	<1210010201-28436-2-git-send-email-stephen.neuendorffer@xilinx.com>
	<20080505175646.BDF3D11806D@mail196-wa4.bigfish.com>
Content-Type: text/plain
Date: Tue, 06 May 2008 10:11:48 +1000
Message-Id: <1210032708.21644.131.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 2008-05-05 at 10:56 -0700, Stephen Neuendorffer wrote:
> FPGA designs may have need of both MMIO-based and NATIVE-based dcr
> interfaces.

You say _may_ ... wouldn't it be better if it was thus left to a given
virtex based platform to enable DCR_MMIO if it uses it and leave only
NATIVE by default ?

> Signed-off-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
> ---
>  arch/powerpc/platforms/40x/Kconfig |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/40x/Kconfig b/arch/powerpc/platforms/40x/Kconfig
> index a9260e2..b8e06df 100644
> --- a/arch/powerpc/platforms/40x/Kconfig
> +++ b/arch/powerpc/platforms/40x/Kconfig
> @@ -123,6 +123,8 @@ config 405GPR
>  
>  config XILINX_VIRTEX
>  	bool
> +	select PPC_DCR_MMIO
> +	select PPC_DCR_NATIVE
>  
>  config XILINX_VIRTEX_II_PRO
>  	bool
