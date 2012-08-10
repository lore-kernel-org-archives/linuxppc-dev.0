Return-Path: <B11780@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe004.messaging.microsoft.com [65.55.88.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CD77D2C00B6
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Aug 2012 06:24:43 +1000 (EST)
From: Gala Kumar-B11780 <B11780@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: Re: [PATCH v2 2/2] powerpc/mpic: add global timer support
Date: Fri, 10 Aug 2012 20:24:33 +0000
Message-ID: <16AF4D91-FFF6-4BA6-8253-4246B8AF54D4@freescale.com>
References: <1344578081-8095-1-git-send-email-Dongsheng.wang@freescale.com>
 <5025639F.4070203@freescale.com>
In-Reply-To: <5025639F.4070203@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Wang Dongsheng-B40534 <B40534@freescale.com>,
 "paulus@samba.org" <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 10, 2012, at 2:40 PM, Scott Wood wrote:

> On 08/10/2012 12:54 AM, Dongsheng.wang@freescale.com wrote:
>> +static const struct of_device_id mpic_timer_ids[] =3D {
>> +	{ .compatible =3D "open-pic,global-timer", },
>> +	{ .compatible =3D "fsl,global-timer", },
>> +	{},
>> +};
>> +
>> +static int __init mpic_timer_init(void)
>> +{
>> +	struct device_node *np =3D NULL;
>> +
>> +	for_each_node_by_type(np, "open-pic")
>> +		if (of_match_node(mpic_timer_ids, np))
>> +			group_init(np);
>> +
>> +	if (list_empty(&group_list))
>> +		return -ENODEV;
>> +
>> +	return 0;
>> +}
>> +arch_initcall(mpic_timer_init);
>>=20
>=20
> Where do you distinguish an FSL timer from an openpic timer?  I thought
> openpic timers didn't support cascading.

in group_init()

+	if (of_device_is_compatible(np, "fsl,global-timer"))
+		priv->flags |=3D FSL_GLOBAL_TIMER;
+

- k
