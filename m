Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18197.36181.369197.363642@cargo.ozlabs.ibm.com>
Date: Wed, 17 Oct 2007 14:19:33 +1000
From: Paul Mackerras <paulus@samba.org>
To: Joseph Fannin <jfannin@gmail.com>
Subject: Re: current -git adbhid.c build error
In-Reply-To: <20071016181644.GA9337@nineveh.local>
References: <20071016181644.GA9337@nineveh.local>
Cc: linuxppc-dev@ozlabs.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Joseph Fannin writes:

> Commit b981d8b3f5e008ff10d993be633ad00564fc22cd in Linus's git tree
> did this:
> 
> 
> @@ -374,9 +373,9 @@ adbhid_input_keycode(int id, int scancode, int repeat)
>  #endif /* CONFIG_PPC_PMAC */
>         }
> 
> -       if (adbhid[id]->keycode[keycode]) {
> -               input_report_key(adbhid[id]->input,
> -                                adbhid[id]->keycode[keycode],
>                                  adbhid[id]->!up_flag);
> +       key = adbhid[id]->keycode[keycode];
> +       if (key) {
> +               input_report_key(adbhid[id]->input, key, !up_flag);
>                 input_sync(adbhid[id]->input);
>         } else
>                 printk(KERN_INFO "Unhandled ADB key (scancode %#02x)
>                 %s.\n", keycode,
> 
> ... but did not define "key":

It was a mis-merge between 555ddbb4, which made that change and *did*
add the declaration of key, and 9a402b64, which deleted the line that
the declaration of key was added to.

We need the patch below.  Dmitry, will you push it or will I?

Paul.

[PATCH] Restore declaration of key in adbhid_input_keycode.

Merge commit b981d8b3f5e008ff10d993be633ad00564fc22cd lost the
declaration of `key' that 555ddbb4e2191c8823df2d61525218ac39481385
added, resulting in failure to compile.  This fixes it.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---

diff --git a/drivers/macintosh/adbhid.c b/drivers/macintosh/adbhid.c
index 8cce016..2766e4f 100644
--- a/drivers/macintosh/adbhid.c
+++ b/drivers/macintosh/adbhid.c
@@ -282,7 +282,7 @@ static void
 adbhid_input_keycode(int id, int scancode, int repeat)
 {
 	struct adbhid *ahid = adbhid[id];
-	int keycode, up_flag;
+	int keycode, up_flag, key;
 
 	keycode = scancode & 0x7f;
 	up_flag = scancode & 0x80;
