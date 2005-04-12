Return-Path: <benh@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@freescale.com>
In-Reply-To: <Pine.LNX.4.61.0504111639330.10171@blarg.somerset.sps.mot.com>
References: <Pine.LNX.4.61.0504111639330.10171@blarg.somerset.sps.mot.com>
Content-Type: text/plain
Date: Tue, 12 Apr 2005 12:28:35 +1000
Message-Id: <1113272915.5388.37.camel@gaston>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Jason McMullan <jason.mcmullan@timesys.com>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] ppc32: refactor FPU exception handling
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2005-04-11 at 17:02 -0500, Kumar Gala wrote:
> Andrew,
> 
> Moved common FPU exception handling code out of head.S so it can be used 
> by several of the sub-architectures that might of a full PowerPC FPU.  
> 
> Also, uses new CONFIG_PPC_FPU define to fix alignment exception 
> handling for floating point load/store instructions to only occur if we 
> have a hardware FPU.
> 
> Signed-off-by: Jason McMullan <jason.mcmullan@timesys.com>
> Signed-off-by: Kumar Gala <kumar.gala@freescale.com>


Andrew, please hold on this patch, it hasn't been properly discussed
with the relevant maintainer, that is Paul Mackerras.

I can see matter for debate in there, like the whole duplication of the
fast exception return path...

It's also touching quite sensitive bits of kernel code (head.S) that
needs careful auditing and testing before beeing pushed upstream.

Ben.
