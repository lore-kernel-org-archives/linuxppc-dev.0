Return-Path: <Heinz.Wrobel@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id D88BB67AC6
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Apr 2005 16:54:58 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	j3R6wqMd004223 for <linuxppc-embedded@ozlabs.org>;
	Tue, 26 Apr 2005 23:58:52 -0700 (MST)
Received: from zwg18exm01.ea.freescale.net (zwg18exm01.ea.freescale.net
	[10.170.73.30])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id j3R6vF1p007617
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Apr 2005 01:57:16 -0500 (CDT)
Message-ID: <DF02D66C37C26B4C8018BF84F0E37FEC08440764@zwg18exm01.ea.freescale.net>
From: Wrobel Heinz-r39252 <Heinz.Wrobel@freescale.com>
To: Eugene Surovegin <ebs@ebshome.net>, linuxppc-embedded@ozlabs.org
Date: Wed, 27 Apr 2005 08:54:44 +0200
MIME-Version: 1.0
Content-Type: text/plain
Subject: RE: [RFC] [PATCH] ppc32: workaround for spurious IRQs on PQ2
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Eugene,

check slides 17, 20-22 out of my SNDF 2004 presentation H1125 found at
http://www.freescale.com/webapp/sps/site/overview.jsp?nodeId=052577pzMPYZjg286165422098

... and attend the June 2005 FTF in Orlando ...
http://www.freescale.com/ftf *grin*

Heinz
 

> -----Original Message-----
> From: linuxppc-embedded-bounces@ozlabs.org 
> [mailto:linuxppc-embedded-bounces@ozlabs.org] On Behalf Of 
> Eugene Surovegin
> Sent: Tuesday, April 26, 2005 9:22 PM
> To: linuxppc-embedded@ozlabs.org
> Subject: [RFC] [PATCH] ppc32: workaround for spurious IRQs on PQ2
> 
> Hi!
> 
> There is a problem with big amount of spurious IRQs on 8248-based 
> design I'm working on.
> 
> I observed this problem with 2.4.30 kernel, but it was reported to be
> still present on 2.6 as well.
> 
> Traces show that spurious IRQ happens right after handle_IRQ_events() 
> enables external interrupts and _before_ even calling real IRQ 
> handler.
> 
> I fixed this problem by adding sync at the end of cpm2_mask_and_ack. 
> Using out_XXX macros for accessing SIU register doesn't seem to help.
> Dan thinks there are some pipeline-related issues here, although I 
> failed to found any mentions of them in 8272 user manual.
> 
> Also, there is a possibility, that we need more explicit sync's in 
> cpm2_pic code.
> 
> Signed-off-by: Eugene Surovegin <ebs@ebshome.net>
> 
> ===== arch/ppc/syslib/cpm2_pic.c 1.11 vs edited =====
> --- 1.11/arch/ppc/syslib/cpm2_pic.c	2005-03-31 02:59:05 -08:00
> +++ edited/arch/ppc/syslib/cpm2_pic.c	2005-04-26 11:55:51 -07:00
> @@ -90,6 +90,7 @@
>  	ppc_cached_irq_mask[word] &= ~(1 << bit);
>  	simr[word] = ppc_cached_irq_mask[word];
>  	sipnr[word] = 1 << bit;
> +	mb();
>  }
>  
>  static void cpm2_end_irq(unsigned int irq_nr)
> 
> 
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
