Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x235.google.com (mail-pg0-x235.google.com
 [IPv6:2607:f8b0:400e:c05::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yb2WV1xTmzDqYg
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Nov 2017 18:36:20 +1100 (AEDT)
Received: by mail-pg0-x235.google.com with SMTP id p9so12074369pgc.8
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Nov 2017 23:36:20 -0800 (PST)
Date: Mon, 13 Nov 2017 18:36:01 +1100
From: Nicholas Piggin <npiggin@gmail.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
 Florian Weimer <fweimer@redhat.com>, "Kirill A. Shutemov"
 <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v2 1/5] powerpc/64s/hash: Fix 128TB-512TB virtual
 address boundary case allocation
Message-ID: <20171113183601.18526bbc@roar.ozlabs.ibm.com>
In-Reply-To: <87h8tysriw.fsf@linux.vnet.ibm.com>
References: <20171109172740.19681-1-npiggin@gmail.com>
 <20171109172740.19681-2-npiggin@gmail.com>
 <87h8tysriw.fsf@linux.vnet.ibm.com>
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

On Mon, 13 Nov 2017 10:29:19 +0530
"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> wrote:

> Nicholas Piggin <npiggin@gmail.com> writes:
> 
> > When allocating VA space with a hint that crosses 128TB, the SLB addr_limit
> > variable is not expanded if addr is not > 128TB, but the slice allocation
> > looks at task_size, which is 512TB. This results in slice_check_fit()
> > incorrectly succeeding because the slice_count truncates off bit 128 of the
> > requested mask, so the comparison to the available mask succeeds.
> >
> > Fix this by using mm->context.addr_limit instead of mm->task_size for
> > testing allocation limits. This causes such allocations to fail.
> >  
> 
> Also note that this change the rule from > 128TB to >-128TB to select
> the larger address space. I guess that is correct because without '>=' we
> won't be able to allocate anything starting from 128TB (except MAP_FIXED).

Oh yes, thanks. That should at least be in the changelog. Probably
split into its own patch really.

Thanks,
Nick
