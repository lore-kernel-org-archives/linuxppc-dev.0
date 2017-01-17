Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v2g0L59cVzDqRj
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jan 2017 17:18:42 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v0H6Dnta037223
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jan 2017 01:18:39 -0500
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2815520th7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jan 2017 01:18:39 -0500
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Tue, 17 Jan 2017 16:18:36 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 077692CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jan 2017 17:18:34 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v0H6IXEU13172970
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jan 2017 17:18:33 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v0H6IXEH005440
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jan 2017 17:18:33 +1100
Subject: Re: [PATCH] powerpc/perf: use MSR to report privilege level on P9 DD1
To: Michael Ellerman <mpe@ellerman.id.au>
References: <1483434793-1814-1-git-send-email-maddy@linux.vnet.ibm.com>
 <87fukib5mg.fsf@concordia.ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Tue, 17 Jan 2017 11:48:26 +0530
MIME-Version: 1.0
In-Reply-To: <87fukib5mg.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <556f4715-254c-7e3d-333c-518b1f7e96de@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Tuesday 17 January 2017 11:16 AM, Michael Ellerman wrote:
> Madhavan Srinivasan <maddy@linux.vnet.ibm.com> writes:
>
>> "use_siar" variable is primarily used for deciding the sampled address
>> and the privilege level to be reported for a sample. perf_read_regs()
>> function updates the "use_siar" and "regs->result" based on the pmu
>> flags along with other checks. To force the use of MSR to report the
>> privilege level and to use "regs->nip" to report the instruction pointer,
>> set "PPMU_NO_CONT_SAMPLING" flag and remove "PPMU_HAS_SIER" from the
>> ppmu->flags.
> This still won't work for marked events AFAICS:

nice catch. My bad. Did not try with the marked events when testing this
patch.

>
> 	if (TRAP(regs) != 0xf00)
> 		use_siar = 0;
> 	else if (marked)
> 		use_siar = 1;
> 	else if ((ppmu->flags & PPMU_NO_CONT_SAMPLING))
> 		use_siar = 0;
> 	else if (!(ppmu->flags & PPMU_NO_SIPR) && regs_sipr(regs))
> 		use_siar = 0;
> 	else
> 		use_siar = 1;
>
> So perhaps we just want a USE_SIAR flag?
OK, Will add a new flag. How about "PPMU_DISBALE_USE_SIAR"?

> And I don't see how HAS_SIER is related? Or is SIER broken too?

We dont see proper values in SIER for some samples and we use
SIER (regs_sipr) to update the misc_flag.

Will fix the commit message.

Maddy

> cheers
>
