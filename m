Return-Path: <york.sun@nxp.com>
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01on0049.outbound.protection.outlook.com [104.47.0.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y2MJn1XPHzDsPQ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Sep 2017 01:32:38 +1000 (AEST)
From: York Sun <york.sun@nxp.com>
To: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Leo Li
 <leoyang.li@nxp.com>
Subject: Re: FSL serial 166550 errata broken?
Date: Wed, 27 Sep 2017 15:32:31 +0000
Message-ID: <VI1PR04MB2078E07ED3BCF8C6001FA72E9A780@VI1PR04MB2078.eurprd04.prod.outlook.com>
References: <1506358524.29657.31.camel@infinera.com>
 <VI1PR04MB207821E9B5E0FE0BB629E1FA9A7A0@VI1PR04MB2078.eurprd04.prod.outlook.com>
 <1506510185.2325.4.camel@infinera.com>
Reply-To: York Sun <york.sun@nxp.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/27/2017 04:03 AM, Joakim Tjernlund wrote:=0A=
> On Mon, 2017-09-25 at 17:26 +0000, York Sun wrote:=0A=
>> On 09/25/2017 09:55 AM, Joakim Tjernlund wrote:=0A=
>>> We got some "broken" boards(mpx8321) where UART RX is held low(BREAK)=
=0A=
>>> There we get a few:=0A=
>>>     serial8250: too much work for irq18=0A=
>>> and the board freezes.=0A=
>>>=0A=
>>> Looking inte to driver/CPU there is an errtum(A-004737) w.r.t BREAK han=
dling=0A=
>>> and I can see we are hitting the irq function fsl8250_handle_irq() adde=
d=0A=
>>> in commit: 9deaa53ac7fa373623123aa4f18828dd62292b1a=0A=
>>>    "serial: add irq handler for Freescale 16550 errata."=0A=
>>> For all I can tell this workaround is broken and I cannot figure out wh=
y.=0A=
>>> Any pointers?=0A=
>>>=0A=
>>=0A=
>> Jocke,=0A=
>>=0A=
>> Did you mean MPC8321?=0A=
>>=0A=
>> I personally don't have experience debugging this erratum. Have you=0A=
>> tried to contact the patch author Paul Gortmaker to see how he managed=
=0A=
>> to get it work?=0A=
> =0A=
> No, but I just found out it is u-boot related. If I use an very old u-boo=
t it works.=0A=
> Between then and now we did a massive upgrade of u-boot and now if breaks=
. And no,=0A=
> bisect not possible due to local u-boot mods :)=0A=
=0A=
How old? It is a good sign that an old U-Boot works. Git bisect would be =
=0A=
a good tool if practical. Sometimes I have to reapply some local changes =
=0A=
for every step of bisect to make it useful. You mileage may vary though.=0A=
=0A=
> =0A=
> Any idea what could be different? I cannot see and I have tested=0A=
> what I could see/think of but now I am out of ideas.=0A=
=0A=
I don't believe we have much change for MPC8321 for a long time. If any =0A=
change has impact on kernel but not U-Boot itself, it may be other =0A=
errata workarounds.=0A=
=0A=
I presume this happens on your own board. If I am in your shoes, I would =
=0A=
try to reduce the number of local commits and reapply them to various =0A=
U-Boot tags to further narrow down the search scope. In the mean time, =0A=
getting register dump to compare the good and bad may be another way to go.=
=0A=
=0A=
York=0A=
