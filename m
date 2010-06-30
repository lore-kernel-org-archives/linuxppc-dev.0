Return-Path: <avorontsov@mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id CFFE1B6F06
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Jul 2010 02:38:06 +1000 (EST)
Date: Wed, 30 Jun 2010 20:38:04 +0400
From: Anton Vorontsov <avorontsov@mvista.com>
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 1/3] gianfar: Implement workaround for eTSEC74 erratum
Message-ID: <20100630163804.GA636@oksana.dev.rtsoft.ru>
References: <20100629205959.GA10905@oksana.dev.rtsoft.ru>
	<20100629.151626.90794001.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20100629.151626.90794001.davem@davemloft.net>
Cc: linuxppc-dev@ozlabs.org, afleming@freescale.com,
	Sandeep.Kumar@freescale.com, manfred.rudigier@omicron.at,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 29, 2010 at 03:16:26PM -0700, David Miller wrote:
> 
> I really don't see any value at all to this config option,
> the errata fixup code should be there all the time.

Well, at least for eTSEC76 erratum (patch 2/3) we have to touch
fast path (i.e. start_xmit), so I just wanted to make zero
overhead for controllers that don't need any fixups.

Not that there's much of the overhead in a single additional
'if' condition, no. ;-)

> It really does no harm to be there in the cases where it isn't
> used, and forcing users to turn this on is just another
> obscure way to end up with an incorrect configuration.

OK, resending the new patches, without Kconfig stuff...

If we'll have too many or too big errata so that it would cause
major performance or code size penalty for non-affected SOCs, we
can always do:

enum gfar_errata {
#ifdef CONFIG_PPC_FOO
	GFAR_ERRATA_FOO = 0x01,
#else
	GFAR_ERRATA_FOO = 0,
#endif
}

And then, priv->errata & GFAR_ERRATA_FOO will be optimized
away by the compiler.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
