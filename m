Date: Wed, 8 Mar 2000 15:19:46 +0100
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Booting 2.3.48 (devel) kernel problems?
Message-Id: <20000308151946.024345@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Mar 8, 2000, Michael Schmitz
<schmitz@opal.biophys.uni-duesseldorf.de> wrote:

>So the framebuffer got mapped from OF but not from BootX.

I think it worked with OF because we inherit from OF SDR1 and, by luck,
OF page tables are high enough in memory to not have been damaged by the
kernel. When booting via BootX, that's not the case.

We should not try to access the framebuffer from identify_machine() and
MMU_Init() unless it was mapped with a BAT in head.S (for debugging
purposes). In normal cases, it will get mapped via map_bootx_text called
from setup_arch() and can be used beyond that point.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
