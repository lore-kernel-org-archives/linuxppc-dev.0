Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6923DDDDEE
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Nov 2008 10:17:26 +1100 (EST)
Subject: Re: Large stack usage in fs code (especially for PPC64)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <20081117133137.616cf287.akpm@linux-foundation.org>
References: <alpine.DEB.1.10.0811171508300.8722@gandalf.stny.rr.com>
	<20081117130856.92e41cd3.akpm@linux-foundation.org>
	<alpine.LFD.2.00.0811171320330.18283@nehalem.linux-foundation.org>
	<20081117133137.616cf287.akpm@linux-foundation.org>
Content-Type: text/plain
Date: Tue, 18 Nov 2008 10:17:04 +1100
Message-Id: <1226963824.7178.255.camel@pasglop>
Mime-Version: 1.0
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
	linuxppc-dev@ozlabs.org, paulus@samba.org, mingo@elte.hu,
	Linus Torvalds <torvalds@linux-foundation.org>, tglx@linutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> I'd have thought so, but I'm sure we're about to hear how important an
> optimisation the smaller stacks are ;)

Not sure, I tend to agree that it would make sense to bump our stack to
64K on 64K pages, it's not like we are saving anything and we are
probably adding overhead in alloc/dealloc. I'll see what Paul thinks
here.

> Yup.  That being said, the younger me did assert that "this is a neater
> implementation anyway".  If we can implement those loops without
> needing those on-stack temporary arrays then things probably are better
> overall.

Amen.

Cheers,
Ben.
