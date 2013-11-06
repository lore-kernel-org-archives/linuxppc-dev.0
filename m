Return-Path: <f.fainelli@gmail.com>
Received: from mail-pb0-x22e.google.com (mail-pb0-x22e.google.com
 [IPv6:2607:f8b0:400e:c01::22e])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8AA4C2C00C4
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Nov 2013 13:24:36 +1100 (EST)
Received: by mail-pb0-f46.google.com with SMTP id un15so3359170pbc.33
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 Nov 2013 18:24:32 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1383704240.4776.115.camel@pasglop>
References: <1383629471-16979-1-git-send-email-alistair@popple.id.au>
 <81419762.0SyAdYsUqu@mexican>
 <CAGVrzcYzBtDcxYXDopOJn_=vW_58SFs9y0uKeGNB9TDPh6J4wg@mail.gmail.com>
 <9250529.5UedqhaNce@mexican> <1383704240.4776.115.camel@pasglop>
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Tue, 5 Nov 2013 18:23:52 -0800
Message-ID: <CAGVrzcZ+Qdjp4hdLREgvgLgNgQxPObJ8u_wD8-3MGy9rGxfHow@mail.gmail.com>
Subject: Re: [PATCH 3/7] IBM Akebono: Add support for a new PHY to the IBM
 emac driver
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
Cc: Alistair Popple <alistair@popple.id.au>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "David S. Miller" <davem@davemloft.net>, netdev <netdev@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2013/11/5 Benjamin Herrenschmidt <benh@kernel.crashing.org>:
> On Wed, 2013-11-06 at 12:38 +1100, Alistair Popple wrote:
>> > Right, rgmii_mode_name() just has informative purposes and should be
>> > removed, I would suggest using standard device tree bindings
>> property
>> > (phy-mode) anyway such that you could use of_get_phy_mode() and use
>> > phy_interface_t types.
>>
>> Ok, that's what is currently done in the core IBM EMAC driver. As this
>> is used
>> just for informative purposes I will remove it. Thanks.
>
> Why ? Information is useful...

Not the way they are currently handled:

+       /* Check if we need to attach to a RGMII */
+       if (!rgmii_valid_mode(mode)) {
+               dev_err(&ofdev->dev, "unsupported settings !\n");

Considering that nothing useful is being printed, that or nothing at
all really looks identical to me.
--
Florian
