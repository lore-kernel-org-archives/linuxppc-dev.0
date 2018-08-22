Return-Path: <npiggin@gmail.com>
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41wCQR0WWkzDr4h
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Aug 2018 13:17:18 +1000 (AEST)
Received: by mail-pf1-x444.google.com with SMTP id l9-v6so284547pff.9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Aug 2018 20:17:18 -0700 (PDT)
Date: Wed, 22 Aug 2018 13:17:10 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, "Aneesh Kumar K . V"
 <aneesh.kumar@linux.ibm.com>
Subject: Re: [RFC PATCH 1/5] powerpc/64s/hash: convert SLB miss handlers to C
Message-ID: <20180822131710.5e2c45f5@roar.ozlabs.ibm.com>
In-Reply-To: <87y3d0kyj9.fsf@concordia.ellerman.id.au>
References: <20180820094200.13003-1-npiggin@gmail.com>
 <20180820094200.13003-2-npiggin@gmail.com>
 <87y3d0kyj9.fsf@concordia.ellerman.id.au>
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

On Tue, 21 Aug 2018 16:46:02 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Nicholas Piggin <npiggin@gmail.com> writes:
> 
> > This patch moves SLB miss handlers completely to C, using the standard
> > exception handler macros to set up the stack and branch to C.
> >
> > This can be done because the segment containing the kernel stack is
> > always bolted, so accessing it with relocation on will not cause an
> > SLB exception.
> >
> > Arbitrary kernel memory may not be accessed when handling kernel space
> > SLB misses, so care should be taken there.  
> 
> We'll need to mark everything that's used in slb.c as notrace, otherwise
> 
> Probably we just need to mark the whole file as not traceable.

Yeah good point there. I'll do that. The whole file including things we
allow today? How do we do that, like this?

CFLAGS_REMOVE_slb.o = -mno-sched-epilog $(CC_FLAGS_FTRACE)

Thanks,
Nick
