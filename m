Message-ID: <1541.206.104.177.96.1022091123.squirrel@nevil.org>
Date: Wed, 22 May 2002 13:12:03 -0500 (CDT)
Subject: No Input from SMC1 on MPC860T - Resolved
From: "Daris A Nevil" <dnevil@snmc.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Cc: <sjl@dent.vctlabs.com>
Reply-To: dnevil@snmc.com
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I wrote to the list about a month ago with a problem I experienced while
porting Linux 2.4.18 to a custom MPC860T based board.  The problem related
to the console port SMC1.  The console worked fine in PPCBoot, but once in
Linux the console would output data.  The bash/sash shell could not see
input from SMC1.

My associate Stephanie Lockwood solved the problem.  In her words:

> After much tracing through kernel source and an insightful comment from
> my husband (who happens to be a diagnostics engineer), I now have a
> kernel with reliable terminal input.
> The key was to not enable the FRZ signal when setting up the timerbase;
> apparently I was getting a spurious freeze signal which was turning off
> my timer interrupts partway through. The keyboard interrupts kept
> coming, but the back-end routine to drain the buffer into the user
> program stopped running.
>

I felt this info might be useful to others involved in porting the latest
kernel to new hardware.


Here is the patch:

--- arch/ppc/kernel/m8xx_setup.c.old        Fri May 10 16:07:23 2002
+++ arch/ppc/kernel/m8xx_setup.c        Mon May 13 19:05:11 2002
@@ -184,10 +184,12 @@
          * (or from the other point of view, to get decrementer interrupts
          * we have to enable the timebase).  The decrementer interrupt
          * is wired into the vector table, nothing to do here for that.
+         *
+         * Do NOT enable the FRZ signal, it stops timer intr -- SJL
          */
         ((volatile immap_t *)IMAP_ADDR)->im_sit.sit_tbscr =
                                 ((mk_int_int_mask(DEC_INTERRUPT) << 8) |
-                                         (TBSCR_TBF | TBSCR_TBE));
+                                         TBSCR_TBE);

         if (request_8xxirq(DEC_INTERRUPT, timebase_interrupt, 0, "tbint",
NULL) != 0)
                 panic("Could not allocate timer IRQ!");


Regards,
Daris Nevil
Simple Network Magic Corporation


--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
