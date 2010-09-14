Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from www.etchedpixels.co.uk (earthlight.etchedpixels.co.uk
	[81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 09425B6F10
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Sep 2010 05:44:23 +1000 (EST)
Date: Tue, 14 Sep 2010 20:44:10 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] hvc_console: fix dropping of characters when output
	byte channel is full
Message-ID: <20100914204410.71942cdc@lxorguk.ukuu.org.uk>
In-Reply-To: <20100914121721.c8671ed8.akpm@linux-foundation.org>
References: <1282329921-24394-1-git-send-email-timur@freescale.com>
	<20100914121721.c8671ed8.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: kumar.gala@freescale.com, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, amit.shah@redhat.com,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Yes, hvc_push() reschedules.  It doesn't sit in a tight loop burning
> electrons!
> 
> Can we do something safer&smarter here?


Its a printk handler - better to lose the bytes than hang the box. I
think the current code is probably right.
