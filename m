Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xYpWt2C0gzDqsF
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Aug 2017 02:32:10 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7IGThaw047774
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Aug 2017 12:32:08 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ce0spcuph-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Aug 2017 12:32:07 -0400
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Fri, 18 Aug 2017 12:32:06 -0400
Date: Fri, 18 Aug 2017 09:32:00 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, paulus@samba.org,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org
Subject: Re: [RFC v7 25/25] powerpc: Enable pkey subsystem
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1501459946-11619-1-git-send-email-linuxram@us.ibm.com>
 <1501459946-11619-26-git-send-email-linuxram@us.ibm.com>
 <871sojkta1.fsf@linux.vnet.ibm.com>
 <20170817174014.GG5505@ram.oc3035372033.ibm.com>
 <87efsaym1o.fsf@linux.vnet.ibm.com>
 <20170817234839.GD5427@ram.oc3035372033.ibm.com>
 <8760dlqxa3.fsf@concordia.ellerman.id.au>
 <87inhkoq1i.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87inhkoq1i.fsf@linux.vnet.ibm.com>
Message-Id: <20170818163200.GB5545@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 18, 2017 at 12:26:33PM -0300, Thiago Jung Bauermann wrote:
> 
> Michael Ellerman <mpe@ellerman.id.au> writes:
> 
> > Ram Pai <linuxram@us.ibm.com> writes:
> >> On Thu, Aug 17, 2017 at 05:30:27PM -0300, Thiago Jung Bauermann wrote:
> >>> Ram Pai <linuxram@us.ibm.com> writes:
> >>> > On Thu, Aug 10, 2017 at 06:27:34PM -0300, Thiago Jung Bauermann wrote:
> >>> >> Ram Pai <linuxram@us.ibm.com> writes:
> >>> >> > @@ -227,6 +229,24 @@ static inline void pkey_mm_init(struct mm_struct *mm)
> >>> >> >  	mm->context.execute_only_pkey = -1;
> >>> >> >  }
> >>> >> >
> >>> >> > +static inline void pkey_mmu_values(int total_data, int total_execute)
> >>> >> > +{
> >>> >> > +	/*
> >>> >> > +	 * since any pkey can be used for data or execute, we
> >>> >> > +	 * will  just  treat all keys as equal and track them
> >>> >> > +	 * as one entity.
> >>> >> > +	 */
> >>> >> > +	pkeys_total = total_data + total_execute;
> >>> >> > +}
> >>> >> 
> >>> >> Right now this works because the firmware reports 0 execute keys in the
> >>> >> device tree, but if (when?) it is fixed to report 32 execute keys as
> >>> >> well as 32 data keys (which are the same keys), any place using
> >>> >> pkeys_total expecting it to mean the number of keys that are available
> >>> >> will be broken. This includes pkey_initialize and mm_pkey_is_allocated.
> >>> >
> >>> > Good point. we should just ignore total_execute. It should
> >>> > be the same value as total_data on the latest platforms.
> >>> > On older platforms it will continue to be zero.
> >>> 
> >>> Indeed. There should just be a special case to disable execute
> >>> protection for P7.
> >>
> >> Ok. we should disable execute protection for P7 and earlier generations of CPU.
> >
> > You should do what the device tree says you can do.
> >
> > If it says there are no execute keys then you shouldn't touch the IAMR.
> 
> The downside of that approach is that the device tree in P8 LPARs
> currently says there are no execute keys even though there are. We'd
> have to require customers to upgrade their firmware to a fixed version
> if they want to use execute keys.

Correct. the device tree for this property currently does not correctly
capture the number of execute keys.

On skiboot based systems, there is not device tree property to refer to
aswell. Thiago has a patch to fix it, but existing systems without the
skiboot fix, will not expose that property.

So unfortunately we will have to rely on multiple peices of information
to enable the pkey system in the kernel.


RP

> 
> -- 
> Thiago Jung Bauermann
> IBM Linux Technology Center

-- 
Ram Pai
