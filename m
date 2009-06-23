Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 73F68B6F44
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 24 Jun 2009 09:31:33 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B4132DDD1B
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jun 2009 09:31:32 +1000 (EST)
Subject: Re: sym scsi driver problem with 2.6.26 or newer debian kernel on
	p610 (fwd)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: blackluck@ktk.bme.hu
In-Reply-To: <1245794228.10356.31.camel@pasglop>
References: <Pine.LNX.4.64.0906141105050.4412@axis700.grange>
	<4A38B883.80507@ktk.bme.hu>  <4A3F4A77.6070704@ktk.bme.hu>
	<1245719890.4017.26.camel@pasglop> <1245724218.4017.35.camel@pasglop>
	<1245794228.10356.31.camel@pasglop>
Content-Type: text/plain
Date: Wed, 24 Jun 2009 09:29:52 +1000
Message-Id: <1245799792.10356.42.camel@pasglop>
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org,
	debian-powerpc@lists.debian.org,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-06-24 at 07:57 +1000, Benjamin Herrenschmidt wrote:
> > I tried on a POWER3 box I have here "IBM,7044-170" and things work fine
> > here with current upstream. (I suspect a much smaller machine).
> > 
> > I will really need an actual bisection here... In the meantime, I'll see
> > if I can get my hand on one of these machines here.
> 
> Ok so I think we may have found it... looks like
> CONFIG_MPIC_BROKEN_REGREAD is what breaks it which is enabled by PA-Semi
> support in the .config.
> 
> Can you verify that disabling PA-Semi support removes that option from
> your .config and that once removed, it works again ?
> 
> We don't know yet -why- it breaks it, still investigating.

Do the following patch also fix it ?

Index: linux-work/arch/powerpc/sysdev/mpic.c
===================================================================
--- linux-work.orig/arch/powerpc/sysdev/mpic.c	2009-06-24 09:24:51.000000000 +1000
+++ linux-work/arch/powerpc/sysdev/mpic.c	2009-06-24 09:26:45.000000000 +1000
@@ -230,14 +230,16 @@ static inline u32 _mpic_irq_read(struct 
 {
 	unsigned int	isu = src_no >> mpic->isu_shift;
 	unsigned int	idx = src_no & mpic->isu_mask;
+	unsigned int	val;
 
+	val = _mpic_read(mpic->reg_type, &mpic->isus[isu],
+			 reg + (idx * MPIC_INFO(IRQ_STRIDE)));	
 #ifdef CONFIG_MPIC_BROKEN_REGREAD
 	if (reg == 0)
-		return mpic->isu_reg0_shadow[idx];
-	else
+		val = (val & (MPIC_VECPRI_MASK | MPIC_VECPRI_ACTIVITY)) |
+			mpic->isu_reg0_shadow[idx];
 #endif
-		return _mpic_read(mpic->reg_type, &mpic->isus[isu],
-				  reg + (idx * MPIC_INFO(IRQ_STRIDE)));
+	return val;
 }
 
 static inline void _mpic_irq_write(struct mpic *mpic, unsigned int src_no,
@@ -251,7 +253,8 @@ static inline void _mpic_irq_write(struc
 
 #ifdef CONFIG_MPIC_BROKEN_REGREAD
 	if (reg == 0)
-		mpic->isu_reg0_shadow[idx] = value;
+		mpic->isu_reg0_shadow[idx] =
+			value & ~(MPIC_VECPRI_MASK | MPIC_VECPRI_ACTIVITY);
 #endif
 }
 
