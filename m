Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 2EDBEDE229
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Apr 2008 14:09:33 +1000 (EST)
Date: Fri, 18 Apr 2008 21:09:33 -0700 (PDT)
Message-Id: <20080418.210933.01471700.davem@davemloft.net>
To: paulus@samba.org
Subject: Re: [PATCH] [POWERPC] i2c: fix build breakage introduced by OF helpers
From: David Miller <davem@davemloft.net>
In-Reply-To: <18441.28496.84724.411784@cargo.ozlabs.ibm.com>
References: <4808AEC7.8040000@scram.de>
	<18441.28496.84724.411784@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: sfr@canb.auug.org.au, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	i2c@lm-sensors.org, scottwood@freescale.com, khali@linux-fr.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Paul Mackerras <paulus@samba.org>
Date: Sat, 19 Apr 2008 14:04:32 +1000

> Jochen Friedrich writes:
> 
> > Fix build breakage introduced in commit
> > "[POWERPC] i2c: OF helpers for the i2c API".
> > If i2c-core is compiled as module, the helper needs to be
> > compiled as module, as well. Rename i2c.c to of_i2c.c to
> > avoid name space conflict.
> 
> Actually, since only powerpc has irq_of_parse_and_map, I'm now
> inclined to think that drivers/of/i2c.c should live under arch/powerpc
> for now, or at the least its option should depend on PPC_OF.

I specifically asked for this to not be PPC only so that I
can make use of this infrastructure on sparc64 for I2C devices.

It's OK if this breaks the sparc64 allmodconfig build, I'll take
care of this once it's merged in.

Please merge the PPC tree to Linus soon, so that I can merge
in my sparc64 NUMA bits which depend upon the LMB changesets
in the PPC tree.

Thanks.
