Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wm0-x244.google.com (mail-wm0-x244.google.com
 [IPv6:2a00:1450:400c:c09::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rSxw26kTBzDqb6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 01:46:26 +1000 (AEST)
Received: by mail-wm0-x244.google.com with SMTP id k184so15868151wme.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jun 2016 08:46:26 -0700 (PDT)
MIME-Version: 1.0
Sender: mathieu.malaterre@gmail.com
From: Mathieu Malaterre <malat@debian.org>
Date: Mon, 13 Jun 2016 17:46:00 +0200
Message-ID: <CA+7wUsxzwTkWKgRH5yG2rNawcJZYYFLaQP0aun8YUD5eoC1i-g@mail.gmail.com>
Subject: Rational for having CONFIG_FB_RADEON=m
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear all,

Debian decided to switch to using CONFIG_FB_RADEON=m (Mach64 and
Rage128 are still built-in). Since CONFIG_FB_OF=y and can never be a
module,  this means for PowerMac+radeon users that Open Firmware is
always the implementation taken from the Frame Buffer:

[    0.740726] Using unsupported 800x600 ATY,RockHopper2_A at
9c008000, depth=8, pitch=1024
[    0.750458] Console: switching to colour frame buffer device 100x37
[    0.759850] fb0: Open Firmware frame buffer device on
/pci@f0000000/ATY,RockHopper2Parent@10/ATY,RockHopper2_A@0

And:

$ cat /proc/fb
0 OFfb ATY,RockHo

Since also `radeonfb` is not capable of kicking out `offb` this means
I cannot `modprobe radeonfb`:

[   96.551486] radeonfb 0000:00:10.0: enabling device (0006 -> 0007)
[   96.551526] radeonfb 0000:00:10.0: BAR 0: can't reserve [mem
0x98000000-0x9fffffff pref]
[   96.551531] radeonfb (0000:00:10.0): cannot request region 0.
[   96.551545] radeonfb: probe of 0000:00:10.0 failed with error -16

So I have two options:

1. Try to convince debian-kernel team to switch back to
CONFIG_FB_RADEON=y (this will conflict with results from:
https://bugs.debian.org/614221)
2. Try to fix `radeonfb` so that it is able to kick offb out of the
way. Eg: https://lists.freedesktop.org/archives/dri-devel/2010-August/002907.html

>From my understanding it would make sense to go for (2), since it
would allow for proper support for CONFIG_FB_RADEON=m on PowerMac. In
this case, would such patch be accepted ?

Thanks
