Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id C03531A03B4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Feb 2016 03:29:12 +1100 (AEDT)
Subject: Re: [PATCH v5] powerpc32: provide VIRT_CPU_ACCOUNTING
To: Scott Wood <oss@buserror.net>
References: <20160211161650.1F12C1A2400@localhost.localdomain>
 <1455657664.2463.68.camel@buserror.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <56C49FD3.8060108@c-s.fr>
Date: Wed, 17 Feb 2016 17:29:07 +0100
MIME-Version: 1.0
In-Reply-To: <1455657664.2463.68.camel@buserror.net>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 16/02/2016 22:21, Scott Wood a écrit :
> On Thu, 2016-02-11 at 17:16 +0100, Christophe Leroy wrote:
>> This patch provides VIRT_CPU_ACCOUTING to PPC32 architecture.
>> PPC32 doesn't have the PACA structure, so we use the task_info
>> structure to store the accounting data.
>>
>> In order to reuse on PPC32 the PPC64 functions, all u64 data has
>> been replaced by 'unsigned long' so that it is u32 on PPC32 and
>> u64 on PPC64
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>> Changes in v3: unlike previous version of the patch that was inspired
>> from IA64 architecture, this new version tries to reuse as much as
>> possible the PPC64 implementation.
>>
>> PPC32 doesn't have PACA and past discusion on v2 version has shown
>> that it is not worth implementing a PACA in PPC32 architecture
>> (see below benh opinion)
>>
>> benh: PACA is actually a data structure and you really really don't want it
>> on ppc32 :-) Having a register point to current works, having a register
>> point to per-cpu data instead works too (ie, change what we do today),
>> but don't introduce a PACA *please* :-)
> And Ben never replied to my reply at the time:
>
> "What is special about 64-bit that warrants doing things differently from 32
> -bit?  What is the difference between PACA and "per-cpu data", other than the
> obscure name?"
>
> I can understand wanting to avoid churn, but other than that, doing things
> differently on 64-bit versus 32-bit sucks.
>

What I can see is that PACA is always available via register r13. Do we 
have anything equivalent on PPC32 ?
If we define a per-cpu data for accounting, what will be the quick way 
to get access to it in entry_32.S ?
Something like a table of accounting data for each CPU, that we index 
with thread_info->cpu ?
This would allow a quite quick access, is it the good way to proceed in 
order to have something closer to PPC64 ?

Christophe
