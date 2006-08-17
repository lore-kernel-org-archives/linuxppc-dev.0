Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7982867B76
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Aug 2006 14:44:15 +1000 (EST)
Subject: Re: [RFC PATCH 1/4] powerpc 2.6.16-rt17: to build on powerpc w/ RT
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: john stultz <johnstul@us.ibm.com>
In-Reply-To: <1155776171.15360.22.camel@localhost.localdomain>
References: <yyiodushvxs.wl@forest.swc.toshiba.co.jp>
	<17628.4499.609213.401518@cargo.ozlabs.ibm.com>
	<yyiac6biz3c.wl@forest.swc.toshiba.co.jp>
	<1155318983.5337.2.camel@localhost.localdomain>
	<1155771487.11312.114.camel@localhost.localdomain>
	<1155772859.15360.12.camel@localhost.localdomain>
	<1155774368.11312.135.camel@localhost.localdomain>
	<1155776171.15360.22.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 17 Aug 2006 06:43:21 +0200
Message-Id: <1155789801.11312.152.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, mingo@elte.hu, tglx@linutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > Well, I've been wanting to look at your stuff and possibly do the
> > conversion for some time, provided we don't lose performances ... Our
> > current implementation is very optimized to avoid even memory barriers
> > in most cases and I doubt we'll be able to be as fine tuned using your
> > generic code, thus it's a tradeoff decision that we have to do. But
> > then, I need to look into the details before doing any final
> > statement :)
> 
> Ok, although do let me know if you see places where the generic code
> could use any of the optimizations used in powerpc.

Difficult... but maybe. One of the main idea is that the 3 values used
for "calibration" (pre-mult offset, multiplier and post-mult offset) are
in a structure. There is an array of 2 of these and a pointer to the
"current" one. When changing those values, we update the "other" one,
wmb, then flip the pointer. The readers can then mostly be barrier-less
since there is a natural data dependency on the pointer.

Ben.
