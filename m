Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y363f1sRQzDqNm
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Sep 2017 06:38:54 +1000 (AEST)
Date: Thu, 28 Sep 2017 13:38:50 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Paul McKenney
 <paulmck@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>,
 kirill@shutemov.name, Andi Kleen <ak@linux.intel.com>, Michal Hocko
 <mhocko@kernel.org>, dave@stgolabs.net, Jan Kara <jack@suse.cz>, Matthew
 Wilcox <willy@infradead.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Paul
 Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Will Deacon
 <will.deacon@arm.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mm
 <linux-mm@kvack.org>, haren@linux.vnet.ibm.com, Anshuman Khandual
 <khandual@linux.vnet.ibm.com>, npiggin@gmail.com, bsingharora@gmail.com,
 Tim Chen <tim.c.chen@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
 "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v3 00/20] Speculative page faults
Message-Id: <20170928133850.90c5bf2aac0f1a63e29c01a3@linux-foundation.org>
In-Reply-To: <924a79af-6d7a-316a-1eee-3aebbfd4addf@linux.vnet.ibm.com>
References: <CAADnVQLmSbLHwj9m33kpzAidJPvq3cbdnXjaew6oTLqHWrBbZQ@mail.gmail.com>
 <20170925163443.260d6092160ec704e2b04653@linux-foundation.org>
 <924a79af-6d7a-316a-1eee-3aebbfd4addf@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 28 Sep 2017 14:29:02 +0200 Laurent Dufour <ldufour@linux.vnet.ibm.com> wrote:

> > Laurent's [0/n] provides some nice-looking performance benefits for
> > workloads which are chosen to show performance benefits(!) but, alas,
> > no quantitative testing results for workloads which we may suspect will
> > be harmed by the changes(?).  Even things as simple as impact upon
> > single-threaded pagefault-intensive workloads and its effect upon
> > CONFIG_SMP=n .text size?
> 
> I forgot to mention in my previous email the impact on the .text section.
> 
> Here are the metrics I got :
> 
> .text size	UP		SMP		Delta
> 4.13-mmotm	8444201		8964137		6.16%
> '' +spf		8452041		8971929		6.15%
> 	Delta	0.09%		0.09%	
> 
> No major impact as you could see.

8k text increase seems rather a lot actually.  That's a lot more
userspace cacheclines that get evicted during a fault...

Is the feature actually beneficial on uniprocessor?
