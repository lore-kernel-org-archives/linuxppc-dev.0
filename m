Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40zxgZ0hVMzF0kx
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jun 2018 00:11:22 +1000 (AEST)
In-Reply-To: <23d156759ff411f5fd932e167b8b5f5ecd6aa88b.1527663626.git.christophe.leroy@c-s.fr>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, segher@kernel.crashing.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [v6,1/2] powerpc/lib: optimise 32 bits __clear_user()
Message-Id: <40zxgY4PMWz9s2k@ozlabs.org>
Date: Tue,  5 Jun 2018 00:11:20 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-05-30 at 07:06:13 UTC, Christophe Leroy wrote:
> Rewrite clear_user() on the same principle as memset(0), making use
> of dcbz to clear complete cache lines.
> 
> This code is a copy/paste of memset(), with some modifications
> in order to retrieve remaining number of bytes to be cleared,
> as it needs to be returned in case of error.
> 
> On the same way as done on PPC64 in commit 17968fbbd19f1
> ("powerpc: 64bit optimised __clear_user"), the patch moves
> __clear_user() into a dedicated file string_32.S
> 
> On a MPC885, throughput is almost doubled:
> 
> Before:
> ~# dd if=/dev/zero of=/dev/null bs=1M count=1000
> 1048576000 bytes (1000.0MB) copied, 18.990779 seconds, 52.7MB/s
> 
> After:
> ~# dd if=/dev/zero of=/dev/null bs=1M count=1000
> 1048576000 bytes (1000.0MB) copied, 9.611468 seconds, 104.0MB/s
> 
> On a MPC8321, throughput is multiplied by 2.12:
> 
> Before:
> root@vgoippro:~# dd if=/dev/zero of=/dev/null bs=1M count=1000
> 1048576000 bytes (1000.0MB) copied, 6.844352 seconds, 146.1MB/s
> 
> After:
> root@vgoippro:~# dd if=/dev/zero of=/dev/null bs=1M count=1000
> 1048576000 bytes (1000.0MB) copied, 3.218854 seconds, 310.7MB/s
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/f36bbf21e8b911b3c629fd36d4d217

cheers
