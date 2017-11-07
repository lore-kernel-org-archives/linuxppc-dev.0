Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yW8q714whzDrK1
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Nov 2017 11:06:26 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id g6so9556361pgn.6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Nov 2017 16:06:26 -0800 (PST)
Date: Tue, 7 Nov 2017 11:06:11 +1100
From: Nicholas Piggin <npiggin@gmail.com>
To: Florian Weimer <fweimer@redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org, "Aneesh Kumar K . V"
 <aneesh.kumar@linux.vnet.ibm.com>, "Kirill A . Shutemov"
 <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH 0/5] VA allocator fixes
Message-ID: <20171107110611.30cfede4@roar.ozlabs.ibm.com>
In-Reply-To: <cc66ea81-fd9a-0bd5-8a8c-5abdc604200b@redhat.com>
References: <20171106100315.29720-1-npiggin@gmail.com>
 <cc66ea81-fd9a-0bd5-8a8c-5abdc604200b@redhat.com>
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

On Mon, 6 Nov 2017 16:16:07 +0100
Florian Weimer <fweimer@redhat.com> wrote:

> On 11/06/2017 11:03 AM, Nicholas Piggin wrote:
> > Florian found a nasty corner case with the VA allocation logic
> > for crossing from 128TB to 512TB limit on hash, and made a
> > really superb report of the problem -- traces, reproducer recipes,
> > analysis, etc. which already mostly solved it.
> > 
> > The first patch in the series should solve Florian's particular
> > case, the next 3 are other issues with addr_limit. The last
> > patch is technically a cleanup but I think it's fairly important
> > in terms of understanding the code and also enabling some BUG
> > checks (when addr_limit == 0).
> > 
> > I have not tested these exactly on Florian's test case, but
> > some tests of my own behave better afterwards. Hopefully he has
> > time to re-test. Some careful review would be welcome too.  
> 
> I think I have applied the five patches you posted, but I still get a 
> brk value above 128 TiB:
> 
> # /lib64/ld64.so.1 ./a.out
> initial brk value: 0x7fffde960000
> probing at 0x80000001fffc
> 
> I assumed you wanted to reject those?

It was difficult to understand what the intended semantics are, but I
think brk should succeed (it is implemented with MAP_FIXED). Of course
it should not succeed then segfault when you try to access it.

> 
> In either case, I recommend to tweak the VM layout, so that ld.so does 
> not land closely to to the 128 TiB limit, so that the brk failure or 
> returning of 48-bit addresses is avoided.

Yeah well that's yet another issue. I was not really involved with the
address space extension work. Anees, Kirill, was the intention for the
128T->512T extension logic to be a no-op for all address space allocaiton
except those with explicit addresses?

Thanks,
Nick
