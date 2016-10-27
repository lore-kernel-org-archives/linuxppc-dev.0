Return-Path: <cyrilbur@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t480R52DqzDvHp
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Oct 2016 12:08:39 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id i85so916260pfa.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Oct 2016 18:08:39 -0700 (PDT)
Message-ID: <1477530511.2313.1.camel@gmail.com>
Subject: Re: [PATCH] powerpc: process.c: fix Kconfig typo
From: Cyril Bur <cyrilbur@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Valentin Rothberg
 <valentinrothberg@gmail.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Thu, 27 Oct 2016 12:08:31 +1100
In-Reply-To: <878ttby7vh.fsf@concordia.ellerman.id.au>
References: <20161005055726.5614-1-valentinrothberg@gmail.com>
 <1475708074.735.2.camel@gmail.com>
 <878ttby7vh.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-10-26 at 16:52 +1100, Michael Ellerman wrote:
> Cyril Bur <cyrilbur@gmail.com> writes:
> 
> > On Wed, 2016-10-05 at 07:57 +0200, Valentin Rothberg wrote:
> > > s/ALIVEC/ALTIVEC/
> > > 
> > 
> > Oops, nice catch
> > 
> > > Signed-off-by: Valentin Rothberg <valentinrothberg@gmail.com>
> > 
> > Reviewed-by: Cyril Bur <cyrilbur@gmail.com>
> 
> How did we not notice? Sounds like we need a new selftest.
> 

Indeed...

Here is probably a good place to say why we didn't catch it and under
what circumstances this will have a negative effect.

If a thread performs and transaction with altivec and then gets
preempted for whatever reason, this bug may cause the kernel to not
reenable altivec when that thread runs again. This will result in an
altivec unavailable fault, when these faults happen inside a user
transaction the kernel has no choice but enable altivec and doom the
transaction.

The result is that transactions using altivec may get aborted more than
they should.

The difficulty in catching this with a selftest is my deliberate use of
the word may above. Optimisations to avoid FPU/altivec/VSX faults mean
that the kernel will always leave them on for 255 switches, this code
prevents the kernel turning it off if it got to the 256th switch (and
userspace was transactional)...


Cyril

> Looks like this should have:
> 
> Fixes: dc16b553c949 ("powerpc: Always restore FPU/VEC/VSX if hardware
> transactional memory in use")
> 
> 
> And I guess I need to start running checkkconfigsymbols.py on every
> commit.
> 
> cheers
