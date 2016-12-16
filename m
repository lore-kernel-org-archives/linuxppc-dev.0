Return-Path: <anju@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tgG635lmhzDwBy
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Dec 2016 03:31:23 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uBGGNl6V095387
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Dec 2016 11:31:20 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27cknt0mw1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Dec 2016 11:31:20 -0500
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Fri, 16 Dec 2016 09:31:18 -0700
Subject: Re: [PATCH V2 2/4] powerpc: add helper to check if offset is within
 rel branch range
To: Masami Hiramatsu <mhiramat@kernel.org>
References: <1481732310-7779-1-git-send-email-anju@linux.vnet.ibm.com>
 <1481732310-7779-5-git-send-email-anju@linux.vnet.ibm.com>
 <20161216205221.b6368901a9eea6a8cb7a84ff@kernel.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 ananth@in.ibm.com, naveen.n.rao@linux.vnet.ibm.com, paulus@samba.org,
 srikar@linux.vnet.ibm.com, benh@kernel.crashing.org,
 mpe@ellerman.id.au, mahesh@linux.vnet.ibm.com
From: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Date: Fri, 16 Dec 2016 22:01:03 +0530
MIME-Version: 1.0
In-Reply-To: <20161216205221.b6368901a9eea6a8cb7a84ff@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <fb24e588-9dc4-4c2c-b8a4-b23c0fb856bc@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Masami,


Thank you for reviewing the patch set.


On Friday 16 December 2016 05:22 PM, Masami Hiramatsu wrote:
> On Wed, 14 Dec 2016 21:48:30 +0530
> Anju T Sudhakar <anju@linux.vnet.ibm.com> wrote:
>
>> From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
>>
> The coding is OK to me. Please add a description for this patch
> here, e.g. what is done by this patch, what kind of branch
> instruction will be covered, and why thse checks are needed etc.


Sure. I will give a description for this patch.


Thanks and Regards,

-Anju

>
> Thank you,
>
>> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
>> Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
>> ---
>>   arch/powerpc/include/asm/code-patching.h |  1 +
>>   arch/powerpc/lib/code-patching.c         | 24 +++++++++++++++++++++++-
>>   2 files changed, 24 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/include/asm/code-patching.h b/arch/powerpc/include/asm/code-patching.h
>> index 2015b07..75ee4f4 100644
>> --- a/arch/powerpc/include/asm/code-patching.h
>> +++ b/arch/powerpc/include/asm/code-patching.h
>> @@ -22,6 +22,7 @@
>>   #define BRANCH_SET_LINK	0x1
>>   #define BRANCH_ABSOLUTE	0x2
>>   
>> +bool is_offset_in_branch_range(long offset);
>>   unsigned int create_branch(const unsigned int *addr,
>>   			   unsigned long target, int flags);
>>   unsigned int create_cond_branch(const unsigned int *addr,
>> diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
>> index d5edbeb..f643451 100644
>> --- a/arch/powerpc/lib/code-patching.c
>> +++ b/arch/powerpc/lib/code-patching.c
>> @@ -32,6 +32,28 @@ int patch_branch(unsigned int *addr, unsigned long target, int flags)
>>   	return patch_instruction(addr, create_branch(addr, target, flags));
>>   }
>>   
>> +bool is_offset_in_branch_range(long offset)
>> +{
>> +	/*
>> +	 * Powerpc branch instruction is :
>> +	 *
>> +	 *  0         6                 30   31
>> +	 *  +---------+----------------+---+---+
>> +	 *  | opcode  |     LI         |AA |LK |
>> +	 *  +---------+----------------+---+---+
>> +	 *  Where AA = 0 and LK = 0
>> +	 *
>> +	 * LI is a signed 24 bits integer. The real branch offset is computed
>> +	 * by: imm32 = SignExtend(LI:'0b00', 32);
>> +	 *
>> +	 * So the maximum forward branch should be:
>> +	 *   (0x007fffff << 2) = 0x01fffffc =  0x1fffffc
>> +	 * The maximum backward branch should be:
>> +	 *   (0xff800000 << 2) = 0xfe000000 = -0x2000000
>> +	 */
>> +	return (offset >= -0x2000000 && offset <= 0x1fffffc && !(offset & 0x3));
>> +}
>> +
>>   unsigned int create_branch(const unsigned int *addr,
>>   			   unsigned long target, int flags)
>>   {
>> @@ -43,7 +65,7 @@ unsigned int create_branch(const unsigned int *addr,
>>   		offset = offset - (unsigned long)addr;
>>   
>>   	/* Check we can represent the target in the instruction format */
>> -	if (offset < -0x2000000 || offset > 0x1fffffc || offset & 0x3)
>> +	if (!is_offset_in_branch_range(offset))
>>   		return 0;
>>   
>>   	/* Mask out the flags and target, so they don't step on each other. */
>> -- 
>> 2.7.4
>>
>
