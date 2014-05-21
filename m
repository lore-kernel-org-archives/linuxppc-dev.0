Return-Path: <f.fainelli@gmail.com>
Received: from mail-qg0-x232.google.com (mail-qg0-x232.google.com
 [IPv6:2607:f8b0:400d:c04::232])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7584D1A0823
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 May 2014 08:03:27 +1000 (EST)
Received: by mail-qg0-f50.google.com with SMTP id z60so4322336qgd.9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 May 2014 15:03:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <537D20EA.1000305@cogentembedded.com>
References: <1400708331-18088-1-git-send-email-f.fainelli@gmail.com>
 <1400708331-18088-5-git-send-email-f.fainelli@gmail.com>
 <537D20EA.1000305@cogentembedded.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Date: Wed, 21 May 2014 15:02:42 -0700
Message-ID: <CAGVrzcbBQFhw-dUh+tFm8H5m9-fmVgutChS8wUG-F6sTBoRq-g@mail.gmail.com>
Subject: Re: [PATCH RESEND net-next 4/9] net: systemport: use the new fixed
 PHY helpers
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 "open list:OPEN FIRMWARE AND..." <devicetree@vger.kernel.org>,
 Aida Mynzhasova <aida.mynzhasova@skitlab.ru>, netdev <netdev@vger.kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 open list <linux-kernel@vger.kernel.org>,
 Claudiu Manoil <claudiu.manoil@freescale.com>,
 Vitaly Bordug <vbordug@ru.mvista.com>, Grant Likely <grant.likely@linaro.org>,
 "open list:LINUX FOR POWERPC..." <linuxppc-dev@lists.ozlabs.org>,
 David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2014-05-21 14:55 GMT-07:00 Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>:
> On 05/22/2014 01:38 AM, Florian Fainelli wrote:
>
>> of_phy_connect_fixed_link() is becoming obsolete, and also required
>> platform code to register the fixed PHYs at the specified addresses for
>> those to be usable. Get rid of it and use the new of_phy_is_fixed_link()
>> plus of_phy_register_fixed_link() helpers to transition over the new
>> scheme.
>
>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>>   drivers/net/ethernet/broadcom/bcmsysport.c | 17 +++++++++++++++--
>>   drivers/net/ethernet/broadcom/bcmsysport.h |  1 +
>>   2 files changed, 16 insertions(+), 2 deletions(-)
>
>
>> diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c
>> b/drivers/net/ethernet/broadcom/bcmsysport.c
>> index d40c5b969e9e..dc708a888f80 100644
>> --- a/drivers/net/ethernet/broadcom/bcmsysport.c
>> +++ b/drivers/net/ethernet/broadcom/bcmsysport.c
>> @@ -1327,8 +1327,8 @@ static int bcm_sysport_open(struct net_device *dev)
>>         /* Read CRC forward */
>>         priv->crc_fwd = !!(umac_readl(priv, UMAC_CMD) & CMD_CRC_FWD);
>>
>> -       priv->phydev = of_phy_connect_fixed_link(dev,
>> bcm_sysport_adj_link,
>> -
>> priv->phy_interface);
>> +       priv->phydev = of_phy_connect(dev, priv->phy_dn,
>> bcm_sysport_adj_link,
>> +                                       0, priv->phy_interface);
>
>
>    The continuation line should start on the next character after ( on the
> above line, according to the networking coding style.

Unless I am once again not following the coding style, the patch in
patchwork has this correctly, and so does my file locally:

http://patchwork.ozlabs.org/patch/351323/
-- 
Florian
