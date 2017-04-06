Return-Path: <srs0=hhrr=3o=gmail.com=linus971@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vzRBG0P3wzDqHH
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Apr 2017 01:16:22 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vzRBF6j6pz8syf
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Apr 2017 01:16:21 +1000 (AEST)
Received: from mail-it0-x243.google.com (mail-it0-x243.google.com
 [IPv6:2607:f8b0:4001:c0b::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vzRBF1ttnz9s85
 for <linuxppc-dev@ozlabs.org>; Fri,  7 Apr 2017 01:16:21 +1000 (AEST)
Received: by mail-it0-x243.google.com with SMTP id w11so4647415itb.0
 for <linuxppc-dev@ozlabs.org>; Thu, 06 Apr 2017 08:16:21 -0700 (PDT)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20170406141352.GF18204@arm.com>
References: <20170404095001.664718b8@roar.ozlabs.ibm.com>
 <CA+55aFzdUMZHzXtn9PyhJg7GjYNQ5fy6=LzBNJx==Ab=U=YYjw@mail.gmail.com>
 <20170404130233.1f45115b@roar.ozlabs.ibm.com>
 <20170405.070157.871721909352646302.davem@davemloft.net>
 <20170406105958.196c6977@roar.ozlabs.ibm.com> <20170406141352.GF18204@arm.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 6 Apr 2017 08:16:19 -0700
Message-ID: <CA+55aFwgNhF=QUKMKLc9TfQ=cgF2mvMEVx9hJms4wQqCsib9Rw@mail.gmail.com>
Subject: Re: [RFC][PATCH] spin loop arch primitives for busy waiting
To: Will Deacon <will.deacon@arm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, David Miller <davem@davemloft.net>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Anton Blanchard <anton@samba.org>,
 linuxppc-dev list <linuxppc-dev@ozlabs.org>,
 Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 6, 2017 at 7:13 AM, Will Deacon <will.deacon@arm.com> wrote:
>
> We've wrapped this up in the arm64 code as __cmpwait, and we use that
> to build smp_cond_load_acquire. It would be nice to use the same machinery
> for the conditional spinning here, unless you anticipate that we're only
> going to be spinning for a handful of iterations anyway?

I suspect most of these loops aren't set up for the WFE kind of
spinning, because they look for more than one variable.

.. and the ones that _are_ set up for this probably should just be
rewritten to use smp_cond_load_acquire() anyway, because the "wait for
value" special case is fairly special.

In theory x86 could use monitor/mwait for it too, in practice I think
it tends to still be too high latency (because it was originally just
designed for the idle loop). mwait got extended to actually be useful,
but I'm not sure what the latency is for the modern one.

               Linus
