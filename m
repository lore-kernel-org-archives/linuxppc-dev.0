Return-Path: <jolsa@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rWHvX3MC0zDqvY
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jun 2016 21:24:08 +1000 (AEST)
Date: Fri, 17 Jun 2016 13:24:01 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Yury Norov <ynorov@caviumnetworks.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@intel.com>, Wang Nan <wangnan0@huawei.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] tools/perf: Fix the mask in regs_dump__printf
Message-ID: <20160617112401.GA3904@krava>
References: <1466140958-1928-1-git-send-email-maddy@linux.vnet.ibm.com>
 <20160617063707.GA31475@krava>
 <7abb0f9a-dea0-de86-ba0b-cebce0f11744@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7abb0f9a-dea0-de86-ba0b-cebce0f11744@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 17, 2016 at 02:43:31PM +0530, Madhavan Srinivasan wrote:

SNIP

> 
>  
>                 if (data->user_regs.abi) {
> -                       u64 mask = evsel->attr.sample_regs_user;
> +                       u.val64 = evsel->attr.sample_regs_user;
>  
> -                       sz = hweight_long(mask) * sizeof(u64);
> +                       if (sizeof(u64) > sizeof(unsigned long)) {
> +                               u64 mask = u.val64;
> +                               u.val32[1] = mask >> 32;
> +                               u.val32[0] = mask & ULONG_MAX;
> +                       }
> +
> +                       sz = hweight_long(u.val64) * sizeof(u64);
>                         OVERFLOW_CHECK(array, sz, max_size);
> -                       data->user_regs.mask = mask;
> +                       data->user_regs.mask = u.val64;
>                         data->user_regs.regs = (u64 *)array;
> 
> Issue I see is when printing the mask value in a 32bit perf
> on a 64bit kernel (big endian).
> 
> 442044948492 0xdc0 [0x188]: PERF_RECORD_SAMPLE(IP, 0x1): 7299/7299:
> 0xc000000000059200 period: 12599 addr: 0
> ... intr regs: mask 0xffffffff000007ff ABI 32-bit
>                             ^^^ shld have been 0x7ffffffffff
> 
> I agree it is better to fix this when reading, but
> we need to swap again when printing?

hum, sample data should be swap at this point already..
see perf_session__process_event

jirka
