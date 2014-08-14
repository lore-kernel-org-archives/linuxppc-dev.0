Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CAF2B1A05EC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Aug 2014 16:19:10 +1000 (EST)
Message-ID: <1407997135.5490.58.camel@pasglop>
Subject: Re: [git pull] Please pull powerpc.git next branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 14 Aug 2014 16:18:55 +1000
In-Reply-To: <1407996977.5490.56.camel@pasglop>
References: <1407996977.5490.56.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel list <linux-kernel@vger.kernel.org>,
 Michael Ellerman <michaele@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-08-14 at 16:16 +1000, Benjamin Herrenschmidt wrote:
> Another interesting one in the "OMG" category is the series from Michael
> adding memory barriers to spin_is_locked(). That's also the result of many
> days of debugging to figure out why the semaphore code would occasionally
> crash in ways that made no sense. It ended up being some creative lock
> stacking that was defeated by the fact that our locks allow a load inside
> the locked section to be re-ordered with the load of the lock value itself
> (I'm still of two mind about whether to kill that once and for all by putting
> a heavier barrier back into our lock implementation...). The fixes come with
> a long explanation in the cset comments, feel free to read it if you feel
> like having a headache today.

Talking of which, I should have tagged that for stable... I'll forward them
separately when you've pulled.

Michael: If I miss this while I'm away next week, can you take care of it ?

Cheers,
Ben.
