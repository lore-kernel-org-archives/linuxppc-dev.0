Return-Path: <linus971@gmail.com>
Received: from mail-qg0-x22a.google.com (mail-qg0-x22a.google.com
 [IPv6:2607:f8b0:400d:c04::22a])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 494671A09DB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Nov 2014 06:54:09 +1100 (AEDT)
Received: by mail-qg0-f42.google.com with SMTP id z107so1112989qgd.15
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Nov 2014 11:54:07 -0800 (PST)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <1416478790-27522-3-git-send-email-mgorman@suse.de>
References: <1416478790-27522-1-git-send-email-mgorman@suse.de>
 <1416478790-27522-3-git-send-email-mgorman@suse.de>
Date: Thu, 20 Nov 2014 11:54:06 -0800
Message-ID: <CA+55aFwV80r66w4RmtY-MAUGkwmfBJe+C5KFD3ZnNgYb_KbBpQ@mail.gmail.com>
Subject: Re: [PATCH 02/10] mm: Add p[te|md] protnone helpers for use by NUMA
 balancing
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Mel Gorman <mgorman@suse.de>
Content-Type: text/plain; charset=UTF-8
Cc: Rik van Riel <riel@redhat.com>, Hugh Dickins <hughd@google.com>,
 Linux Kernel <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
 Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
 Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>,
 Sasha Levin <sasha.levin@oracle.com>, Dave Jones <davej@redhat.com>,
 LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>,
 Kirill Shutemov <kirill.shutemov@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 20, 2014 at 2:19 AM, Mel Gorman <mgorman@suse.de> wrote:
> This is a preparatory patch that introduces protnone helpers for automatic
> NUMA balancing.

Oh, I hadn't noticed that you had renamed these things. It was
probably already true in your V1 version.

I do *not* think that "pte_protnone_numa()" makes sense as a name. It
only confuses people to think that there is still/again something
NUMA-special about the PTE. The whole point of the protnone changes
was to make it really very very clear that from a hardware standpoint,
this is *exactly* about protnone, and nothing else.

The fact that we then use protnone PTE's for numa faults is a VM
internal issue, it should *not* show up in the architecture page table
helpers.

I'm not NAK'ing this name, but I really think it's a very important
part of the whole patch series - to stop the stupid confusion about
NUMA entries. As far as the page tables are concerned, this has
absolutely _zero_ to do with NUMA.

We made that mistake once. We're fixing it. Let the naming *show* that
it's fixed, and this is "pte_protnone()".

The places that use this for NUMA handling might have a comment or
something. But they'll be in the VM where this matters, not in the
architecture page table description files. The comment would be
something like "if the vma is accessible, but the PTE is marked
protnone, this is a autonuma entry".

                    Linus
