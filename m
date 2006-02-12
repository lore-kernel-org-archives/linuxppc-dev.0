Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 596A9679EA
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Feb 2006 09:36:54 +1100 (EST)
Subject: Re: [PPC,SOUND] Fix audio gpio state detection
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andreas Schwab <schwab@suse.de>
In-Reply-To: <jehd7527wq.fsf@sykes.suse.de>
References: <jehd7527wq.fsf@sykes.suse.de>
Content-Type: text/plain
Date: Mon, 13 Feb 2006 09:35:37 +1100
Message-Id: <1139783738.5247.54.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	Ben Collins <ben.collins@ubuntu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2006-02-11 at 17:10 +0100, Andreas Schwab wrote:
> When booting with line out or headphone plugged, you won't hear anything.
> The problem is that after reset all channels are muted, but the actual
> value of the gpio port doesn't exactly match the active_val settings as
> expected by check_audio_gpio.  For example, the line_mute port is set to
> 7, but check_audio_gpio would expect 0xd or 0xf, thus its return value
> indicates that it is not active, even though it is.  AFAICS only looking
> at the low bit is enough to determine whether the port is active.
> 
> Signed-off-by: Andreas Schwab <schwab@suse.de>
> 
> Index: linux-2.6.16-rc2/sound/ppc/tumbler.c
> ===================================================================
> --- linux-2.6.16-rc2.orig/sound/ppc/tumbler.c	2006-02-03 19:43:50.000000000 +0100
> +++ linux-2.6.16-rc2/sound/ppc/tumbler.c	2006-02-11 03:46:30.000000000 +0100
> @@ -207,7 +207,7 @@ static int check_audio_gpio(struct pmac_
>  
>  	ret = do_gpio_read(gp);
>  
> -	return (ret & 0xd) == (gp->active_val & 0xd);
> +	return (ret & 0x1) == (gp->active_val & 0x1);
>  }
>  
>  static int read_audio_gpio(struct pmac_gpio *gp)

Can you sync with the patches Ben Collins is doing on this as well ?

Ben, what is your status ? Are you feeding those through upstream the
alsa folks ? Or waiting for me to do something ? :)

The above, if it appear to works well enough might be worth merging
now ...

Ben.
