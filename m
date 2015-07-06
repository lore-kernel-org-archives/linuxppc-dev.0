Return-Path: <nikunj@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1D2001A0452
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Jul 2015 15:57:48 +1000 (AEST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nikunj@linux.vnet.ibm.com>;
 Mon, 6 Jul 2015 11:27:43 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 6C436125806D
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Jul 2015 11:30:23 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t665vWeO54394908
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Jul 2015 11:27:33 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t665vVll004741
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Jul 2015 11:27:31 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
To: Dinar valeev <k0da@opensuse.org>, linuxppc-dev@lists.ozlabs.org
Cc: Dinar Valeev <dvaleev@suse.com>
Subject: Re: [PATCH] Caps in not always shift
In-Reply-To: <1432893503-19197-1-git-send-email-k0da@opensuse.org>
References: <1432893503-19197-1-git-send-email-k0da@opensuse.org>
Date: Mon, 06 Jul 2015 11:27:31 +0530
Message-ID: <87d205rfp0.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dinar valeev <k0da@opensuse.org> writes:

> From: Dinar Valeev <dvaleev@suse.com>
>
> Caps behaves like shift only for latin characters.
> In case we're typing - for example with caps enabled, SLOF picks _ char
> from shifted table.
>
> Threat caps as shift only for letters.
>
> Signed-off-by: Dinar Valeev <dvaleev@suse.com>

Reviewed-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

> ---
>  lib/libusb/usb-hid.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/lib/libusb/usb-hid.c b/lib/libusb/usb-hid.c
> index f0cab8a..9e14cf5 100644
> --- a/lib/libusb/usb-hid.c
> +++ b/lib/libusb/usb-hid.c
> @@ -83,6 +83,8 @@ uint8_t set_leds;
>  const uint8_t *key_std       = NULL;
>  const uint8_t *key_std_shift = NULL;
>  
> +uint8_t ctrl; /* modifiers */
> +
>  /**
>   * read character from Keyboard-Buffer
>   *
> @@ -120,22 +122,27 @@ static void write_key(uint8_t key)
>  static void get_char(uint8_t ctrl, uint8_t keypos)
>  {
>  	uint8_t ch;
> +	int caps = 0;
> +//key position for latin letters
> +#define KEYP_LATIN_A 4
> +#define KEYP_LATIN_Z 29
>  
>  #ifdef KEY_DEBUG
>  	printf("pos %02X\n", keypos);
>  #endif
>  
>  	if (set_leds & LED_CAPS_LOCK)	                /* is CAPS Lock set ? */
> -		ctrl |= MODIFIER_SHIFT;	                    /* simulate shift */
> +		caps = 1;
>  
> -	if (ctrl == 0) {
> +	/* caps is a shift only for latin chars */
> +	if ((caps == 0 && ctrl == 0) || (caps == 1 && (keypos < KEYP_LATIN_A || keypos > KEYP_LATIN_Z))) {
>  		ch = key_std[keypos];
>  		if (ch != 0)
>  			write_key(ch);
>  		return;
>  	}
>  
> -	if (ctrl & MODIFIER_SHIFT) {
> +	if ((ctrl & MODIFIER_SHIFT) || caps == 1) {
>  		ch = key_std_shift[keypos];
>  		if (ch != 0)
>  			write_key(ch);
> @@ -187,6 +194,12 @@ static void check_key_code(uint8_t *buf)
>  					set_leds ^= LED_CAPS_LOCK;
>  					break;
>  
> +				case 0x36:		                /*Shift pressed*/
> +					ctrl |= MODIFIER_SHIFT;
> +					break;
> +				case 0xb6:		                /*Shift unpressed*/
> +					ctrl &= ~MODIFIER_SHIFT;
> +					break;
>  				case 0x3a:	                        /* F1 */
>  					write_key(0x1b);
>  					write_key(0x5b);
> -- 
> 2.1.4
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
