Return-Path: <schwab@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id DD4B4B6F7C
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 18 Aug 2011 19:31:20 +1000 (EST)
From: Andreas Schwab <schwab@redhat.com>
To: Ian Campbell <Ian.Campbell@citrix.com>
Subject: Re: build failure with gcc 4.6.0 "array subscript is above array
	bounds"
References: <1313656032.5010.247.camel@zakaz.uk.xensource.com>
Date: Thu, 18 Aug 2011 11:31:17 +0200
In-Reply-To: <1313656032.5010.247.camel@zakaz.uk.xensource.com> (Ian
	Campbell's message of "Thu, 18 Aug 2011 09:27:12 +0100")
Message-ID: <m34o1fyska.fsf@hase.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ian Campbell <Ian.Campbell@citrix.com> writes:

> I noticed this with a defconfig build:
>       CC      arch/powerpc/kernel/ptrace.o
>     arch/powerpc/kernel/ptrace.c: In function 'arch_ptrace':
>     arch/powerpc/kernel/ptrace.c:1502:5: error: array subscript is above array bounds [-Werror=array-bounds]
>     arch/powerpc/kernel/ptrace.c:1530:5: error: array subscript is above array bounds [-Werror=array-bounds]
>
> That corresponds to:
> 	tmp = ((unsigned long *)child->thread.fpr)
> 		[TS_FPRWIDTH * (index - PT_FPR0)];
>
> child->thread.fpr is "double fpr[32][TS_FPRWIDTH]".
>
> index has already been bounds checked so we know it is <= PT_FPSCR.
>
> I tried to fix but I don't really know enough about PPC to figure out
> the correct fix is. PT_FPSCR is "PT_FPR0 + 32" on ppc64, which seems
> consistent with the fpr definition.

Perhaps there should be a union that overlays fpr with an array of
longs.

> On ppc32 PT_FPSCR is "PT_FPR0 + 2*32 + 1", I tried replacing the 32 with
> "PT_FPSCR - PT_FPR0" (+ 1) but that got me into the BUILD_BUG_ONs at
> line 346 and 374. At this point I'm afraid gave up trying to fix things,
> I hope the report is useful anyway...

On ppc32 a single ptrace call can only read/write half of an fpr, so
each fpr occupies two slots.

Andreas.

-- 
Andreas Schwab, schwab@redhat.com
GPG Key fingerprint = D4E8 DBE3 3813 BB5D FA84  5EC7 45C6 250E 6F00 984E
"And now for something completely different."
