Return-Path: <paulus@ozlabs.org>
Date: Wed, 1 Sep 2010 18:02:14 +1000
From: Paul Mackerras <paulus@samba.org>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: [PATCH] powerpc: mtmsrd not defined
Message-ID: <20100901080214.GA4722@brick.ozlabs.ibm.com>
References: <20100822180958.6305f5b1@lappy.seanm.ca>
	<1282516494.22370.440.camel@pasglop>
	<20100822184844.37c30d5e@lappy.seanm.ca>
	<D9007E15-F764-450D-9B20-6506F0051BA7@kernel.crashing.org>
	<20100831134605.1fca5fdf@lappy.seanm.ca>
	<20100831225525.1c9bd5a8@lappy.seanm.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100831225525.1c9bd5a8@lappy.seanm.ca>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 31, 2010 at 10:55:25PM -0400, Sean MacLennan wrote:

> I had to give up. Without the CONFIG_PPC_FPU it compiles fine for an
> FPU less 44x. But with the CONFIG_PPC_FPU, I get the following errors:

Ah, those references would be from arch/powerpc/lib/sstep.c.  Evidently
we need #ifdef CONFIG_PPC_FPU around the emulation of the floating-point
loads and stores.

Do we do any in-kernel emulation of floating-point operations with
CONFIG_PPC_FPU turned off?

Paul.
