Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C221EB6F7A
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 22 Jun 2011 21:28:56 +1000 (EST)
Subject: Re: [PATCH] powerpc/e500: fix breakage with fsl_rio_mcheck_exception
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20110616190916.GA31367@schlenkerla.am.freescale.net>
Date: Wed, 22 Jun 2011 06:28:44 -0500
Message-Id: <F7376A37-E830-49DD-A614-749889D53517@kernel.crashing.org>
References: <20110616190916.GA31367@schlenkerla.am.freescale.net>
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jun 16, 2011, at 2:09 PM, Scott Wood wrote:

> The wrong MCSR bit was being used on e500mc.  MCSR_BUS_RBERR only exists
> on e500v1/v2.  Use MCSR_LD on e500mc, and remove all MCSR checking
> in fsl_rio_mcheck_exception as we now no longer call that function
> if the appropriate bit in MCSR is not set.
> 
> If RIO support was enabled at compile-time, but was never probed, just
> return from fsl_rio_mcheck_exception rather than dereference a NULL
> pointer.
> 
> TODO: There is still a remaining, though comparitively minor, issue in
> that this recovery mechanism will falsely engage if there's an unrelated
> MCSR_LD event at the same time as a RIO error.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
> arch/powerpc/kernel/traps.c   |    2 +-
> arch/powerpc/sysdev/fsl_rio.c |   33 +++++++++++++++++----------------
> 2 files changed, 18 insertions(+), 17 deletions(-)

applied to merge

- k
