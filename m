Subject: CLLF860T FEC problem in linux-2.4.0-test4-pre6
To: linuxppc-embedded@lists.linuxppc.org (LinuxPPC Embedded Mailing List)
Date: Thu, 13 Jul 2000 18:55:35 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000713085536.368DE289@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi dudes,

I've just had a shot at running the latest 2.2.4-test4-pre6 snapshot on a
CLLF860T board, and I'm finding that opening the FEC driver fails, because
the PHY hasn't been recognised.  Firstly though, I had to apply this patch
to get the FEC initialised:

diff -ur linux-2.4.0-test4-pre6/drivers/net/setup.c linux-2.4.0-test4-pre6.cllf/drivers/net/setup.c
--- linux-2.4.0-test4-pre6/drivers/net/setup.c	Wed May 24 01:21:51 2000
+++ linux-2.4.0-test4-pre6.cllf/drivers/net/setup.c	Thu Jul 13 18:03:42 2000
@@ -22,6 +22,7 @@
 extern int awc4500_365_probe(void);
 extern int arcnet_init(void);
 extern int scc_enet_init(void);
+extern int fec_enet_init(void);
 extern int dlci_setup(void);
 extern int lapbeth_init(void);
 extern int sdla_setup(void);
@@ -74,6 +75,9 @@
 #endif
 #if defined(CONFIG_SCC_ENET)
         {scc_enet_init, 0},
+#endif
+#if defined(CONFIG_FEC_ENET)
+        {fec_enet_init, 0},
 #endif
 #if defined(CONFIG_COMX)
 	{comx_init, 0},


I have CONFIG_FEC_QS6612 enabled in fec.c, but it appears that I'm never
getting an MII interrupt, because fec_enet_interrupt is never called.
Hence, neither mii_discover_phy function gets called, and fec_enet_open later
fails with -ENODEV.

Has anyone got any clues on this before I dive into it tomorrow?

Thanks,
Graham
--
Graham Stoney
Principal Hardware/Software Engineer
Canon Information Systems Research Australia
Ph: +61 2 9805 2909  Fax: +61 2 9805 2929

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
