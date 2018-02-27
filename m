Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x22f.google.com (mail-pg0-x22f.google.com
 [IPv6:2607:f8b0:400e:c05::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zrCcV0ng4zF1X0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Feb 2018 20:11:37 +1100 (AEDT)
Received: by mail-pg0-x22f.google.com with SMTP id g12so7293284pgs.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Feb 2018 01:11:37 -0800 (PST)
Date: Tue, 27 Feb 2018 19:11:25 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC REBASED 5/5] powerpc/mm/slice: use the dynamic high slice
 size to limit bitmap operations
Message-ID: <20180227191125.659d5cbe@roar.ozlabs.ibm.com>
In-Reply-To: <87bmga7qng.fsf@linux.vnet.ibm.com>
References: <02a62db83282b5ef3e0e8281fdc46fa91beffc86.1518382747.git.christophe.leroy@c-s.fr>
 <5badd882663833576c10b8aafe235fe1e443f119.1518382747.git.christophe.leroy@c-s.fr>
 <87bmga7qng.fsf@linux.vnet.ibm.com>
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

On Tue, 27 Feb 2018 14:31:07 +0530
"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> wrote:

> Christophe Leroy <christophe.leroy@c-s.fr> writes:
> 
> > The number of high slices a process might use now depends on its
> > address space size, and what allocation address it has requested.
> >
> > This patch uses that limit throughout call chains where possible,
> > rather than use the fixed SLICE_NUM_HIGH for bitmap operations.
> > This saves some cost for processes that don't use very large address
> > spaces.  
> 
> I haven't really looked at the final code. One of the issue we had was
> with the below scenario.
> 
> mmap(addr, len) where addr < 128TB and addr+len > 128TB  We want to make
> sure we build the mask such that we don't find the addr available.

We should run it through the mmap regression tests. I *think* we moved
all of that logic from the slice code to get_ummapped_area before going
in to slices. I may have missed something though, it would be good to
have more eyes on it.

Thanks,
Nick
