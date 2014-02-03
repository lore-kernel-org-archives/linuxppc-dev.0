Return-Path: <cody@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0FDB72C0091
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Feb 2014 08:22:08 +1100 (EST)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cody@linux.vnet.ibm.com>;
 Mon, 3 Feb 2014 14:22:06 -0700
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id C882A19D804C
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Feb 2014 14:22:03 -0700 (MST)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by b03cxnp08028.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s13LM3d257999564
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Feb 2014 22:22:03 +0100
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 s13LPMM3016553
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Feb 2014 14:25:22 -0700
Message-ID: <52F0086F.60103@linux.vnet.ibm.com>
Date: Mon, 03 Feb 2014 13:21:51 -0800
From: Cody P Schafer <cody@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>,
 Linux PPC <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 3/8] powerpc: add hvcalls for 24x7 and gpci (get
 performance counter info)
References: <20140201055806.A25152C00B2@ozlabs.org>
In-Reply-To: <20140201055806.A25152C00B2@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
 Peter Zijlstra <a.p.zijlstra@chello.nl>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
 LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/31/2014 09:58 PM, Michael Ellerman wrote:
> On Thu, 2014-16-01 at 23:53:49 UTC, Cody P Schafer wrote:
>> Signed-off-by: Cody P Schafer <cody@linux.vnet.ibm.com>
>> ---
>>   arch/powerpc/include/asm/hvcall.h | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
>> index d8b600b..48d6efa 100644
>> --- a/arch/powerpc/include/asm/hvcall.h
>> +++ b/arch/powerpc/include/asm/hvcall.h
>> @@ -269,11 +269,15 @@
>>   #define H_COP			0x304
>>   #define H_GET_MPP_X		0x314
>>   #define H_SET_MODE		0x31C
>> -#define MAX_HCALL_OPCODE	H_SET_MODE
>> +#define H_GET_24X7_CATALOG_PAGE 0xF078
>> +#define H_GET_24X7_DATA		0xF07C
>> +#define H_GET_PERF_COUNTER_INFO 0xF080
>
> Ugh, why the hell did they put them up there.
>
>> +#define MAX_HCALL_OPCODE	H_GET_PERF_COUNTER_INFO
>
> We have an array which is sized based on this, which is unpleasant.
>
> I think you're better off putting these below in the platform specific section,
> and leaving MAX_HCALL_OPCODE alone. The only downside is you can't use the
> hcall tracing to see them.

Ya, I'm aware. I've got them up there as I did want to trace them :) . I 
don't see a big issue with moving them out of that section, though.

>>   /* Platform specific hcalls, used by KVM */
>>   #define H_RTAS			0xf000
>
