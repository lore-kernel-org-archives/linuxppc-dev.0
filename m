Message-ID: <3C160B04.93085D47@allot.com>
Date: Tue, 11 Dec 2001 15:32:52 +0200
From: Felix Radensky <felix@allot.com>
MIME-Version: 1.0
To: David =?iso-8859-1?Q?M=FCller?= (ELSOFT AG) <d.mueller@elsoft.ch>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: ppc405_enet problems
References: <3C14B86D.726DBDE6@allot.com> <3C15BB05.7070702@elsoft.ch>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

Thanks, David and Armin for your help. I've tried the methods you suggested
but none of them worked. The real problem in my case was the MAX_NUM_PHYS
constant. I've noticed that after the first for loop in find_phy routine, the
value of
i is MAX_NUM_PHYS. So I've tried to increase the value of this constant, and
my
phy was (almost) discovered properly after the 5th iteration. I say almost,
because
I also had to change the value of phy id from 0x20005c23 to 0x20005c20 (the
value
reported by find_phy. Armin, can you please explain how this number was
determined.

After applying the above changes I was able to boot and mount root via NFS.

Another thing I've noticed is that you now have to explicitly specify the ip
address
of NFS server as kernel parameter. The former default (NFS sever = BOOTP
server)
seems not to work anymore.

Felix.


"David Müller (ELSOFT AG)" wrote:

> It looks like the MII controller is not setting the error flag for the
> first access (reading of PHYIR1 in find_phy(ppc405_phy.c)
>
> Perhaps my work-around (see attached file) will help you too.
>
> Felix Radensky wrote:
>
>  > Hi,
>  >
>  > I'm trying to run the latest linuxppc_2_4_devel kernel on
>  > our custom 405GP based board. I get kernel panic when an
>  > attempt is made to probe for ethernet controller phy:
>  >
>  > Kernel panic: eth0: PHY id 0xfbc85c20 is not supported!
>  >
>  > The phy is National Semiconductor DP83846AVHG.
>  > It works fine with Monta Vista HHL 2.0 kernel.
>  >
>  > What you think could be the problem ?
>  >
>  > TIA.
>  >
>  > Felix.
>  >
>
> Dave
>
>   ------------------------------------------------------------------------
> --- 1.5/drivers/net/ppc405_phy.c        Thu Oct 25 00:44:15 2001
> +++ edited/ppc405_phy.c Mon Dec  3 16:51:05 2001
> @@ -707,14 +707,17 @@
>  {
>         struct fec_enet_private *fep;
>         int i;
> -       uint phy_reg;
> +       uint phy_reg, phy_reg2;
>         uint phytype;
>
>         fep = dev->priv;
>
>         for ( i = 0; i < MAX_NUM_PHYS; i++)
> -               if (!(fec_enet_mdio_read(i, mk_mii_read(MII_REG_PHYIR1),
> -                                               &phy_reg)))
> +               if (!((fec_enet_mdio_read(i, mk_mii_read(MII_REG_PHYIR1),
> +                                               &phy_reg)) ||
> +                     (fec_enet_mdio_read(i, mk_mii_read(MII_REG_PHYIR2),
> +                                               &phy_reg2))))
> +
>                         break;
>
>         fep->phy_addr = i;


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
