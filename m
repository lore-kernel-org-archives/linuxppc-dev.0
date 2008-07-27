Return-Path: <glikely@secretlab.ca>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.168])
	by ozlabs.org (Postfix) with ESMTP id 18227DDF1E
	for <linuxppc-dev@ozlabs.org>; Sun, 27 Jul 2008 14:04:48 +1000 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so4716513wfg.15
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jul 2008 21:04:48 -0700 (PDT)
Date: Sat, 26 Jul 2008 20:08:57 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Trent Piepho <tpiepho@freescale.com>
Subject: Re: [PATCH 1/2] leds: make the default trigger name const
Message-ID: <20080727020857.GM12191@secretlab.ca>
References: <Pine.LNX.4.64.0807181339500.10116@t2.domain.actdsltmp>
	<1217019705-24244-1-git-send-email-tpiepho@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1217019705-24244-1-git-send-email-tpiepho@freescale.com>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Richard Purdie <rpurdie@rpsys.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jul 25, 2008 at 02:01:44PM -0700, Trent Piepho wrote:
> The default_trigger fields of struct gpio_led and thus struct led_classdev
> are pretty much always assigned from a string literal, which means the
> string can't be modified.  Which is fine, since there is no reason to
> modify the string and in fact it never is.
> 
> But they should be marked const to prevent such code from being added, to
> prevent warnings if -Wwrite-strings is used and when assigned from a
> constant string other than a string literal (which produces a warning under
> current kernel compiler flags), and for general good coding practices.
> 
> Signed-off-by: Trent Piepho <tpiepho@freescale.com>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
> ---
>  include/linux/leds.h |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/leds.h b/include/linux/leds.h
> index 519df72..defe693 100644
> --- a/include/linux/leds.h
> +++ b/include/linux/leds.h
> @@ -48,7 +48,7 @@ struct led_classdev {
>  
>  	struct device		*dev;
>  	struct list_head	 node;			/* LED Device list */
> -	char			*default_trigger;	/* Trigger to use */
> +	const char		*default_trigger;	/* Trigger to use */
>  
>  #ifdef CONFIG_LEDS_TRIGGERS
>  	/* Protects the trigger data below */
> @@ -121,7 +121,7 @@ extern void ledtrig_ide_activity(void);
>  /* For the leds-gpio driver */
>  struct gpio_led {
>  	const char *name;
> -	char *default_trigger;
> +	const char *default_trigger;
>  	unsigned 	gpio;
>  	u8 		active_low;
>  };
> -- 
> 1.5.4.3
> 
