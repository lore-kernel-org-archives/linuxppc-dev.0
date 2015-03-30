Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5E3A61A0058
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2015 16:32:25 +1100 (AEDT)
Message-ID: <1427693545.28219.1.camel@ellerman.id.au>
Subject: Re: [PATCH 2/2] powerpc/powernv: Reboot when requested by firmware
From: Michael Ellerman <mpe@ellerman.id.au>
To: Joel Stanley <joel@jms.id.au>
Date: Mon, 30 Mar 2015 16:32:25 +1100
In-Reply-To: <1427681733-25488-2-git-send-email-joel@jms.id.au>
References: <1427681733-25488-1-git-send-email-joel@jms.id.au>
 <1427681733-25488-2-git-send-email-joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, fabf@skynet.be,
 jk@ozlabs.org, akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-03-30 at 12:45 +1030, Joel Stanley wrote:
> Use orderly_reboot so userspace will to shut itself down via the reboot
> path. This is required for graceful reboot initiated by the BMC, such
> as when a user uses ipmitool to issue a 'chassis power cycle' command.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  arch/powerpc/platforms/powernv/opal-power.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/opal-power.c b/arch/powerpc/platforms/powernv/opal-power.c
> index 48bf5b0..ac46c2c 100644
> --- a/arch/powerpc/platforms/powernv/opal-power.c
> +++ b/arch/powerpc/platforms/powernv/opal-power.c
> @@ -29,8 +29,9 @@ static int opal_power_control_event(struct notifier_block *nb,
>  
>  	switch (type) {
>  	case SOFT_REBOOT:
> -		/* Fall through. The service processor is responsible for
> -		 * bringing the machine back up */
> +		pr_info("OPAL: reboot requested\n");
> +		orderly_reboot();
> +		break;

Acked-by: Michael Ellerman <mpe@ellerman.id.au>


Andrew, do you want to take these 2 via your tree? Assuming folks are OK with
patch 1.

cheers
