Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 8C8601007D2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Oct 2011 05:29:43 +1100 (EST)
In-Reply-To: <1319652797-28017-1-git-send-email-msm@freescale.com>
References: <08F58B37-0825-4C07-91B3-1040A7E70528@freescale.com>
 <1319652797-28017-1-git-send-email-msm@freescale.com>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <2E906E82-C4BE-4A7A-BA25-3ADAFFA3EB09@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/5] powerpc/85xx: issue 15 EOI after core reset for FSL
 CoreNet devices
Date: Wed, 26 Oct 2011 20:30:04 +0200
To: Matthew McClintock <msm@freescale.com>
Cc: kumar.gala@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> @@ -1759,6 +1760,12 @@ void mpic_reset_core(int cpu)
>  	pir &= ~(1 << cpuid);
>  	mpic_write(mpic->gregs, MPIC_INFO(GREG_PROCESSOR_INIT), pir);
>  	mpic_read(mpic->gregs, MPIC_INFO(GREG_PROCESSOR_INIT));
> +
> +	/* Perform 15 EOI on each reset core to clear pending interrupts */
> +	for (i = 0; i < 15; i++) {
> +		_mpic_write(mpic->reg_type, &mpic->cpuregs[cpuid],
> +				      MPIC_CPU_EOI, 0);
> +	}

This is generic code, right?  Please add info to the comment about
which devices need this quirk, then.


Segher
