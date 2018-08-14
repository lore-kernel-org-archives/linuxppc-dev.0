Return-Path: <zhongjiang@huawei.com>
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41qTN90fjTzF0bZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Aug 2018 20:28:55 +1000 (AEST)
Message-ID: <5B72AEDB.70505@huawei.com>
Date: Tue, 14 Aug 2018 18:28:43 +0800
From: zhong jiang <zhongjiang@huawei.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
CC: <tony.luck@intel.com>, <fenghua.yu@intel.com>, <benh@kernel.crashing.org>,
 <paulus@samba.org>, <oleg@redhat.com>, <rppt@linux.vnet.ibm.com>,
 <dhowells@redhat.com>, <akpm@linux-foundation.org>,
 <viro@zeniv.linux.org.uk>, <linux-ia64@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 2/2] powerpc: Use ARRAY_SIZE to replace its implementation
References: <1534214814-9043-1-git-send-email-zhongjiang@huawei.com>
 <1534214814-9043-3-git-send-email-zhongjiang@huawei.com>
 <874lfxjnzl.fsf@concordia.ellerman.id.au>
In-Reply-To: <874lfxjnzl.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="ISO-8859-1"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2018/8/14 17:28, Michael Ellerman wrote:
> zhong jiang <zhongjiang@huawei.com> writes:
>> Use ARRAY_SIZE instead of dividing sizeof array with sizeof an element.
>> So just replace it.
>>
>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
>> ---
>>  arch/powerpc/xmon/ppc-opc.c | 12 ++++--------
>>  1 file changed, 4 insertions(+), 8 deletions(-)
> This code is copied from binutils and we don't want to needlessly cause
> it to diverge from the binutils copy.
>
> So thanks but no thanks.
Thank you for clarification.

Sincerely
zhong jiang
> cheers
>
>> diff --git a/arch/powerpc/xmon/ppc-opc.c b/arch/powerpc/xmon/ppc-opc.c
>> index ac2b55b..f3f57a1 100644
>> --- a/arch/powerpc/xmon/ppc-opc.c
>> +++ b/arch/powerpc/xmon/ppc-opc.c
>> @@ -966,8 +966,7 @@
>>    { 0xff, 11, NULL, NULL, PPC_OPERAND_SIGNOPT },
>>  };
>>  
>> -const unsigned int num_powerpc_operands = (sizeof (powerpc_operands)
>> -					   / sizeof (powerpc_operands[0]));
>> +const unsigned int num_powerpc_operands = ARRAY_SIZE(powerpc_operands);
>>  
>>  /* The functions used to insert and extract complicated operands.  */
>>  
>> @@ -6980,8 +6979,7 @@
>>  {"fcfidu.",	XRC(63,974,1),	XRA_MASK, POWER7|PPCA2,	PPCVLE,		{FRT, FRB}},
>>  };
>>  
>> -const int powerpc_num_opcodes =
>> -  sizeof (powerpc_opcodes) / sizeof (powerpc_opcodes[0]);
>> +const int powerpc_num_opcodes = ARRAY_SIZE(powerpc_opcodes);
>>  
>>  /* The VLE opcode table.
>>  
>> @@ -7219,8 +7217,7 @@
>>  {"se_bl",	BD8(58,0,1),	BD8_MASK,	PPCVLE,	0,		{B8}},
>>  };
>>  
>> -const int vle_num_opcodes =
>> -  sizeof (vle_opcodes) / sizeof (vle_opcodes[0]);
>> +const int vle_num_opcodes = ARRAY_SIZE(vle_opcodes);
>>  
>>  /* The macro table.  This is only used by the assembler.  */
>>  
>> @@ -7288,5 +7285,4 @@
>>  {"e_clrlslwi",4, PPCVLE, "e_rlwinm %0,%1,%3,(%2)-(%3),31-(%3)"},
>>  };
>>  
>> -const int powerpc_num_macros =
>> -  sizeof (powerpc_macros) / sizeof (powerpc_macros[0]);
>> +const int powerpc_num_macros = ARRAY_SIZE(powerpc_macros);
>> -- 
>> 1.7.12.4
> .
>
