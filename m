Return-Path: <B07421@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe002.messaging.microsoft.com [213.199.154.140])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 92B8C2C0085
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Feb 2013 05:27:39 +1100 (EST)
Date: Thu, 7 Feb 2013 12:27:29 -0600
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] mpic: fix Destination Registers init problem
To: Zhao Chenhui <chenhui.zhao@freescale.com>
References: <1360224420-5009-1-git-send-email-chenhui.zhao@freescale.com>
In-Reply-To: <1360224420-5009-1-git-send-email-chenhui.zhao@freescale.com>
 (from chenhui.zhao@freescale.com on Thu Feb  7 02:07:00 2013)
Message-ID: <1360261649.27002.5@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/07/2013 02:07:00 AM, Zhao Chenhui wrote:
> The Freescale implementation of the MPIC only allows a single CPU
> destination for non-IPI interrupts. Test the flag MPIC_SINGLE_DEST_CPU
> to check if the Destination registers should be set.
>=20
> This prevents more than one bit is set at secondary processors
> initilizing time if the flag MPIC_SINGLE_DEST_CPU is set.
>=20
> Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
>  arch/powerpc/sysdev/mpic.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
> index 9c6e535..cc537f8 100644
> --- a/arch/powerpc/sysdev/mpic.c
> +++ b/arch/powerpc/sysdev/mpic.c
> @@ -1675,7 +1675,7 @@ void mpic_setup_this_cpu(void)
>  	 * it differently, then we should make sure we also change the =20
> default
>  	 * values of irq_desc[].affinity in irq.c.
>   	 */
> -	if (distribute_irqs) {
> +	if (distribute_irqs && !(mpic->flags & MPIC_SINGLE_DEST_CPU)) {
>  	 	for (i =3D 0; i < mpic->num_sources ; i++)
>  			mpic_irq_write(i, MPIC_INFO(IRQ_DESTINATION),
>  				mpic_irq_read(i, =20
> MPIC_INFO(IRQ_DETINATION)) | msk);

http://patchwork.ozlabs.org/patch/211454/

-Scott=
