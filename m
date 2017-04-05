Return-Path: <srs0=8xr5=3n=davemloft.net=davem@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vynbC2mzLzDqGv
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Apr 2017 00:02:15 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vynbC1N6yz8w2b
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Apr 2017 00:02:15 +1000 (AEST)
Received: from shards.monkeyblade.net (unknown [184.105.139.130])
 by ozlabs.org (Postfix) with ESMTP id 3vynbB6b70z9s8D
 for <linuxppc-dev@ozlabs.org>; Thu,  6 Apr 2017 00:02:12 +1000 (AEST)
Date: Wed, 05 Apr 2017 07:01:57 -0700 (PDT)
Message-Id: <20170405.070157.871721909352646302.davem@davemloft.net>
To: npiggin@gmail.com
Cc: torvalds@linux-foundation.org, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, anton@samba.org, linuxppc-dev@ozlabs.org
Subject: Re: [RFC][PATCH] spin loop arch primitives for busy waiting
From: David Miller <davem@davemloft.net>
In-Reply-To: <20170404130233.1f45115b@roar.ozlabs.ibm.com>
References: <20170404095001.664718b8@roar.ozlabs.ibm.com>
 <CA+55aFzdUMZHzXtn9PyhJg7GjYNQ5fy6=LzBNJx==Ab=U=YYjw@mail.gmail.com>
 <20170404130233.1f45115b@roar.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Nicholas Piggin <npiggin@gmail.com>
Date: Tue, 4 Apr 2017 13:02:33 +1000

> On Mon, 3 Apr 2017 17:43:05 -0700
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
>> But that depends on architectures having some pattern that we *can*
>> abstract. Would some "begin/in-loop/end" pattern like the above be
>> sufficient?
> 
> Yes. begin/in/end would be sufficient for powerpc SMT priority, and
> for x86, and it looks like sparc64 too. So we could do that if you
> prefer.

Sparc64 has two cases, on older chips we can induce a cpu thread yield
with a special sequence of instructions, and on newer chips we have
a bonafide pause instruction.

So cpu_relax() all by itself pretty much works for us.
