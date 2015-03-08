Return-Path: <linus971@gmail.com>
Received: from mail-ie0-x22d.google.com (mail-ie0-x22d.google.com
 [IPv6:2607:f8b0:4001:c03::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45EEA1A04C0
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Mar 2015 05:46:12 +1100 (AEDT)
Received: by iecrl12 with SMTP id rl12so14920818iec.8
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Mar 2015 11:46:10 -0700 (PDT)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CA+55aFyQyZXu2fi7X9bWdSX0utk8=sccfBwFaSoToROXoE_PLA@mail.gmail.com>
References: <1425741651-29152-1-git-send-email-mgorman@suse.de>
 <1425741651-29152-5-git-send-email-mgorman@suse.de>
 <20150307163657.GA9702@gmail.com>
 <CA+55aFwDuzpL-k8LsV3touhNLh+TFSLKP8+-nPwMXkWXDYPhrg@mail.gmail.com>
 <20150308100223.GC15487@gmail.com>
 <CA+55aFyQyZXu2fi7X9bWdSX0utk8=sccfBwFaSoToROXoE_PLA@mail.gmail.com>
Date: Sun, 8 Mar 2015 11:46:10 -0700
Message-ID: <CA+55aFwE4K7wmPWKR2SMb9us0LQEoGeLeErrPdB--bSbwf7yzg@mail.gmail.com>
Subject: Re: [PATCH 4/4] mm: numa: Slow PTE scan rate if migration failures
 occur
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset=UTF-8
Cc: Dave Chinner <david@fromorbit.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, xfs@oss.sgi.com,
 Linux-MM <linux-mm@kvack.org>, Mel Gorman <mgorman@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Mar 8, 2015 at 11:35 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>> As a second hack (not to be applied), could we change:
>>
>>  #define _PAGE_BIT_PROTNONE      _PAGE_BIT_GLOBAL
>>
>> to:
>>
>>  #define _PAGE_BIT_PROTNONE      (_PAGE_BIT_GLOBAL+1)
>>
>> to double check that the position of the bit does not matter?
>
> Agreed. We should definitely try that.

There's a second reason to do that, actually: the __supported_pte_mask
thing, _and_ the pageattr stuff in __split_large_page() etc play games
with _PAGE_GLOBAL. As does drivers/lguest for some reason.

So looking at this all, there's a lot of room for confusion with _PAGE_GLOBAL.

That kind of confusion would certainly explain the whole "the changes
_look_ like they do the same thing, but don't" - because of silly
semantic conflicts with PROTNONE vs GLOBAL.

                                Linus
