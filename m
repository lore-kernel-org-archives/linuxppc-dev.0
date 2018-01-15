Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zL0tF382VzF0Y0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jan 2018 04:37:41 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w0FHTgqd115578
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jan 2018 12:37:38 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2fh0ca9hcg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jan 2018 12:37:38 -0500
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Mon, 15 Jan 2018 17:37:36 -0000
Subject: Re: [PATCH v6 01/24] x86/mm: Define CONFIG_SPF
To: Thomas Gleixner <tglx@linutronix.de>
Cc: paulmck@linux.vnet.ibm.com, peterz@infradead.org,
 akpm@linux-foundation.org, kirill@shutemov.name, ak@linux.intel.com,
 mhocko@kernel.org, dave@stgolabs.net, jack@suse.cz,
 Matthew Wilcox <willy@infradead.org>, benh@kernel.crashing.org,
 mpe@ellerman.id.au, paulus@samba.org, Ingo Molnar <mingo@redhat.com>,
 hpa@zytor.com, Will Deacon <will.deacon@arm.com>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Andrea Arcangeli <aarcange@redhat.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>, kemi.wang@intel.com,
 sergey.senozhatsky.work@gmail.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, haren@linux.vnet.ibm.com,
 khandual@linux.vnet.ibm.com, npiggin@gmail.com, bsingharora@gmail.com,
 Tim Chen <tim.c.chen@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
 x86@kernel.org
References: <1515777968-867-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <1515777968-867-2-git-send-email-ldufour@linux.vnet.ibm.com>
 <alpine.DEB.2.20.1801121955150.2371@nanos>
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Mon, 15 Jan 2018 18:37:25 +0100
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1801121955150.2371@nanos>
Content-Type: text/plain; charset=utf-8
Message-Id: <753d7b28-3d7e-0c01-0386-8dad161f88ea@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Thomas,

Thanks for reviewing this series.

On 12/01/2018 19:57, Thomas Gleixner wrote:
> On Fri, 12 Jan 2018, Laurent Dufour wrote:
> 
>> Introduce CONFIG_SPF which turns on the Speculative Page Fault handler when
>> building for 64bits with SMP.
>>
>> Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
>> ---
>>  arch/x86/Kconfig | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index a317d5594b6a..d74353b85aaf 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -2882,6 +2882,10 @@ config X86_DMA_REMAP
>>  config HAVE_GENERIC_GUP
>>  	def_bool y
>>  
>> +config SPF
>> +	def_bool y
>> +	depends on X86_64 && SMP
> 
> Can you please put that into a generic place as
> 
>     config SPF
>     	   bool
> 
> and let the architectures select it.

I'll change that to let the architectures (x86 and ppc64 currently)
selecting it, but the definition will remain in the arch/xxx/Kconfig file
since it depends on the architecture support in the page fault handler.

> Also SPF could be bit more elaborate and self explaining for the causual
> reader. 3 letter acronyms are reserved for non existing agencies.

That's true 3 letter acronyms are already reserved...
I'll change it to CONFIG_SPECULATIVE_PAGE_FAULT as suggested by Matthew Wilcox.

Thanks,
Laurent.
