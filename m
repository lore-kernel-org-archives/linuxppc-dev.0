Return-Path: <Ian.Campbell@eu.citrix.com>
Received: from SMTP.EU.CITRIX.COM (smtp.ctxuk.citrix.com [62.200.22.115])
	by ozlabs.org (Postfix) with ESMTP id 55DF7B6F90
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 18 Aug 2011 18:38:43 +1000 (EST)
Subject: build failure with gcc 4.6.0 "array subscript is above array bounds"
From: Ian Campbell <Ian.Campbell@citrix.com>
To: <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 18 Aug 2011 09:27:12 +0100
Message-ID: <1313656032.5010.247.camel@zakaz.uk.xensource.com>
MIME-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I noticed this with a defconfig build:
      CC      arch/powerpc/kernel/ptrace.o
    arch/powerpc/kernel/ptrace.c: In function 'arch_ptrace':
    arch/powerpc/kernel/ptrace.c:1502:5: error: array subscript is above array bounds [-Werror=array-bounds]
    arch/powerpc/kernel/ptrace.c:1530:5: error: array subscript is above array bounds [-Werror=array-bounds]

That corresponds to:
	tmp = ((unsigned long *)child->thread.fpr)
		[TS_FPRWIDTH * (index - PT_FPR0)];

child->thread.fpr is "double fpr[32][TS_FPRWIDTH]".

index has already been bounds checked so we know it is <= PT_FPSCR.

I tried to fix but I don't really know enough about PPC to figure out
the correct fix is. PT_FPSCR is "PT_FPR0 + 32" on ppc64, which seems
consistent with the fpr definition.

On ppc32 PT_FPSCR is "PT_FPR0 + 2*32 + 1", I tried replacing the 32 with
"PT_FPSCR - PT_FPR0" (+ 1) but that got me into the BUILD_BUG_ONs at
line 346 and 374. At this point I'm afraid gave up trying to fix things,
I hope the report is useful anyway...

Ian.
