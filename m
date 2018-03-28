Return-Path: <rientjes@google.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40BLMX1ZbfzF2Hl
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Mar 2018 08:18:15 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id g14so1690937pfh.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2018 14:18:15 -0700 (PDT)
Date: Wed, 28 Mar 2018 14:18:11 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>
cc: Thomas Gleixner <tglx@linutronix.de>, paulmck@linux.vnet.ibm.com,
 peterz@infradead.org, akpm@linux-foundation.org, kirill@shutemov.name,
 ak@linux.intel.com, mhocko@kernel.org, dave@stgolabs.net, jack@suse.cz,
 Matthew Wilcox <willy@infradead.org>, benh@kernel.crashing.org,
 mpe@ellerman.id.au, paulus@samba.org, Ingo Molnar <mingo@redhat.com>,
 hpa@zytor.com, Will Deacon <will.deacon@arm.com>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Andrea Arcangeli <aarcange@redhat.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>, kemi.wang@intel.com,
 sergey.senozhatsky.work@gmail.com,
 Daniel Jordan <daniel.m.jordan@oracle.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, haren@linux.vnet.ibm.com, khandual@linux.vnet.ibm.com,
 npiggin@gmail.com, bsingharora@gmail.com,
 Tim Chen <tim.c.chen@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
 x86@kernel.org
Subject: Re: [PATCH v9 01/24] mm: Introduce CONFIG_SPECULATIVE_PAGE_FAULT
In-Reply-To: <aa678038-9c5c-a8cb-0aed-ef19bde5d623@linux.vnet.ibm.com>
Message-ID: <alpine.DEB.2.20.1803281416310.167685@chino.kir.corp.google.com>
References: <1520963994-28477-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <1520963994-28477-2-git-send-email-ldufour@linux.vnet.ibm.com>
 <alpine.DEB.2.20.1803251442090.80485@chino.kir.corp.google.com>
 <32c80b6a-28c6-bf63-ed7b-6a042ae18e8f@linux.vnet.ibm.com>
 <alpine.DEB.2.20.1803280310380.68839@chino.kir.corp.google.com>
 <aa678038-9c5c-a8cb-0aed-ef19bde5d623@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 28 Mar 2018, Laurent Dufour wrote:

> > Putting this in mm/Kconfig is definitely the right way to go about it 
> > instead of any generic option in arch/*.
> > 
> > My question, though, was making this configurable by the user:
> > 
> > config SPECULATIVE_PAGE_FAULT
> > 	bool "Speculative page faults"
> > 	depends on X86_64 || PPC
> > 	default y
> > 	help
> > 	  ..
> > 
> > It's a question about whether we want this always enabled on x86_64 and 
> > power or whether the user should be able to disable it (right now they 
> > can't).  With a large feature like this, you may want to offer something 
> > simple (disable CONFIG_SPECULATIVE_PAGE_FAULT) if someone runs into 
> > regressions.
> 
> I agree, but I think it would be important to get the per architecture
> enablement to avoid complex check here. For instance in the case of powerPC
> this is only supported for PPC_BOOK3S_64.
> 
> To avoid exposing such per architecture define here, what do you think about
> having supporting architectures setting ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT
> and the SPECULATIVE_PAGE_FAULT depends on this, like this:
> 
> In mm/Kconfig:
> config SPECULATIVE_PAGE_FAULT
>  	bool "Speculative page faults"
>  	depends on ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT && SMP
>  	default y
>  	help
> 		...
> 
> In arch/powerpc/Kconfig:
> config PPC
> 	...
> 	select ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT	if PPC_BOOK3S_64
> 
> In arch/x86/Kconfig:
> config X86_64
> 	...
> 	select ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT
> 
> 

Looks good to me!  It feels like this will add more assurance that if 
things regress for certain workloads that it can be disabled.  I don't 
feel strongly about the default value, I'm ok with it being enabled by 
default.
