Return-Path: <richard@nod.at>
Received: from radon.swed.at (a.ns.miles-group.at [95.130.255.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B2A2F1A09D5
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Dec 2014 09:25:31 +1100 (AEDT)
Message-ID: <5484D240.30506@nod.at>
Date: Sun, 07 Dec 2014 23:18:40 +0100
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
To: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] arch: powerpc: kernel: signal_32.c: Remove unused function
References: <1417990021-18696-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
In-Reply-To: <1417990021-18696-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Content-Type: text/plain; charset=iso-8859-15
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am 07.12.2014 um 23:07 schrieb Rickard Strandqvist:
> Remove the function sys_debug_setcontext() that is not used anywhere.
> 
> This was partially found by using a static code analysis program called cppcheck.

Please don't blindly trust code analysis tools.
The function you're removing *is* in use.

  LD      init/built-in.o
arch/powerpc/kernel/built-in.o: In function `sys_call_table':
(.rodata+0x744): undefined reference to `sys_debug_setcontext'
make: *** [vmlinux] Error 1

Thanks,
//richard
