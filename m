Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1outboundpool.messaging.microsoft.com [216.32.181.182])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9D9E2B6F2B
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  7 Apr 2011 04:49:04 +1000 (EST)
Date: Wed, 6 Apr 2011 13:47:50 -0500
From: Scott Wood <scottwood@freescale.com>
To: Barry G <mr.scada@gmail.com>
Subject: Re: Combining multiple NAND MTDs
Message-ID: <20110406134750.489e2ba6@schlenkerla.am.freescale.net>
In-Reply-To: <BANLkTim=oxHcW-HV5Z062r2p2D1nTL8mcQ@mail.gmail.com>
References: <BANLkTim=oxHcW-HV5Z062r2p2D1nTL8mcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 5 Apr 2011 16:35:10 -0700
Barry G <mr.scada@gmail.com> wrote:

> I want to run UBIFS on the combined 2 gigs of flash.  Whats the best
> way to do this?
> 
> I tried using the mtdconcat stuff and wrote a small driver
> but I am not sure how to populate the mtd_info structure since do_probe_map
> doesn't work with NAND AFAIK.
> 
> I see that fsl_elbc_select_chip says "hardware does not seem to support this".
> Not sure if this is related.

It's not related -- it's talking about a single physical chip with
multiple chip selects, not a logical concatenation of multiple separate
devices.

> I see some comments in mtd-physmap.txt about using multiple reg ranges?
> Does this work with NAND?

No.

I don't know of an out-of-the-box configuration step you can take to do
mtdconcat of eLBC NAND, but you could try creating a custom map driver that
glues things together as you wish.  Or if you want to be more ambitious,
perhaps a kernel command line (or other dynamic config) option that lets you
glue arbitrary MTD devices together.

-Scott
