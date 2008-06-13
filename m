Return-Path: <ossrosch@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2C9B3DDFC4
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Jun 2008 00:39:51 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m5DEdlw4024240
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jun 2008 10:39:47 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m5DEdlad204028
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jun 2008 10:39:47 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m5DEdk7R002554
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jun 2008 10:39:47 -0400
From: Stefan Roscher <ossrosch@linux.vnet.ibm.com>
To: Roland Dreier <rdreier@cisco.com>
Subject: Re: [PATCH REPOST] IB/ehca: In case of lost interrupts,
	trigger EOI to reenable interrupts
Date: Fri, 13 Jun 2008 16:39:40 +0200
References: <200806101644.34693.ossrosch@linux.vnet.ibm.com>
	<200806101701.47090.ossrosch@linux.vnet.ibm.com>
	<adaabht5klx.fsf@cisco.com>
In-Reply-To: <adaabht5klx.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200806131639.43173.ossrosch@linux.vnet.ibm.com>
Cc: TKLEIN@de.ibm.com, THEMANN@de.ibm.com, fenkes@de.ibm.com,
	LKML <linux-kernel@vger.kernel.org>, OF-EWG <ewg@lists.openfabrics.org>,
	LinuxPPC-Dev <linuxppc-dev@ozlabs.org>, raisch@de.ibm.com,
	Paul Mackerras <paulus@samba.org>, general@lists.openfabrics.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Roland,

On Tuesday 10 June 2008 18:18:50 Roland Dreier wrote:
>  > > So just to be clear: this is a workaround for a hardware/firmware bug?
> 
>  > Yes it is.
> 
> OK, so paulus et al... does it seem like a good approach to call H_EOI
> from driver code (given that this driver makes tons of other hcalls)?
> 
> How critical is this?  Since you said "corner case testing" I suspect we
> can defer this to 2.6.27 and maybe get it into -stable later?

No, it's ok with me if you pick this for 2.6.27.
> 
> Also, out of curiousity:
> 
>  > +u64 hipz_h_eoi(int irq)
>  > +{
>  > +	int value;
>  > +	unsigned long xirr;
>  > +
>  > +	iosync();
> 
> what is the iosync() required for here?

It's the same sequence as the interrupt handler for powerpc is implemented.

> 
>  > +	value = (0xff << 24) | irq;
>  > +	xirr = value & 0xffffffff;
> 
> given that irq and value are ints, is there any possible way value could
> have bits outside of the low 32 set?  If you're worried about sign
> extension isn't it simpler to just make value unsigned?
> 
>  > +	return plpar_hcall_norets(H_EOI, xirr);
>  > +}
> 
> ie why not:
> 
> u64 hipz_h_eoi(int irq)
> {
> 	unsigned xirr;
> 
> 	iosync();
> 	xirr = (0xff << 24) | irq;
> 	return plpar_hcall_norets(H_EOI, xirr);
> }
> 
Yeah, you are rigth I will change that with the final patch.
I will send the final patch soon.

regards Stefan
