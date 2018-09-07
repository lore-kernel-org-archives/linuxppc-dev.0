Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 426KSG15gBzF3Qv
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Sep 2018 00:23:58 +1000 (AEST)
Date: Fri, 7 Sep 2018 16:23:53 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Christophe LEROY <christophe.leroy@c-s.fr>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-sparse@vger.kernel.org
Subject: Re: [PATCH] perf: enum overflow in uapi/linux/perf_event.h
Message-ID: <20180907142353.GI24106@hirez.programming.kicks-ass.net>
References: <a70172863fa7d3c138f788b18d36524bd45b0a73.1536326078.git.christophe.leroy@c-s.fr>
 <20180907134246.GC24106@hirez.programming.kicks-ass.net>
 <ae32181d-37b2-1a13-3c72-66775e05ff88@c-s.fr>
 <20180907135817.GF24106@hirez.programming.kicks-ass.net>
 <7a086a56-a896-9513-7315-9d0d21b61a44@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7a086a56-a896-9513-7315-9d0d21b61a44@c-s.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 07, 2018 at 04:15:33PM +0200, Christophe LEROY wrote:

> Ah yes, it seems that GCC is happy. So sparse should be fixed instead ?

Ideally, yes.

> Anyway, is it really correct to put this constant inside that enum, after
> PERF_SAMPLE_MAX  ?

It is a bit of a hack, agreed. What we do is use the top bit of that
word (u64) for some internal state. By placing it there (after MAX) we
ensure it is not available for userspace (trying to set it will return
in -EINVAL) and by keeping it in the enum we know that bit is
unavailable for future use.

I have a patch queued that puts a little comment on that:

  https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?h=perf/urgent&id=34cad593c9ea350a1811ab718e64b36e5cde870c

(url is not stable, as I regenerate that git tree from quilt every so
often, but it should probably last the day).
