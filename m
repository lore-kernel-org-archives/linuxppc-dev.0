Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a01:7a0:2:106d:700::1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zL19j4wnmzF0W8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jan 2018 04:51:05 +1100 (AEDT)
Date: Mon, 15 Jan 2018 18:49:17 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>
cc: paulmck@linux.vnet.ibm.com, peterz@infradead.org,
 akpm@linux-foundation.org, kirill@shutemov.name, ak@linux.intel.com,
 mhocko@kernel.org, dave@stgolabs.net, jack@suse.cz,
 Matthew Wilcox <willy@infradead.org>, benh@kernel.crashing.org,
 mpe@ellerman.id.au, paulus@samba.org, Ingo Molnar <mingo@redhat.com>,
 hpa@zytor.com, Will Deacon <will.deacon@arm.com>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Andrea Arcangeli <aarcange@redhat.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>, kemi.wang@intel.com,
 sergey.senozhatsky.work@gmail.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, haren@linux.vnet.ibm.com, khandual@linux.vnet.ibm.com,
 npiggin@gmail.com, bsingharora@gmail.com,
 Tim Chen <tim.c.chen@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
 x86@kernel.org
Subject: Re: [PATCH v6 01/24] x86/mm: Define CONFIG_SPF
In-Reply-To: <753d7b28-3d7e-0c01-0386-8dad161f88ea@linux.vnet.ibm.com>
Message-ID: <alpine.DEB.2.20.1801151846110.2143@nanos>
References: <1515777968-867-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <1515777968-867-2-git-send-email-ldufour@linux.vnet.ibm.com>
 <alpine.DEB.2.20.1801121955150.2371@nanos>
 <753d7b28-3d7e-0c01-0386-8dad161f88ea@linux.vnet.ibm.com>
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

On Mon, 15 Jan 2018, Laurent Dufour wrote:
> On 12/01/2018 19:57, Thomas Gleixner wrote:
> > On Fri, 12 Jan 2018, Laurent Dufour wrote:
> > 
> >> Introduce CONFIG_SPF which turns on the Speculative Page Fault handler when
> >> building for 64bits with SMP.
> >>
> >> Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
> >> ---
> >>  arch/x86/Kconfig | 4 ++++
> >>  1 file changed, 4 insertions(+)
> >>
> >> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> >> index a317d5594b6a..d74353b85aaf 100644
> >> --- a/arch/x86/Kconfig
> >> +++ b/arch/x86/Kconfig
> >> @@ -2882,6 +2882,10 @@ config X86_DMA_REMAP
> >>  config HAVE_GENERIC_GUP
> >>  	def_bool y
> >>  
> >> +config SPF
> >> +	def_bool y
> >> +	depends on X86_64 && SMP
> > 
> > Can you please put that into a generic place as
> > 
> >     config SPF
> >     	   bool
> > 
> > and let the architectures select it.
> 
> I'll change that to let the architectures (x86 and ppc64 currently)
> selecting it, but the definition will remain in the arch/xxx/Kconfig file
> since it depends on the architecture support in the page fault handler.

Errm. No.

	config SPECULATIVE_PAGE_FAULT
      		bool

goes into a generic config file, e.g. mm/Kconfig

Each architecture which implements support does:

	select SPECULATIVE_PAGE_FAULT

in arch/xxx/Kconfig

Thanks,

	tglx
