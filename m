Message-ID: <3C18C309.9D234D7F@labs.mot.com>
Date: Thu, 13 Dec 2001 09:02:34 -0600
From: Steve Rossi <srossi@labs.mot.com>
MIME-Version: 1.0
To: Dan Malek <dan@embeddededge.com>
Cc: Embedded Linux PPC List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: high priority interrupts disabled - problem found
References: <3C112297.6DE37608@labs.mot.com> <3C114C63.3050102@embeddededge.com> <3C14F91F.F382ABE3@labs.mot.com> <3C177748.1A1342C2@labs.mot.com> <3C17E3B4.9E73B22E@labs.mot.com> <3C18336D.7030706@embeddededge.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek wrote:

> We should mask all lower priority interrupts, and the challenge is keeping
> the proper nesting of the masks so the nested interrupts can be "unwound"
> properly ...

Thanks for your followup Dan. I've got a rather straightforward "dumb" approach
to fixing this problem - see the patch below. The disclaimer - I'm a hardware
guy
trying to do software, so there might be a much more elegant solution. The idea
here is that the ppc_cached_irq_mask is maintained as is, but in addition to
masking
the interrupt being serviced, all lower priority interrupts are also masked.
This is un-done
in the unmask function, where ppc_cached_irq_mask is also used to ensure we're
not
un-masking interrupts that were masked prior to the call to mask_and_ack. This
doesn't
affect the nesting of interrupts.  I might be completely missing something here,
so any comments?

I've tested this and it seems to work fine - and it even fixes my problem!

Steve


--- ppc8xx_pic.c.orig   Thu Dec 13 08:35:02 2001
+++ ppc8xx_pic.c        Thu Dec 13 08:39:45 2001
@@ -20,6 +20,24 @@
  * but they are overkill for us.
  */

+static unsigned int ppc_irq_priority_mask[NR_IRQS] = { 0x0,
+                                           0x80000000,
+                                           0xC0000000,
+                                           0xE0000000,
+                                           0xF0000000,
+                                           0xF8000000,
+                                           0xFC000000,
+                                           0xFE000000,
+                                           0xFF000000,
+                                           0xFF800000,
+                                           0xFFC00000,
+                                           0xFFE00000,
+                                           0xFFF00000,
+                                           0xFFF80000,
+                                           0xFFFC0000,
+                                           0xFFFE0000
+                                          };
+
 static void m8xx_mask_irq(unsigned int irq_nr)
 {
        int     bit, word;
@@ -41,7 +59,8 @@

        ppc_cached_irq_mask[word] |= (1 << (31-bit));
        ((immap_t *)IMAP_ADDR)->im_siu_conf.sc_simask =
-                                               ppc_cached_irq_mask[word];
+                                               ppc_cached_irq_mask[word] |
+                                                (~ppc_irq_priority_mask[bit] &
ppc_cached_irq_mask[word]);
 }

 static void m8xx_mask_and_ack(unsigned int irq_nr)
@@ -53,7 +72,7 @@

        ppc_cached_irq_mask[word] &= ~(1 << (31-bit));
        ((immap_t *)IMAP_ADDR)->im_siu_conf.sc_simask =
-                                               ppc_cached_irq_mask[word];
+                                               ppc_cached_irq_mask[word] &
ppc_irq_priority_mask[bit];
        ((immap_t *)IMAP_ADDR)->im_siu_conf.sc_sipend = 1 << (31-bit);
 }



--
-------------------------------------------------------
Steven K. Rossi                     srossi@labs.mot.com
Staff Engineer
Multimedia Communications Research Laboratory
Motorola Labs
-------------------------------------------------------


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
