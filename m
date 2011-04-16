Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DACE9B6F59
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Apr 2011 17:39:40 +1000 (EST)
Subject: Re: regression: 2.6.39-rc2,3 compile failure on p2020
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Richard Cochran <richardcochran@gmail.com>
In-Reply-To: <20110416072856.GA3542@riccoc20.at.omicron.at>
References: <20110416072856.GA3542@riccoc20.at.omicron.at>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 16 Apr 2011 17:39:29 +1000
Message-ID: <1302939569.28876.146.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2011-04-16 at 09:28 +0200, Richard Cochran wrote:
> When compiling mpc85xx_smp_defconfig, the kernel fails to link with:
> 
>    arch/powerpc/kernel/built-in.o: In function `cpu_die':
>    arch/powerpc/kernel/smp.c:702: undefined reference to
> `start_secondary_resume'
> 
> I suspect:
> 
>   commit fa3f82c8bb7acbe049ea71f258b3ae0a33d9d40b
>   powerpc/smp: soft-replugged CPUs must go back to start_secondary
> 
> The symbol start_secondary_resume is provided by head_32.S, but it is
> not present in head_fsl_booke.S.
> 
> I don't now how to fix this and would appreciate any help.

I'll fix it. Basically copy the code from head_32.S to head_fsl_booke.S


Thanks,

Cheers,
Ben.
