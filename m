Return-Path: <anju@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vNSBx6zBhzDq8X
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 16:14:33 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1F5Drej074211
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 00:14:32 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28m9wxmm7r-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 00:14:31 -0500
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Tue, 14 Feb 2017 22:14:31 -0700
Subject: Re: [v4,1/2] arch/powerpc: Implement Optprobes
To: Michael Ellerman <patch-notifications@ellerman.id.au>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <3vN27w1vFGz9s74@ozlabs.org>
Cc: ananth@in.ibm.com, mahesh@linux.vnet.ibm.com, paulus@samba.org,
 mhiramat@kernel.org, naveen.n.rao@linux.vnet.ibm.com,
 hemant@linux.vnet.ibm.com, srikar@linux.vnet.ibm.com
From: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Date: Wed, 15 Feb 2017 10:44:18 +0530
MIME-Version: 1.0
In-Reply-To: <3vN27w1vFGz9s74@ozlabs.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <584d290d-e571-5ade-c239-563cb0440704@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thank You Michael.  :)


On Tuesday 14 February 2017 06:10 PM, Michael Ellerman wrote:
> On Wed, 2017-02-08 at 09:50:51 UTC, Anju T wrote:
>> Current infrastructure of kprobe uses the unconditional trap instruction
>> to probe a running kernel. Optprobe allows kprobe to replace the trap with
>> a branch instruction to a detour buffer. Detour buffer contains instructions
>> to create an in memory pt_regs. Detour buffer also has a call to
>> optimized_callback() which in turn call the pre_handler().
>> After the execution of the pre-handler, a call is made for instruction
>> emulation. The NIP is determined in advanced through dummy instruction
>> emulation and a branch instruction is created to the NIP at the end of
>> the trampoline.
>>
>> To address the limitation of branch instruction in POWER architecture,
>> detour buffer slot is allocated from a reserved area. For the time being,
>> 64KB is reserved in memory for this purpose.
>>
>> Instructions which can be emulated using analyse_instr() are the candidates
>> for optimization. Before optimization ensure that the address range
>> between the detour buffer allocated and the instruction being probed
>> is within +/- 32MB.
>>
>> Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
>> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
>> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> Series applied to powerpc next, thanks.
>
> https://git.kernel.org/powerpc/c/51c9c0843993528bffc920c54c2121
>
> cheers
>
