Message-Id: <5.1.0.14.2.20030604074708.0210b928@falcon.si.com>
Date: Wed, 4 Jun 2003 08:04:34 -0400
To: linuxppc-embedded@lists.linuxppc.org
From: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
Subject: Re: Failsafe bootloader
In-Reply-To: <00048074.C22236@opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 12:16 PM 6/4/2003 -0400, damm@opensource.se wrote:

>On Tue, 3 Jun 2003 23:47:22 -0700
>Darin.Johnson@nokia.com wrote:

[snipped intro to miniboot]

>http://opensource.se/projects/miniboot/index.html
>
>However, the number of boards / processors supported are limited at the
>moment.
>I've also heard that uboot/ppcboot could be used to update itself, but I've
>never
>tested it myself.

[snip]

>/ magnus

Uploading a new bootrom (which u-boot can do) is quite easy.  The hard part
is protecting the hardware from the users. :-/  The critical part is the
erasing of the flash holding the bootrom image and programming the new
bootrom in WITHOUT LOSING POWER.  If an idiot user unplugs the board or a
truck hits a power pole at the instant when the old bootrom has been erased
and before the new bootrom has been programmed, you have a dead
board.  Bad.  Real bad.

You can minimize the window, but it is impossible to close it entirely
(using EEPROM, a power supply with a 10mSec hold up and a power fail
warning can close the window, but that isn't a common
configuration).  Depending on your flash, the window can be anywhere from
milliseconds to seconds (usually tens to hundreds of milliseconds).

Using a two-step boot process via miniboot as Magnus suggests allows you to
upgrade your "bootrom" without ever erasing your reset vector and lowest
level bootrom executable.  This _does_ prevent the above mentioned window
from ever opening, making it a safe(r) upgrade process.  In addition, if
you have two bootrom images, you will be able to upgrade the one with a
fallback if an idiot user unplugs your board.  You then upgrade the backup
once the primary has been programmed successfully.

Of course, this still doesn't protect you from loading a new bootrom that
has a valid checksum but a fatal problem (doh-doh-doh).  Fortunately, in
that case the idiot is ourselves and we deserve the pain involved, and
hopefully learn from it ;-).

gvb


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
