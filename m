Subject: Re: Move 405LP RTC support from beech.c into ibm405lp.c
From: Hollis Blanchard <hollis@austin.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: embedded list <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <20021212035459.GF4631@zax.zax>
References: <20021212035459.GF4631@zax.zax>
Date: 12 Dec 2002 10:17:44 -0600
Message-Id: <1039709875.3537.20.camel@granite.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 2002-12-11 at 21:54, David Gibson wrote:
>
> The RTC support (written by Todd Poynor) for the Beech is actually in
> the 405LP chip itself, not just on the Beech board.
<snip>

As a separate patch (either before or after your move), I'd like to see
the following patch committed. The current "reset" code doesn't follow
the sequence described in the manual, and doesn't really reset the chip.
Until I added this code, the RTC usually would simply not advance. I've
tested this thoroughly on Beech (405LP 1.1).

Also, the comment makes me curious - why rely on the BIOS to set the
right input frequency? It's just one more line of code here (and a
#define or two for the various boards).

===== beech.c 1.8 vs edited =====
--- 1.8/arch/ppc/platforms/beech.c      Mon Nov 11 11:57:56 2002
+++ edited/beech.c      Thu Dec 12 10:05:01 2002
@@ -280,10 +280,15 @@

                /* Reset the core and ensure it's enabled.  We assume
                   only that the BIOS has set the correct frequency. */
-
-               mtdcr(DCRN_RTC0_WRAP, 0);
+
+               mtdcr(DCRN_RTC0_WRAP, 0);               /* toggle NRST & NMR */
                mtdcr(DCRN_RTC0_WRAP, 3);
-               mtdcr(DCRN_RTC0_CR1, mfdcr(DCRN_RTC0_CR1) & 0x7f);
+               mtdcr(DCRN_RTC0_CR0, 0x60);             /* No divider chain, No
square wave */
+               mtdcr(DCRN_RTC0_CR1, 0x80);             /* Disable update cycles
/interrupts*/
+               mtdcr(DCRN_RTC0_WRAP, 0);               /* toggle NRST & NMR */
+               mtdcr(DCRN_RTC0_WRAP, 3);
+               mtdcr(DCRN_RTC0_CR1, mfdcr(DCRN_RTC0_CR1) & 0x7f); /* allow upda
tes */
+
                not_initialized = 0;
        }



-Hollis
--
PowerPC Linux
IBM Linux Technology Center

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
