Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1EB05DDF1D
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Jun 2007 11:50:13 +1000 (EST)
In-Reply-To: <20070624224652.2950.qmail@farnsworth.org>
References: <20070624224652.2950.qmail@farnsworth.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A6094184-7DFA-4ADC-B16D-20C7593135AA@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] ppc: Marvell mv64x60 drivers for ppc platforms fix
Date: Sun, 24 Jun 2007 20:49:58 -0500
To: Dale Farnsworth <dale@farnsworth.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 24, 2007, at 5:46 PM, Dale Farnsworth wrote:

> In article <200706241552.31483.yur@emcraft.com> you write:
>>  This patch fixes the issue of erroneously involving the
>> arch/powerpc/sysdev/mv64x60*.c files into the compilation
>> process for ppc- (not powerpc-) based platforms (e.g.,
>> P3M750).
>>
>>  Signed-off-by: Yuri Tikhonov <yur@emcraft.com>
>>
>> --
>>
>> diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/ 
>> Makefile
>> index c3ce0bd..25eaa14 100644
>> --- a/arch/powerpc/sysdev/Makefile
>> +++ b/arch/powerpc/sysdev/Makefile
>> @@ -17,7 +17,9 @@ obj-$(CONFIG_FSL_PCIE)		+= fsl_pcie.o
>>  obj-$(CONFIG_TSI108_BRIDGE)	+= tsi108_pci.o tsi108_dev.o
>>  obj-$(CONFIG_QUICC_ENGINE)	+= qe_lib/
>>  mv64x60-$(CONFIG_PCI)		+= mv64x60_pci.o
>
> Shouldn't the above line also be placed inside the of following ifeq ?
>
>> +ifeq ($(CONFIG_PPC_MERGE),y)
>>  obj-$(CONFIG_MV64X60)		+= $(mv64x60-y) mv64x60_pic.o mv64x60_dev.o
>> +endif
>>
>>  # contains only the suspend handler for time
>>  obj-$(CONFIG_PM)		+= timer.o

Also, lets just move these into the existing ifeq  
($CONFIG_PPC_MERGE,y) block in that makefile rather than introducing  
a new one.

- k
