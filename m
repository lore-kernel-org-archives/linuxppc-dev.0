Return-Path: <thuth@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EFAC51A06F9
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Sep 2015 00:13:20 +1000 (AEST)
Subject: Re: [PATCH] Fix function keys sequence on USB
To: Dinar valeev <k0da@opensuse.org>, linuxppc-dev@lists.ozlabs.org,
 Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
References: <1432906201-25009-1-git-send-email-k0da@opensuse.org>
Cc: Dinar Valeev <dvaleev@suse.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <55E5B27A.8020306@redhat.com>
Date: Tue, 1 Sep 2015 16:13:14 +0200
MIME-Version: 1.0
In-Reply-To: <1432906201-25009-1-git-send-email-k0da@opensuse.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


 Hi!

May I ask what's the status of this patch? As far as I can see, it has
not been included in the repository yet?

On 29/05/15 15:30, Dinar valeev wrote:
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
...
> @@ -278,7 +274,7 @@ static void check_key_code(uint8_t *buf)
>  				case 0x45:
>  					write_key(0x1b);	       /* F12 */
>  					write_key(0x5b);
> -					write_key(0x31);
> +					write_key(0x32);
>  					write_key(0x34);
>  					write_key(0x7e);
>  					break;

... I'm especially interested in this hunk here. One of our testers ran
into the problem that you can not enter the boot menu when using USB
keyboard (and starting QEMU with "-boot menu=on"), and I think this is
related to this hunk.

Looking at "f12-pressed?" in slof/fs/start-up.fs you can also easily see
that the menu code expects a "32" instead of "31" here, and Dinar's
patch fixes this issue!

 Thomas
