Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 763871A09F0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jan 2015 20:28:31 +1100 (AEDT)
Message-ID: <1421746096.4949.40.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/pseries: Avoid context switch in EEH reset if
 required
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Date: Tue, 20 Jan 2015 10:28:16 +0100
In-Reply-To: <1421621243-21265-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1421621243-21265-1-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-01-19 at 09:47 +1100, Gavin Shan wrote:
> On pseries platform, the EEH reset backend pseries_eeh_reset() can
> be called in atomic context as follows. For this case, we should
> call udelay() instead of msleep() to avoid context switching.
> 
>      drivers/scsi/ipr.c::ipr_reset_slot_reset_done()
>      drivers/pci/pci.c::pci_set_pcie_reset_state()
>      arch/powerpc/kernel/eeh.c::pcibios_set_pcie_reset_state()
>      arch/powerpc/platforms/pseries/eeh_pseries.c::pseries_eeh_reset()

It's not acceptable to introduce multi-millisecond delays at interrupt
time. In fact, we should generally not use udelay in such context.

I understand that this is an exceptional error handling case but it's
still not right.

Are there many other users of pci_set_pcie_reset_state() at interrupt
time ? Can we have a discussion with the PCI folks as to whether that
should be legal or not ?

I'm tempted to require that it's made illegal.

Ben.

> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> Tested-by: Wen Xiong<wenxiong@linux.vnet.ibm.com>
> ---
>  arch/powerpc/platforms/pseries/eeh_pseries.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
> index a6c7e19..67623a3 100644
> --- a/arch/powerpc/platforms/pseries/eeh_pseries.c
> +++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
> @@ -503,8 +503,7 @@ static int pseries_eeh_get_state(struct eeh_pe *pe, int *state)
>   */
>  static int pseries_eeh_reset(struct eeh_pe *pe, int option)
>  {
> -	int config_addr;
> -	int ret;
> +	int config_addr, delay, ret;
>  
>  	/* Figure out PE address */
>  	config_addr = pe->config_addr;
> @@ -528,9 +527,14 @@ static int pseries_eeh_reset(struct eeh_pe *pe, int option)
>  	/* We need reset hold or settlement delay */
>  	if (option == EEH_RESET_FUNDAMENTAL ||
>  	    option == EEH_RESET_HOT)
> -		msleep(EEH_PE_RST_HOLD_TIME);
> +		delay = EEH_PE_RST_HOLD_TIME;
> +	else
> +		delay = EEH_PE_RST_SETTLE_TIME;
> +
> +	if (in_atomic())
> +		udelay(delay * 1000);
>  	else
> -		msleep(EEH_PE_RST_SETTLE_TIME);
> +		msleep(delay);
>  
>  	return ret;
>  }
