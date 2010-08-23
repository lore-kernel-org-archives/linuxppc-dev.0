Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 4EA82B6F14
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 24 Aug 2010 08:18:37 +1000 (EST)
Date: Mon, 23 Aug 2010 15:18:53 -0700 (PDT)
Message-Id: <20100823.151853.108794567.davem@davemloft.net>
To: benh@kernel.crashing.org
Subject: Re: 64-bit ppc rwsem
From: David Miller <davem@davemloft.net>
In-Reply-To: <1282600885.22370.453.camel@pasglop>
References: <20100818.222925.233689776.davem@davemloft.net>
	<201008231544.16422.arnd@arndb.de>
	<1282600885.22370.453.camel@pasglop>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
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

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 24 Aug 2010 08:01:25 +1000

> On Mon, 2010-08-23 at 15:44 +0200, Arnd Bergmann wrote:
>> 
>> * Alpha has an optimization for the uniprocessor case, where the atomic
>> instructions get turned into nonatomic additions. The spinlock based
>> version uses no locks on UP but disables interrupts for reasons I don't
>> understand (nothing running at interrupt time should try to access an rwsem).
>> Should the generic version do the same as Alpha?
> 
> I've seen drivers in the past do trylocks at interrupt time ... tho I
> agree it sucks.

Recently there was a thread where this was declared absolutely illegal.

Maybe it was allowed, or sort-of worked before, and that's why it's
accounted for with IRQ disables in some implementations.  I don't
know.
