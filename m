Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5E0A467BD5
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Jun 2006 16:30:37 +1000 (EST)
Subject: Re: [PATCH] powerpc vdso updates
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Anton Blanchard <anton@samba.org>
In-Reply-To: <20060610031543.GH23891@krispykreme>
References: <1148961097.15722.11.camel@localhost.localdomain>
	<20060610031543.GH23891@krispykreme>
Content-Type: text/plain
Date: Sat, 10 Jun 2006 16:30:26 +1000
Message-Id: <1149921026.12687.112.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, Ingo Molnar <mingo@elte.hu>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2006-06-10 at 13:15 +1000, Anton Blanchard wrote:
> Hi Ben,
> 
> > This patch cleans up some locking & error handling in the ppc vdso and
> > moves the vdso base pointer from the thread struct to the mm context
> > where it more logically belongs. It brings the powerpc implementation
> > closer to Ingo's new x86 one and also adds an arch_vma_name() function
> > allowing to print [vsdo] in /proc/<pid>/maps if Ingo's x86 vdso patch is
> > also applied.
> 
> Im getting this on the current powerpc git tree:
> 
> arch/powerpc/kernel/signal_32.c: In function 'handle_rt_signal':
> arch/powerpc/kernel/signal_32.c:763: error: request for member
> 'vdso_base' in something not a structure or union
> 
> It looks like we use the mm_context_t definition in asm-ppc/mmu.h for
> 32bit ARCH=powerpc builds and need vdso_base there too.

Yes, I have a patch almost ready for that.

Ben.
