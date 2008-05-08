Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AF90BDDEEB
	for <linuxppc-dev@ozlabs.org>; Thu,  8 May 2008 16:55:59 +1000 (EST)
Subject: RE: [PATCH] [POWERPC] Reintroduce O_SYNC flag to make DRAM non-cached.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Spence Nick <Nick.Spence@freescale.com>
In-Reply-To: <9E50B2A5FE44294CBF877745D9A4125F01D37125@az33exm24.fsl.freescale.net>
References: <1210224392246-git-send-email-nick.spence@freescale.com>
	<18466.38047.531381.157886@cargo.ozlabs.ibm.com>
	<9E50B2A5FE44294CBF877745D9A4125F01D37125@az33exm24.fsl.freescale.net>
Content-Type: text/plain
Date: Thu, 08 May 2008 16:55:43 +1000
Message-Id: <1210229743.1421.36.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 2008-05-07 at 23:31 -0700, Spence Nick wrote:
> 
> In our case the memory area is reserved so that the main processor will
> not touch it except when mapped by the mem driver.

Then you should completely carve it out of the LMB's which will ensure
it's not seen as RAM by /dev/mem and not mapped by the linear mapping
(well, the later depends ... if it's carved out of the top of RAM it
should work fine, if it's a hole, I'm not sure we handle holes in the
linear mapping on 32 bits).

> Alternative solutions are to modify the user space code to flush out the
> caches by reading a large area, or to implement a board specific 
> ppc_md.phys_mem_access_prot() function to do this.
> 
> Either of these will meet my needs, but this will leave the O_SYNC flag
> ignored on the PowerPC architecture in 2.6, but honored by Linux 2.4 and
> other architectures. Probably not a problem for most people.
