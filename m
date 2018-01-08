Return-Path: <bharata@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zFV5w5nsjzF0Qr
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Jan 2018 20:17:08 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.21) with SMTP id
 w089Eb5v117072
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Jan 2018 04:17:06 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2fc4ns38rk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Jan 2018 04:17:06 -0500
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bharata@linux.vnet.ibm.com>;
 Mon, 8 Jan 2018 09:17:03 -0000
Date: Mon, 8 Jan 2018 14:46:52 +0530
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, nfont@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, david@gibson.dropbear.id.au,
 anton@samba.org
Subject: Re: [RFC FIX v1 1/2] powerpc: Discover radix availability before
 scanning the memory nodes
Reply-To: bharata@linux.vnet.ibm.com
References: <1515150321-24894-1-git-send-email-bharata@linux.vnet.ibm.com>
 <1515150321-24894-2-git-send-email-bharata@linux.vnet.ibm.com>
 <87shbj3myn.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87shbj3myn.fsf@concordia.ellerman.id.au>
Message-Id: <20180108091652.GA1245@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Jan 06, 2018 at 10:28:00AM +1100, Michael Ellerman wrote:
> Bharata B Rao <bharata@linux.vnet.ibm.com> writes:
> 
> > Currently device tree nodes for memory are scanned before the
> > radix feature is discovered in mmu_early_init_devtree(). Move this
> > routine ahead of scanning memory nodes so that we know if the
> > guest is radix or not when scanning ibm,dynamic-reconfiguration-memory.
> 
> Sorry this doesn't work.
> 
> > diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> > index b15bae2..079d893 100644
> > --- a/arch/powerpc/kernel/prom.c
> > +++ b/arch/powerpc/kernel/prom.c
> > @@ -722,6 +722,8 @@ void __init early_init_devtree(void *params)
> >  	 */
> >  	of_scan_flat_dt(early_init_dt_scan_chosen_ppc, boot_command_line);
> >  
> > +	mmu_early_init_devtree();
> > +
> 
> You've moved this above parse_early_param(), but
> mmu_early_init_devtree() uses disable_radix, which is an early param. So
> this will break disable_radix handling.
> 
> It will probably break other things too because the ordering of this
> init code is very fragile - bootstrapping is hard :)

So from your and Aneesh's reply I realize that my current approach
involving upfront mapping of hotplugged memory with smaller mappings
without afffecting PowerVM will not be feasible. Guess breaking the
mapping appropriately during unplug would be the only real solution then.

Regards,
Bharata.
