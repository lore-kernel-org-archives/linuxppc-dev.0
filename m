Message-ID: <3D1069BE.E5CC6632@icn.siemens.de>
Date: Wed, 19 Jun 2002 13:23:42 +0200
From: Steffen Rumler <Steffen.Rumler@icn.siemens.de>
MIME-Version: 1.0
To: "Ludszuweit, Axel" <Axel.Ludszuweit@datentechnik.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: set_multicast_list function of ppc enet driver
References: <C287DEEDF2D4C1409FDE10D8253BD7000D4C33@eurobird.dt.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> I have a question about the powerquicc ethernet
> drivers, especcially to the set_multicast_list
> routine.
> In this routine, only one multicast address
> is used, to evaluate the appropriate hash value.
> I dont know, how the dmi structure works, but I have
> took a look to other drivers.
> In my opinion, dev->dmi is the start point
> of dev->mc_count chained dmi structures,
> which contains all multicast addresses.
> I have attached a patch of the 8260 version of
> enet.c, which will take this in account.
> I dont have tested the patch.
> Have someone experience with the multicast feature
> and can give me some feedback?

I agree with you. For the version of the fcc_enet.c (for MPC8260)
passed with the 2.4.3 kernel the set_multicast_list()
routine was incomplete and not working.

Via the dmi list the complete set of multicast groups
actually joined will be presented, every time a process joins or
dis-joins a new multicast group. This is fine, because the
driver has not record it in SW.

I pass you also my fixed version for the FCC.


Steffen Rumler


static void
set_multicast_list (struct net_device *dev)
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
