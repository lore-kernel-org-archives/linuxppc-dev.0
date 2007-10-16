Return-Path: <jfannin@gmail.com>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.186])
	by ozlabs.org (Postfix) with ESMTP id AF4DFDDEAB
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 04:17:01 +1000 (EST)
Received: by rv-out-0910.google.com with SMTP id c27so1368511rvf
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 11:17:00 -0700 (PDT)
Date: Tue, 16 Oct 2007 14:16:44 -0400
From: Joseph Fannin <jfannin@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: current -git adbhid.c build error
Message-ID: <20071016181644.GA9337@nineveh.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Commit b981d8b3f5e008ff10d993be633ad00564fc22cd in Linus's git tree
did this:


@@ -374,9 +373,9 @@ adbhid_input_keycode(int id, int scancode, int repeat)
 #endif /* CONFIG_PPC_PMAC */
        }

-       if (adbhid[id]->keycode[keycode]) {
-               input_report_key(adbhid[id]->input,
-                                adbhid[id]->keycode[keycode],
                                 adbhid[id]->!up_flag);
+       key = adbhid[id]->keycode[keycode];
+       if (key) {
+               input_report_key(adbhid[id]->input, key, !up_flag);
                input_sync(adbhid[id]->input);
        } else
                printk(KERN_INFO "Unhandled ADB key (scancode %#02x)
                %s.\n", keycode,

... but did not define "key":

drivers/macintosh/adbhid.c: In function ‘adbhid_input_keycode’:
drivers/macintosh/adbhid.c:376: error: ‘key’ undeclared (first use in this function)

Gitweb says something about a merge conflict in this file, so maybe
Linus did this, and not Dmitry?

I'll leave it up to someone else to decide how best this variable
should be defined.

--
Joseph Fannin
jfannin@gmail.com
