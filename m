Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x242.google.com (mail-pl0-x242.google.com
 [IPv6:2607:f8b0:400e:c01::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4155FN3rwbzF54W
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2018 09:10:00 +1000 (AEST)
Received: by mail-pl0-x242.google.com with SMTP id z9-v6so338786plk.11
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jun 2018 16:10:00 -0700 (PDT)
Date: Wed, 13 Jun 2018 09:09:50 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-mm <linux-mm@kvack.org>, ppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-arch <linux-arch@vger.kernel.org>, "Aneesh Kumar K. V"
 <aneesh.kumar@linux.vnet.ibm.com>, Minchan Kim <minchan@kernel.org>, Mel
 Gorman <mgorman@techsingularity.net>, Nadav Amit <nadav.amit@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 3/3] powerpc/64s/radix: optimise TLB flush with
 precise TLB ranges in mmu_gather
Message-ID: <20180613090950.50566245@roar.ozlabs.ibm.com>
In-Reply-To: <CA+55aFyk9VBLUk8VYhfEUR55x0TXY9_QX1dE4wE0A_ias9tMNQ@mail.gmail.com>
References: <20180612071621.26775-1-npiggin@gmail.com>
 <20180612071621.26775-4-npiggin@gmail.com>
 <CA+55aFzKBieD0Y3sgFQzt+x5esqb9vT6SEQ28xyCz5UWegfFVg@mail.gmail.com>
 <20180613083131.139a3c34@roar.ozlabs.ibm.com>
 <CA+55aFyk9VBLUk8VYhfEUR55x0TXY9_QX1dE4wE0A_ias9tMNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 12 Jun 2018 15:42:34 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Tue, Jun 12, 2018 at 3:31 PM Nicholas Piggin <npiggin@gmail.com> wrote:
> >
> > Okay sure, and this is the reason for the wide cc list. Intel does
> > need it of course, from 4.10.3.1 of the dev manual:
> >
> >   =E2=80=94 The processor may create a PML4-cache entry even if there a=
re no
> >     translations for any linear address that might use that entry
> >     (e.g., because the P flags are 0 in all entries in the referenced
> >     page-directory-pointer table). =20
>=20
> But does intel need it?
>=20
> Because I don't see it. We already do the __tlb_adjust_range(), and we
> never tear down the highest-level page tables afaik.
>=20
> Am I missing something?


Sorry I mean Intel needs the existing behaviour of range flush expanded
to cover page table pages.... right? The manual has similar wording for
lower levels of page tables too. So it does need to send an invalidate
*somewhere* that a freed page table page covers, even if no valid pte
was torn down.

Thanks,
Nick
