Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xWD3L2DxkzDr4C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Aug 2017 21:31:58 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
Cc: Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH v3 1/2] powerpc/xmon: Dump ftrace buffers for the current
 CPU only
In-Reply-To: <1501704846-22625-1-git-send-email-leitao@debian.org>
References: <1501704846-22625-1-git-send-email-leitao@debian.org>
Date: Mon, 14 Aug 2017 21:31:56 +1000
Message-ID: <87mv72qtar.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Breno Leitao <leitao@debian.org> writes:

> Current xmon 'dt' command dumps the tracing buffer for all the CPUs,
> which makes it very hard to read due to the fact that most of
> powerpc machines currently have many CPUs.

> Other than that, the CPU
> lines are interleaved in the ftrace log.

That's because they're ordered by time. And the CPU number is included
in each line.

> This new option just dumps the ftrace buffer for the current CPU.

This is still a good idea though :)

> diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
> index 08e367e3e8c3..e0522f60f0ee 100644
> --- a/arch/powerpc/xmon/xmon.c
> +++ b/arch/powerpc/xmon/xmon.c
> @@ -234,6 +234,7 @@ Commands:\n\
>    "\
>    dr	dump stream of raw bytes\n\
>    dt	dump the tracing buffers (uses printk)\n\
> +  dtc	dump the tracing buffers for current CPU (uses printk)\n\

Hopefully people won't be disappointed that this doesn't invoke dtc
(Device Tree Compiler) in xmon :P

cheers
