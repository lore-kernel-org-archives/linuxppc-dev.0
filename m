Return-Path: <sandipan@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4251ms51M0zF371
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Sep 2018 21:33:49 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w85BUgIY111042
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Sep 2018 07:33:47 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2macv6muha-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Sep 2018 07:33:46 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sandipan@linux.ibm.com>;
 Wed, 5 Sep 2018 12:30:55 +0100
Subject: Re: [PATCH 1/6] powerpc sstep: Add maddhd, maddhdu, maddld
 instruction emulation
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: mpe@ellerman.id.au, paulus@samba.org, naveen.n.rao@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, anton@samba.org, ravi.bangoria@linux.ibm.com
References: <cover.1535609090.git.sandipan@linux.ibm.com>
 <2962112510464de01b24f9e1014909fde3380d52.1535609090.git.sandipan@linux.ibm.com>
 <20180904221223.GR24439@gate.crashing.org>
From: Sandipan Das <sandipan@linux.ibm.com>
Date: Wed, 5 Sep 2018 17:00:49 +0530
MIME-Version: 1.0
In-Reply-To: <20180904221223.GR24439@gate.crashing.org>
Content-Type: text/plain; charset=utf-8
Message-Id: <99722a4e-fea8-7c74-2cb4-7d5efd2c54fa@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Segher,

On Wednesday 05 September 2018 03:42 AM, Segher Boessenkool wrote:
> On Mon, Sep 03, 2018 at 08:49:33PM +0530, Sandipan Das wrote:
>> +#ifdef __powerpc64__
>> +	case 4:
>> +		if (!cpu_has_feature(CPU_FTR_ARCH_300))
>> +			return -1;
>> +
>> +		switch (instr & 0x3f) {
>> +		case 48:	/* maddhd */
>> +			asm("maddhd %0,%1,%2,%3" : "=r" (op->val) :
>> +			    "r" (regs->gpr[ra]), "r" (regs->gpr[rb]),
>> +			    "r" (regs->gpr[rc]));
>> +			goto compute_done;
> 
> If running maddhd does not work, will running it in kernel mode work?
> 

Not sure what you meant here but one of the scenarios that I'm aware of
where this is will be used is if we place a probe at a location having
an maddhd instruction. The kernel would first attempt to emulate its
behaviour, which in this case is done by executing the same instruction
(similar to what is done for mulhd and mulhw) and if that fails, try to
execute the instruction natively.

- Sandipan
