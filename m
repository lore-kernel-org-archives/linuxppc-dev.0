Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEF4606A31B
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Nov 2026 20:25:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jK0Sk58jSz2xSS;
	Wed, 04 Nov 2026 07:25:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:4190:8020::34"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793737542;
	cv=none; b=V+K2wdGXEIWpHaDKdhNPC1Y3z11yY4wwFtU8vr6UFK9w51dfMCClZrBiVD7EIwDP/9IUsDMjT4eTctd8uq23WO3ZB70WUzcLYm+nhn+SZDJdt43vPwTDTbqAJ65ZyWo8eAHoC5qzzIuyf+kYEjIujscMIN0ho21tEptGhFlP2jkOYxPcCrkM5bO8SPFDqIHdx+19OJl+p0RFl4sjpGEz5GMn+cfcv9L2Xu+nKzwKo+o3bZGvNnhvYOs6rWd54x7cr1PS8DsspryDWlTBxgt3E8vpsYAvrZU/Z5SvvRKe1bFmTk1nLR+T5HprDW9p9C278aEgJ6j76w81ws3zlbWI/A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793737542; c=relaxed/relaxed;
	bh=hywMFMGWC22FCsnfeYWHg5SybWSfpDHUd/LvoxS7oLY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=aAU4nntMBozbIwJFwtP3R52jG8i+gy7IdXouGKRAh2Vc/gFbaiugvBwu0dspRzjnCzSt+v/naXSLB8rg/S3ry+2vN95Wc8r8H/Fr04IctlORuA7XhkrTMe4pKjvADXgxfmh8Bx58g79iR32ZuqgJN7EOWudy+OiwtNjkfj9BHUF7fifSFtIuw8Q2uzYZcb6Y5kom/SHNinOFjZl7a9fVEyu/9RA56Kt4ek4OVQxrhWn+xklvb1g2bz5/0vc/uPcX/1uy5pxX3Z2Bu9AJEZ/LlHua0Kh9hR7Yns3rMl+ugL+MHleZWo7FNXdjKoBJFkagkQaLtVRKpc/E5cN8pA4MoA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none (client-ip=2001:4190:8020::34; helo=angie.orcam.me.uk; envelope-from=macro@orcam.me.uk; receiver=lists.ozlabs.org) smtp.mailfrom=orcam.me.uk
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=orcam.me.uk (client-ip=2001:4190:8020::34; helo=angie.orcam.me.uk; envelope-from=macro@orcam.me.uk; receiver=lists.ozlabs.org)
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jK0Sj3Zncz2xBK
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Nov 2026 07:25:39 +1100 (AEDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 38B0092009E; Tue,  3 Nov 2026 21:25:31 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 321B692009B;
	Tue,  3 Nov 2026 20:25:31 +0000 (GMT)
Date: Tue, 3 Nov 2026 20:25:31 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    James Hilliard <james.hilliard1@gmail.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, Raul E Rangel <rrangel@chromium.org>, 
    =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
    Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
    Tony Lindgren <tony@atomide.com>, 
    Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
    Richard Genoud <richard.genoud@bootlin.com>, 
    Nicolas Ferre <nicolas.ferre@microchip.com>, 
    Alexandre Belloni <alexandre.belloni@bootlin.com>, 
    Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
    Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
    =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
    Sascha Hauer <s.hauer@pengutronix.de>, 
    Pengutronix Kernel Team <kernel@pengutronix.de>, 
    Fabio Estevam <festevam@gmail.com>, Timur Tabi <timur@kernel.org>, 
    Peter Ujfalusi <peter.ujfalusi@ti.com>, 
    Vignesh Raghavendra <vigneshr@ti.com>, 
    Patrice Chotard <patrice.chotard@foss.st.com>, 
    linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
    linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
    linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v9 2/8] serial: serialize asynchronous write wakeups with
 the port lock
In-Reply-To: <auoUlkzXsl9WJG8B@ashevche-desk.local>
Message-ID: <alpine.DEB.2.21.2611031947260.15685@angie.orcam.me.uk>
References: <20261102-submit-serial-8250-dma-cancel-v1-v9-0-9159caade148@gmail.com> <20261102-submit-serial-8250-dma-cancel-v1-v9-2-9159caade148@gmail.com> <auoUlkzXsl9WJG8B@ashevche-desk.local>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 3 Nov 2026, Andy Shevchenko wrote:

> > +static unsigned long sccnxp_handle_events(struct sccnxp_port *s)
> >  {
> 
> > -	int i;
> > +	unsigned int i;
> 
> This change seems unrelated to the patch. Again, slow down and READ what AI
> produces before sending, please!

 Indeed.  FWIW I've thrown v8 at hardware I look after, that is:

 drivers/tty/serial/dz.c            |  9 ++--
 drivers/tty/serial/sb1250-duart.c  | 25 ++++++----
 drivers/tty/serial/zs.c            | 94 ++++++++++++++++++++++++++++----------
 drivers/tty/serial/zs.h            |  3 ++

and that has caused no observable regressions in my simple verification as 
direct terminal lines, both in the line mode and with ncurses.

 I have no leased-line modem hardware to put this under stress with all 
the signalling; I could see, and probably should, whether I can set up a 
SLIP connection with a direct serial link and see how it performs, but 
it'd take me more time than I can afford right now, especially as I'm 
locally short of one PSU for the systems in question that is waiting for 
parts to arrive for repair, and swapping the one working unit between 
systems is quite involving (ones in the lab won't run SLIP owing to the 
firmware limitation of the console servers they're wired to).

 But I didn't have a chance to reply before v9 has been posted with more 
updates, so I'll wait for things to settle before reviewing the changes in 
detail.

 Please consider this a NAK for the drivers listed above until the final 
version of the patch has been posted and I've had a chance to verify it.

  Maciej

