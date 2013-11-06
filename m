Return-Path: <f.fainelli@gmail.com>
Received: from mail-pa0-x22d.google.com (mail-pa0-x22d.google.com
 [IPv6:2607:f8b0:400e:c03::22d])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BB72E2C009D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Nov 2013 11:16:51 +1100 (EST)
Received: by mail-pa0-f45.google.com with SMTP id kp14so9683656pab.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 Nov 2013 16:16:48 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <81419762.0SyAdYsUqu@mexican>
References: <1383629471-16979-1-git-send-email-alistair@popple.id.au>
 <1383629471-16979-3-git-send-email-alistair@popple.id.au>
 <CAGVrzcZQ26kbim2piOwrvpyOcSaTET5da7Yh4GWv+erfuOBDhQ@mail.gmail.com>
 <81419762.0SyAdYsUqu@mexican>
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Tue, 5 Nov 2013 16:16:08 -0800
Message-ID: <CAGVrzcYzBtDcxYXDopOJn_=vW_58SFs9y0uKeGNB9TDPh6J4wg@mail.gmail.com>
Subject: Re: [PATCH 3/7] IBM Akebono: Add support for a new PHY to the IBM
 emac driver
To: Alistair Popple <alistair@popple.id.au>
Content-Type: text/plain; charset=UTF-8
Cc: netdev <netdev@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2013/11/5 Alistair Popple <alistair@popple.id.au>:
> On Tue, 5 Nov 2013 10:47:22 Florian Fainelli wrote:
>> [snip]
>>
>> > +/* RGMII bridge supports only GMII/TBI and RGMII/RTBI PHYs */
>> > +static inline int rgmii_valid_mode(int phy_mode)
>> > +{
>> > +       return  phy_mode == PHY_MODE_GMII ||
>> > +               phy_mode == PHY_MODE_MII ||
>> > +               phy_mode == PHY_MODE_RGMII ||
>> > +               phy_mode == PHY_MODE_TBI ||
>> > +               phy_mode == PHY_MODE_RTBI;
>> > +}
>> > +
>> > +static inline const char *rgmii_mode_name(int mode)
>> > +{
>> > +       switch (mode) {
>> > +       case PHY_MODE_RGMII:
>> > +               return "RGMII";
>> > +       case PHY_MODE_TBI:
>> > +               return "TBI";
>> > +       case PHY_MODE_GMII:
>> > +               return "GMII";
>> > +       case PHY_MODE_MII:
>> > +               return "MII";
>> > +       case PHY_MODE_RTBI:
>> > +               return "RTBI";
>> > +       default:
>> > +               BUG();
>> > +       }
>>
>> Any reasons why you are duplicating what is available in
>> drivers/of/of_net.c ::of_get_phy_mode()?
>
> Unless I'm missing something of_get_phy_mode() is going the other way.
> rgmii_mode_name() is converting PHY_MODE_* into a human-readable string. I
> couldn't find any obvious kernel method to do this but maybe I missed it?

Right, rgmii_mode_name() just has informative purposes and should be
removed, I would suggest using standard device tree bindings property
(phy-mode) anyway such that you could use of_get_phy_mode() and use
phy_interface_t types.
-- 
Florian
