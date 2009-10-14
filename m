Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f218.google.com (mail-gx0-f218.google.com
	[209.85.217.218]) by ozlabs.org (Postfix) with ESMTP id DCAC0B7B6F
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2009 06:00:12 +1100 (EST)
Received: by gxk10 with SMTP id 10so107964gxk.3
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Oct 2009 12:00:11 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <a6fc612b826ff12628e62601203d565df00c6436.1255499081.git.michael@ellerman.id.au>
References: <a6fc612b826ff12628e62601203d565df00c6436.1255499081.git.michael@ellerman.id.au>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 14 Oct 2009 12:59:51 -0600
Message-ID: <fa686aa40910141159l402304e9y22a6b2d7d8d79759@mail.gmail.com>
Subject: Re: [PATCH 1/6] powerpc: Make NR_IRQS a CONFIG option
To: Michael Ellerman <michael@ellerman.id.au>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 13, 2009 at 11:44 PM, Michael Ellerman
<michael@ellerman.id.au> wrote:
> The irq_desc array consumes quite a lot of space, and for systems
> that don't need or can't have 512 irqs it's just wasted space.
>
> The first 16 are reserved for ISA, so the minimum of 32 is really
> 16 - and no one has asked for more than 512 so leave that as the
> maximum.

Does it really make sense to have this as a user twiddlable value?
Especially when many users just don't have the background to know what
an appropriate value is here and will get it wrong?  I believe your
sparse IRQ patch has a bigger impact anyway on systems where memory is
tight.

g.

>
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> ---
> =A0arch/powerpc/Kconfig =A0 =A0 =A0 =A0 =A0 | =A0 10 ++++++++++
> =A0arch/powerpc/include/asm/irq.h | =A0 =A04 ++--
> =A02 files changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 10a0a54..2230e75 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -56,6 +56,16 @@ config IRQ_PER_CPU
> =A0 =A0 =A0 =A0bool
> =A0 =A0 =A0 =A0default y
>
> +config NR_IRQS
> + =A0 =A0 =A0 int "Number of virtual interrupt numbers"
> + =A0 =A0 =A0 range 32 512
> + =A0 =A0 =A0 default "512"
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 This defines the number of virtual interrupt numbers th=
e kernel
> + =A0 =A0 =A0 =A0 can manage. Virtual interrupt numbers are what you see =
in
> + =A0 =A0 =A0 =A0 /proc/interrupts. If you configure your system to have =
too few,
> + =A0 =A0 =A0 =A0 drivers will fail to load or worse - handle with care.
> +
> =A0config STACKTRACE_SUPPORT
> =A0 =A0 =A0 =A0bool
> =A0 =A0 =A0 =A0default y
> diff --git a/arch/powerpc/include/asm/irq.h b/arch/powerpc/include/asm/ir=
q.h
> index bbcd1aa..b83fcc8 100644
> --- a/arch/powerpc/include/asm/irq.h
> +++ b/arch/powerpc/include/asm/irq.h
> @@ -34,8 +34,8 @@ extern atomic_t ppc_n_lost_interrupts;
> =A0*/
> =A0#define NO_IRQ_IGNORE =A0 =A0 =A0 =A0 =A0((unsigned int)-1)
>
> -/* Total number of virq in the platform (make it a CONFIG_* option ? */
> -#define NR_IRQS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0512
> +/* Total number of virq in the platform */
> +#define NR_IRQS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0CONFIG_NR_IRQS
>
> =A0/* Number of irqs reserved for the legacy controller */
> =A0#define NUM_ISA_INTERRUPTS =A0 =A0 16
> --
> 1.6.2.1
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
