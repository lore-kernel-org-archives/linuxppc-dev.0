Return-Path: <f.fainelli@gmail.com>
Received: from mail-oi0-x241.google.com (mail-oi0-x241.google.com
 [IPv6:2607:f8b0:4003:c06::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6A6CC1A0075
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Jan 2016 13:59:35 +1100 (AEDT)
Received: by mail-oi0-x241.google.com with SMTP id x140so9743861oif.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jan 2016 18:59:34 -0800 (PST)
Subject: Re: [PATCH 1/3][v2] net: phy: introduce 1000BASE-KX and 10GBASE-KR
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Shaohui Xie <shaohui.xie@nxp.com>, Andrew Lunn <andrew@lunn.ch>,
 "shh.xie@gmail.com" <shh.xie@gmail.com>
References: <1452759839-9874-1-git-send-email-shh.xie@gmail.com>
 <20160114164418.GD19773@lunn.ch>
 <VI1PR04MB166491DEBB439EB72742201DE8CD0@VI1PR04MB1664.eurprd04.prod.outlook.com>
 <56997951.90304@gmail.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "davem@davemloft.net" <davem@davemloft.net>,
 Shaohui Xie <Shaohui.Xie@freescale.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <5699B211.5070602@gmail.com>
Date: Fri, 15 Jan 2016 18:59:29 -0800
MIME-Version: 1.0
In-Reply-To: <56997951.90304@gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Le 15/01/2016 14:57, Sebastian Hesselbarth a écrit :
> On 15.01.2016 05:01, Shaohui Xie wrote:
>>> -----Original Message-----
>>> From: Andrew Lunn [mailto:andrew@lunn.ch]
>>> Sent: Friday, January 15, 2016 12:44 AM
>>> To: shh.xie@gmail.com
>>> Cc: devicetree@vger.kernel.org; netdev@vger.kernel.org; linuxppc-
>>> dev@lists.ozlabs.org; f.fainelli@gmail.com; davem@davemloft.net; Shaohui Xie
>>> Subject: Re: [PATCH 1/3][v2] net: phy: introduce 1000BASE-KX and 10GBASE-KR
>>>
>>> On Thu, Jan 14, 2016 at 04:23:59PM +0800, shh.xie@gmail.com wrote:
>>>> From: Shaohui Xie <Shaohui.Xie@freescale.com>
>>>>
>>>> This commit adds necessary definitions for the PHY layer to recognize
>>>> backplane Ethernet 1000BASE-KX and 10GBASE-KR as valid PHY interfaces,
>>>> "1000base-kx" for 1000BASE-KX, "10gbase-kr" for 10GBASE-KR.
>>>>
>>>> Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
>>>> ---
>>>> changes in v2:
>>>> new patch.
> 
> Shaohui,
> 
> it would be more useful to describe _what_ is new here compared to v1.
> 
> Anyway:
> 
>>>>  Documentation/devicetree/bindings/net/ethernet.txt | 4 ++--
>>>>  include/linux/phy.h                                | 6 ++++++
>>>>  2 files changed, 8 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/net/ethernet.txt
>>>> b/Documentation/devicetree/bindings/net/ethernet.txt
>>>> index 5d88f37..1166a5c 100644
>>>> --- a/Documentation/devicetree/bindings/net/ethernet.txt
>>>> +++ b/Documentation/devicetree/bindings/net/ethernet.txt
>>>> @@ -11,8 +11,8 @@ The following properties are common to the Ethernet
>>> controllers:
>>>>    the maximum frame size (there's contradiction in ePAPR).
>>>>  - phy-mode: string, operation mode of the PHY interface; supported values are
>>>>    "mii", "gmii", "sgmii", "qsgmii", "tbi", "rev-mii", "rmii",
>>>> "rgmii", "rgmii-id",
>>>> -  "rgmii-rxid", "rgmii-txid", "rtbi", "smii", "xgmii"; this is now a
>>>> de-facto
>>>> -  standard property;
>>>> +  "rgmii-rxid", "rgmii-txid", "rtbi", "smii", "xgmii", "1000base-kx",
>>>> + "10gbase-kr";  this is now a de-facto standard property;
>>>
>>> I know very little about this, so i'm just asking a question. None of the other
>>> interface modes contain a bit rate. So is the bit rate needed for your two new
>>> modes?
>>
>> 1000BASE-KX and 10GBASE-KR are terms in IEEE802.3, so as XGMII and GMII. 
>> There are interfaces could be different bit rates but same types, 
>> e.g. 100BASE-LX10 and 1000BASE-LX10, or 40GBASE-KR4 and 100GBASE-KR4, 
>> having bit rate is clear to represent hardware.
>>
> 
> If you look at the list of possible values for "phy-mode" you'd see that
> none of it describes a PHY-to-PHY connection but all are for MAC-to-PHY
> connections. Also, names above suggest it already: MII is short for
> media _independent_ interface.
> 
> I copy Andrew's concerns and think that neither 10000base-kx nor
> 10gbase-kr belong in the list of phy-mode properties.

I concur with that as well, if the phy connection does not really matter
here, or does not seem like a good fit, maybe we should have a different
property, or just define the hardware interface a little differently?
-- 
Florian
