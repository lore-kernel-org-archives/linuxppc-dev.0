Subject: Re: Keyboard broken on iBook - linuxppc-2.5 latest
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: cliff white <cliffw@osdl.org>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20031006132423.3bd10bc9.cliffw@osdl.org>
References: <20031006125829.58943956.cliffw@osdl.org>
	 <1065471191.30751.0.camel@gaston> <20031006132423.3bd10bc9.cliffw@osdl.org>
Content-Type: text/plain
Message-Id: <1065472048.30835.3.camel@gaston>
Mime-Version: 1.0
Date: Mon, 06 Oct 2003 22:27:28 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 2003-10-06 at 22:24, cliff white wrote:

> Thanks, much appreciated. If you'd like some more testing before that,
> please point me to bits, would be grateful.

Patch from Brice Figureau earlier on this list:


     From:
Brice
Figureau
<brice@tincell.com>
       To:
cliff white
<cliffw@osdl.org>
       Cc:
linuxppc-dev@lists.linuxppc.org, linux-kernel@vger.kernel.org
  Subject:
[PATCH]
macintosh/adbhid.c REP_DELAY fix (was Re: 2.6.0-test5 - stuck keys on iBook)
     Date:
Fri, 03 Oct
2003
09:40:22
+0200


Hi Cliff,

On Tue, 2003-09-30 at 23:31, cliff white wrote:
> Kernel version: latest from ppc.bkbits.net/linuxppc-2.5
>
> Symptom: keyboard diarrhea - single keypress == 3-7 characters.

Here is a patch that fixes the keyboard problem. The input layer
REP_DELAY (and REP_PERIOD) were changed from jiffies to ms but the adb
was not updated accordingly.

I hope this will help you.

Brice

--- drivers/macintosh/adbhid.c.orig     2003-10-02 22:39:31.112571794
+0200
+++ drivers/macintosh/adbhid.c  2003-10-02 22:40:22.888120863 +0200
@@ -611,8 +611,8 @@
                /* HACK WARNING!! This should go away as soon there is
an utility
                 * to control that for event devices.
                 */
-               adbhid[id]->input.rep[REP_DELAY] = HZ/2;   /* input
layer default: HZ/4 */
-               adbhid[id]->input.rep[REP_PERIOD] = HZ/15; /* input
layer default: HZ/33 */
+               adbhid[id]->input.rep[REP_DELAY] = 500;   /* input layer
default: 250 */
+               adbhid[id]->input.rep[REP_PERIOD] = 66;   /* input layer
default:  33 */
        }
 }


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
