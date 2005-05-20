Return-Path: <akonovalov@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (RT-soft-2.Moscow.itn.ru [80.240.96.70])
	by ozlabs.org (Postfix) with SMTP id 4C171679EB
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 21 May 2005 03:29:34 +1000 (EST)
Message-ID: <428E2049.4010907@ru.mvista.com>
Date: Fri, 20 May 2005 21:37:13 +0400
From: Andrei Konovalov <akonovalov@ru.mvista.com>
MIME-Version: 1.0
To: Jason McMullan <jason.mcmullan@timesys.com>
References: <1114609634.30649.14.camel@ad.doubleclick.net>
In-Reply-To: <1114609634.30649.14.camel@ad.doubleclick.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: PPC_LINUX <linuxppc-embedded@ozlabs.org>
Subject: Re: MPC8xx Platformization
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Jason,

Jason McMullan wrote:
> The following is a rough skeleton of platformization for the mpc8xx
> series, in the same technique as Kumar's 85xx platformization.
> 
> This rough cut will be followed up later with specific
> driver platformization fixes.

How is the progress on the 8xx platformization?
We are working (in the same direction) on a couple 8xx boards,
and there is an issue which is not addressed by your patch:

> ------------------------------------------------------------------------
> 
> Date:        Wed, 20 Apr 2005 11:11:23 -0400
> Signed-Off-By:  Jason McMullan <jason.mcmullan@timesys.com>
> Description: MPC8xx platformization
> 
...
> --- /dev/null
> +++ linux/arch/ppc/platforms/8xx/mpc8xx_sys.c
...
> +struct ppc_sys_spec ppc_sys_specs[] = {
> +	{
> +		.ppc_sys_name	= "MPC885",
> +		.mask 		= 0xFFFF0000,
> +		.value 		= 0x00500000,
...
> --- linux-orig/arch/ppc/syslib/m8xx_setup.c
> +++ linux/arch/ppc/syslib/m8xx_setup.c
...
>  
> +	identify_ppc_sys_by_id(mfspr(PVR));
> +

All the MPC8xx'es have 0x0050 in the upper half of PVR.
So checking the value of PVR with .mask = 0xFFFF0000 makes no sense.

I've looked at how U-Boot detects the CPU, and the procedure is much more
complicated than just checking PVR and IMMR. U-Boot even probes (writes the
pattern to the register and reads it back) to check if the CPU has FEC.
But it still doesn't distinguish between e.g. MPC885, MPC880, MPC875, and MPC870
- though the set of on-chip devices is different for the four.

Anyone having an idea on what to pass to identify_ppc_sys_by_id() in case of MPC8xx?


Thanks,
Andrei
