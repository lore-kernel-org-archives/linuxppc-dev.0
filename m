Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qVqwb15r5zDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Mar 2016 13:23:11 +1100 (AEDT)
Received: from mail-pa0-x22e.google.com (mail-pa0-x22e.google.com
 [IPv6:2607:f8b0:400e:c03::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3qVqwZ45Vgz9s0k
 for <linuxppc-dev@ozlabs.org>; Thu, 24 Mar 2016 13:23:10 +1100 (AEDT)
Received: by mail-pa0-x22e.google.com with SMTP id tt10so9961925pab.3
 for <linuxppc-dev@ozlabs.org>; Wed, 23 Mar 2016 19:23:10 -0700 (PDT)
Subject: Re: [PATCH/RFC] ppc64 livepatch: frameless klp_return_helper using
 odd TOC
To: Torsten Duwe <duwe@lst.de>, Michael Ellerman <mpe@ellerman.id.au>
References: <20160323155858.GB27110@lst.de>
Cc: Petr Mladek <pmladek@suse.com>, jeyu@redhat.com, jkosina@suse.cz,
 jikos@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 kamalesh@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org,
 live-patching@vger.kernel.org, mbenes@suse.cz
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <56F34F85.7020408@gmail.com>
Date: Thu, 24 Mar 2016 13:23:01 +1100
MIME-Version: 1.0
In-Reply-To: <20160323155858.GB27110@lst.de>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 24/03/16 02:58, Torsten Duwe wrote:
> Since nobody liked the extra stack frame nor its workarounds, here is
> the next attempt. Assumptions:
>
> 1. Heuristics are bad. The better they are, the more subtly the
>    way they might fail.
>
> 2. The TOC pointer is usually dividable by 4, if not by 8. An odd
>    value never occurs.
>
> Conclusively, this patch unambiguously creates an odd TOC value when
> an ftraced function's global entry point is used. Ftrace_caller will
> then immediately fix it, and alongside gather the information whether
> the made call was local or global.
>
> In case of live patching this information is furthermore used to decide
> whether a klp_return_helper needs to be inserted or not.
> CAVEAT: any frameless klp_return_helper does not play well with
> sibling calls! There's an emergency exit that might work, at worst
> it will cause an oops, but it surely avoids a lockup.
> At least the live patching modules on ppc64le will need to be compiled
> using the -fno-optimize-sibling-calls compiler flag!
>
> Thanks go to Michael Matz and Richard Biener for reassurance about
> heuristics and pointers to the compiler flag.
>
> Signed-off-by: Torsten Duwe <duwe@suse.de>
>
>
I missed this yesterday, not on cc, but caught it on the list today

Thanks for working on this. I did a quick look, so the CR+4 code plus heuristics for global/local call detection? I'll review this soon - hopefully tonight, but we have a long weekend coming up, so there might be delays. In the meanwhile feel free to add my signed-off-by for the CR+4 code. I am also looking at a different approach -- per thread lr0 stack.

Balbir Singh.
