Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from www.etchedpixels.co.uk (earthlight.etchedpixels.co.uk
	[81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CD17EB6EEF
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Sep 2010 05:31:44 +1000 (EST)
Date: Tue, 14 Sep 2010 20:52:46 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] hvc_console: fix dropping of characters when output
	byte channel is full
Message-ID: <20100914205246.0e35c9af@lxorguk.ukuu.org.uk>
In-Reply-To: <4C8FCC2E.1020107@freescale.com>
References: <1282329921-24394-1-git-send-email-timur@freescale.com>
	<20100914121721.c8671ed8.akpm@linux-foundation.org>
	<20100914204410.71942cdc@lxorguk.ukuu.org.uk>
	<4C8FCC2E.1020107@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: kumar.gala@freescale.com, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, amit.shah@redhat.com,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 14 Sep 2010 14:25:34 -0500
Timur Tabi <timur@freescale.com> wrote:

> Alan Cox wrote:
> > Its a printk handler - better to lose the bytes than hang the box. I
> > think the current code is probably right.
> 
> What do you think about this change:
> 
> http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-October/thread.html#76830
> 
> This is the original version of my patch.  In it, I simply allow drivers to
> return 0 to indicate that they're too busy to accept data.  It works great
> on the hvc driver that we have in-house today, but it might break other
> drivers that return 0 to indicate error.

If you want to make that change then I guess you need to audit every
other hvc driver first.

But I never understood the point of the hvc layer anyway 8)
