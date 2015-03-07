Return-Path: <linus971@gmail.com>
Received: from mail-ig0-x22b.google.com (mail-ig0-x22b.google.com
 [IPv6:2607:f8b0:4001:c05::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5F05D1A0196
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  8 Mar 2015 05:42:32 +1100 (AEDT)
Received: by igkb16 with SMTP id b16so11759797igk.1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 Mar 2015 10:42:30 -0800 (PST)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CA+55aFwSQgrYqfXPr6RPvQ+8OJfexXJRY_GVEKg5QtB2t38cWA@mail.gmail.com>
References: <1425741651-29152-1-git-send-email-mgorman@suse.de>
 <1425741651-29152-4-git-send-email-mgorman@suse.de>
 <CA+55aFwSQgrYqfXPr6RPvQ+8OJfexXJRY_GVEKg5QtB2t38cWA@mail.gmail.com>
Date: Sat, 7 Mar 2015 10:42:29 -0800
Message-ID: <CA+55aFxwmysVRCkBKFA88m_h0Byb0-2QvWn0_2rb_QNb8Eeedg@mail.gmail.com>
Subject: Re: [PATCH 3/4] mm: numa: Mark huge PTEs young when clearing NUMA
 hinting faults
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Mel Gorman <mgorman@suse.de>
Content-Type: text/plain; charset=UTF-8
Cc: Dave Chinner <david@fromorbit.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, xfs@oss.sgi.com,
 Linux-MM <linux-mm@kvack.org>, Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>, Ingo Molnar <mingo@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Mar 7, 2015 at 10:33 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>             Completely untested, but that "just
> or in the new protection bits" is what pnf_pte() does just a few lines
> above this.

Hmm. Looking at this, we do *not* want to set _PAGE_ACCESSED when we
turn a page into PROT_NONE or mark it for numa faulting. Nor do we
want to set it for mprotect for random pages that we haven't actually
accessed, just changed the protections for.

So my patch was obviously wrong, and I should feel bad for suggesting
it. I'm a moron, and my expectations that "pte_modify()" would just
take the accessed bit from the vm_page_prot field was stupid and
wrong.

Mel's patch is the right thing to do.

                                Linus
