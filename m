Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-f53.google.com (mail-pa0-f53.google.com
 [209.85.220.53])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AEC191A004D
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 May 2015 20:00:08 +1000 (AEST)
Received: by pabru16 with SMTP id ru16so76849105pab.1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 May 2015 03:00:06 -0700 (PDT)
Message-ID: <55698A1E.6030205@ozlabs.ru>
Date: Sat, 30 May 2015 19:59:58 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Dinar valeev <k0da@opensuse.org>, linuxppc-dev@lists.ozlabs.org
CC: Dinar Valeev <dvaleev@suse.com>,
 Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH slof] Fix function keys sequence on USB
References: <1432906201-25009-1-git-send-email-k0da@opensuse.org>
In-Reply-To: <1432906201-25009-1-git-send-email-k0da@opensuse.org>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/29/2015 11:30 PM, Dinar valeev wrote:
> From: Dinar Valeev <dvaleev@suse.com>
>
> Original issue is home and end keys are not functional in grub2.

"home" works for in grub/ubuntu14 and grub2/fedora21. "end" does not but I 
am not sure that your patch will fix it,

> Later I've found other inconsistencies in f1-f12 keys.

The keys did not work in VGA or in stdio too?

By "stdio" I mean running QEMU like this:
-nographic -vga none -nodefaults \
-chardev stdio,id=id0,signal=off,mux=on \
-device spapr-vty,id=id1,chardev=id0,reg=0x71000100 \
-mon id=id2,chardev=id0,mode=readline

This is how I tried grub and keys, terminal type is "xterm". What do I miss?

> "Correct sequence" was crabbed by pressing key on cat running in
> xterm.

And the existing codes are for what type of term


> Tested with Home, End, F2, Del and F10 keys in grub2

Please add "slof" in the subject so everybody could know what this is 
about; and module/file name to tell what part it is touching. I did not 
notice the patch till I saw it on google+ ;) Like:

[PATCH slof] usb-hid: Fix function keys sequence on USB

Or/and put me or Nikunj in cc:


> Signed-off-by: Dinar Valeev <dvaleev@suse.com>
> ---
>   lib/libusb/usb-hid.c | 40 +++++++++++++++++-----------------------
>   1 file changed, 17 insertions(+), 23 deletions(-)
>
> diff --git a/lib/libusb/usb-hid.c b/lib/libusb/usb-hid.c
> index f0cab8a..ccd5ba9 100644
> --- a/lib/libusb/usb-hid.c
> +++ b/lib/libusb/usb-hid.c
> @@ -190,33 +190,29 @@ static void check_key_code(uint8_t *buf)
>   				case 0x3a:	                        /* F1 */
>   					write_key(0x1b);
>   					write_key(0x5b);
> -					write_key(0x31);
> -					write_key(0x31);
> -					write_key(0x7e);
> +					write_key(0x4f);
> +					write_key(0x50);
>   					break;
>
>   				case 0x3b:		                /* F2 */
>   					write_key(0x1b);
>   					write_key(0x5b);
> -					write_key(0x31);
> -					write_key(0x32);
> -					write_key(0x7e);
> +					write_key(0x4f);
> +					write_key(0x51);
>   					break;
>
>   				case 0x3c:
>   					write_key(0x1b);               /* F3 */
>   					write_key(0x5b);
> -					write_key(0x31);
> -					write_key(0x33);
> -					write_key(0x7e);
> +					write_key(0x4f);
> +					write_key(0x52);
>   					break;
>
>   				case 0x3d:
>   					write_key(0x1b);		/* F4 */
>   					write_key(0x5b);
> -					write_key(0x31);
> -					write_key(0x34);
> -					write_key(0x7e);
> +					write_key(0x4f);
> +					write_key(0x53);
>   					break;
>
>   				case 0x3e:
> @@ -254,7 +250,7 @@ static void check_key_code(uint8_t *buf)
>   				case 0x42:
>   					write_key(0x1b);		/* F9 */
>   					write_key(0x5b);
> -					write_key(0x31);
> +					write_key(0x32);
>   					write_key(0x30);
>   					write_key(0x7e);
>   					break;
> @@ -262,7 +258,7 @@ static void check_key_code(uint8_t *buf)
>   				case 0x43:
>   					write_key(0x1b);	       /* F10 */
>   					write_key(0x5b);
> -					write_key(0x31);
> +					write_key(0x32);
>   					write_key(0x31);
>   					write_key(0x7e);
>   					break;
> @@ -270,7 +266,7 @@ static void check_key_code(uint8_t *buf)
>   				case 0x44:
>   					write_key(0x1b);	       /* F11 */
>   					write_key(0x5b);
> -					write_key(0x31);
> +					write_key(0x32);
>   					write_key(0x33);
>   					write_key(0x7e);
>   					break;
> @@ -278,7 +274,7 @@ static void check_key_code(uint8_t *buf)
>   				case 0x45:
>   					write_key(0x1b);	       /* F12 */
>   					write_key(0x5b);
> -					write_key(0x31);
> +					write_key(0x32);
>   					write_key(0x34);
>   					write_key(0x7e);
>   					break;
> @@ -290,36 +286,34 @@ static void check_key_code(uint8_t *buf)
>   				case 0x49:
>   					write_key(0x1b);	       /* INS */
>   					write_key(0x5b);
> -					write_key(0x31);
> +					write_key(0x32);
>   					write_key(0x7e);
>   					break;
>
>   				case 0x4a:
>   					write_key(0x1b);	      /* HOME */
>   					write_key(0x5b);
> -					write_key(0x32);
> -					write_key(0x7e);
> +					write_key(0x48);
>   					break;
>
>   				case 0x4b:
>   					write_key(0x1b);	      /* PgUp */
>   					write_key(0x5b);
> -					write_key(0x33);
> +					write_key(0x35);
>   					write_key(0x7e);
>   					break;
>
>   				case 0x4c:
>   					write_key(0x1b);	       /* DEL */
>   					write_key(0x5b);
> -					write_key(0x34);
> +					write_key(0x33);
>   					write_key(0x7e);
>   					break;
>
>   				case 0x4d:
>   					write_key(0x1b);	       /* END */
>   					write_key(0x5b);
> -					write_key(0x35);
> -					write_key(0x7e);
> +					write_key(0x46);
>   					break;
>
>   				case 0x4e:
>


-- 
Alexey
