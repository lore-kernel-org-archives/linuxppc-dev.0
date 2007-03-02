Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id F326FDDEFB
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  3 Mar 2007 05:57:08 +1100 (EST)
Date: Fri, 2 Mar 2007 12:57:02 -0600
From: Scott Wood <scottwood@freescale.com>
To: Domen Puncer <domen.puncer@telargo.com>
Subject: Re: [PATCH 7/7] lite5200b suspend: low-power mode
Message-ID: <20070302185702.GA2719@ld0162-tx32.am.freescale.net>
References: <20070301075323.GP4397@moe.telargo.com>
	<20070301080008.GH17184@moe.telargo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070301080008.GH17184@moe.telargo.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Mar 01, 2007 at 09:00:08AM +0100, Domen Puncer wrote:
> +static int lite5200_pm_enter(suspend_state_t state)
> +{
[snip]
> +	mbar = ioremap_nocache(0xf0000000, 0x8000);

You can't do ioremap with interrupts disabled (it will fail with spinlock
debugging enabled); the mapping should be set up at boot time.

-Scott
