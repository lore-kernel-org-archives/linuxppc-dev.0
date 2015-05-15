Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1C4B21A0477
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2015 11:34:48 +1000 (AEST)
Message-ID: <1431653687.13498.1.camel@ellerman.id.au>
Subject: Re: [PATCH] ppc64 ftrace: mark data_access callees "notrace" (pt.1)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Torsten Duwe <duwe@lst.de>
Date: Fri, 15 May 2015 11:34:47 +1000
In-Reply-To: <20150513161100.GA1619@lst.de>
References: <20150513161100.GA1619@lst.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: ppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-05-13 at 18:11 +0200, Torsten Duwe wrote:
> In order to avoid an endless recursion, functions that may get
> called from the data access handler must not call into tracing
> functions, which may cause data access faults ;-)
> 
> Advancing from my previous approach that lavishly compiled whole
> subdirs without the profiling switches, this is more fine-grained
> (but probably yet incomplete). This patch is necessary albeit not
> sufficient for FTRACE_WITH_REGS on ppc64.

There's got to be a better solution than this. The chance that you've correctly
annotated every function is basically 0, and the chance that we correctly add
it to every new or modififed function in the future is also 0.

I don't mean that as a criticism of you, but rather the technique. For starters
I don't see any annotations in 32-bit code, or in the BookE code etc.

Can you give us more details on what goes wrong without these annotations?

cheers
