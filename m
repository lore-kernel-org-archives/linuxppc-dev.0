Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7612C67C52
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Nov 2006 08:34:05 +1100 (EST)
Subject: Re: [PATCH] Add support for FP emulation for the e300c2 core
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kim Phillips <kim.phillips@freescale.com>
In-Reply-To: <20061122142020.3e700bac.kim.phillips@freescale.com>
References: <20061122142020.3e700bac.kim.phillips@freescale.com>
Content-Type: text/plain
Date: Thu, 23 Nov 2006 08:34:34 +1100
Message-Id: <1164231274.5653.28.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> +BEGIN_FTR_SECTION
> +/*
> + * certain freescale cores treat 'normal' floating point instructions
> + * as FP Unavail exception.  Redirect to normal illegal/emulation handling.
> + */
> +	b 	ProgramCheck
> +END_FTR_SECTION_IFSET(CPU_FTR_FP_TAKES_FPUNAVAIL)
>  	EXCEPTION_PROLOG
>  	bne	load_up_fpu		/* if from user, just load it up */
>  	addi	r3,r1,STACK_FRAME_OVERHEAD

Do you absolutely need that ? Is there any way those cores will actually
send a "normal" FPUnavail exception ? If not, don't bother. There aren't
that many CPU feature bits left so let's not use one for something that
never happens.

Ben.
