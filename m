Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id B6E2ADDE21
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Mar 2007 18:13:52 +1100 (EST)
Date: Thu, 08 Mar 2007 23:13:41 -0800 (PST)
Message-Id: <20070308.231341.41635421.davem@davemloft.net>
To: dwmw2@infradead.org
Subject: Re: [PATCH] [POWERPC] Wire up sys_sync_file_range
From: David Miller <davem@davemloft.net>
In-Reply-To: <1173423341.3461.548.camel@pmac.infradead.org>
References: <20070309152201.027c2bf5.sfr@canb.auug.org.au>
	<1173423341.3461.548.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linux-arch@vger.kernel.org, sfr@canb.auug.org.au, ralf@linux-mips.org,
	linuxppc-dev@ozlabs.org, paulus@samba.org, rmk@arm.linux.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: David Woodhouse <dwmw2@infradead.org>
Date: Fri, 09 Mar 2007 06:55:41 +0000

> On Fri, 2007-03-09 at 15:22 +1100, Stephen Rothwell wrote:
> > This requires an architecture specific compat routine as u64s are passed
> > in odd/even (high/low) register pairs on ppc32.
> > 
> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> 
> Doesn't that apply to ARM and to 32-bit MIPS too? And perhaps others?

Unfortunately in the MIPS case you'll have to do some ifdef'ing because
the order of the "high" and "low" sub-part arguments is dependant upon
endianness and MIPS can be both big and little endian.
