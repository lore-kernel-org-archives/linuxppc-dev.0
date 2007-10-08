Return-Path: <jonsmirl@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.179])
	by ozlabs.org (Postfix) with ESMTP id 161C9DDEEC
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  9 Oct 2007 02:46:04 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so1815368wag
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 08 Oct 2007 09:46:03 -0700 (PDT)
Message-ID: <9e4733910710080946s75b826d7rb87bf2acb423f337@mail.gmail.com>
Date: Mon, 8 Oct 2007 12:46:03 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Sascha Hauer" <s.hauer@pengutronix.de>
Subject: Re: [RFC PATCH v0.1] net driver: mpc52xx fec
In-Reply-To: <20071008090135.GB11231@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20070810095153.GC13994@moe.telargo.com>
	<9e4733910709271112y100e55e8q100336ce95acaf3f@mail.gmail.com>
	<46FBF9B7.9010007@freescale.com>
	<200709281112.18480.jbe@pengutronix.de>
	<20071008090135.GB11231@pengutronix.de>
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

On 10/8/07, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> While the previous patch I sent fixed the reset path for the fec
> controller this patch makes sure the chip does not have to be resetted.
> Problem was that we ran out of receive buffers when we nmapped our
> board (nmap sends lots of small packages in a short period of time).
> By increasing the number of rx buffers this problem does not appear
> anymore.
> This patch produces a significant memory overhead to the driver of about
> 340k, so we might want to have this configurable as a module parameter.
> Let me know what the preferred way is, I can update the patch
> accordingly.

Is nmap sending UPD packets, why does the chip need to receive
everything without dropping packets? It we do get into receive
overrun, is everything recovering correctly?

As another test you could slow everything down by forcing the net to 10Mb.

It may be interesting to explore why the small packets aren't being
processed fast enough, there could be other bugs lurking.

-- 
Jon Smirl
jonsmirl@gmail.com
