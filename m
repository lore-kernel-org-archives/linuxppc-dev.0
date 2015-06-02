Return-Path: <nikunj@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A8B5E1A0015
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jun 2015 19:48:58 +1000 (AEST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nikunj@linux.vnet.ibm.com>;
 Tue, 2 Jun 2015 19:48:56 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 7F61A2BB0047
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jun 2015 19:48:54 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t529mifu66388096
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Jun 2015 19:48:53 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t529mLxs027904
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Jun 2015 19:48:21 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
To: Dinar valeev <k0da@opensuse.org>, linuxppc-dev@lists.ozlabs.org,
 "Thomas Huth" <thuth@redhat.com>
Cc: Dinar Valeev <dvaleev@suse.com>
Subject: Re: [PATCH] Fix function keys sequence on USB
In-Reply-To: <1432906201-25009-1-git-send-email-k0da@opensuse.org>
References: <1432906201-25009-1-git-send-email-k0da@opensuse.org>
Date: Tue, 02 Jun 2015 15:17:53 +0530
Message-ID: <87iob6jvau.fsf@linux.vnet.ibm.com>
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

Tested fine.

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

Does F10 work for you? doesn't work for me ?

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

Looking at accept.fs - handle-ESC-5b ...

: handle-ESC-5b
   key
   dup 31 = IF \ HOME
      key drop ( drops closing 7e ) handle-^A
   ELSE
      dup 33 = IF \ DEL
         key drop handle-^D
      ELSE
         dup 34 = IF \ END
            key drop handle-^E
         ELSE
            dup 1f and handle-CSI
         THEN
      THEN
   THEN drop
;


... following change is sufficient:
-					write_key(0x32);
+					write_key(0x31);


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

Right.

>  					write_key(0x7e);
>  					break;
>  
>  				case 0x4d:
>  					write_key(0x1b);	       /* END */
>  					write_key(0x5b);
> -					write_key(0x35);
> -					write_key(0x7e);
> +					write_key(0x46);

I tried using: 0x34, but somehow it does not work.

Regards
Nikunj
