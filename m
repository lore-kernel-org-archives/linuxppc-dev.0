Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yBVV93krtzDqlv
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Oct 2017 08:24:01 +1100 (AEDT)
Date: Tue, 10 Oct 2017 14:23:56 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Cc: paulmck@linux.vnet.ibm.com, peterz@infradead.org, kirill@shutemov.name,
 ak@linux.intel.com, mhocko@kernel.org, dave@stgolabs.net, jack@suse.cz,
 Matthew Wilcox <willy@infradead.org>, benh@kernel.crashing.org,
 mpe@ellerman.id.au, paulus@samba.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, hpa@zytor.com, Will Deacon
 <will.deacon@arm.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Andrea Arcangeli <aarcange@redhat.com>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, haren@linux.vnet.ibm.com, khandual@linux.vnet.ibm.com,
 npiggin@gmail.com, bsingharora@gmail.com, Tim Chen
 <tim.c.chen@linux.intel.com>, linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: Re: [PATCH v4 19/20] x86/mm: Add speculative pagefault handling
Message-Id: <20171010142356.b33f8a8fee3427fbdf0708e3@linux-foundation.org>
In-Reply-To: <1507543672-25821-20-git-send-email-ldufour@linux.vnet.ibm.com>
References: <1507543672-25821-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <1507543672-25821-20-git-send-email-ldufour@linux.vnet.ibm.com>
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

On Mon,  9 Oct 2017 12:07:51 +0200 Laurent Dufour <ldufour@linux.vnet.ibm.com> wrote:

> +/*
> + * Advertise that we call the Speculative Page Fault handler.
> + */
> +#if defined(CONFIG_X86_64) && defined(CONFIG_SMP)
> +#define __HAVE_ARCH_CALL_SPF
> +#endif

Here's where I mess up your life ;)

It would be more idiomatic to define this in arch/XXX/Kconfig:

config SPF
	def_bool y if SMP

then use CONFIG_SPF everywhere.

Also, it would be better if CONFIG_SPF were defined at the start of the
patch series rather than the end, so that as the patches add new code,
that code is actually compilable.  For bisection purposes.  I can
understand if this is too much work and effort - we can live with
things the way they are now.

This patchset is a ton of new code in very sensitive areas and seems to
have received little review and test.  I can do a
merge-and-see-what-happens but it would be quite a risk to send all
this upstream based only on my sketchy review and linux-next runtime
testing.  Can we bribe someone?
