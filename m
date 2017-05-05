Return-Path: <robherring2@gmail.com>
Received: from mail-io0-f196.google.com (mail-io0-f196.google.com
 [209.85.223.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wKNQJ5SkXzDqCd
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 May 2017 06:14:00 +1000 (AEST)
Received: by mail-io0-f196.google.com with SMTP id l196so3835869ioe.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 May 2017 13:14:00 -0700 (PDT)
Date: Fri, 5 May 2017 15:13:57 -0500
From: Rob Herring <robh@kernel.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>, Mark Rutland <mark.rutland@arm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v2] powerpc/8xx: Adding support of IRQ in MPC8xx GPIO
Message-ID: <20170505201357.bxbjo623uiey5vvu@rob-hp-laptop>
References: <20170501073813.7567549BED@pc13941vm.idsi0.si.c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170501073813.7567549BED@pc13941vm.idsi0.si.c-s.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 01, 2017 at 09:38:13AM +0200, Christophe Leroy wrote:
> This patch allows the use of IRQ to notify the change of GPIO status
> on MPC8xx CPM IO ports. This then allows to associate IRQs to GPIOs
> in the Device Tree.

Wow, that's an old part.

> Ex:
> 	CPM1_PIO_C: gpio-controller@960 {
> 		#gpio-cells = <2>;
> 		compatible = "fsl,cpm1-pario-bank-c";
> 		reg = <0x960 0x10>;
> 		fsl,cpm1-gpio-irq-mask = <0x0fff>;
> 		interrupts = <1 2 6 9 10 11 14 15 23 24 26 31>;
> 		interrupt-parent = <&CPM_PIC>;
> 		gpio-controller;
> 	};
> 
> The property 'fsl,cpm1-gpio-irq-mask' defines which of the 16 GPIOs
> have the associated interrupts defined in the 'interrupts' property.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  v2: Updated the binding ; changed property 'interrupt-mask' to 'fsl,cpm1-gpio-irq-mask'
> 
>  .../devicetree/bindings/soc/fsl/cpm_qe/gpio.txt    | 21 +++++++++++++++++-

Acked-by: Rob Herring <robh@kernel.org>

>  arch/powerpc/include/asm/cpm1.h                    |  2 ++
>  arch/powerpc/sysdev/cpm1.c                         | 25 ++++++++++++++++++++++
>  3 files changed, 47 insertions(+), 1 deletion(-)
