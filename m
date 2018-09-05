Return-Path: <sandipan@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4252CC0NkMzF35w
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Sep 2018 21:53:10 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w85BnZPD039673
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Sep 2018 07:53:08 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2mae68se2m-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Sep 2018 07:53:08 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sandipan@linux.ibm.com>;
 Wed, 5 Sep 2018 12:53:06 +0100
Subject: Re: [PATCH 6/6] powerpc sstep: Add modsd, modud instruction emulation
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: mpe@ellerman.id.au, paulus@samba.org, naveen.n.rao@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, anton@samba.org, ravi.bangoria@linux.ibm.com
References: <cover.1535609090.git.sandipan@linux.ibm.com>
 <15e572f61bb5c74b01210b9245ce2750a31d6002.1535609090.git.sandipan@linux.ibm.com>
 <20180904212109.GP24439@gate.crashing.org>
From: Sandipan Das <sandipan@linux.ibm.com>
Date: Wed, 5 Sep 2018 17:23:01 +0530
MIME-Version: 1.0
In-Reply-To: <20180904212109.GP24439@gate.crashing.org>
Content-Type: text/plain; charset=utf-8
Message-Id: <7b8de807-7eaa-ce4f-8560-1b850e8325a0@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Segher,

On Wednesday 05 September 2018 02:51 AM, Segher Boessenkool wrote:
> On Mon, Sep 03, 2018 at 08:49:38PM +0530, Sandipan Das wrote:
>> +#ifdef __powerpc64__
>> +		case 265:	/* modud */
>> +			if (!cpu_has_feature(CPU_FTR_ARCH_300))
>> +				return -1;
>> +			op->val = regs->gpr[ra] % regs->gpr[rb];
>> +			goto compute_done;
>> +#endif
> 
> The mod instruction has special cases that aren't handled by this C code,
> too (divide by 0, or signed division of the most negative number by -1).
> For the mod intruction the behaviour is undefined in those cases, but you
> probably should force some specific behaviour.  You don't want the kernel
> to execute a trap instruction, etc. :-)
> 

Agreed. In that case, the same would apply to the divw, divwu, divd and divdu
instructions as well, right? Cause I don't see these cases being handled for
them currently.

Also, if I execute a modulo or division instruction for any of these special
cases in a userspace binary, I don't see any exceptions being generated. It's
just that the result is undefined (usually same as one of the source operands,
I don't remember if it was the dividend or the divisor). So, I'm wondering if
this would be necessary.

- Sandipan
