Message-ID: <3D106B83.79843019@icn.siemens.de>
Date: Wed, 19 Jun 2002 13:31:15 +0200
From: Steffen Rumler <Steffen.Rumler@icn.siemens.de>
MIME-Version: 1.0
To: "Ludszuweit, Axel" <Axel.Ludszuweit@datentechnik.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: set_multicast_list function of ppc enet driver
References: <C287DEEDF2D4C1409FDE10D8253BD7000D4C33@eurobird.dt.net> <3D1069BE.E5CC6632@icn.siemens.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Sorry, the

  dmi = dmi->next;  !!!

was missing:


static void
set_multicast_list(struct net_device *dev)
{
  struct  fcc_enet_private *cep;
  struct  dev_mc_list *dmi;
  u_char  *mcptr, *tdptr;
  volatile fcc_enet_t *ep;
  int     i, j;

  cep = (struct fcc_enet_private *)dev->priv;

  /* Get pointer to FCC area in parameter RAM.
   */
  ep = (fcc_enet_t *)dev->base_addr;

  if (dev->flags&IFF_PROMISC) {

    /* Log any net taps. */
    printk("%s: Promiscuous mode enabled.\n", dev->name);
    cep->fccp->fcc_fpsmr |= FCC_PSMR_PRO;
  } else {

    cep->fccp->fcc_fpsmr &= ~FCC_PSMR_PRO;

    if (dev->flags & IFF_ALLMULTI) {
      /* Catch all multicast addresses, so set the
       * filter to all 1's.
       */
      ep->fen_gaddrh = 0xffffffff;
      ep->fen_gaddrl = 0xffffffff;
    }
    else {
      /* Clear filter and add the addresses in the list.
       */
      ep->fen_gaddrh = 0;
      ep->fen_gaddrl = 0;

      dmi = dev->mc_list;

      for (i=0; i<dev->mc_count; i++) {

        /* Only support group multicast for now.
	 */
        if (!(dmi->dmi_addr[0] & 1))
          continue;

        /* The address in dmi_addr is LSB first,
	 * and taddr is MSB first.  We have to
	 * copy bytes MSB first from dmi_addr.
	 */
        mcptr = (u_char *)dmi->dmi_addr + 5;
        tdptr = (u_char *)&ep->fen_taddrh;

        for (j=0; j<6; j++)
          *tdptr++ = *mcptr--;

        /* Ask CPM to run CRC and set bit in
	 * filter mask.
	 */
#ifdef CONFIG_MCU
        run_cpcr_cmd(cep->fip->fc_cpmpage,
                     cep->fip->fc_cpmblock,
                     0x0c,
                     CPM_CR_SET_GADDR);
#else  /* CONFIG_MCU */
        cpmp->cp_cpcr = mk_cr_cmd(cep->fip->fc_cpmpage,
                                  cep->fip->fc_cpmblock, 0x0c,
                                  CPM_CR_SET_GADDR) | CPM_CR_FLG;
        udelay(10);
        while (cpmp->cp_cpcr & CPM_CR_FLG);
#endif  /* CONFIG_MCU */

        dmi = dmi->next;  /* S.R. switch to the next list entry */
      }
    }
  }
}



--


--------------------------------------------------------------

Steffen Rumler
ICN ON PNE SB 4
Siemens AG
Hofmannstr. 51                 Email: Steffen.Rumler@icn.siemens.de
D-81359 Munich                 Phone: +49 89 722-44061
Germany                        Fax  : +49 89 722-36703

--------------------------------------------------------------

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
