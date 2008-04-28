Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E57DADE004
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2008 01:58:28 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m3SFwM3C008119
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Apr 2008 08:58:23 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id m3SFwMLW012340
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Apr 2008 10:58:22 -0500 (CDT)
Date: Mon, 28 Apr 2008 10:58:21 -0500
From: Scott Wood <scottwood@freescale.com>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 7/7] linkstation: implement standby
Message-ID: <20080428155821.GD9849@ld0162-tx32.am.freescale.net>
References: <Pine.LNX.4.64.0804281714000.7897@axis700.grange>
	<Pine.LNX.4.64.0804281732000.7897@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0804281732000.7897@axis700.grange>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, Pavel Machek <pavel@ucw.cz>,
	linux-pm@lists.linux-foundation.org,
	Johannes Berg <johannes@sipsolutions.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 28, 2008 at 05:40:19PM +0200, Guennadi Liakhovetski wrote:
> +static int ls_pm_enter(suspend_state_t state)
> +{
> +	u64 tb;
> +
> +	/* Get timebase */
> +	tb = get_tb();
> +
> +	/* put CPU to sleep, re-enabling interrupts */
> +	mpc6xx_enter_standby();
> +
> +	local_irq_disable();

Interrupts should not be enabled when you come out of
mpc6xx_enter_standby(); see the TLF_SLEEPING patch.

> +#define	MPC10X_LP_REF_EN	(1<<12)
> +#define	MPC10X_PM		(1<<7)
> +#define MPC10X_DOZE		(1<<5)
> +#define	MPC10X_NAP		(1<<4)
> +#define	MPC10X_SLEEP		(1<<3)

Mismatched whitespace (MPC10X_DOZE has a space before it; the others have
tabs).

-Scott
