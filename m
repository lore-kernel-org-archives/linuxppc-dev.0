Return-Path: <timur.tabi@gmail.com>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by ozlabs.org (Postfix) with ESMTP id 3A247B6EDF
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  1 Jul 2010 06:56:30 +1000 (EST)
Received: by vws11 with SMTP id 11so1452885vws.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 30 Jun 2010 13:56:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100308191005.GE4324@amak.tundra.com>
References: <20100308191005.GE4324@amak.tundra.com>
From: Timur Tabi <timur.tabi@gmail.com>
Date: Wed, 30 Jun 2010 15:55:58 -0500
Message-ID: <AANLkTine3pc2Ai2Woj81Y9fS_KgGs1sIMb2NMR6G74ww@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] powerpc/85xx: Add MChk handler for SRIO port
To: Alexandre Bounine <abounine@tundra.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	thomas.moll@sysgo.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 8, 2010 at 2:10 PM, Alexandre Bounine <abounine@tundra.com> wro=
te:
>
> From: Alexandre Bounine <alexandre.bounine@idt.com>
>
> Add Machine Check exception handling into RapidIO port driver
> for Freescale SoCs (MPC85xx).
>
> Signed-off-by: Alexandre Bounine <alexandre.bounine@idt.com>
> Tested-by: Thomas Moll <thomas.moll@sysgo.com>
...

> +static int fsl_rio_mcheck_exception(struct pt_regs *regs)
> +{
> + =A0 =A0 =A0 const struct exception_table_entry *entry =3D NULL;
> + =A0 =A0 =A0 unsigned long reason =3D (mfspr(SPRN_MCSR) & MCSR_MASK);

MCSR_MASK is not defined anywhere, so when I compile this code, I get this:

  CC      arch/powerpc/sysdev/fsl_rio.o
arch/powerpc/sysdev/fsl_rio.c: In function 'fsl_rio_mcheck_exception':
arch/powerpc/sysdev/fsl_rio.c:248: error: 'MCSR_MASK' undeclared
(first use in this function)
arch/powerpc/sysdev/fsl_rio.c:248: error: (Each undeclared identifier
is reported only once
arch/powerpc/sysdev/fsl_rio.c:248: error: for each function it appears in.)

--=20
Timur Tabi
Linux kernel developer at Freescale
