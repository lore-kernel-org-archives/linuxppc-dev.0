MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Poor 8260 FCC Ethernet performance 
Date: Wed, 9 Jun 2004 17:33:39 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B06DAF9@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Rune Torgersen" <runet@innovsys.com>,
	<linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


BTW, found the problem with that piece of code about 2 seconds after
sending it....
The fcc_rbase &tbase parameters are not given the physical address, but
the virtual one...

Change
 	ep->fen_genfcc.fcc_rbase = (uint)&immap->im_dprambase[i];
To
	ep->fen_genfcc.fcc_rbase = __pa((uint)&immap->im_dprambase[i]);

And
	ep->fen_genfcc.fcc_tbase = (uint)&immap->im_dprambase[i];
To
	ep->fen_genfcc.fcc_tbase = __pa((uint)&immap->im_dprambase[i]);


And everything works great...
Probably even increased performance a bit...

Proper patch:
--- ../fcc_enet.c       2004-06-09 22:33:14.000000000 -0500
+++ arch/ppc/8260_io/fcc_enet.c 2004-06-09 22:26:47.000000000 -0500
@@ -1564,17 +1564,17 @@ init_fcc_param(fcc_info_t *fip, struct n
         * These are relative offsets in the DP ram address space.
         * Initialize base addresses for the buffer descriptors.
         */
-#if 0
+#if 1
        /* I really want to do this, but for some reason it doesn't
         * work with the data cache enabled, so I allocate from the
         * main memory instead.
         */
        i = m8260_cpm_dpalloc(sizeof(cbd_t) * RX_RING_SIZE, 8);
-       ep->fen_genfcc.fcc_rbase = (uint)&immap->im_dprambase[i];
+       ep->fen_genfcc.fcc_rbase = __pa((uint)&immap->im_dprambase[i]);
        cep->rx_bd_base = (cbd_t *)&immap->im_dprambase[i];

        i = m8260_cpm_dpalloc(sizeof(cbd_t) * TX_RING_SIZE, 8);
-       ep->fen_genfcc.fcc_tbase = (uint)&immap->im_dprambase[i];
+       ep->fen_genfcc.fcc_tbase = __pa((uint)&immap->im_dprambase[i]);
        cep->tx_bd_base = (cbd_t *)&immap->im_dprambase[i];
 #else
        cep->rx_bd_base = (cbd_t *)m8260_cpm_hostalloc(sizeof(cbd_t) *
RX_RING_SIZE, 8);

---

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
