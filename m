Return-Path: <darren.hart@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by ozlabs.org (Postfix) with ESMTP id 6B077B6F6B
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 21 Jul 2011 00:49:54 +1000 (EST)
Message-ID: <4E26E8AC.7080407@intel.com>
Date: Wed, 20 Jul 2011 07:39:40 -0700
From: Darren Hart <darren.hart@intel.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC/PATCH] mm/futex: Fix futex writes on archs with SW tracking
	of dirty & young
References: <1310717238-13857-1-git-send-email-haishan.bai@gmail.com>	
	<1310717238-13857-2-git-send-email-haishan.bai@gmail.com>	
	<1310725418.2586.309.camel@twins> <4E21A526.8010904@gmail.com>	
	<1310860194.25044.17.camel@pasglop>	
	<4b337921-d430-4b63-bc36-ad31753cf800@email.android.com>	
	<1310912990.25044.203.camel@pasglop>
	<1310944453.25044.262.camel@pasglop>	
	<1310961691.25044.274.camel@pasglop> <4E23D728.7090406@gmail.com>	
	<1310972462.25044.292.camel@pasglop> <4E23E02C.8090401@gmail.com>	
	<1310974591.25044.298.camel@pasglop> <4E24FA51.70602@gmail.com>
	<1311049762.25044.392.camel@pasglop>
In-Reply-To: <1311049762.25044.392.camel@pasglop>
Content-Type: text/plain; charset=UTF-8
Cc: tony.luck@intel.com, Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Shan Hai <haishan.bai@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
	linux-kernel@vger.kernel.org, cmetcalf@tilera.com,
	dhowells@redhat.com, paulus@samba.org, tglx@linutronix.de,
	walken@google.com, linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Obviously no objection from the futex side of things, looks good. Couple
nits on the function comment:

On 07/18/2011 09:29 PM, Benjamin Herrenschmidt wrote:
...
> -/**
> +/*
> + * fixup_user_fault() - manually resolve a user page  fault

s/  fault/ fault/

> + * @tsk:	the task_struct to use for page fault accounting, or
> + *		NULL if faults are not to be recorded.
> + * @mm:		mm_struct of target mm
> + * @address:	user address
> + * @fault_flags:flags to pass down to handle_mm_fault()
> + *
> + * This is meant to be called in the specific scenario where for
> + * locking reasons we try to access user memory in atomic context
> + * (within a pagefault_disable() section), this returns -EFAULT,
> + * and we want to resolve the user fault before trying again.
> + *
> + * Typically this is meant to be used by the futex code.
> + *
> + * The main difference with get_user_pages() is that this function
> + * will unconditionally call handle_mm_fault() which will in turn
> + * perform all the necessary SW fixup of the dirty and young bits
> + * in the PTE, while handle_mm_fault() only guarantees to update
> + * these in the struct page.
> + *
> + * This is important for some architectures where those bits also
> + * gate the access permission to the page because their are

s/their/they/

Thanks,

-- 
Darren Hart
Intel Open Source Technology Center
Yocto Project - Linux Kernel
