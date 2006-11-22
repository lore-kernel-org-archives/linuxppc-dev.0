Return-Path: <bergner@vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6800567C3F
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Nov 2006 03:06:13 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id kAMG697N019411
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Nov 2006 11:06:09 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kAMG69CL477756
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Nov 2006 09:06:09 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kAMG68gn007858
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Nov 2006 09:06:09 -0700
Subject: Re: [PATCH] CAS DFP support
From: Peter Bergner <bergner@vnet.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <AA60A1D7-D271-4CE1-A39F-2CE9F605DB16@kernel.crashing.org>
References: <1164208814.1954.372.camel@goblue>
	<AA60A1D7-D271-4CE1-A39F-2CE9F605DB16@kernel.crashing.org>
Content-Type: text/plain
Date: Wed, 22 Nov 2006 10:06:04 -0600
Message-Id: <1164211565.4932.7.camel@otta>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-11-22 at 09:46 -0600, Kumar Gala wrote:
> On Nov 22, 2006, at 9:20 AM, Jake Moilanen wrote:
> 
> > When booting a Power6 in compat mode, the DFP bit must be set in the
> > client architecture call, or else firmware will downgrade the
> > compliance
> > to P5 compat mode, thus removing VMX and DFP instructions.
> >
> > Signed-off-by: Jake Moilanen <moilanen@austin.ibm.com>
> >
> > --- 2.6/arch/powerpc/kernel/prom_init.c~	2006-11-13 15:01:13.000000000
> > -0600
> > +++ 2.6/arch/powerpc/kernel/prom_init.c	2006-11-21 18:38:27.000000000
> > -0600
> > @@ -627,6 +627,7 @@ static void __init early_cmdline_parse(v
> >  /* Option vector 3: processor options supported */
> >  #define OV3_FP			0x80	/* floating point */
> >  #define OV3_VMX			0x40	/* VMX/Altivec */
> > +#define OV3_DFP			0x20	/* decimal floating point */
> 
> Can we make the flag OV3_DECFP to distinguish it from Double FP.

One thing OV3_DFP has going for it is that is matches the nomenclature
used by GCC, binutils.  I'm not sure what you mean by Double FP, unless
you're referring to the double wide FP unit on the Blue Gene/L 440
processor, but they don't refer to it as Double FP.

Peter
