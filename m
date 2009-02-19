Return-Path: <shaggy@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e7.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 57327DDDA5
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Feb 2009 02:07:53 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e7.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n1JExj8S004411
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Feb 2009 09:59:45 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	n1JF7nIn103342
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Feb 2009 10:07:49 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n1JF7mVC018177
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Feb 2009 10:07:49 -0500
Subject: Re: [PATCH] powerpc: New cpu type shows up as "unknown" even when
	logical PVR is recognized
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: michael@ellerman.id.au
In-Reply-To: <1234620007.10265.7.camel@localhost>
References: <1234557928.10378.8.camel@norville.austin.ibm.com>
	<1234620007.10265.7.camel@localhost>
Content-Type: text/plain
Date: Thu, 19 Feb 2009 09:07:46 -0600
Message-Id: <1235056066.20983.1.camel@norville.austin.ibm.com>
Mime-Version: 1.0
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2009-02-15 at 01:00 +1100, Michael Ellerman wrote:
> On Fri, 2009-02-13 at 14:45 -0600, Dave Kleikamp wrote:
> > When identify_cpu() is called a second time with a logical PVR, it only
> > copies a subset of the cpu_spec structure to avoid overwriting the
> > performance monitor fields that were initialized based on the real PVR.
> > 
> > If the real PVR is not recognized, the structure is initialized with
> > default data in which the pvr_mask field is zero.  Overriding the default
> > definition with the one based on the logical PVR does not update the
> > pvr_mask field.  Since the pvr_mask field remains zero, show_cpuinfo()
> > reports the cpu as "unknown".
> > 
> > identify_cpu() should update the pvr_mask, so that show_cpuinfo() reports
> > the logical cpu name, as it would if the kernel recognized the real PVR.
> > 
> > For completeness, this patch also updates pvr_value, although its only
> > use appears to be in booke_wdt_init() setting ident.firmware_version.  I'm
> > not sure which value (the real or logical) is the most useful here, if it
> > matters at all.
> > 
> > Signed-off-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
> > 
> > diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
> > index 923f87a..a216fad 100644
> > --- a/arch/powerpc/kernel/cputable.c
> > +++ b/arch/powerpc/kernel/cputable.c
> > @@ -1780,6 +1780,8 @@ struct cpu_spec * __init identify_cpu(unsigned long offset, unsigned int pvr)
> >  			 * performance monitor fields.
> >  			 */
> >  			if (t->num_pmcs && !s->num_pmcs) {
> > +				t->pvr_mask = s->pvr_mask;
> > +				t->pvr_value = s->pvr_value;
> >  				t->cpu_name = s->cpu_name;
> >  				t->cpu_features = s->cpu_features;
> >  				t->cpu_user_features = s->cpu_user_features;
> 
> Seems like we'd be better off copying the whole structure, and then
> putting back the performance monitor fields. So we don't end up with
> another bug if something's added to struct cpu_spec.

I feel that may be a bit of overkill, but I don't feel strongly either
way.  I'd like the patch to be picked up in one fashion or another.

Thanks,
Shaggy
-- 
David Kleikamp
IBM Linux Technology Center
