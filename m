Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3EC90DE286
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Mar 2008 07:52:34 +1100 (EST)
Subject: Re: [BUG] 2.6.25-rc5-mm1 kernel panic with "Exception: 501 " on
	powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <20080312104645.34e58319.akpm@linux-foundation.org>
References: <20080311011434.ad8c8d7d.akpm@linux-foundation.org>
	<47D7D2C9.4090001@linux.vnet.ibm.com>
	<20080312104645.34e58319.akpm@linux-foundation.org>
Content-Type: text/plain
Date: Thu, 13 Mar 2008 07:40:06 +1100
Message-Id: <1205354406.9431.23.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Matthew Wilcox <matthew@wil.cx>,
	linux-kernel@vger.kernel.org,
	Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Beats me.  Maybe we're still enabling interrupts too early.  But the new
> semaphore code got fixed (didn't it?)

Won't lockdep/irqtrace warn if that happens ? You don't yet have the
lockdep patches for ppc64 (I'm still trying to find out why they break
iSeries) but it should warn of such a spurrious IRQ enable on other
archs too... At least, from a quick look at the code, it -seems- that it
does have such a test.

Cheers,
Ben.
