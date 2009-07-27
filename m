Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id B706DB7334
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 27 Jul 2009 14:09:58 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1A8D4DDD01
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Jul 2009 14:09:57 +1000 (EST)
Subject: Re: [PATCH] prom_init: evaluate mem kernel parameter for early
	allocation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Benjamin Krill <ben@codiert.org>
In-Reply-To: <20090717202922.GA20168@codiert.org>
References: <20090717202922.GA20168@codiert.org>
Content-Type: text/plain
Date: Mon, 27 Jul 2009 14:09:37 +1000
Message-Id: <1248667777.5706.0.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2009-07-17 at 22:29 +0200, Benjamin Krill wrote:
> Evaluate mem kernel parameter for early memory allocations. If mem is set
> no allocation in the region above the given boundary is allowed. The current
> code doesn't take care about this and allocate memory above the given mem
> boundary.

Breaks build on ppc32 due to ...

> +	opt = strstr(RELOC(prom_cmd_line), RELOC("mem="));

"opt" isn't defined (it's defined inside CONFIG_PPC64). Please respin
a patch that also removes that bit so that "opt" is always defined.

Cheers,
Ben.
