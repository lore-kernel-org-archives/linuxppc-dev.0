Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6CBB2DDE1E
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Dec 2008 20:03:31 +1100 (EST)
Subject: Re: [PATCH] net/ehea: bitops work on unsigned longs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
In-Reply-To: <20081230.215156.151347026.davem@davemloft.net>
References: <20081231141853.c6d123c4.sfr@canb.auug.org.au>
	<20081230.215156.151347026.davem@davemloft.net>
Content-Type: text/plain
Date: Wed, 31 Dec 2008 20:02:51 +1100
Message-Id: <1230714172.15389.63.camel@pasglop>
Mime-Version: 1.0
Cc: tklein@de.ibm.com, sfr@canb.auug.org.au, themann@de.ibm.com,
	netdev@vger.kernel.org, linuxppc-dev@ozlabs.org, raisch@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-12-30 at 21:51 -0800, David Miller wrote:
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Wed, 31 Dec 2008 14:18:53 +1100
> 
> > These changes will avoid several warnings when we change u64 to unsigned
> > long long.
> > 
> > Also, ehea_driver_flags is only used in ehca_main.c
> > 
> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > ---
> 
> And also rejected, just like the previous two.
> 
> This is so much worse than the problems we had with
> printing u64's and it's being done as a result to
> the "fix" for that.

Hi David !

I think this patch specifically is different and deserve a second look.

While the other patches are somewhat debatable (I do agree with you for
example that we shouldn't break the possibility of building for 32-bit,
and we shouldn't artifically add crud to silence warnings caused by the
u64 type change etc... I'll send separate replies to the other messages
later), in the case of this specific patch, I think it's actually more
correct to define a "flags" field that is used by set_bit() and
test_bit() using "long" rather than "u64" (for that same reason you
mention, which is 32/64-bit compatibility).

IE. The bitops operate on longs. Thus the field should be a long,
period. The compatibility here consists of making sure we don't use bits
above 31, which in this case is find since we use a short enum.

Thus the patch is makes the code cleaner and more correct regardless of
the type change of u64.

So from my side, this patch is

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Cheers,
Ben.
