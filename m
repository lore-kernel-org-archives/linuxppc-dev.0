Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net
	[151.189.21.42])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4B951DDEA0
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Jun 2007 19:27:59 +1000 (EST)
In-Reply-To: <20070606070115.GW15955@bakeyournoodle.com>
References: <20070606070115.GW15955@bakeyournoodle.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1b1703feac8f12e20b917f48e2847475@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Create a dummy zImage if no valid platform has been
	selected.
Date: Wed, 6 Jun 2007 11:27:53 +0200
To: tony@bakeyournoodle.com (Tony Breeds)
Cc: LinuxPPC-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +$(obj)/zImage.strip: vmlinux
> +	$(STRIP) -s -R .comment $< -o $@

Bad name, you are not creating a stripped zImage, but
a stripped vmlinux.

> +# If we don't have a platform selected then just strip the vmlinux.

Why do anything at all when no platform is selected?

> +ifeq ("$(image-y)", "")

No quotes needed, standard style is

ifeq (,$(image-y))

> +image-y := zImage.strip
> +endif
> +
>  $(obj)/zImage:		$(addprefix $(obj)/, $(image-y))
>  	@rm -f $@; ln $< $@

Perhaps the minimal change (this is a degenerated case
anyway) would be to make this command non-failing?  Or
maybe that's not desired for "normal" builds?  Hard to
see how it ever could go wrong then, but that's wishful
thinking.  Maybe  ln -sf  would be best, it would just
create a dangling softlink in the allno case (and remove
the need for the rm command, too).

What do y'all think?


Segher
