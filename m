Return-Path: <linus971@gmail.com>
Received: from mail-it0-x22a.google.com (mail-it0-x22a.google.com
 [IPv6:2607:f8b0:4001:c0b::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41HcjM5S9TzF1LJ
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Jun 2018 12:22:15 +1000 (AEST)
Received: by mail-it0-x22a.google.com with SMTP id o5-v6so4345789itc.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jun 2018 19:22:15 -0700 (PDT)
MIME-Version: 1.0
References: <99169786-61dd-b19c-ac81-84bcd0a67de4@lwfinger.net>
 <CA+55aFzZ7PND2Xvz9wB1jaCmp0rBMTSmJtKiFwSeOWy9iLSd8Q@mail.gmail.com>
 <20180629214647.mkgpni6hxj7aore4@kshutemo-mobl1>
In-Reply-To: <20180629214647.mkgpni6hxj7aore4@kshutemo-mobl1>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 29 Jun 2018 19:22:01 -0700
Message-ID: <CA+55aFySZ39GHpK4XPvsOGv6yfsn9PyR+3Fs9_zb=2CQ2ha+rQ@mail.gmail.com>
Subject: Re: [Update] Regression in 4.18 - 32-bit PowerPC crashes on boot -
 bisected to commit 1d40a5ea01d5
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: aneesh.kumar@linux.ibm.com, Larry Finger <Larry.Finger@lwfinger.net>,
 Matthew Wilcox <willy@infradead.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Vlastimil Babka <vbabka@suse.cz>,
 Christoph Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Jerome Glisse <jglisse@redhat.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, Pekka Enberg <penberg@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>, Andrey Ryabinin <aryabinin@virtuozzo.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, ppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 29, 2018 at 2:46 PM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> Looks like pgtable_page_dtor() gets called in __pte_free_tlb() path twice.
> Once in __pte_free_tlb() itself and the second time in pgtable_free().

Ahh, that would certainly do it,. and explains why this hits ppc32 but
not x86, for example.

                Linus
