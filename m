Return-Path: <tnt@246tNt.com>
Received: from outmx017.isp.belgacom.be (outmx017.isp.belgacom.be
	[195.238.2.116]) by ozlabs.org (Postfix) with ESMTP id 13EA267A65
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 12 Mar 2005 07:47:43 +1100 (EST)
Received: from outmx017.isp.belgacom.be (localhost [127.0.0.1])
	by outmx017.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id j2BKlWQL009581
	for <linuxppc-embedded@ozlabs.org>; Fri, 11 Mar 2005 21:47:34 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <423203EC.1070003@246tNt.com>
Date: Fri, 11 Mar 2005 21:47:40 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Kumar Gala <kumar.gala@freescale.com>
References: <4231F9F9.5080506@246tNt.com>
	<be4da82f8d12e20b54050e15fd27df36@freescale.com>
In-Reply-To: <be4da82f8d12e20b54050e15fd27df36@freescale.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Cc: Tom Rini <trini@kernel.crashing.org>, LKML <linux-kernel@vger.kernel.org>,
	Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH 1/2] MPC52xx updates : sparse clean-ups
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



Kumar Gala wrote:

>>
>>
>> diff -Nru a/arch/ppc/syslib/mpc52xx_pic.c 
>> b/arch/ppc/syslib/mpc52xx_pic.c
>> --- a/arch/ppc/syslib/mpc52xx_pic.c     2005-03-11 20:41:36 +01:00
>>  +++ b/arch/ppc/syslib/mpc52xx_pic.c     2005-03-11 20:41:36 +01:00
>>  @@ -33,8 +33,8 @@
>>   #include <asm/mpc52xx.h>
>>
>>
>>
>> -static struct mpc52xx_intr *intr;
>>  -static struct mpc52xx_sdma *sdma;
>>  +static struct mpc52xx_intr __iomem *intr;
>>  +static struct mpc52xx_sdma __iomem *sdma;
>>
>>  static void
>>   mpc52xx_ic_disable(unsigned int irq)
>>  @@ -173,7 +173,7 @@
>>          mpc52xx_ic_disable,             /* disable(irq) */
>>         mpc52xx_ic_disable_and_ack,     /* disable_and_ack(irq) */
>>          mpc52xx_ic_end,                 /* end(irq) */
>>  -       0                               /* set_affinity(irq, cpumask)
>> SMP. */
>>  +       NULL                            /* set_affinity(irq, cpumask)
>> SMP. */
>>   };
>
>
> It looks like others have moved to a C99 initialization style for 
> hw_interrupt_type, see syslib/ipic.c for an example.
>

Indeed. Here's a third patch ;)
It has been added to the bk tree as well.



# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2005/03/11 21:37:08+01:00 tnt@246tNt.com
#   ppc32: Change to a C99 initialization style for hw_interrupt_type
#          in MPC52xx interrupt controller
#
# arch/ppc/syslib/mpc52xx_pic.c
#   2005/03/11 21:36:54+01:00 tnt@246tNt.com +5 -8
#   ppc32: Change to a C99 initialization style for hw_interrupt_type
#          in MPC52xx interrupt controller
#
diff -Nru a/arch/ppc/syslib/mpc52xx_pic.c b/arch/ppc/syslib/mpc52xx_pic.c
--- a/arch/ppc/syslib/mpc52xx_pic.c     2005-03-11 21:45:50 +01:00
+++ b/arch/ppc/syslib/mpc52xx_pic.c     2005-03-11 21:45:50 +01:00
@@ -166,14 +166,11 @@
 }
 
 static struct hw_interrupt_type mpc52xx_ic = {
-       "MPC52xx",
-       NULL,                           /* startup(irq) */
-       NULL,                           /* shutdown(irq) */
-       mpc52xx_ic_enable,              /* enable(irq) */
-       mpc52xx_ic_disable,             /* disable(irq) */
-       mpc52xx_ic_disable_and_ack,     /* disable_and_ack(irq) */
-       mpc52xx_ic_end,                 /* end(irq) */
-       NULL                            /* set_affinity(irq, cpumask) 
SMP. */
+       .typename       = "MPC52xx",
+       .enable         = mpc52xx_ic_enable,
+       .disable        = mpc52xx_ic_disable,
+       .ack            = mpc52xx_ic_disable_and_ack,
+       .end            = mpc52xx_ic_end,
 };
 
 void __init
