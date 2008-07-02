Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2F3C0DDF74
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jul 2008 01:04:12 +1000 (EST)
Message-Id: <F2A6FF1A-CF7F-4B2A-94B3-4C0E0693CB21@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Chen Gong <clumsycg@gmail.com>
In-Reply-To: <486B8AFE.7060303@gmail.com>
Content-Type: text/plain; charset=GB2312; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH] powerpc/85xx: Add support for MPC8536DS
Date: Wed, 2 Jul 2008 10:03:51 -0500
References: <Pine.LNX.4.64.0807020201030.24791@blarg.am.freescale.net>
	<20080702170814.de282293.sfr@canb.auug.org.au>
	<486B8AFE.7060303@gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 2, 2008, at 9:04 AM, Chen Gong wrote:

> Stephen Rothwell =D0=B4=B5=C0:
>> Hi Kumar,
>>
>> On Wed, 2 Jul 2008 02:01:10 -0500 (CDT) Kumar Gala =
<galak@kernel.crashing.org=20
>> > wrote:
>>> +void __init mpc8536_ds_pic_init(void)
>>> +{
>>> +	struct mpic *mpic;
>>> +	struct resource r;
>>> +	struct device_node *np =3D NULL;
>>
>> You don't need to initialise this.
>>
>>> +	np =3D of_find_node_by_type(np, "open-pic");
>>> +
>>
>> Extra blank line.
>>
>>> +	if (np =3D=3D NULL) {
>>> +		printk(KERN_ERR "Could not find open-pic node\n");
>>> +		return;
>>> +	}
>>> +
>>> +	if (of_address_to_resource(np, 0, &r)) {
>>> +		printk(KERN_ERR "Failed to map mpic register space\n");
>>> +		of_node_put(np);
>>> +		return;
>>> +	}
>>> +
>>> +	mpic =3D mpic_alloc(np, r.start,
>>> +			  MPIC_PRIMARY | MPIC_WANTS_RESET |
>>> +			  MPIC_BIG_ENDIAN | MPIC_BROKEN_FRR_NIRQS,
>>> +			0, 256, " OpenPIC  ");
>>> +	BUG_ON(mpic =3D=3D NULL);
>>> +
>>> +	mpic_init(mpic);
>>
>> You leak a reference to np here.
>
> It looks like there are same problem in other mpc85xx_xx.c files

agreed for the mpc85xx_ds.c, I dont see the _cds or _ads having these =20=

issues.

- k
