Return-Path: <sergey.senozhatsky.work@gmail.com>
Received: from mail-pf0-x22d.google.com (mail-pf0-x22d.google.com
 [IPv6:2607:f8b0:400e:c00::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xtBBh6pf4zDqXp
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Sep 2017 18:14:04 +1000 (AEST)
Received: by mail-pf0-x22d.google.com with SMTP id e1so3971671pfk.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Sep 2017 01:14:04 -0700 (PDT)
Date: Thu, 14 Sep 2017 17:13:58 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
 paulmck@linux.vnet.ibm.com, peterz@infradead.org,
 akpm@linux-foundation.org, kirill@shutemov.name, ak@linux.intel.com,
 mhocko@kernel.org, dave@stgolabs.net, jack@suse.cz,
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
Message-ID: <20170914081358.GG599@jagdpanzerIV.localdomain>
References: <1504894024-2750-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <1504894024-2750-5-git-send-email-ldufour@linux.vnet.ibm.com>
 <20170913115354.GA7756@jagdpanzerIV.localdomain>
 <44849c10-bc67-b55e-5788-d3c6bb5e7ad1@linux.vnet.ibm.com>
 <20170914003116.GA599@jagdpanzerIV.localdomain>
 <441ff1c6-72a7-5d96-02c8-063578affb62@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <441ff1c6-72a7-5d96-02c8-063578affb62@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On (09/14/17 09:55), Laurent Dufour wrote:
[..]
> > so if there are two CPUs, one doing write_seqcount() and the other one
> > doing read_seqcount() then what can happen is something like this
> > 
> > 	CPU0					CPU1
> > 
> > 						fs_reclaim_acquire()
> > 	write_seqcount_begin()
> > 	fs_reclaim_acquire()			read_seqcount_begin()
> > 	write_seqcount_end()
> > 
> > CPU0 can't write_seqcount_end() because of fs_reclaim_acquire() from
> > CPU1, CPU1 can't read_seqcount_begin() because CPU0 did write_seqcount_begin()
> > and now waits for fs_reclaim_acquire(). makes sense?
> 
> Yes, this makes sense.
> 
> But in the case of this series, there is no call to
> __read_seqcount_begin(), and the reader (the speculative page fault
> handler), is just checking for (vm_seq & 1) and if this is true, simply
> exit the speculative path without waiting.
> So there is no deadlock possibility.

probably lockdep just knows that those locks interleave at some
point.


by the way, I think there is one path that can spin

find_vma_srcu()
 read_seqbegin()
  read_seqcount_begin()
   raw_read_seqcount_begin()
    __read_seqcount_begin()

	-ss
