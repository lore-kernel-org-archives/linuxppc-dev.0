Return-Path: <nikunj@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1ECA41A04C7
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Jul 2015 18:00:02 +1000 (AEST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nikunj@linux.vnet.ibm.com>;
 Mon, 6 Jul 2015 13:29:59 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 443A0E0133
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Jul 2015 13:32:06 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t667w92r44695610
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Jul 2015 13:28:12 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t666lK3n010243
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Jul 2015 12:17:20 +0530
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
To: Dinar valeev <k0da@opensuse.org>, linuxppc-dev@lists.ozlabs.org
Cc: Dinar Valeev <dvaleev@suse.com>
Subject: Re: [PATCH] Fix function keys sequence on USB
In-Reply-To: <1432906201-25009-1-git-send-email-k0da@opensuse.org>
References: <1432906201-25009-1-git-send-email-k0da@opensuse.org>
Date: Mon, 06 Jul 2015 13:28:07 +0530
Message-ID: <873811ra40.fsf@linux.vnet.ibm.com>
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
> Original issue is home and end keys are not functional in grub2.
> Later I've found other inconsistencies in f1-f12 keys.
>
> "Correct sequence" was crabbed by pressing key on cat running in
> xterm.
>
> Tested with Home, End, F2, Del and F10 keys in grub2

Few observations with more testing:

* In console mode F2 and F10 both are interpreted as ESC.
* In VNC F2 works fine F10 does not.

I would suggest to drop the "Fn" related changes and resend this patch
with END/HOME. As Ctrl-c and Ctrl-x both works as expected in the grub
edit mode.

>
> Signed-off-by: Dinar Valeev <dvaleev@suse.com>
> ---
>  lib/libusb/usb-hid.c | 40 +++++++++++++++++-----------------------
>  1 file changed, 17 insertions(+), 23 deletions(-)
>
> diff --git a/lib/libusb/usb-hid.c b/lib/libusb/usb-hid.c
> index f0cab8a..ccd5ba9 100644
> --- a/lib/libusb/usb-hid.c
> +++ b/lib/libusb/usb-hid.c
> @@ -190,33 +190,29 @@ static void check_key_code(uint8_t *buf)
>  				case 0x3a:	                        /* F1 */
>  					write_key(0x1b);
>  					write_key(0x5b);
> -					write_key(0x31);
> -					write_key(0x31);
> -					write_key(0x7e);
> +					write_key(0x4f);
> +					write_key(0x50);
>  					break;
>  
>  				case 0x3b:		                /* F2 */
>  					write_key(0x1b);
>  					write_key(0x5b);
> -					write_key(0x31);
> -					write_key(0x32);
> -					write_key(0x7e);
> +					write_key(0x4f);
> +					write_key(0x51);
>  					break;
>  
>  				case 0x3c:
>  					write_key(0x1b);               /* F3 */
>  					write_key(0x5b);
> -					write_key(0x31);
> -					write_key(0x33);
> -					write_key(0x7e);
> +					write_key(0x4f);
> +					write_key(0x52);
>  					break;
>  
>  				case 0x3d:
>  					write_key(0x1b);		/* F4 */
>  					write_key(0x5b);
> -					write_key(0x31);
> -					write_key(0x34);
> -					write_key(0x7e);
> +					write_key(0x4f);
> +					write_key(0x53);
>  					break;
>  
>  				case 0x3e:
> @@ -254,7 +250,7 @@ static void check_key_code(uint8_t *buf)
>  				case 0x42:
>  					write_key(0x1b);		/* F9 */
>  					write_key(0x5b);
> -					write_key(0x31);
> +					write_key(0x32);
>  					write_key(0x30);
>  					write_key(0x7e);
>  					break;
> @@ -262,7 +258,7 @@ static void check_key_code(uint8_t *buf)
>  				case 0x43:
>  					write_key(0x1b);	       /* F10 */
>  					write_key(0x5b);
> -					write_key(0x31);
> +					write_key(0x32);
>  					write_key(0x31);
>  					write_key(0x7e);
>  					break;
> @@ -270,7 +266,7 @@ static void check_key_code(uint8_t *buf)
>  				case 0x44:
>  					write_key(0x1b);	       /* F11 */
>  					write_key(0x5b);
> -					write_key(0x31);
> +					write_key(0x32);
>  					write_key(0x33);
>  					write_key(0x7e);
>  					break;
> @@ -278,7 +274,7 @@ static void check_key_code(uint8_t *buf)
>  				case 0x45:
>  					write_key(0x1b);	       /* F12 */
>  					write_key(0x5b);
> -					write_key(0x31);
> +					write_key(0x32);
>  					write_key(0x34);
>  					write_key(0x7e);
>  					break;
> @@ -290,36 +286,34 @@ static void check_key_code(uint8_t *buf)
>  				case 0x49:
>  					write_key(0x1b);	       /* INS */
>  					write_key(0x5b);
> -					write_key(0x31);
> +					write_key(0x32);
>  					write_key(0x7e);
>  					break;
>  
>  				case 0x4a:
>  					write_key(0x1b);	      /* HOME */
>  					write_key(0x5b);
> -					write_key(0x32);
> -					write_key(0x7e);
> +					write_key(0x48);
>  					break;
>  
>  				case 0x4b:
>  					write_key(0x1b);	      /* PgUp */
>  					write_key(0x5b);
> -					write_key(0x33);
> +					write_key(0x35);
>  					write_key(0x7e);
>  					break;
>  
>  				case 0x4c:
>  					write_key(0x1b);	       /* DEL */
>  					write_key(0x5b);
> -					write_key(0x34);
> +					write_key(0x33);
>  					write_key(0x7e);
>  					break;
>  
>  				case 0x4d:
>  					write_key(0x1b);	       /* END */
>  					write_key(0x5b);
> -					write_key(0x35);
> -					write_key(0x7e);
> +					write_key(0x46);
>  					break;
>  
>  				case 0x4e:
> -- 
> 2.1.4
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
