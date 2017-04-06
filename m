Return-Path: <srs0=okf1=3o=gmail.com=npiggin@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vz4BN5V3MzDqKJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Apr 2017 11:00:12 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vz4BN53dnz8wVn
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Apr 2017 11:00:12 +1000 (AEST)
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vz4BN0Pq2z9sCX
 for <linuxppc-dev@ozlabs.org>; Thu,  6 Apr 2017 11:00:11 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id g2so4611818pge.2
 for <linuxppc-dev@ozlabs.org>; Wed, 05 Apr 2017 18:00:11 -0700 (PDT)
Date: Thu, 6 Apr 2017 10:59:58 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: David Miller <davem@davemloft.net>
Cc: torvalds@linux-foundation.org, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, anton@samba.org, linuxppc-dev@ozlabs.org
Subject: Re: [RFC][PATCH] spin loop arch primitives for busy waiting
Message-ID: <20170406105958.196c6977@roar.ozlabs.ibm.com>
In-Reply-To: <20170405.070157.871721909352646302.davem@davemloft.net>
References: <20170404095001.664718b8@roar.ozlabs.ibm.com>
 <CA+55aFzdUMZHzXtn9PyhJg7GjYNQ5fy6=LzBNJx==Ab=U=YYjw@mail.gmail.com>
 <20170404130233.1f45115b@roar.ozlabs.ibm.com>
 <20170405.070157.871721909352646302.davem@davemloft.net>
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

On Wed, 05 Apr 2017 07:01:57 -0700 (PDT)
David Miller <davem@davemloft.net> wrote:

> From: Nicholas Piggin <npiggin@gmail.com>
> Date: Tue, 4 Apr 2017 13:02:33 +1000
> 
> > On Mon, 3 Apr 2017 17:43:05 -0700
> > Linus Torvalds <torvalds@linux-foundation.org> wrote:
> >   
> >> But that depends on architectures having some pattern that we *can*
> >> abstract. Would some "begin/in-loop/end" pattern like the above be
> >> sufficient?  
> > 
> > Yes. begin/in/end would be sufficient for powerpc SMT priority, and
> > for x86, and it looks like sparc64 too. So we could do that if you
> > prefer.  
> 
> Sparc64 has two cases, on older chips we can induce a cpu thread yield
> with a special sequence of instructions, and on newer chips we have
> a bonafide pause instruction.
> 
> So cpu_relax() all by itself pretty much works for us.
> 

Thanks for taking a look. The default spin primitives should just
continue to do the right thing for you in that case.

Arm has a yield instruction, ia64 has a pause... No unusual
requirements that I can see.

If there are no objections, I'll send the arch-independent part of
this through the powerpc tree (the last one I sent, which follows
Linus' preferred pattern).

Thanks,
Nick
