Return-Path: <luc.vanoostenryck@gmail.com>
Received: from mail-wm0-x241.google.com (mail-wm0-x241.google.com
 [IPv6:2a00:1450:400c:c09::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 426Z8K1RNNzF3Tr
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Sep 2018 09:56:00 +1000 (AEST)
Received: by mail-wm0-x241.google.com with SMTP id 207-v6so15947858wme.5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Sep 2018 16:56:00 -0700 (PDT)
Date: Sat, 8 Sep 2018 01:55:54 +0200
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: Christophe LEROY <christophe.leroy@c-s.fr>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-sparse@vger.kernel.org
Subject: Re: [PATCH] perf: enum overflow in uapi/linux/perf_event.h
Message-ID: <20180907235552.6a6oytkzzpn4pcgl@ltop.local>
References: <a70172863fa7d3c138f788b18d36524bd45b0a73.1536326078.git.christophe.leroy@c-s.fr>
 <20180907134246.GC24106@hirez.programming.kicks-ass.net>
 <ae32181d-37b2-1a13-3c72-66775e05ff88@c-s.fr>
 <20180907135817.GF24106@hirez.programming.kicks-ass.net>
 <7a086a56-a896-9513-7315-9d0d21b61a44@c-s.fr>
 <20180907184358.pg2ho4m4tc3dpwlw@ltop.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20180907184358.pg2ho4m4tc3dpwlw@ltop.local>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 07, 2018 at 08:43:59PM +0200, Luc Van Oostenryck wrote:
> On Fri, Sep 07, 2018 at 04:15:33PM +0200, Christophe LEROY wrote:
> > Le 07/09/2018 à 15:58, Peter Zijlstra a écrit :
> > > On Fri, Sep 07, 2018 at 01:50:18PM +0000, Christophe Leroy wrote:
> > > > 
> > > > 
> > > > On 09/07/2018 01:42 PM, Peter Zijlstra wrote:
> > > > > On Fri, Sep 07, 2018 at 01:27:19PM +0000, Christophe Leroy wrote:
> > > > > > On PPC32, enums are 32 bits, so __PERF_SAMPLE_CALLCHAIN_EARLY is
> > > > > > out of scope. The following sparse warning is encountered:
> > > > > > 
> > > > > >     CHECK   arch/powerpc/kernel/process.c
> > > > > > ./include/uapi/linux/perf_event.h:147:56: warning: cast truncates bits from constant value (8000000000000000 becomes 0)
> > > > > 
> > > > > Urgh... what compiler is that? I've not seen anything like that from the
> > > > > build bots.
> > > > > 
> > > > 
> > > > [root@pc16082vm linux-powerpc]# sparse --version
> > > > 0.5.2
> > > > 
> > > > [root@pc16082vm linux-powerpc]# ppc-linux-gcc --version
> > > > ppc-linux-gcc (GCC) 5.4.0
> > > 
> > > Ah, that's a sparse warning. But does your GCC agree? The thing is,
> > > sparse uses the C enum spec, but I suspect GCC uses the C++ enum spec
> > > and it all works fine.
> 
> Sparse is a bit weird about the exact underlying type used for enums.
> 
> > Ah yes, it seems that GCC is happy. So sparse should be fixed instead ?
> 
> I'll investigate (I suppose the same is given on x86-32).


It's definitively a bug in sparse. A relatively nasty one and which
open a can of worms. Fortunately, I had already looked at these
problems in May, I just didn't had the time to push the patches.

-- Luc
