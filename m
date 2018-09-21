Return-Path: <yuehaibing@huawei.com>
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Gbl10B3XzF3Pb
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Sep 2018 11:35:24 +1000 (AEST)
Subject: Re: [PATCH net-next 17/22] hv_netvsc: fix return type of
 ndo_start_xmit function
To: Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger
 <stephen@networkplumber.org>
References: <20180920123306.14772-1-yuehaibing@huawei.com>
 <20180920123306.14772-18-yuehaibing@huawei.com>
 <20180920074341.3acef75c@xeon-e3>
 <BN6PR21MB016180C794F26A279345A17FCA130@BN6PR21MB0161.namprd21.prod.outlook.com>
CC: "davem@davemloft.net" <davem@davemloft.net>,
 "dmitry.tarnyagin@lockless.no" <dmitry.tarnyagin@lockless.no>,
 "wg@grandegger.com" <wg@grandegger.com>, "mkl@pengutronix.de"
 <mkl@pengutronix.de>, "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
 "hsweeten@visionengravers.com" <hsweeten@visionengravers.com>,
 "madalin.bucur@nxp.com" <madalin.bucur@nxp.com>,
 "pantelis.antoniou@gmail.com" <pantelis.antoniou@gmail.com>,
 "claudiu.manoil@nxp.com" <claudiu.manoil@nxp.com>, "leoyang.li@nxp.com"
 <leoyang.li@nxp.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "sammy@sammy.net" <sammy@sammy.net>, "ralf@linux-mips.org"
 <ralf@linux-mips.org>, "nico@fluxnic.net" <nico@fluxnic.net>,
 "steve.glendinning@shawell.net" <steve.glendinning@shawell.net>,
 "f.fainelli@gmail.com" <f.fainelli@gmail.com>, "grygorii.strashko@ti.com"
 <grygorii.strashko@ti.com>, "w-kwok2@ti.com" <w-kwok2@ti.com>,
 "m-karicheri2@ti.com" <m-karicheri2@ti.com>, "t.sailer@alumni.ethz.ch"
 <t.sailer@alumni.ethz.ch>, "jreuter@yaina.de" <jreuter@yaina.de>, "KY
 Srinivasan" <kys@microsoft.com>, "wei.liu2@citrix.com" <wei.liu2@citrix.com>,
 "paul.durrant@citrix.com" <paul.durrant@citrix.com>, "arvid.brodin@alten.se"
 <arvid.brodin@alten.se>, "pshelar@ovn.org" <pshelar@ovn.org>,
 "dev@openvswitch.org" <dev@openvswitch.org>, "linux-mips@linux-mips.org"
 <linux-mips@linux-mips.org>, "xen-devel@lists.xenproject.org"
 <xen-devel@lists.xenproject.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-usb@vger.kernel.org"
 <linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-can@vger.kernel.org"
 <linux-can@vger.kernel.org>, "devel@linuxdriverproject.org"
 <devel@linuxdriverproject.org>, "linux-hams@vger.kernel.org"
 <linux-hams@vger.kernel.org>, "linux-omap@vger.kernel.org"
 <linux-omap@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
From: YueHaibing <yuehaibing@huawei.com>
Message-ID: <1dfae517-640a-fa56-34e8-52964c29a15f@huawei.com>
Date: Fri, 21 Sep 2018 09:35:13 +0800
MIME-Version: 1.0
In-Reply-To: <BN6PR21MB016180C794F26A279345A17FCA130@BN6PR21MB0161.namprd21.prod.outlook.com>
Content-Type: text/plain; charset="windows-1252"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2018/9/20 22:50, Haiyang Zhang wrote:
> 
> 
>> -----Original Message-----
>> From: Stephen Hemminger <stephen@networkplumber.org>
>> Sent: Thursday, September 20, 2018 10:44 AM
>> To: YueHaibing <yuehaibing@huawei.com>
>> Cc: davem@davemloft.net; dmitry.tarnyagin@lockless.no;
>> wg@grandegger.com; mkl@pengutronix.de; michal.simek@xilinx.com;
>> hsweeten@visionengravers.com; madalin.bucur@nxp.com;
>> pantelis.antoniou@gmail.com; claudiu.manoil@nxp.com; leoyang.li@nxp.com;
>> linux@armlinux.org.uk; sammy@sammy.net; ralf@linux-mips.org;
>> nico@fluxnic.net; steve.glendinning@shawell.net; f.fainelli@gmail.com;
>> grygorii.strashko@ti.com; w-kwok2@ti.com; m-karicheri2@ti.com;
>> t.sailer@alumni.ethz.ch; jreuter@yaina.de; KY Srinivasan <kys@microsoft.com>;
>> Haiyang Zhang <haiyangz@microsoft.com>; wei.liu2@citrix.com;
>> paul.durrant@citrix.com; arvid.brodin@alten.se; pshelar@ovn.org;
>> dev@openvswitch.org; linux-mips@linux-mips.org; xen-
>> devel@lists.xenproject.org; netdev@vger.kernel.org; linux-usb@vger.kernel.org;
>> linux-kernel@vger.kernel.org; linux-can@vger.kernel.org;
>> devel@linuxdriverproject.org; linux-hams@vger.kernel.org; linux-
>> omap@vger.kernel.org; linuxppc-dev@lists.ozlabs.org; linux-arm-
>> kernel@lists.infradead.org
>> Subject: Re: [PATCH net-next 17/22] hv_netvsc: fix return type of
>> ndo_start_xmit function
>>
>> On Thu, 20 Sep 2018 20:33:01 +0800
>> YueHaibing <yuehaibing@huawei.com> wrote:
>>> int netvsc_start_xmit(struct sk_buff *skb, struct net_device *net)
>>>  	 */
>>>  	vf_netdev = rcu_dereference_bh(net_device_ctx->vf_netdev);
>>>  	if (vf_netdev && netif_running(vf_netdev) &&
>>> -	    !netpoll_tx_running(net))
>>> -		return netvsc_vf_xmit(net, vf_netdev, skb);
>>> +	    !netpoll_tx_running(net)) {
>>> +		ret = netvsc_vf_xmit(net, vf_netdev, skb);
>>> +		if (ret)
>>> +			return NETDEV_TX_BUSY;
>>> +	}
>>
>> Sorry, the new code is wrong. It will fall through if ret == 0 (NETDEV_TX_OK)
>> Please review and test your patches.
> 
> Plus consideration of -- For error case, please just return NETDEV_TX_OK. We 
> are not sure if the error can go away after retrying, returning NETDEV_TX_BUSY 
> may cause infinite retry from the upper layer.
> 
> So, let's just always return NETDEV_TX_OK like this:
> 		netvsc_vf_xmit(net, vf_netdev, skb);
> 		return NETDEV_TX_OK;

Thank you for review.

Will do that in v2.

> 
> Thanks,
> - Haiyang
> 
> .
> 
