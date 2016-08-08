Return-Path: <hbathini@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s7BqS5gLmzDqQ4
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Aug 2016 19:26:12 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3s7BqS0HN6z9sDf
 for <linuxppc-dev@ozlabs.org>; Mon,  8 Aug 2016 19:26:11 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u789OXX7029328
 for <linuxppc-dev@ozlabs.org>; Mon, 8 Aug 2016 05:26:09 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24nc1pbmvb-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 08 Aug 2016 05:26:09 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Mon, 8 Aug 2016 19:26:06 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id E400C2BB0055
 for <linuxppc-dev@ozlabs.org>; Mon,  8 Aug 2016 19:26:02 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u789Q2xK27066486
 for <linuxppc-dev@ozlabs.org>; Mon, 8 Aug 2016 19:26:02 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u789Q2q3005471
 for <linuxppc-dev@ozlabs.org>; Mon, 8 Aug 2016 19:26:02 +1000
Subject: Re: [RESEND][PATCH v2 2/2] powerpc/fadump: parse fadump reserve
 memory size based on memory range
To: Michael Ellerman <mpe@ellerman.id.au>, rusty@rustcorp.com.au,
 ebiederm@xmission.com, vgoyal@redhat.com,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
References: <147025270324.29229.8322429758761407397.stgit@hbathini.in.ibm.com>
 <147025281599.29229.9962999599360876220.stgit@hbathini.in.ibm.com>
 <87h9b0g953.fsf@concordia.ellerman.id.au>
 <ef95923f-56b6-b4f1-94a2-555f7df32629@linux.vnet.ibm.com>
 <be3ba9ef-278e-63cd-8569-2d8228f83aac@linux.vnet.ibm.com>
 <87vazbskpe.fsf@concordia.ellerman.id.au>
Cc: kexec@lists.infradead.org, lkml <linux-kernel@vger.kernel.org>,
 Ananth N Mavinakayanahalli <ananth@in.ibm.com>
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Mon, 8 Aug 2016 14:55:59 +0530
MIME-Version: 1.0
In-Reply-To: <87vazbskpe.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <94029a02-4357-ed77-5fb9-4ca3271e43ea@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Monday 08 August 2016 02:26 PM, Michael Ellerman wrote:
> Hari Bathini <hbathini@linux.vnet.ibm.com> writes:
>> On Friday 05 August 2016 12:23 AM, Hari Bathini wrote:
>>> On Thursday 04 August 2016 03:15 PM, Michael Ellerman wrote:
>>>> The code already knows how to reserve 5% based on the size of the
>>>> machine's
>>>> memory, as long as no commandline parameter is passed. So why can't we
>>>> just use that logic?
>>> That is the default value reserved but not a good enough value for
>>> every case. It is a bit difficult to come up with a robust formula
>>> that works for every case as new kernel changes could make the
>>> values obsolete. But it won't be all that difficult to find values that
>>> work for different memory ranges for a given kernel version.
>>> Passing that as range based input with "fadump_reserve_mem"
>>> parameter would work for every memory configuration on a
>>> given system, which is what this patch is trying to provide..
>> You want me to add this to the changelog on respin?

Hi Michael,

> I'm not really convinced.
>
> Distros are going to want to specify a fixed set of values for different
> memory sizes, at least that's what I've seen in the past with kdump. So
> I don't see why we can't just do that in the kernel with a formula based
> on memory size, and maybe some other information.

Agreed. Such support would be great but this patch is adding support
for a new syntax for an existing parameter which should still be good
to have?

> Maybe the formula is more complicated than 5% of RAM, but it shouldn't
> be *that* much more complicated.

Depending on what all kernel versions that need support, this can
get ugly? I could be completely wrong though..

Thanks
Hari

> cheers
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
>
