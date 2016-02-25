Return-Path: <hughd@google.com>
Received: from mail-ob0-x22f.google.com (mail-ob0-x22f.google.com
 [IPv6:2607:f8b0:4003:c01::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E55B21A00A5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 13:11:07 +1100 (AEDT)
Received: by mail-ob0-x22f.google.com with SMTP id jq7so36102613obb.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Feb 2016 18:11:07 -0800 (PST)
Date: Wed, 24 Feb 2016 18:10:57 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
cc: Paul Mackerras <paulus@ozlabs.org>, linuxppc-dev@lists.ozlabs.org,
 linux-mm@kvack.org
Subject: Problems with swapping in v4.5-rc on POWER
Message-ID: <alpine.LSU.2.11.1602241716220.15121@eggly.anvils>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I've plagiarized the subject from Paulus's "Problems with THP" mail
last weekend; but my similar problems are on PowerMac G5 baremetal,
with 4kB pages, not capable of THP and no THP configured in.

Under heavily swapping load, running kernel builds on tmpfs in limited
memory, I've been seeing random segfaults too, internal compiler errors
etc.  Not easily reproduced: sometimes happens in minutes, sometimes
not for several hours.

I tried and failed to construct a reproducer for you: my lack of a good
recipe has deterred me from reporting it, and seeing Paulus's mail on
THP gave me hope that the answer would come up in that thread; but no,
that was quickly resolved as a THP issue, since fixed.

(Mine had appeared to be fixed in v4.5-rc4 anyway; but I guess I
just didn't try hard enough, it resurfaced on -rc5 immediately.)

I've seen no sign of such problems on x86.  And I saw no sign of such
problems on v4.4-rc8-mm1, when I included the fixes to the _PAGE_PTE
and _PAGE_SWP_SOFT_DIRTY swapoff issues we discussed back then (in
33 hours of load, should be good enough; but did see such problems
a couple of times before including those fixes - I took them to be
a side-effect of the page flags issue, but now rather doubt that).

The minutes or hours thing: I wonder if that indicates a missing
initialization somewhere: that can easily show up soon after booting,
but then the machine settles into a steady state of reusing the same
structures, now initialized; until much later something disturbs the
state and it has to allocate more.  Sheer speculation, but I wonder.

Hugh
