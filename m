Return-Path: <rientjes@google.com>
Received: from mail-pf0-x234.google.com (mail-pf0-x234.google.com
 [IPv6:2607:f8b0:400e:c00::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40KyRD6gwYzDr5X
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Apr 2018 16:47:52 +1000 (AEST)
Received: by mail-pf0-x234.google.com with SMTP id l27so7452463pfk.12
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Apr 2018 23:47:52 -0700 (PDT)
Date: Mon, 9 Apr 2018 23:47:48 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Andi Kleen <ak@linux.intel.com>
cc: Laurent Dufour <ldufour@linux.vnet.ibm.com>, paulmck@linux.vnet.ibm.com,
 peterz@infradead.org, akpm@linux-foundation.org, kirill@shutemov.name,
 mhocko@kernel.org, dave@stgolabs.net, jack@suse.cz,
 Matthew Wilcox <willy@infradead.org>, benh@kernel.crashing.org,
 mpe@ellerman.id.au, paulus@samba.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, hpa@zytor.com,
 Will Deacon <will.deacon@arm.com>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Andrea Arcangeli <aarcange@redhat.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>, kemi.wang@intel.com,
 sergey.senozhatsky.work@gmail.com,
 Daniel Jordan <daniel.m.jordan@oracle.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, haren@linux.vnet.ibm.com, khandual@linux.vnet.ibm.com,
 npiggin@gmail.com, bsingharora@gmail.com,
 Tim Chen <tim.c.chen@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
 x86@kernel.org
Subject: Re: [PATCH v9 21/24] perf tools: Add support for the SPF perf
 event
In-Reply-To: <20180327034936.GO13724@tassilo.jf.intel.com>
Message-ID: <alpine.DEB.2.21.1804092346090.225864@chino.kir.corp.google.com>
References: <1520963994-28477-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <1520963994-28477-22-git-send-email-ldufour@linux.vnet.ibm.com>
 <alpine.DEB.2.20.1803261443560.255554@chino.kir.corp.google.com>
 <20180327034936.GO13724@tassilo.jf.intel.com>
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

On Mon, 26 Mar 2018, Andi Kleen wrote:

> > Aside: should there be a new spec_flt field for struct task_struct that 
> > complements maj_flt and min_flt and be exported through /proc/pid/stat?
> 
> No. task_struct is already too bloated. If you need per process tracking 
> you can always get it through trace points.
> 

Hi Andi,

We have

	count_vm_event(PGFAULT);
	count_memcg_event_mm(vma->vm_mm, PGFAULT);

in handle_mm_fault() but not counterpart for spf.  I think it would be 
helpful to be able to determine how much faulting can be done 
speculatively if there is no per-process tracking without tracing.
