Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f172.google.com (mail-gx0-f172.google.com
	[209.85.217.172]) by ozlabs.org (Postfix) with ESMTP id D2649DE0D6
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 13:38:50 +1000 (EST)
Received: by gxk20 with SMTP id 20so456453gxk.9
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 20:38:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <fa686aa40904222037k6c40ebe1p99f66a6a66ea94d7@mail.gmail.com>
References: <49EFA450.1050100@mail.mcgill.ca>
	<fa686aa40904222037k6c40ebe1p99f66a6a66ea94d7@mail.gmail.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 22 Apr 2009 21:38:31 -0600
Message-ID: <fa686aa40904222038g632ca0e4ub03ece6728683e25@mail.gmail.com>
Subject: Re: [14/14] net: add Xilinx ll_temac device driver
To: Graeme Smecher <graeme.smecher@mail.mcgill.ca>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 22, 2009 at 9:37 PM, Grant Likely <grant.likely@secretlab.ca> w=
rote:
> On Wed, Apr 22, 2009 at 5:12 PM, Graeme Smecher
> <graeme.smecher@mail.mcgill.ca> wrote:
>> Hi Grant,
>>
>> I'm not sure if you've caught this yet, but there's a typo in
>> drivers/net/xilinx_temac.c. The TX and RX ISRs (ll_temac_tx_irq and
>> ll_temac_rx_irq) take two arguments, but...
>
> Thanks Graeme. =A0As you can tell, I haven't actually used
> CONFIG_NET_POLL_CONTROLLER since I refactored this driver. =A0I'll fix
> this in the next version.

And BTW, don't forget to CC the mailing list when replying.

g.

>>
>>> +#ifdef CONFIG_NET_POLL_CONTROLLER
>>> +static void
>>> +temac_poll_controller(struct net_device *ndev)
>>> +{
>>> + =A0 =A0 struct temac_local *lp =3D netdev_priv(ndev);
>>> +
>>> + =A0 =A0 disable_irq(lp->tx_irq);
>>> + =A0 =A0 disable_irq(lp->rx_irq);
>>> +
>>> + =A0 =A0 ll_temac_rx_irq(lp->tx_irq, lp, 0);
>>> + =A0 =A0 ll_temac_tx_irq(lp->rx_irq, lp, 0);
>>> +
>>> + =A0 =A0 enable_irq(lp->tx_irq);
>>> + =A0 =A0 enable_irq(lp->rx_irq);
>>> +}
>>> +#endif
>>
>> they're called here with three for some reason.
>>
>> Thanks for the driver! I'm developing for the Virtex-4 FX16, and I'll
>> let you know if I run into any problems there.
>>
>> best,
>> Graeme
>>
>
>
>
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
