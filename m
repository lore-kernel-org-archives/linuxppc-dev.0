Return-Path: <rcjenn@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e38.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A61DDB6FA0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 May 2012 00:55:33 +1000 (EST)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <rcjenn@linux.vnet.ibm.com>;
 Thu, 10 May 2012 08:55:29 -0600
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
 [9.17.195.227])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 90C5019D804E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 May 2012 08:55:14 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q4AEtKNK103584
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 May 2012 08:55:22 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q4AEtGg3001488
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 May 2012 08:55:17 -0600
Date: Wed, 9 May 2012 10:56:39 -0500
From: Robert Jennings <rcj@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Support lower minimum entitlement for virtual
 processors
Message-ID: <20120509155639.GA12000@linux.vnet.ibm.com>
References: <20120323212213.GB9456@linux.vnet.ibm.com>
 <1335763810.20866.38.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1335763810.20866.38.camel@pasglop>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Benjamin Herrenschmidt (benh@kernel.crashing.org) wrote:
> On Fri, 2012-03-23 at 16:22 -0500, Robert Jennings wrote:
> > This patch changes the architecture vector to advertise support for a
> > lower minimum virtual processor entitled capacity.  The default
> > minimum without this patch is 10%, this patch specifies 5%.  This will
> > allow 20 LPARs per CPU rather than only 10.
> 
> Any reason why we don't just put 1% in there and thus don't have to
> change again when pHyp decides to lower their minimum ? :-)
> 
> (Can you test that it works, ie, that pHyp doesn't barf if we put 1% and
> properly uses 5% in that case ?)

Thanks Ben, makes good sense.
I'm in the process of validating this and I'll post reply or a new
version of the patch when I get it completed.

--Rob Jennings

> > Signed-off-by: Robert Jennings <rcj@linux.vnet.ibm.com>
> > ---
> >  arch/powerpc/kernel/prom_init.c |    8 ++++++--
> >  1 files changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
> > index eca626e..3d882ea 100644
> > --- a/arch/powerpc/kernel/prom_init.c
> > +++ b/arch/powerpc/kernel/prom_init.c
> > @@ -689,6 +689,9 @@ static void __init early_cmdline_parse(void)
> >  #define OV3_VMX			0x40	/* VMX/Altivec */
> >  #define OV3_DFP			0x20	/* decimal FP */
> >  
> > +/* Option vector 4: IBM PAPR implementation */
> > +#define OV4_MIN_ENT_CAP		0x05	/* minimum VP entitled capacity */
> > +
> >  /* Option vector 5: PAPR/OF options supported */
> >  #define OV5_LPAR		0x80	/* logical partitioning supported */
> >  #define OV5_SPLPAR		0x40	/* shared-processor LPAR supported */
> > @@ -753,8 +756,9 @@ static unsigned char ibm_architecture_vec[] = {
> >  	OV3_FP | OV3_VMX | OV3_DFP,
> >  
> >  	/* option vector 4: IBM PAPR implementation */
> > -	2 - 2,				/* length */
> > +	3 - 2,				/* length */
> >  	0,				/* don't halt */
> > +	OV4_MIN_ENT_CAP,		/* minimum VP entitled capacity */
> >  
> >  	/* option vector 5: PAPR/OF options */
> >  	13 - 2,				/* length */
> > @@ -771,7 +775,7 @@ static unsigned char ibm_architecture_vec[] = {
> >  	 * must match by the macro below. Update the definition if
> >  	 * the structure layout changes.
> >  	 */
> > -#define IBM_ARCH_VEC_NRCORES_OFFSET	100
> > +#define IBM_ARCH_VEC_NRCORES_OFFSET	101
> >  	W(NR_CPUS),			/* number of cores supported */
> >  
> >  	/* option vector 6: IBM PAPR hints */
> 
> 
