Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18190.3365.54961.935346@cargo.ozlabs.ibm.com>
Date: Thu, 11 Oct 2007 21:46:45 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Make clockevents work on PPC601 processors
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In testing the new clocksource and clockevent code on a PPC601
processor, I discovered that the clockevent multiplier value for the
decrementer clockevent was overflowing.  Because the RTCL register in
the 601 effectively counts at 1GHz (it doesn't actually, but it
increases by 128 every 128ns), and the shift value was 32, that meant
the multiplier value had to be 2^32, which won't fit in an unsigned
long on 32-bit.  The same problem would arise on any platform where
the timebase frequency was 1GHz or more (not that we actually have any
such machines today).

This fixes it by reducing the shift value to 16.  Doing the
calculations with a resolution of 2^-16 nanoseconds (15 femtoseconds)
should be quite adequate.  :) 

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 64b503c..9368da3 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -108,7 +108,7 @@ static void decrementer_set_mode(enum clock_event_mode mode,
 static struct clock_event_device decrementer_clockevent = {
        .name           = "decrementer",
        .rating         = 200,
-       .shift          = 32,
+       .shift          = 16,
        .mult           = 0,	/* To be filled in */
        .irq            = 0,
        .set_next_event = decrementer_set_next_event,
