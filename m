Return-Path: <peterz@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y13BW26pGzDsN9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Sep 2017 22:22:43 +1000 (AEST)
Date: Mon, 25 Sep 2017 14:22:19 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
 paulmck@linux.vnet.ibm.com, akpm@linux-foundation.org,
 kirill@shutemov.name, ak@linux.intel.com, mhocko@kernel.org,
 dave@stgolabs.net, jack@suse.cz,
 Matthew Wilcox <willy@infradead.org>, benh@kernel.crashing.org,
 mpe@ellerman.id.au, paulus@samba.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, hpa@zytor.com,
 Will Deacon <will.deacon@arm.com>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 haren@linux.vnet.ibm.com, khandual@linux.vnet.ibm.com,
 npiggin@gmail.com, bsingharora@gmail.com,
 Tim Chen <tim.c.chen@linux.intel.com>,
 linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: Re: [PATCH v3 04/20] mm: VMA sequence count
Message-ID: <20170925122219.ia6cmz2tng65fhoe@hirez.programming.kicks-ass.net>
References: <20170913115354.GA7756@jagdpanzerIV.localdomain>
 <44849c10-bc67-b55e-5788-d3c6bb5e7ad1@linux.vnet.ibm.com>
 <20170914003116.GA599@jagdpanzerIV.localdomain>
 <441ff1c6-72a7-5d96-02c8-063578affb62@linux.vnet.ibm.com>
 <20170914081358.GG599@jagdpanzerIV.localdomain>
 <26fa0b71-4053-5af7-baa0-e5fff9babf41@linux.vnet.ibm.com>
 <20170914091101.GH599@jagdpanzerIV.localdomain>
 <9605ce43-0f61-48d7-88e2-88220b773494@linux.vnet.ibm.com>
 <20170914094043.GJ599@jagdpanzerIV.localdomain>
 <4e6c4e45-bbd6-3fd8-ee96-216892c797b3@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4e6c4e45-bbd6-3fd8-ee96-216892c797b3@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 15, 2017 at 02:38:51PM +0200, Laurent Dufour wrote:
> >  /*
> >   * well... answering your question - it seems raw versions of seqcount
> >   * functions don't call lockdep's lock_acquire/lock_release...
> >   *
> >   * but I have never told you that. never.
> >   */
> 
> Hum... I'm not sure that would be the best way since in other case lockdep
> checks are valid, but if getting rid of locked's warning is required to get
> this series upstream, I'd use raw versions... Please advice...

No sensible other way to shut it up come to mind though. Might be best
to use the raw primitives with a comment explaining why.
