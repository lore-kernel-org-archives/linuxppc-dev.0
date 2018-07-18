Return-Path: <geoff@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41WBtN3WrCzDqBx
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jul 2018 08:40:12 +1000 (AEST)
Subject: Re: Improvements for the PS3
To: Fredrik Noring <noring@nocrew.org>, linuxppc-dev@lists.ozlabs.org,
 Geert Uytterhoeven <geert@linux-m68k.org>
References: <20180714164906.GQ23412@localhost.localdomain>
From: Geoff Levand <geoff@infradead.org>
Message-ID: <7d6362d7-da99-e57f-40ed-81c7a03ea1a4@infradead.org>
Date: Wed, 18 Jul 2018 15:40:05 -0700
MIME-Version: 1.0
In-Reply-To: <20180714164906.GQ23412@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Fredrik,

On 07/14/2018 09:49 AM, Fredrik Noring wrote:
> so I added a sleep with
> 
> +	msleep(10000);
> +
>  	return 0;
> 
> et voilà, the screen came alive and the kernel panic was revealed! It seems
> the kernel panics so fast that the PS3 frame buffer is unprepared. This is,
> of course, very unfortunate because trying to debug the boot process without
> a screen or any other means of obtaining console text is quite difficult.

We could add a fixed delay there, but I'd like to avoid waiting that
long on every boot.  Why don't you add a kernel module_param named
something like ps3fb_delay that takes a value in milliseconds and a
default of zero.  See:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/video/fbdev/ps3fb.c?h=v4.17#n260

> I suppose the problem is that it relies on interrupts for ps3fb_sync_image
> to regularly copy the image, hence without them the screen isn't updated to
> show kernel panics, etc. Perhaps one way to fix that is to implement the
> struct fb_tile_ops API, so that the console is synchronously updated? Would
> that be acceptable?

I'm not sure if that would work or not.   Maybe Geert is more familiar with it.

-Geoff
