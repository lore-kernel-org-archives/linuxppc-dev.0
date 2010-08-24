Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CDD27B70A5
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 24 Aug 2010 11:31:42 +1000 (EST)
Subject: Re: 64-bit ppc rwsem
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
In-Reply-To: <20100823.151853.108794567.davem@davemloft.net>
References: <20100818.222925.233689776.davem@davemloft.net>
	<201008231544.16422.arnd@arndb.de> <1282600885.22370.453.camel@pasglop>
	<20100823.151853.108794567.davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 24 Aug 2010 11:31:17 +1000
Message-ID: <1282613477.22370.485.camel@pasglop>
Mime-Version: 1.0
Cc: arnd@arndb.de, linuxppc-dev@lists.ozlabs.org, paulus@au.ibm.com,
	linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
	akpm@linux-foundation.org, torvalds@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2010-08-23 at 15:18 -0700, David Miller wrote:
> > I've seen drivers in the past do trylocks at interrupt time ... tho
> I
> > agree it sucks.
> 
> Recently there was a thread where this was declared absolutely
> illegal.
> 
> Maybe it was allowed, or sort-of worked before, and that's why it's
> accounted for with IRQ disables in some implementations.  I don't
> know. 

Ok, I'm happy to say it's a big no-no then.

Arnd, do you want to take over the moving to asm-generic and take care
of the spinlock case as well ? I can send Linus the first patch that
changes powerpc to use atomic_long now along with a few other things I
have pending, then you can pickup from there. Or do you want me to
continue pushing my patch as-is and we can look at cleaning up the
spinlock case separately ?

Cheers,
Ben.
