Message-ID: <3CC82E76.28C45EFC@snom.de>
Date: Thu, 25 Apr 2002 18:27:34 +0200
From: Sven Boehringer <boehringer@snom.de>
Reply-To: boehringer@snom.de
MIME-Version: 1.0
To: Matthew Locke <mlocke@mvista.com>,
	linuxppc <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: AW: Does anyone port m8xx_pcmcia driver to Linux Kernel  
 successfully?
References: <8D4C69676E66D511A1CB00508BBBB192157983@ranmx1.ran.harris.com> <3CBEF7A7.1090900@mvista.com> <3CC7CD7A.20F24E1A@snom.de> <3CC82B37.1010506@mvista.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Matthew,

thanks! I thought you have some special includes :-)
I could compare your defines with them in the Manual. Again thanks for
that.

regards,

	Sven

Matthew Locke wrote:
>
> Sven Boehringer wrote:
>
> >Hi all,
> >
> >i tried your patch, but it seems to me that there are some #defines
> >missing?
> >I try to use the source/kernel on a FADS board, an in that section there
> >is
> >"BCSR1_PCCVPP1". But i can't find this value. I tried to copy some
> >values from ppcboot,
> >but these particular are not there. Are there some special includes?
> >
> >I have the actual linuxppc_2_4_devel source-tree, but i can't find these
> >values.
> >
> The BCSR1_* in the  CONFIG_FADS areas are register addresses specific to
> the FADS board.
> It seems some FADS stuff still hasn't made it into _devel.  Here are the
> defines I have:
> /* Bits of interest in the BCSRs.
>  */
> #define BCSR1_ETHEN             ((uint)0x20000000)
> #define BCSR1_RS232EN_1         ((uint)0x01000000)
> #define BCSR1_PCCEN             ((uint)0x00800000)
> #define BCSR1_PCCVCC0           ((uint)0x00400000)
> #define BCSR1_PCCVPP_MASK       ((uint)0x00300000)
> #define BCSR1_PCCVPP0           ((uint)0x00200000)
> #define BCSR1_PCCVPP1           ((uint)0x00100000)
> #define BCSR1_RS232EN_2         ((uint)0x00040000)
> #define BCSR1_PCCVCC1           ((uint)0x00010000)
> #define BCSR1_PCCVCC_MASK       (BCSR1_PCCVCC0 | BCSR1_PCCVCC1)
> #define BCSR4_ETHLOOP           ((uint)0x80000000)      /* EEST Loopback */
> #define BCSR4_EEFDX             ((uint)0x40000000)      /* EEST FDX
> enable */
> #define BCSR4_FETH_EN           ((uint)0x08000000)      /* PHY enable */
> #define BCSR4_FETHCFG0          ((uint)0x04000000)      /* PHY autoneg
> mode */
> #define BCSR4_FETHCFG1          ((uint)0x00400000)      /* PHY autoneg
> mode */
> #define BCSR4_FETHFDE           ((uint)0x02000000)      /* PHY FDX
> advertise */
> #define BCSR4_FETHRST           ((uint)0x00200000)      /* PHY Reset */
>
> >
> >
> >regards
> >       Sven
> >
> >Matthew Locke wrote:
> >
> >>here is the patch to add the 8xx pcmcia socket driver to the kernel.
> >>
> >>Fend, Matthias wrote:
> >>
> >>>hello Matthew,
> >>>
> >>>i also tried to do this work - without the desired success
> >>>
> >>>i don't know exactly if my hardware is faulty or my m8xx port ... :-(
> >>>
> >>>so if i could have your version of the pcmcia stuff i would be very glad.
> >>>
> >>>thanks matthias
> >>>
> >>>>-----Ursprüngliche Nachricht-----
> >>>>Von:  Matthew Locke [SMTP:mlocke@mvista.com]
> >>>>Gesendet am:  Dienstag, 16. April 2002 18:50
> >>>>An:   Jacky Wang
> >>>>Cc:   linuxppc-embedded@lists.linuxppc.org
> >>>>Betreff:      Re: Does anyone port m8xx_pcmcia driver to Linux Kernel
> >>>>successfully?
> >>>>
> >>>>
> >>>>Jacky Wang wrote:
> >>>>
> >>>>>Hi everyone,
> >>>>>
> >>>>>I am interesting about how to port m8xx_pcmcia driver to linux kernel w/
> >>>>>
> >>>>MPC850.
> >>>>
> >>>>>Would you mind to share your successful experience with me?
> >>>>>
> >>>>I did (w/ the help of others). It is on its way upstream now. If you
> >>>>need it soon, let me know and I can make it available.
> >>>>
> >>>>>Best Regards
> >>>>>Jacky Wang
> >>>>>
> >>>>>
> >>>>** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org
> >>>>
> >>>/
> >>>
> >
> >>+/* ------------------------------------------------------------------------- */
> >>+/* FADS Boards from Motorola                                               */
> >>+
> >>+#if defined(CONFIG_FADS)
> >>+
> >>+#define PCMCIA_BOARD_MSG "FADS"
> >>+
> >>+static int voltage_set(int slot, int vcc, int vpp)
> >>+{
> >>+       uint reg = 0;
> >>+
> >>+       switch(vcc) {
> >>+               case 0: break;
> >>+               case 33: reg |= BCSR1_PCCVCC0; break;
> >>+               case 50: reg |= BCSR1_PCCVCC1; break;
> >>+               default: return 1;
> >>+       }
> >>+
> >>+       switch(vpp) {
> >>+               case 0: break;
> >>+               case 33:
> >>+               case 50:
> >>+                       if(vcc == vpp)
> >>+                               reg |= BCSR1_PCCVPP1;
> >>+                       else
> >>+                               return 1;
> >>+                       break;
> >>+               case 120:
> >>+                       if ((vcc == 33) || (vcc == 50))
> >>+                               reg |= BCSR1_PCCVPP0;
> >>+                       else
> >>+                               return 1;
> >>+               default: return 1;
> >>+       }
> >>+
> >>+       /* first, turn off all power */
> >>+       *((uint *)BCSR1) &= ~(BCSR1_PCCVCC_MASK | BCSR1_PCCVPP_MASK);
> >>+
> >>+       /* enable new powersettings */
> >>+       *((uint *)BCSR1) |= reg;
> >>+
> >>+       return 0;
> >>+}
> >>+
> >>+#define socket_get(_slot_) PCMCIA_SOCKET_KEY_5V
> >>+
> >>+static void hardware_enable(int slot)
> >>+{
> >>+       *((uint *)BCSR1) &= ~BCSR1_PCCEN;
> >>+}
> >>+
> >>+static void hardware_disable(int slot)
> >>+{
> >>+       *((uint *)BCSR1) |=  BCSR1_PCCEN;
> >>+}
> >>+
> >>+#endif
> >>
> >+
> >
>

--
`------------------------`
snom technology AG

Sven Böhringer
Pascalstraße 10
D-10587 Berlin
phone: +49 30 39833-425
`-----------------------`

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
