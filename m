Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wtS1d3hWVzDt0s
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 13:36:53 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id f127so767907pgc.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 20:36:53 -0700 (PDT)
Date: Thu, 22 Jun 2017 13:36:40 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Ananth N Mavinakayanahalli
 <ananth@linux.vnet.ibm.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 3/6] powerpc/64s: Blacklist system_call() and
 system_call_common() from kprobes
Message-ID: <20170622133640.66861cda@roar.ozlabs.ibm.com>
In-Reply-To: <e602b626323ee22ac39de305b62385a2a0210018.1498069502.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1498069502.git.naveen.n.rao@linux.vnet.ibm.com>
 <e602b626323ee22ac39de305b62385a2a0210018.1498069502.git.naveen.n.rao@linux.vnet.ibm.com>
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

On Thu, 22 Jun 2017 00:08:39 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> Convert some of the symbols into private symbols and blacklist
> system_call_common() and system_call() from kprobes. We can't take a
> trap at parts of these functions as either MSR_RI is unset or the kernel
> stack pointer is not yet setup.
> 
> Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

I don't have a problem with this bunch of system call labels
going private. They've never added much for me in profiles.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

Semi-related question, why is system_call: where it is? Should we
move it up to right after the mtmsrd / wrteei instruction?
(obviously for another patch). It's pretty common to get PMU
interrupts coming in right after mtmsr and this makes profiles split
the syscall into two which is annoying.

Thanks,
Nick
