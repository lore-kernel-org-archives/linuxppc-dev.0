Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E2957DDED4
	for <linuxppc-dev@ozlabs.org>; Thu,  8 May 2008 00:22:21 +1000 (EST)
Message-ID: <4821BB0E.80000@freescale.com>
Date: Wed, 07 May 2008 09:22:06 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: ALSA vs. non coherent DMA
References: <1210032508.21644.129.camel@pasglop> <s5hmyn3d7d5.wl%tiwai@suse.de>
In-Reply-To: <s5hmyn3d7d5.wl%tiwai@suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: alsa-devel@alsa-project.org,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Takashi Iwai wrote:

> This is a mmap of the data record to be shared in realtime with apps.
> The app updates its data pointer (appl_ptr) on the mmapped buffer
> while the driver updates the data (e.g. DMA position, called hwptr) on
> the fly on the mmapped record.  Due to its real-time nature, it has to
> be coherent -- at least, it was a problem on ARM.

This doesn't sound like a coherency problem to me, and least not one you'd find
on PowerPC.  Both the driver and the application run on the host CPU, so there
shouldn't be any coherency problem.  My understanding is that a "non coherent"
platform is one where the host CPU isn't aware when a *hardware device* writes
directly to memory, e.g. via DMA.

-- 
Timur Tabi
Linux kernel developer at Freescale
