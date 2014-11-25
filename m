Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 159A71A0038
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Nov 2014 16:26:51 +1100 (AEDT)
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id DAADC14019C
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2014 16:26:50 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 25 Nov 2014 15:26:49 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 3D1D12BB0066
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2014 16:26:43 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAP5QhTQ40042748
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2014 16:26:43 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAP5QfWg027318
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2014 16:26:43 +1100
Message-ID: <54741307.6070905@linux.vnet.ibm.com>
Date: Tue, 25 Nov 2014 10:56:31 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH V4 1/8] elf: Add new PowerPC specifc core note sections
References: <1415683597-22819-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1415683597-22819-2-git-send-email-khandual@linux.vnet.ibm.com>
 <20141121154310.489097fb4403d664f2156043@linux-foundation.org>
In-Reply-To: <20141121154310.489097fb4403d664f2156043@linux-foundation.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: mikey@neuling.org, james.hogan@imgtec.com, avagin@openvz.org,
 Paul.Clothier@imgtec.com, peterz@infradead.org, palves@redhat.com,
 linux-kernel@vger.kernel.org, oleg@redhat.com, dhowells@redhat.com,
 linuxppc-dev@ozlabs.org, davej@redhat.com, tglx@linutronix.de,
 sukadev@linux.vnet.ibm.com, davem@davemloft.net, sam.bobroff@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/22/2014 05:13 AM, Andrew Morton wrote:
> On Tue, 11 Nov 2014 10:56:30 +0530 Anshuman Khandual <khandual@linux.vnet.ibm.com> wrote:
> 
>> This patch adds four new core note sections for PowerPC transactional
>> memory and one core note section for general miscellaneous debug registers.
>> These addition of new elf core note sections extends the existing elf ABI
>> without affecting it in any manner.
>>
>> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
>> ---
>>  include/uapi/linux/elf.h | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
>> index ea9bf25..2260fc0 100644
>> --- a/include/uapi/linux/elf.h
>> +++ b/include/uapi/linux/elf.h
>> @@ -379,6 +379,11 @@ typedef struct elf64_shdr {
>>  #define NT_PPC_VMX	0x100		/* PowerPC Altivec/VMX registers */
>>  #define NT_PPC_SPE	0x101		/* PowerPC SPE/EVR registers */
>>  #define NT_PPC_VSX	0x102		/* PowerPC VSX registers */
>> +#define NT_PPC_TM_SPR	0x103		/* PowerPC TM special registers */
>> +#define NT_PPC_TM_CGPR	0x104		/* PowerpC TM checkpointed GPR */
>> +#define NT_PPC_TM_CFPR	0x105		/* PowerPC TM checkpointed FPR */
>> +#define NT_PPC_TM_CVMX	0x106		/* PowerPC TM checkpointed VMX */
>> +#define NT_PPC_MISC	0x107		/* PowerPC miscellaneous registers */
>>  #define NT_386_TLS	0x200		/* i386 TLS slots (struct user_desc) */
>>  #define NT_386_IOPERM	0x201		/* x86 io permission bitmap (1=deny) */
>>  #define NT_X86_XSTATE	0x202		/* x86 extended state using xsave */
> 
> ack from me, if that was at all expected.

Thanks Andrew.

> 
> Please cc Shuah Khan <shuah.kh@samsung.com> on the tools/testing/selftests
> changes.

Sure, will do.
