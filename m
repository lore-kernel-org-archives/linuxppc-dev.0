From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: <mlan@cpu.lu>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Strange OF display while booting
Date: Sun, 19 Aug 2001 23:58:36 +0200
Message-Id: <20010819215836.31159@smtp.wanadoo.fr>
In-Reply-To: <200108190938.LAA00865@piglet.grunz.lu>
References: <200108190938.LAA00865@piglet.grunz.lu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>With recent BenH kernels, the early boot messages (before switching to
>aty128fb in my case) are messed up. The first few messages start in the
>middle of the top row, with some white areas to the left of the
>messages, then at the middle hight of the screen there's a white area
>spannig all the width, and below that the text messages are aligned
>correctly again to the left edge of the screen.
>
>FWIW, this was not the case with older kernels (2.4.5-pre3 comes to
>mind).
>
>Maybe somenody will know what changed...

That code have been hacked a bit by both paulus and me lately. Can
you try out my current rsync ?

There were several issue, including some miscalculation of the display
BAT, and some problems writing to some old machine framebuffer with
cache enabled. I moved out the bootx text from prom.c and now start
displaying things only in platform_init (where we have the display BAT
set to non-cachable).

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
