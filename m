Subject: IDMA: Setting Up Parameter RAM.
To: linuxppc-embedded@lists.linuxppc.org ( Linux PPC Mailing List)
Date: Thu, 25 May 2000 16:02:39 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000525060239.3F99C3C989@elph.research.canon.com.au>
From: gjohnson@research.canon.com.au (Greg Johnson)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

I am having a little problem with IDMA parameter RAM on the 855T/860.
The problem is that when I set up the parameter RAM's DMA Channel
Mode Register, and the IDMA BD Base Address pointer, the CPM does not
appear to recognise these new values. I am quite confident that I
am setting up the ports etc for our board correctly. I shall elaborate.

When I power on our board, boot, load our driver for the hardware,
setup the IDMA/Parameter RAM/Buffer Descriptors and attempt to start
an IDMA transfer,  nothing happens. (reloading driver and retries
do not work)

When I then hit the reset button (no power cycle) and go through the
same ritual, IDMA works fine.

The reason being is that values for the IDMA Parameter RAM DMA Channel
mode register (DCMR) and IDMA BD Base Address pointer (IBASE) that
were written in the first attempt on power-on are preserved in
DPRAM over the reboot. Why would these value apparently be written
in the first attempt, but appear not to be recognised by the CPM???

In addition, if I power on, and use the boot loader to program the
IDMA Parameter RAM DCMR and IBASE elements, then boot Linux, load
the driver and attempt a DMA operation, It all works fine. The
reason I don't want to be content with setting this information up
in the boot loader is that we want to be able to eventually allocate
and release buffer descriptors.

I suspect that I am not setting up something correctly that affects
the way that the Communications Processor responds to changes in the
Parameter RAM.

Can anyoue offer any clues/hints/guesses???

Thanks in advance.

Greg.

--
+------------------------------------------------------+
| Do you want to know more? www.geocities.com/worfsom/ |
|              ..ooOO Greg Johnson OOoo..              |
| HW/SW Engineer        gjohnson@research.canon.com.au |
| Canon Information Systems Research Australia (CISRA) |
| 1 Thomas Holt Dr., North Ryde, NSW, 2113,  Australia |
|      "I FLEXed my BISON and it went YACC!" - me.     |
+------------------------------------------------------+

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
