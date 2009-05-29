Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D4B8ADDFA4
	for <linuxppc-dev@ozlabs.org>; Fri, 29 May 2009 15:03:59 +1000 (EST)
Subject: Re: [PATCH] powerpc ptrace block-step
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Roland McGrath <roland@redhat.com>
In-Reply-To: <20090401215903.DE872FC3AB@magilla.sf.frob.com>
References: <20090401215903.DE872FC3AB@magilla.sf.frob.com>
Content-Type: text/plain
Date: Fri, 29 May 2009 15:03:49 +1000
Message-Id: <1243573429.17903.30.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, utrace-devel@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2009-04-01 at 14:59 -0700, Roland McGrath wrote:
> Maynard asked about user_enable_block_step() support on powerpc.
> This is the old patch I've posted before.  I haven't even tried
> to compile it lately, but it rebased cleanly.
> 
> AFAIK the only reason this didn't go in several months ago was waiting
> for someone to decide what the right arch_has_block_step() condition was,
> i.e. if it needs to check some cpu_feature or chip identifier bits.
> 
> I had hoped that I had passed the buck then to ppc folks to figure that out
> and make it so.  But it does not appear to have happened.
> 
> Note you can drop the #define PTRACE_SINGLEBLOCK if you want to be
> conservative and not touch the user (ptrace) ABI yet.  Then Maynard
> could beat on it with internal uses (utrace) before you worry about
> whether userland expects the new ptrace request macro to exist.

So the patch had some issues, such as missing clearing of DBCR0 bits,
missing changes to code in traps.c to properly identify the new cause
of debug interrupts, etc...

I've spinned a new version, I'll post it as soon as I got to do some
quick tests. It will then go into the next merge window hopefully.

Note: I've verified, blockstep seems to be implemented by all the core
variants -except- the old 601.

Cheers,
Ben.
