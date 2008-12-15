Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 12973DDDE3
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Dec 2008 02:43:54 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 6/16] powerpc/mm: Split mmu_context handling v3
Date: Mon, 15 Dec 2008 16:43:44 +0100
References: <20081215054530.4835FDE00C@ozlabs.org>
In-Reply-To: <20081215054530.4835FDE00C@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200812151643.44944.arnd@arndb.de>
Cc: Kumar Gala <kumar.gala@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 15 December 2008, Benjamin Herrenschmidt wrote:
> +/*
> + * On 32-bit PowerPC 6xx/7xx/7xxx CPUs, we use a set of 16 VSIDs
> + * (virtual segment identifiers) for each context.  Although the
> + * hardware supports 24-bit VSIDs, and thus >1 million contexts,
> + * we only use 32,768 of them.  That is ample, since there can be
> + * at most around 30,000 tasks in the system anyway, and it means
> + * that we can use a bitmap to indicate which contexts are in use.
> + * Using a bitmap means that we entirely avoid all of the problems
> + * that we used to have when the context number overflowed,
> + * particularly on SMP systems.
> + *  -- paulus.
> + */

Didn't we lift the limit to 30,000 tasks at some point? The comment
in linux/threads.h mentions that the PID space goes up to 4 million.
What does actually happen when we increase pid_max to beyond 32768
on those systems and try to use them? Is there another limit in place?

	Arnd <><
