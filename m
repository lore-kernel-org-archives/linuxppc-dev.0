Return-Path: <alistair@popple.id.au>
Received: from ipmail06.adl2.internode.on.net (ipmail06.adl2.internode.on.net
 [IPv6:2001:44b8:8060:ff02:300:1:2:6])
 by ozlabs.org (Postfix) with ESMTP id 679F82C0087
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Nov 2013 11:08:06 +1100 (EST)
From: Alistair Popple <alistair@popple.id.au>
To: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 3/7] IBM Akebono: Add support for a new PHY to the IBM
 emac driver
Date: Wed, 06 Nov 2013 11:08:35 +1100
Message-ID: <81419762.0SyAdYsUqu@mexican>
In-Reply-To: <CAGVrzcZQ26kbim2piOwrvpyOcSaTET5da7Yh4GWv+erfuOBDhQ@mail.gmail.com>
References: <1383629471-16979-1-git-send-email-alistair@popple.id.au>
 <1383629471-16979-3-git-send-email-alistair@popple.id.au>
 <CAGVrzcZQ26kbim2piOwrvpyOcSaTET5da7Yh4GWv+erfuOBDhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: netdev <netdev@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 5 Nov 2013 10:47:22 Florian Fainelli wrote:
> [snip]
> 
> > +/* RGMII bridge supports only GMII/TBI and RGMII/RTBI PHYs */
> > +static inline int rgmii_valid_mode(int phy_mode)
> > +{
> > +       return  phy_mode == PHY_MODE_GMII ||
> > +               phy_mode == PHY_MODE_MII ||
> > +               phy_mode == PHY_MODE_RGMII ||
> > +               phy_mode == PHY_MODE_TBI ||
> > +               phy_mode == PHY_MODE_RTBI;
> > +}
> > +
> > +static inline const char *rgmii_mode_name(int mode)
> > +{
> > +       switch (mode) {
> > +       case PHY_MODE_RGMII:
> > +               return "RGMII";
> > +       case PHY_MODE_TBI:
> > +               return "TBI";
> > +       case PHY_MODE_GMII:
> > +               return "GMII";
> > +       case PHY_MODE_MII:
> > +               return "MII";
> > +       case PHY_MODE_RTBI:
> > +               return "RTBI";
> > +       default:
> > +               BUG();
> > +       }
> 
> Any reasons why you are duplicating what is available in
> drivers/of/of_net.c ::of_get_phy_mode()?

Unless I'm missing something of_get_phy_mode() is going the other way. 
rgmii_mode_name() is converting PHY_MODE_* into a human-readable string. I 
couldn't find any obvious kernel method to do this but maybe I missed it?

Regards,

Alistair
