Return-Path: <vojtech@suse.cz>
Received: from mail.suse.cz (styx.suse.cz [82.119.242.94])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A1616688D6
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jan 2006 18:47:34 +1100 (EST)
Date: Fri, 13 Jan 2006 08:47:49 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Michael Hanselmann <linux-kernel@hansmi.ch>
Subject: Re: [PATCH/RFC?] usb/input: Add support for fn key on Apple PowerBooks
Message-ID: <20060113074749.GA7103@midnight.suse.cz>
References: <20051225212041.GA6094@hansmi.ch>
	<1137022900.5138.66.camel@localhost.localdomain>
	<20060112000830.GB10142@hansmi.ch>
	<200601122312.05210.dtor_core@ameritech.net>
	<20060113065302.GA3458@hansmi.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060113065302.GA3458@hansmi.ch>
Cc: linux-kernel@killerfox.forkbomb.ch,
	Dmitry Torokhov <dtor_core@ameritech.net>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	linux-input@atrey.karlin.mff.cuni.cz
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jan 13, 2006 at 07:53:02AM +0100, Michael Hanselmann wrote:
 
> It indeed is. Fixed.

It gets better all the time. ;)

> New patch:
> 
> This patch implements support for the fn key on Apple PowerBooks using
> USB based keyboards.
> 
> Signed-off-by: Michael Hanselmann <linux-kernel@hansmi.ch>
> Acked-by: Rene Nussbaumer <linux-kernel@killerfox.forkbomb.ch>
> Acked-by: Johannes Berg <johannes@sipsolutions.net>
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> ---

> @@ -325,7 +459,27 @@ static void hidinput_configure_usage(str
>  
>  			set_bit(EV_REP, input->evbit);
>  			switch(usage->hid & HID_USAGE) {
> -				case 0x003: map_key_clear(KEY_FN);		break;
> +#ifdef CONFIG_USB_HIDINPUT_POWERBOOK
> +				/* The fn key on Apple PowerBooks */
> +				case 0x0003: {
> +					struct hidinput_key_translation *trans;
> +
> +					map_key_clear(KEY_FN);
> +
> +					set_bit(KEY_FN, input->keybit);

The set_bit(KEY_FN, input->keybit) is superfluous here, right?
map_key_clear(KEY_FN); will take care of that further down.

> +					set_bit(KEY_NUMLOCK, input->keybit);
> +
> +					/* Enable all needed keys */
> +					for(trans = powerbook_fn_keys; trans->from; trans++)
> +						set_bit(trans->to, input->keybit);
> +
> +					for(trans = powerbook_numlock_keys; trans->from; trans++)
> +						set_bit(trans->to, input->keybit);
> +
> +					goto ignore;
> +				}
> +#endif
> +
>  				default:    goto ignore;
>  			}
>  			break;

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
