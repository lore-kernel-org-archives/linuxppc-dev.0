Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao12.cox.net (fed1rmmtao12.cox.net [68.230.241.27])
	by ozlabs.org (Postfix) with ESMTP id 1C77D67A65
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Mar 2005 03:39:06 +1100 (EST)
Date: Mon, 21 Mar 2005 09:39:05 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Kumar Gala <galak@freescale.com>
Message-ID: <20050321163904.GT8345@smtp.west.cox.net>
References: <Pine.LNX.4.61.0503181818330.26408@blarg.somerset.sps.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.61.0503181818330.26408@blarg.somerset.sps.mot.com>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [RFC] ppc32: Report chip version in common /proc/cpuinfo
	handling
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Mar 18, 2005 at 06:26:52PM -0600, Kumar Gala wrote:

> 
> You asked me to look at doing the following.  I just want to make sure 
> this is what we want to do (and call it).  I'm a little concerned that 
> 'chip' is not necessary the right name in light of TSI10x and MV64x60 
> being described by ppc_sys in the future.

"chip" or "chip(set)" or anything else is fine with me (I'm horrible at
names).  But I don't like:

> +#if defined (CONFIG_85xx) || defined (CONFIG_83xx)
> +	if (cur_ppc_sys_spec->ppc_sys_name)
> +		seq_printf(m, "chip\t\t: %s\n", cur_ppc_sys_spec->ppc_sys_name);
> +#endif

ifdef'ing this.  If the field is set, we should print it.

-- 
Tom Rini
http://gate.crashing.org/~trini/
