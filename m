Message-Id: <200007122119.WAA26666@hyperion.valhalla.net>
Date: Wed, 12 Jul 2000 22:15:24 +0100
Subject: 2.4.0-test3 dmasound - prob. found - solution ?
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: linuxppc-dev@lists.linuxppc.org
CC: Benjamin Herrenschmidt <bh40@calva.net>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Ben,

I've been through the (non-PB) init code very carefully and am convinced
that what was in dmasound.c in pre10-ben1 is also in the split code from
2.4.0-test3.

TODO - go through the PB stuff equally carefully (later).

I have found the problem with G3/desktop/AWACS rev.3.

2.4.0-test3 has conditionals before cuda interaction like:

if( sysctrlr != sysctril_cuda) ... don't do it...

2.2.17pre10 has:

if( adb_hardware != adb_viacuda) ... don't do it...

commenting out the conditional before the bit where output is switched on
brings the G3 to life...

The questions are:

what does this change reflect in the transition to 2.4.0?
which is correct (noting also that there are *three* possible ADB sources in
the configs)?

looking much better...
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
