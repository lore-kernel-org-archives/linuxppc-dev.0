Message-ID: <008d01c15af6$669574d0$337ceccb@dasan.com>
From: "Young-Han, Kim" <yhkim@da-san.com>
To: <linuxppc-embedded@lists.linuxppc.org>,
	<laurent.pinchart@capflow.com>
References: <sbd43a78.005@tms-pty.com> <3BD4070D.9040405@capflow.com>
Subject: Re: Problem using FEC on a860T
Date: Mon, 22 Oct 2001 21:38:06 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Reader!

  I was solved this problem...
  The season is relate with interrupt.
  The fec.c enable the interrupt so fast!
  And, the LINK interrupt of some PHYs use with the Duplex Indicator.
  So, we must clear the interrupt and must set the interrupt mode,
before install the PHY Link interrupt!

  Please refer my source code(comment with YHKIM) of fec_enet_init().

===== fec_enet_init ======
#ifdef CONFIG_RPXCLASSIC
        /* Make Port C, bit 15 an input that causes interrupts.
        */
        immap->im_ioport.iop_pcpar &= ~0x0001;
        immap->im_ioport.iop_pcdir &= ~0x0001;
        immap->im_ioport.iop_pcso  &= ~0x0001;
        immap->im_ioport.iop_pcint |=  0x0001;
        cpm_install_handler(CPMVEC_PIO_PC15, mii_link_interrupt, dev);

        /* Make LEDS reflect Link status.
        */
        *((uint *) RPX_CSR_ADDR) &= ~BCSR2_FETHLEDMODE;
#endif

/* YHKIM */
#ifndef CONFIG_DASAN_COMMON
#ifdef PHY_INTERRUPT
        if (request_8xxirq(PHY_INTERRUPT, mii_link_interrupt, 0, "mii", dev) != 0)
                panic("Could not allocate MII IRQ!");

        ((immap_t *)IMAP_ADDR)->im_siu_conf.sc_siel |=
                (0x80000000 >> PHY_INTERRUPT);
#endif
#endif  /* CONFIG_DASAN_COMMON */

        dev->base_addr = (unsigned long)fecp;
        dev->priv = fep;

        /* The FEC Ethernet specific entries in the device structure. */
        dev->open = fec_enet_open;
        dev->hard_start_xmit = fec_enet_start_xmit;
        dev->tx_timeout = fec_timeout;
        dev->watchdog_timeo = TX_TIMEOUT;
        dev->stop = fec_enet_close;
        dev->get_stats = fec_enet_get_stats;
        dev->set_multicast_list = set_multicast_list;

#ifdef  CONFIG_USE_MDIO
        for (i=0; i<NMII-1; i++)
                mii_cmds[i].mii_next = &mii_cmds[i+1];
        mii_free = mii_cmds;
#endif  /* CONFIG_USE_MDIO */

        /* Configure all of port D for MII.
        */
        immap->im_ioport.iop_pdpar = 0x1fff;

        /* Bits moved from Rev. D onward.
        */
        if ((mfspr(IMMR) & 0xffff) < 0x0501)
                immap->im_ioport.iop_pddir = 0x1c58;    /* Pre rev. D */
        else
                immap->im_ioport.iop_pddir = 0x1fff;    /* Rev. D and later */

#ifdef  CONFIG_USE_MDIO
        /* Set MII speed to 2.5 MHz
        */
        fecp->fec_mii_speed = fep->phy_speed =
                (( (bd->bi_intfreq + 500000) / 2500000 / 2 ) & 0x3F ) << 1;
#else
        fecp->fec_mii_speed = 0;        /* turn off MDIO */
#endif  /* CONFIG_USE_MDIO */

        printk ("%s: FEC ENET Version 0.2, FEC irq %d"
#ifdef PHY_INTERRUPT
                ", MII irq %d"
#endif
                ", addr ",
                dev->name, FEC_INTERRUPT
#ifdef PHY_INTERRUPT
                , PHY_INTERRUPT
#endif
        );
        for (i=0; i<6; i++)
                printk("%02x%c", dev->dev_addr[i], (i==5) ? '\n' : ':');

#ifdef  CONFIG_USE_MDIO /* start in full duplex mode, and negotiate speed */
        fec_restart (dev, 1);
#else                   /* always use half duplex mode only */
        fec_restart (dev, 0);
#endif

#ifdef  CONFIG_USE_MDIO
        /* Queue up command to detect the PHY and initialize the
         * remainder of the interface.
         */
        fep->phy_id_done = 0;
        fep->phy_addr = 0;
        mii_queue(dev, mk_mii_read(MII_REG_PHYIR1), mii_discover_phy);
#endif  /* CONFIG_USE_MDIO */

/* YHKIM */
#ifdef CONFIG_DASAN_COMMON
#ifdef PHY_INTERRUPT
        while(fep->phy == 0)
                udelay(5);

        mii_do_cmd(dev, fep->phy->ack_int);
        mii_do_cmd(dev, fep->phy->startup);
        {
                int tmp_i;

                for(tmp_i=0 ; tmp_i<50; tmp_i++)
                        udelay(5);
        }

        if (request_8xxirq(PHY_INTERRUPT, mii_link_interrupt, 0, "mii", dev) != 0)
                panic("Could not allocate MII IRQ!");

        printk("install fec link interrupt\n");

        ((immap_t *)IMAP_ADDR)->im_siu_conf.sc_siel |=
                (0x80000000 >> PHY_INTERRUPT);
#endif  /* PHY_INTERRUPT */
#endif  /* CONFIG_DASAN_COMMON */

        return 0;
}
====================


-
-                              ?
-                             '''
-                            (o o)
- -----------------------oOO--(_)--OOo-----------------------
- == English Version ==
- Young-Han, Kim
- Senior Research Engineer
-
- E-Mail : yhkim@da-san.com
- Direct : ++ 82 2 3484 6579
- H.P    : ++ 82 19 254 7566
-
-                        DASAN Co., Ltd.
- 6F KOSMO Tower 1002, Daechi-dong, Kangnam-ku, Seoul, Korea
-                         Zip : 135-280
-                    Tel : ++ 82 2 3484 6500
-                    Fax : ++ 82 2 3484 6501
-                    http://www.da-san.com
- ===========================================================
- == Korean Version ==
- 김영한   선임연구원 / 기술연구소
- E-Mail : yhkim@da-san.com
- 직통   : 02-3484-6579
- 핸드폰 : 019-254-7566
-
-                        (주)다산인터네트
-           서울시 강남구 대치동 1002 코스모 타워 6층
-                    우편번호 : 135-280
-                    Tel : 02-3484-6500
-                    Fax : 02-3484-6501
-                    http://www.da-san.com
-----------------------------------------------------------
----- Original Message -----
From: "Laurent Pinchart" <laurent.pinchart@capflow.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sent: Monday, October 22, 2001 8:46 PM
Subject: Re: Problem using FEC on a860T


>
> >
> >
> >when I compile without "MDIO for PHY configuration"
> >the kernel prints forever the message  "fec.c[1374] mii_link_interrupt:
> >unexpected Link interrupt
> >on the console at boottime.
> >
> >when I compile with it, the kernel Oopses.
> >after carefull debugging, I tracked it down to the line 1367 in
> >arch/ppc/8xx_io/
> >    mii_do_cmd(dev, fep->phy->ack_int);
> >
> >it is a kernel access of bad area.
> >
> There is a problem in the FEC driver. The MII link interrupt gets
> enabled too soon, before the PHY interface chip is configured. I believe
> that the problem has been fixed in the linuxppc_2_4_devel tree. It was
> supposed to be fixed much sooner, but the patch got lost somewhere
> between the developpers and the development tree.
>
> The problem should not occur if a full duplex ethernet link is connected
> to the board at boot time.
>
> Laurent Pinchart
>
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
