Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xYn4W4ZX3zDrFw
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Aug 2017 01:26:51 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7IFOGwc037443
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Aug 2017 11:26:49 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ce0x08n0d-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Aug 2017 11:26:49 -0400
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Fri, 18 Aug 2017 11:26:48 -0400
References: <1501459946-11619-1-git-send-email-linuxram@us.ibm.com>
 <1501459946-11619-26-git-send-email-linuxram@us.ibm.com>
 <871sojkta1.fsf@linux.vnet.ibm.com>
 <20170817174014.GG5505@ram.oc3035372033.ibm.com>
 <87efsaym1o.fsf@linux.vnet.ibm.com>
 <20170817234839.GD5427@ram.oc3035372033.ibm.com>
 <8760dlqxa3.fsf@concordia.ellerman.id.au>
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ram Pai <linuxram@us.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, paulus@samba.org,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org
Subject: Re: [RFC v7 25/25] powerpc: Enable pkey subsystem
In-reply-to: <8760dlqxa3.fsf@concordia.ellerman.id.au>
Date: Fri, 18 Aug 2017 12:26:33 -0300
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87inhkoq1i.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Michael Ellerman <mpe@ellerman.id.au> writes:

> Ram Pai <linuxram@us.ibm.com> writes:
>> On Thu, Aug 17, 2017 at 05:30:27PM -0300, Thiago Jung Bauermann wrote:
>>> Ram Pai <linuxram@us.ibm.com> writes:
>>> > On Thu, Aug 10, 2017 at 06:27:34PM -0300, Thiago Jung Bauermann wrote:
>>> >> Ram Pai <linuxram@us.ibm.com> writes:
>>> >> > @@ -227,6 +229,24 @@ static inline void pkey_mm_init(struct mm_struct *mm)
>>> >> >  	mm->context.execute_only_pkey = -1;
>>> >> >  }
>>> >> >
>>> >> > +static inline void pkey_mmu_values(int total_data, int total_execute)
>>> >> > +{
>>> >> > +	/*
>>> >> > +	 * since any pkey can be used for data or execute, we
>>> >> > +	 * will  just  treat all keys as equal and track them
>>> >> > +	 * as one entity.
>>> >> > +	 */
>>> >> > +	pkeys_total = total_data + total_execute;
>>> >> > +}
>>> >> 
>>> >> Right now this works because the firmware reports 0 execute keys in the
>>> >> device tree, but if (when?) it is fixed to report 32 execute keys as
>>> >> well as 32 data keys (which are the same keys), any place using
>>> >> pkeys_total expecting it to mean the number of keys that are available
>>> >> will be broken. This includes pkey_initialize and mm_pkey_is_allocated.
>>> >
>>> > Good point. we should just ignore total_execute. It should
>>> > be the same value as total_data on the latest platforms.
>>> > On older platforms it will continue to be zero.
>>> 
>>> Indeed. There should just be a special case to disable execute
>>> protection for P7.
>>
>> Ok. we should disable execute protection for P7 and earlier generations of CPU.
>
> You should do what the device tree says you can do.
>
> If it says there are no execute keys then you shouldn't touch the IAMR.

The downside of that approach is that the device tree in P8 LPARs
currently says there are no execute keys even though there are. We'd
have to require customers to upgrade their firmware to a fixed version
if they want to use execute keys.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
