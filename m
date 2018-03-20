Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4054hr2ddmzF0n1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Mar 2018 18:44:59 +1100 (AEDT)
Subject: Re: [PATCH 2/2] powerpc/mm: Trace tlbia instruction
To: Balbir Singh <bsingharora@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
References: <4ffd3d6143f991615ffe07f43952cbc62163d319.1521452718.git.christophe.leroy@c-s.fr>
 <cccc5b8516ce8cb57bedf2c51cf67f9a2ca95242.1521452718.git.christophe.leroy@c-s.fr>
 <20180320094320.03ae264d@balbir.ozlabs.ibm.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <2aac79d5-6cf8-cd65-79b9-68839c537474@c-s.fr>
Date: Tue, 20 Mar 2018 08:44:54 +0100
MIME-Version: 1.0
In-Reply-To: <20180320094320.03ae264d@balbir.ozlabs.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 19/03/2018 à 23:43, Balbir Singh a écrit :
> On Mon, 19 Mar 2018 11:32:40 +0100 (CET)
> Christophe Leroy <christophe.leroy@c-s.fr> wrote:
> 
>> Add a trace point for tlbia (Translation Lookaside Buffer Invalidate
>> All) instruction.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>>   arch/powerpc/include/asm/trace.h | 15 +++++++++++++++
>>   arch/powerpc/mm/mmu_decl.h       |  2 ++
>>   2 files changed, 17 insertions(+)
>>
>> diff --git a/arch/powerpc/include/asm/trace.h b/arch/powerpc/include/asm/trace.h
>> index 33f3b479138b..d1d63b173dd7 100644
>> --- a/arch/powerpc/include/asm/trace.h
>> +++ b/arch/powerpc/include/asm/trace.h
>> @@ -202,6 +202,21 @@ TRACE_EVENT(tlbie,
>>   		__entry->r)
>>   );
>>   
>> +TRACE_EVENT(tlbia,
>> +
>> +	TP_PROTO(unsigned long lpid),
>> +	TP_ARGS(lpid),
>> +	TP_STRUCT__entry(
>> +		__field(unsigned long, lpid)
>> +		),
>> +
>> +	TP_fast_assign(
>> +		__entry->lpid = lpid;
>> +		),
>> +
>> +	TP_printk("lpid=%ld", __entry->lpid)
>> +);
> 
> 
> Do we want to call this lpid?
> 

Should we can it rs in consistence with tlbie trace ? Or just pid ?
Allthough it is not an argument used by tlbia, I think it is good to 
keep a trace of it to keep track of the reason why tlbia is called.

Christophe
