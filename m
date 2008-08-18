Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 60451DDED4
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 18 Aug 2008 20:49:49 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] MPC52XX: Don't touch pipelining for MPC5200B
Date: Mon, 18 Aug 2008 12:49:36 +0200
References: <20080818093132.GA4282@pengutronix.de>
In-Reply-To: <20080818093132.GA4282@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200808181249.37220.arnd@arndb.de>
Cc: Wolfram Sang <w.sang@pengutronix.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Monday 18 August 2008, Wolfram Sang wrote:
> MPC5200 needs to have pipelining disabled for ATA to work. MPC5200B does =
not.
> So, for the latter, don't touch the original setting from the bootloader.

> +#if defined(CONFIG_PPC_MPC5200_BUGFIX)
> =A0=A0=A0=A0=A0=A0=A0=A0/* Disable XLB pipelining

Please make this a run-time conditional instead of compile-time.
Your current patch is still broken if you want to have a common
kernel for MPC5200 and MPC5200B.

	Arnd <><
