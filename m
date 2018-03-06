Return-Path: <ruscur@russell.cc>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zwPBw4gKkzF1CK
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2018 15:37:27 +1100 (AEDT)
Message-ID: <1520311039.2077.10.camel@russell.cc>
Subject: Re: [PATCH 6/9] powerpc/eeh: Clarify arguments to eeh_reset_device()
From: Russell Currey <ruscur@russell.cc>
To: Sam Bobroff <sam.bobroff@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org
Date: Tue, 06 Mar 2018 15:37:19 +1100
In-Reply-To: <c9191611543d221d5f003fad4a68dd5f86839404.1520294174.git.sam.bobroff@au1.ibm.com>
References: <cover.1520294174.git.sam.bobroff@au1.ibm.com>
 <c9191611543d221d5f003fad4a68dd5f86839404.1520294174.git.sam.bobroff@au1.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-03-06 at 10:59 +1100, Sam Bobroff wrote:
> It is currently difficult to understand the behaviour of
> eeh_reset_device() due to the way it's parameters are used. In
> particular, when 'bus' is NULL, it's value is still necessary so the
> same value is looked up again locally under a different name
> ('frozen_bus') but behaviour is changed.
> 
> To clarify this, add a new parameter 'eeh_aware_driver', and have the
> caller set it when it would have passed NULL for 'bus' and always
> pass
> a value for 'bus'. Then change any test that was on 'bus' to one on
> '!eeh_aware_driver' and replace uses of 'frozen_bus' with 'bus'.
> 
> Also update the function's comment.
> 
> This should not change behaviour.
> 
> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
> ---
>  arch/powerpc/kernel/eeh_driver.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/eeh_driver.c
> b/arch/powerpc/kernel/eeh_driver.c
> index cb584d72b0a5..6c3577133223 100644
> --- a/arch/powerpc/kernel/eeh_driver.c
> +++ b/arch/powerpc/kernel/eeh_driver.c
> @@ -619,17 +619,19 @@ int eeh_pe_reset_and_recover(struct eeh_pe *pe)
>  
>  /**
>   * eeh_reset_device - Perform actual reset of a pci slot
> + * @eeh_aware_driver: Does the device's driver provide EEH support?
>   * @pe: EEH PE
>   * @bus: PCI bus corresponding to the isolcated slot
> + * @rmv_data: Optional, list to record removed devices
>   *
>   * This routine must be called to do reset on the indicated PE.
>   * During the reset, udev might be invoked because those affected
>   * PCI devices will be removed and then added.
>   */

Just a nitpick here, I would prefer that the PE remain the first
argument of the function since that's one thing that's pretty standard
across the EEH implementation.  I'd also say that "driver_aware" is
clearer than "aware_driver".

Reviewed-by: Russell Currey <ruscur@russell.cc>
