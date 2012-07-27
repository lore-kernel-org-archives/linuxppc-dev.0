Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 94F532C007C
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Jul 2012 07:58:43 +1000 (EST)
Subject: Re: [PATCH] powerpc/smp: Do not disable IPI interrupts during suspend
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1342788421-27648-1-git-send-email-chenhui.zhao@freescale.com>
Date: Fri, 27 Jul 2012 16:58:38 -0500
Message-Id: <5028672F-1873-4E45-AA23-4CA9F191BE77@kernel.crashing.org>
References: <1342788421-27648-1-git-send-email-chenhui.zhao@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>,
 Zhao Chenhui <chenhui.zhao@freescale.com>,
 "linux-kernel@vger.kernel.org list" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 20, 2012, at 7:47 AM, Zhao Chenhui wrote:

> During suspend, all interrupts including IPI will be disabled. In this =
case,
> the suspend process will hang in SMP. To prevent this, pass the flag
> IRQF_NO_SUSPEND when requesting IPI irq.
>=20
> Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
> arch/powerpc/kernel/smp.c |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)

BenH,

Can you ack?

- k

>=20
> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index fecb038..d26bbf8 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -171,7 +171,7 @@ int smp_request_message_ipi(int virq, int msg)
> 	}
> #endif
> 	err =3D request_irq(virq, smp_ipi_action[msg],
> -			  IRQF_PERCPU | IRQF_NO_THREAD,
> +			  IRQF_PERCPU | IRQF_NO_THREAD | =
IRQF_NO_SUSPEND,
> 			  smp_ipi_name[msg], 0);
> 	WARN(err < 0, "unable to request_irq %d for %s (rc %d)\n",
> 		virq, smp_ipi_name[msg], err);
> --=20
> 1.6.4.1
>=20
