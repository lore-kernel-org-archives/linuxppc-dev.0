Return-Path: <willy@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zLYKb677vzF0WQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jan 2018 01:59:47 +1100 (AEDT)
Date: Tue, 16 Jan 2018 06:58:46 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Cc: paulmck@linux.vnet.ibm.com, peterz@infradead.org,
 akpm@linux-foundation.org, kirill@shutemov.name, ak@linux.intel.com,
 mhocko@kernel.org, dave@stgolabs.net, jack@suse.cz,
 benh@kernel.crashing.org, mpe@ellerman.id.au, paulus@samba.org,
 Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, hpa@zytor.com,
 Will Deacon <will.deacon@arm.com>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Andrea Arcangeli <aarcange@redhat.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 kemi.wang@intel.com, sergey.senozhatsky.work@gmail.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 haren@linux.vnet.ibm.com, khandual@linux.vnet.ibm.com,
 npiggin@gmail.com, bsingharora@gmail.com,
 Tim Chen <tim.c.chen@linux.intel.com>,
 linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: Re: [PATCH v6 22/24] mm: Speculative page fault handler return VMA
Message-ID: <20180116145846.GE30073@bombadil.infradead.org>
References: <1515777968-867-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <1515777968-867-23-git-send-email-ldufour@linux.vnet.ibm.com>
 <20180112190251.GC7590@bombadil.infradead.org>
 <20180113042354.GA24241@bombadil.infradead.org>
 <6d958348-bece-2c21-e8dc-4e5a65e82f9b@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6d958348-bece-2c21-e8dc-4e5a65e82f9b@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 16, 2018 at 03:47:51PM +0100, Laurent Dufour wrote:
> On 13/01/2018 05:23, Matthew Wilcox wrote:
> > Of course, we don't need to change them all.  Try this:
> 
> That would be good candidate for a clean up but I'm not sure this should be
> part of this already too long series.
> 
> If you don't mind, unless a global agreement is stated on that, I'd prefer
> to postpone such a change once the initial series is accepted.

Actually, I think this can go in first, independently of the speculative
fault series.  It's a win in memory savings, and probably shaves a
cycle or two off the fault handler due to less argument marshalling in
the call-stack.
