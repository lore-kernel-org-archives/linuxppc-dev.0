Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 51258DE2C2
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Apr 2008 04:44:51 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m3GIihA2010392
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 11:44:44 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m3GIih0p000557
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 13:44:43 -0500 (CDT)
Date: Wed, 16 Apr 2008 13:44:42 -0500
From: Scott Wood <scottwood@freescale.com>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 6/8] [POWERPC] sysdev,qe_lib: implement FSL GTM support
Message-ID: <20080416184442.GA12179@ld0162-tx32.am.freescale.net>
References: <20080311172106.GA4766@localhost.localdomain>
	<20080311172429.GF7727@localhost.localdomain>
	<20080318174329.GB4099@loki.buserror.net>
	<20080318192152.GA26493@localhost.localdomain>
	<47E01E22.9000807@freescale.com>
	<20080318202717.GA1030@localhost.localdomain>
	<47E02A8C.2080705@freescale.com>
	<20080416183904.GA23512@polina.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080416183904.GA23512@polina.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 16, 2008 at 10:39:04PM +0400, Anton Vorontsov wrote:
> +/**
> + * gtm_reset_utimer16 - reset 16 bits timer
> + * @tmr:	pointer to the gtm_timer structure obtained from gtm_get_timer
> + * @usec:	timer interval in microseconds
> + * @free_run:	free run flag
> + *
> + * This function (re)sets GTM timer so it counts up to the interval value and
> + * fires the interrupt when the value is reached. If free_run flag was set,
> + * timer will also reset itself upon reference value, otherwise it continues to
> + * increment.
> + */
> +int gtm_reset_utimer16(struct gtm_timer *tmr, u16 usec, bool free_run)

A maximal timeout of ~65 ms is a little low...  For use as a wakeup from
sleep mode, I'd like to be able to request timeouts as large as the
hardware allows.

-Scott
