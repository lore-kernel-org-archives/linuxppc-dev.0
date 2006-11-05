Return-Path: <tnt@246tNt.com>
Message-ID: <454D2FEC.3050605@246tNt.com>
Date: Sun, 05 Nov 2006 01:27:24 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH/RFC] powerpc: Add MPC5200 Interrupt Controller support.
References: <454902F9.20206@bplan-gmbh.de>	<1162419138.25682.453.camel@localhost.localdomain>	<454A1C37.5050208@bplan-gmbh.de>
	<454A5952.6090801@bplan-gmbh.de>
	<1162683341.28571.82.camel@localhost.localdomain>
In-Reply-To: <1162683341.28571.82.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org, sl@bplan-gmbh.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


>> +	picnode = find_mpc52xx_picnode();
>> +	sdmanode = find_mpc52xx_sdmanode();
>>     
>
> Any reason why you have those inline 1-line functions and just not put
> the actual of_find_* call in here ?
>   
I think it might be worth creating a
arch/powerpc/sysdev/mpc52xx_common.c (we'll probably need it later on
anyway)
with a helper that would do
 - The find_node
 - get_address / translate /  get_size
 - ioremap

Something like :

intr = mpc52xx_find_and_map("mpc52xx-intr");
sdma = mpc52xx_find_and_map("mpc52xx-sdma");

would be more elegant. Especially since finding and mapping things like
intr/sdma/xlb/cdm ... will be done at several place. That would prevent
repeating all that code for nothing.




Also, in the Makefile, I would make the compilation conditionnal to
CONFIG_PPC_MPC52xx and not CONFIG_PPC_MPC52xx_PIC ...
If you're on a 52xx, you most likely want the interrupt controller ...

But the CONFIG_PPC_MPC52xx option should be in arch/powerpc/Kconfig
and not in the platform/embedded6xx/Kconfig


        Sylvain
