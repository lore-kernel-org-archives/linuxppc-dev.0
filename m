Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yBpqf0k00zDr5S
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Oct 2017 20:40:13 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9B9dq6w097180
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Oct 2017 05:40:11 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dhekcp7bu-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Oct 2017 05:40:10 -0400
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Wed, 11 Oct 2017 10:40:07 +0100
Subject: Re: [PATCH v4 19/20] x86/mm: Add speculative pagefault handling
To: Andrew Morton <akpm@linux-foundation.org>
Cc: paulmck@linux.vnet.ibm.com, peterz@infradead.org, kirill@shutemov.name,
 ak@linux.intel.com, mhocko@kernel.org, dave@stgolabs.net, jack@suse.cz,
 Matthew Wilcox <willy@infradead.org>, benh@kernel.crashing.org,
 mpe@ellerman.id.au, paulus@samba.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 hpa@zytor.com, Will Deacon <will.deacon@arm.com>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Andrea Arcangeli <aarcange@redhat.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 haren@linux.vnet.ibm.com, khandual@linux.vnet.ibm.com,
 npiggin@gmail.com, bsingharora@gmail.com,
 Tim Chen <tim.c.chen@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
 x86@kernel.org
References: <1507543672-25821-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <1507543672-25821-20-git-send-email-ldufour@linux.vnet.ibm.com>
 <20171010142356.b33f8a8fee3427fbdf0708e3@linux-foundation.org>
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Wed, 11 Oct 2017 11:39:58 +0200
MIME-Version: 1.0
In-Reply-To: <20171010142356.b33f8a8fee3427fbdf0708e3@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Message-Id: <6c58b73a-b089-237f-46df-95e7c6fbe7ba@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/10/2017 23:23, Andrew Morton wrote:
> On Mon,  9 Oct 2017 12:07:51 +0200 Laurent Dufour <ldufour@linux.vnet.ibm.com> wrote:
> 
>> +/*
>> + * Advertise that we call the Speculative Page Fault handler.
>> + */
>> +#if defined(CONFIG_X86_64) && defined(CONFIG_SMP)
>> +#define __HAVE_ARCH_CALL_SPF
>> +#endif
> 
> Here's where I mess up your life ;)

That's ok... for this time ;)

> It would be more idiomatic to define this in arch/XXX/Kconfig:
> 
> config SPF
> 	def_bool y if SMP
> 
> then use CONFIG_SPF everywhere.

That's far smarter ! Thanks for the tip, I'll change the series in this way.

> Also, it would be better if CONFIG_SPF were defined at the start of the
> patch series rather than the end, so that as the patches add new code,
> that code is actually compilable.  For bisection purposes.  I can
> understand if this is too much work and effort - we can live with
> things the way they are now.

I'll make the change and define CONFIG_SPF earlier, since until the patch
enabling SPF page fault handler call in the arch part, the code is not
triggered but the sequence count and the RCU stuff will be called this way.


> This patchset is a ton of new code in very sensitive areas and seems to
> have received little review and test.  I can do a
> merge-and-see-what-happens but it would be quite a risk to send all
> this upstream based only on my sketchy review and linux-next runtime
> testing.  Can we bribe someone?

I'll do appreciate to get more review too. So please...
