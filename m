Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A583DDDF2F
	for <linuxppc-dev@ozlabs.org>; Sun, 24 Aug 2008 00:48:50 +1000 (EST)
Message-Id: <9EFB5988-A62A-4E79-B66E-BA89101BA6E2@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Martyn Welch <martyn.welch@gefanuc.com>
In-Reply-To: <20080822121152.70f01597.martyn.welch@gefanuc.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH v2 1/2] powerpc: Board support for GE Fanuc SBC610
Date: Sat, 23 Aug 2008 09:47:28 -0500
References: <20080822104615.11984.93838.stgit@ubuntu8041.localdomain>
	<20080822104620.11984.30369.stgit@ubuntu8041.localdomain>
	<72120CFB-62D9-44B0-AD4F-26332C90F3C9@kernel.crashing.org>
	<20080822121152.70f01597.martyn.welch@gefanuc.com>
Cc: scottwood@freescale.com, linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 22, 2008, at 6:11 AM, Martyn Welch wrote:

>>> +static void __init
>>> +gef_sbc610_init_irq(void)
>>> +{
>>> +	struct mpic *mpic1;
>>> +	struct device_node *np;
>>> +	struct resource res;
>>> +
>>> +	/* Determine PIC address. */
>>> +	np = of_find_node_by_type(NULL, "open-pic");
>>> +	if (np == NULL)
>>> +		return;
>>> +	of_address_to_resource(np, 0, &res);
>>> +
>>> +	mpic1 = mpic_alloc(np, res.start,
>>> +			MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
>>> +			0, 256, "mpic");
>>> +	of_node_put(np);
>>> +	BUG_ON(mpic1 == NULL);
>>> +
>>> +	mpic_init(mpic1);
>>> +}
>>
>> any reason not to use mpc86xx_init_irq() in pic.c?
>>
>
> Yes, the afore-mentioned chained interrupt controller that is rather  
> specific to our boards that I will/have added to this function in a  
> patch that I shall post soon.

Hmm, does that chained interrupt-controller really effect this bit of  
code any?  I'd expect you'd be able to still call mpc86xx_init_irq()  
and than in your board file hook up the cascade (like how we hookup  
the i8259 in pic.c).

If not here are a few comments:

* Use *mpic instead mpic1
* Add MPIC_BROKEN_FRR_NIRQS to the flags

- k
