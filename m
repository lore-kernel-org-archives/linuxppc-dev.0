MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Poor 8260 FCC Ethernet performance 
Date: Wed, 9 Jun 2004 17:19:50 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B06DAF8@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Does the FCC performance issue have something to do with the fact that
the current FCC drivers in linux puts the buffer descriptors in main
memory and not in dual port?

>From arch/ppc/8260_io/fcc_enet.c (line 1563)

	/* Allocate space for the buffer descriptors in the DP ram.
	 * These are relative offsets in the DP ram address space.
	 * Initialize base addresses for the buffer descriptors.
	 */
#if 0
	/* I really want to do this, but for some reason it doesn't
	 * work with the data cache enabled, so I allocate from the
	 * main memory instead.
	 */
	i = m8260_cpm_dpalloc(sizeof(cbd_t) * RX_RING_SIZE, 8);
	ep->fen_genfcc.fcc_rbase = (uint)&immap->im_dprambase[i];
	cep->rx_bd_base = (cbd_t *)&immap->im_dprambase[i];

	i = m8260_cpm_dpalloc(sizeof(cbd_t) * TX_RING_SIZE, 8);
	ep->fen_genfcc.fcc_tbase = (uint)&immap->im_dprambase[i];
	cep->tx_bd_base = (cbd_t *)&immap->im_dprambase[i];
#else
	cep->rx_bd_base = (cbd_t *)m8260_cpm_hostalloc(sizeof(cbd_t) *
RX_RING_SIZE, 8);
	ep->fen_genfcc.fcc_rbase = __pa(cep->rx_bd_base);
	cep->tx_bd_base = (cbd_t *)m8260_cpm_hostalloc(sizeof(cbd_t) *
TX_RING_SIZE, 8);
	ep->fen_genfcc.fcc_tbase = __pa(cep->tx_bd_base);
#endif

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
