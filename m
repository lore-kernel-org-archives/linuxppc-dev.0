Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3B934B7CE2
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Feb 2010 14:12:13 +1100 (EST)
Subject: Re: [PATCH 2/5] powerpc/head fsl: move the temp 4KiB mapping to TLB0
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1263573697-17839-3-git-send-email-linuxppc-dev@ml.breakpoint.cc>
Date: Wed, 17 Feb 2010 21:09:08 -0600
Message-Id: <4714F80D-5102-4C25-BA62-0034D775C63B@kernel.crashing.org>
References: <1263573697-17839-1-git-send-email-linuxppc-dev@ml.breakpoint.cc>
	<1263573697-17839-3-git-send-email-linuxppc-dev@ml.breakpoint.cc>
To: Sebastian Andrzej Siewior <linuxppc-dev@ml.breakpoint.cc>
Cc: linuxppc-dev@ozlabs.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jan 15, 2010, at 10:41 AM, Sebastian Andrzej Siewior wrote:

> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>=20
> Right now the setup code takes ESEL of the current mapping and puts =
the
> temporary into ESEL (old_ESEL & 1 ) + 1 which is either one or two.
> This is actually not required since all slots in TLB0 are invalid by =
now
> and can be used.
> This patch moved the temp mapping to TLB0, ESEL[0]. The invalidation =
of
> TLB0 does not care about IPPROT so that part can go as well.
> The benefit is that now the setup code may set every slot of TLB1 =
while
> before that it was not allowed to touch ESEL one or two depending on =
the
> old_ESEL.
>=20
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> arch/powerpc/kernel/head_fsl_booke.S |   20 +++++---------------
> 1 files changed, 5 insertions(+), 15 deletions(-)

this is problematic, we can't assume that TLB0 is safe.  It possible =
some other software is running on a second core and does a broadcast =
tlbivax which will wipe what's in TLB0.

- k=
