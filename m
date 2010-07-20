Return-Path: <schwidefsky@de.ibm.com>
Received: from mtagate5.de.ibm.com (mtagate5.de.ibm.com [195.212.17.165])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate5.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 474CAB6F07
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jul 2010 17:35:05 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate5.de.ibm.com (8.13.1/8.13.1) with ESMTP id o6K7Z1xK003544
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jul 2010 07:35:01 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id o6K7Z1jf1703998
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jul 2010 09:35:01 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id o6K7Z0eJ014565
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jul 2010 09:35:01 +0200
Date: Tue, 20 Jul 2010 09:34:59 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: [PATCH] math-emu: correct test for downshifting fraction in
	_FP_FROM_INT()
Message-ID: <20100720093459.10f0ea90@mschwide.boeblingen.de.ibm.com>
In-Reply-To: <19524.52658.716540.932975@pilspetsen.it.uu.se>
References: <19524.51858.992299.119315@pilspetsen.it.uu.se>
	<19524.52658.716540.932975@pilspetsen.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 20 Jul 2010 00:12:02 +0200
Mikael Pettersson <mikpe@it.uu.se> wrote:

> Unfortunately it seems difficult to write a generic module
> which uses math-emu:
> - <math-emu/soft-fp.h> includes <asm/sfp-machine.h>,
>   but only a handful of archs have it
> - <asm/sfp-machine.h> isn't always self-contained and may depend
>   on various $arch-specific declarations being present
> 
> The given test module works on sparc64 and ppc64, where it uses
> the kernel's sfp-machine.h, and on x86 where it uses a stub
> sfp-machine.h supplied by itself.  I tried to cross-compile it
> for alpha, but that failed due to its sfp-machine.h not being
> self-contained.  I didn't try sh or s390.

It would be challange to try this on s390. The math emulation code is
only used for really old 31 bit machines. Starting with the G5 the fpu
can do IEEE754, I would say the math emulation code is irrelevant for
s390 by now.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
