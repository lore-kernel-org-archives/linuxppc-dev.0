Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EF30E67B82
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Sep 2006 09:19:02 +1000 (EST)
Subject: Re: Fw: [PATCH] Remove powerpc specific parts of 3c509 driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linas Vepstas <linas@austin.ibm.com>
In-Reply-To: <20060919184243.GL29167@austin.ibm.com>
References: <20060919145433.8fc7d478.sfr@canb.auug.org.au>
	<20060919184243.GL29167@austin.ibm.com>
Content-Type: text/plain
Date: Wed, 20 Sep 2006 09:18:38 +1000
Message-Id: <1158707918.6002.179.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: akpm@osdl.org, Stephen Rothwell <sfr@canb.auug.org.au>,
	netdev@vger.kernel.org, jgarzik@pobox.com,
	ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> However, I presume someone added the  __powerpc__ define here
> because they picked up a 3c509 at a garage sale, stuck it in 
> a powerpc, found out it didn't work due to a byte-swapping bug,
> and then patched it as above. I'm disturbed that somehow 
> outsl_ns() became identical to outsl() at some point, presumably
> breaking this patch.

The problem is that somebody had the "bright" idea to implement ppc
outsl as byteswapping a loooong time ago. This was totally bogus and got
fixed, but it looks like this driver holds a remain of that period.

Ben.
