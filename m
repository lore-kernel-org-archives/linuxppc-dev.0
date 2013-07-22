Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe002.messaging.microsoft.com [216.32.180.12])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E2F242C00B6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 08:19:19 +1000 (EST)
Date: Mon, 22 Jul 2013 17:19:08 -0500
From: Scott Wood <scottwood@freescale.com>
To: Alexander Graf <agraf@suse.de>
Subject: Re: PPC: Don't sync timebase when inside VM
Message-ID: <20130722221908.GA26079@home.buserror.net>
References: <1330697553-27156-1-git-send-email-agraf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1330697553-27156-1-git-send-email-agraf@suse.de>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 02, 2012 at 03:12:33PM +0100, Alexander Graf wrote:
> When running inside a virtual machine, we can not modify timebase, so
> let's just not call the functions for it then.
> 
> This resolves hangs when booting e500 SMP guests on overcommitted hosts.
> 
> Reported-by: Stuart Yoder <B08248@freescale.com>
> Signed-off-by: Alexander Graf <agraf@suse.de>
> 
> ---
> arch/powerpc/platforms/85xx/smp.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
> index ff42490..d4b6c1f 100644
> --- a/arch/powerpc/platforms/85xx/smp.c
> +++ b/arch/powerpc/platforms/85xx/smp.c
> @@ -249,6 +249,13 @@ void __init mpc85xx_smp_init(void)
>  		smp_85xx_ops.cause_ipi = doorbell_cause_ipi;
>  	}
>  
> +	/* When running under a hypervisor, we can not modify tb */
> +	np = of_find_node_by_path("/hypervisor");
> +	if (np) {
> +		smp_85xx_ops.give_timebase = NULL;
> +		smp_85xx_ops.take_timebase = NULL;
> +	}

I'm marking this superseded as we now only set give/take_timebase if a
guts node is present that corresponds to an SMP SoC.  QEMU currently
advertises an mpc8544 guts (which is not SMP) and will eventually move to
a paravirt device with no guts at all.

-Scott
