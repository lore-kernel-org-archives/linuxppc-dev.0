Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18441.33181.511355.338428@cargo.ozlabs.ibm.com>
Date: Sat, 19 Apr 2008 15:22:37 +1000
From: Paul Mackerras <paulus@samba.org>
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] [POWERPC] i2c: fix build breakage introduced by OF helpers
In-Reply-To: <20080418.210933.01471700.davem@davemloft.net>
References: <4808AEC7.8040000@scram.de>
	<18441.28496.84724.411784@cargo.ozlabs.ibm.com>
	<20080418.210933.01471700.davem@davemloft.net>
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

David Miller writes:
> From: Paul Mackerras <paulus@samba.org>
> Date: Sat, 19 Apr 2008 14:04:32 +1000
> 
> > Jochen Friedrich writes:
> > 
> > > Fix build breakage introduced in commit
> > > "[POWERPC] i2c: OF helpers for the i2c API".
> > > If i2c-core is compiled as module, the helper needs to be
> > > compiled as module, as well. Rename i2c.c to of_i2c.c to
> > > avoid name space conflict.
> > 
> > Actually, since only powerpc has irq_of_parse_and_map, I'm now
> > inclined to think that drivers/of/i2c.c should live under arch/powerpc
> > for now, or at the least its option should depend on PPC_OF.
> 
> I specifically asked for this to not be PPC only so that I
> can make use of this infrastructure on sparc64 for I2C devices.

OK.

> It's OK if this breaks the sparc64 allmodconfig build, I'll take
> care of this once it's merged in.

It breaks the sparc32 allmodconfig build, which seems to be a
concern.  How do you suggest we fix that?

> Please merge the PPC tree to Linus soon, so that I can merge
> in my sparc64 NUMA bits which depend upon the LMB changesets
> in the PPC tree.

Sure, it's just this sparc32 breakage which is holding me up.

Paul.
