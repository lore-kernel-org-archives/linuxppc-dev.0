Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp07.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EA493B6ED0
 for <linuxppc-dev@ozlabs.org>; Thu,  1 Mar 2012 12:14:57 +1100 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Thu, 1 Mar 2012 01:09:31 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q211EgNu1360040
 for <linuxppc-dev@ozlabs.org>; Thu, 1 Mar 2012 12:14:42 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q211EgSe021965
 for <linuxppc-dev@ozlabs.org>; Thu, 1 Mar 2012 12:14:42 +1100
Date: Thu, 1 Mar 2012 09:14:40 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 20/21] Introduce struct eeh_stats for EEH
Message-ID: <20120301011440.GA2805@shangw>
References: <1330409051-8941-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1330409051-8941-21-git-send-email-shangw@linux.vnet.ibm.com>
 <1330520204.15023.16.camel@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1330520204.15023.16.camel@concordia>
Cc: linuxppc-dev@ozlabs.org
Reply-To: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > With the original EEH implementation, the EEH global statistics
> > are maintained by individual global variables. That makes the
> > code a little hard to maintain.
> 
> Hi Gavin,
> 
> > @@ -1174,21 +1182,24 @@ static int proc_eeh_show(struct seq_file *m, void *v)
> >  {
> >  	if (0 == eeh_subsystem_enabled) {
> >  		seq_printf(m, "EEH Subsystem is globally disabled\n");
> > -		seq_printf(m, "eeh_total_mmio_ffs=%ld\n", total_mmio_ffs);
> > +		seq_printf(m, "eeh_total_mmio_ffs=%d\n", eeh_stats.total_mmio_ffs);
> >  	} else {
> >  		seq_printf(m, "EEH Subsystem is enabled\n");
> >  		seq_printf(m,
> > -				"no device=%ld\n"
> > -				"no device node=%ld\n"
> > -				"no config address=%ld\n"
> > -				"check not wanted=%ld\n"
> > -				"eeh_total_mmio_ffs=%ld\n"
> > -				"eeh_false_positives=%ld\n"
> > -				"eeh_slot_resets=%ld\n",
> > -				no_device, no_dn, no_cfg_addr, 
> > -				ignored_check, total_mmio_ffs, 
> > -				false_positives,
> > -				slot_resets);
> > +				"no device           =%d\n"
> > +				"no device node      =%d\n"
> > +				"no config address   =%d\n"
> > +				"check not wanted    =%d\n"
> > +				"eeh_total_mmio_ffs  =%d\n"
> > +				"eeh_false_positives =%d\n"
> > +				"eeh_slot_resets     =%d\n",
> 
> There *might* be tools out there that parse this output, so I'd say
> don't change it unless you have to - and I don't think you have to?
> 

Thanks for catching the point, Michael. I will change it back soon ;-)

Thanks,
Gavin
