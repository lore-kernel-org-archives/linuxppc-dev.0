In-Reply-To: <Pine.HPX.4.10.10003151038290.3396-100000@gra-ux1.iram.es>
Date: Wed, 15 Mar 2000 12:31:50 +0100
To: Gabriel Paubert <paubert@iram.es>, linux-fbdev@vuser.vu.union.edu,
        linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: [linux-fbdev] [PATCH 2.3.x] fbdev reversion
Message-Id: <20000315123150.025617@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Mar 15, 2000, Gabriel Paubert <paubert@iram.es> wrote:

>> #define _IO_BASE       0
>>
>> breaks CHRP and PReP boxes that use plain ISA drivers (inb() and friends).
>
>Indeed, but that's unavoidable. Except that the breakage has to wait for
>2.5 to be acceptable. Given the choice I prefer to break this and properly
>use resources even for drivers which believe that they have to use fixed
>addresses assigned by God, or rather the devil given the mess that the PC
>`architecture' is.

Well, we need a fix _now_ (that I will backport to 2.2.x as soon as
possible too), at least for PowerMacs. The problem of ISA drivers with
legacy hard-coded addresses is indeed a real one, but it can be
temporarily worked around by having the kernel maintaing a separate
mapping of the "old" IO base to the legacy ISA bus if one exist.

We have, I think, no legacy code using /proc/bus/pci, do we ? If I'm
right, then we can chance it to return physical addresses without
breaking anyone so at least we have a temporary fix for XFree. We must
get the kernel<->userland interface right asap so that we don't need to
change XFree again and again.

I'll play a bit with Michel patches next week-end. Unfortunately, I can't
test much on 2.3.x until the OHCI driver is fixed.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
