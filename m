Return-Path: <oohall@gmail.com>
Received: from mail-qk0-x241.google.com (mail-qk0-x241.google.com
 [IPv6:2607:f8b0:400d:c09::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rGJS13hwdzDqZp
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 May 2016 18:03:45 +1000 (AEST)
Received: by mail-qk0-x241.google.com with SMTP id i7so4614253qkd.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 May 2016 01:03:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160526142142.b16f7f3f18204faf0823ac65@linux-foundation.org>
References: <1462435033-15601-1-git-send-email-oohall@gmail.com>
 <20160526142142.b16f7f3f18204faf0823ac65@linux-foundation.org>
Date: Fri, 27 May 2016 18:03:42 +1000
Message-ID: <CAOSf1CHFYeTEQ2-Fr+mdziJLTgf5=cgJKUXAFqREo5rMgWYEDQ@mail.gmail.com>
Subject: Re: [RFC PATCH] mm/init: fix zone boundary creation
From: oliver <oohall@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 Mel Gorman <mgorman@techsingularity.net>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 27, 2016 at 7:21 AM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> hm, this is all ten year old Mel code.
>
> What's the priority on this?  What are the user-visible runtime
> effects, how many people are affected, etc?

Low priority. To get bitten by this you need to enable a zone that appears
after ZONE_MOVABLE in the zone_type enum. As far as I can tell this means
running a kernel with ZONE_DEVICE or ZONE_CMA enabled, so I can't see this
affecting too many people.

I only noticed this because I've been fiddling with ZONE_DEVICE on powerpc and
4.6 broke my test kernel. This bug, in conjunction with the changes in Taku
Izumi's kernelcore=mirror patch (d91749c1dda71) and powerpc being the odd
architecture which initialises max_zone_pfn[] to ~0ul instead of 0 caused all
of system memory to be placed into ZONE_DEVICE at boot, followed a
panic since device memory cannot be used for kernel allocations. I've already
submitted a patch to fix the powerpc specific bits, but I figured this should
be fixed too.

oliver
