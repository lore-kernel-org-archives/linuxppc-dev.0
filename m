From: Chas Williams <chas@cmf.nrl.navy.mil>
Date: Fri, 4 Feb 2000 21:15:04 -0500
Message-Id: <200002050215.VAA02658@fermi.cmf.nrl.navy.mil>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: anyone build 2.3.42 for ppc?
References: <200002042204.RAA44619@p2.parker.boston.ma.us>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


i needed to apply the following to fix nvram access:

--- drivers/char/misc.c.000     Fri Feb  4 18:00:52 2000
+++ drivers/char/misc.c Fri Feb  4 18:03:43 2000
@@ -72,6 +72,7 @@
 extern int rtc_DP8570A_init(void);
 extern int rtc_MK48T08_init(void);
 extern int dsp56k_init(void);
+extern int nvram_init(void);
 extern int radio_init(void);
 extern int pc110pad_init(void);
 extern int pmu_device_init(void);
@@ -207,6 +208,9 @@
 #endif
 #ifdef CONFIG_ATARI_DSP56K
        dsp56k_init();
+#endif
+#ifdef CONFIG_NVRAM
+       nvram_init();
 #endif
 #ifdef CONFIG_MISC_RADIO
        radio_init();

i also saw another problem i chrp_setup.c, and i believe this is the correct
fix but have no way to test it.

--- arch/ppc/kernel/chrp_setup.c.000    Fri Feb  4 17:14:16 2000
+++ arch/ppc/kernel/chrp_setup.c        Fri Feb  4 17:14:27 2000
@@ -394,7 +394,7 @@
         * We do it this way since our irq_desc[irq].handler can change
         * with RTL and no longer be open_pic -- Cort
         */
-       if ( irq >= open_pic.irq_offset)
+       if ( irq >= open_pic_irq_offset)
                openpic_eoi( smp_processor_id() );
 }

@@ -411,7 +411,7 @@
                        (*(unsigned long *)get_property(np,
                                                        "8259-interrupt-acknowle
dge", NULL));
        }
-       open_pic.irq_offset = 16;
+       open_pic_irq_offset = 16;
        for ( i = 16 ; i < NR_IRQS ; i++ )
                irq_desc[i].handler = &open_pic;
        openpic_init(1);

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
