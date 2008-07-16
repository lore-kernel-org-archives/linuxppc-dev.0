Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7E90ADE1BE
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2008 08:02:20 +1000 (EST)
Message-Id: <702673D5-9D36-4428-91FB-3D0697A1D5ED@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20080716214722.GA6251@ld0162-tx32.am.freescale.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH] powerpc/ep8248e: Fix compile problem if !CONFIG_FS_ENET
Date: Wed, 16 Jul 2008 17:01:28 -0500
References: <Pine.LNX.4.64.0807160838520.14127@blarg.am.freescale.net>
	<20080716214722.GA6251@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
	davej@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 16, 2008, at 4:47 PM, Scott Wood wrote:

> On Wed, Jul 16, 2008 at 08:39:12AM -0500, Kumar Gala wrote:
>> If we don't enable FS_ENET we get build issues:
>>
>> arch/powerpc/platforms/built-in.o: In function `ep8248e_mdio_probe':
>> arch/powerpc/platforms/82xx/ep8248e.c:129: undefined reference to  
>> `alloc_mdio_bitbang'
>> arch/powerpc/platforms/82xx/ep8248e.c:143: undefined reference to  
>> `mdiobus_register'
>
> How is this possible?  CONFIG_EP8248E selects CONFIG_MDIO_BITBANG.
>
>> +#ifdef CONFIG_FS_ENET_MDIO_FCC
>> static void ep8248e_set_mdc(struct mdiobb_ctrl *ctrl, int level)
>> {
>> 	if (level)
>> @@ -164,6 +165,7 @@ static struct of_platform_driver  
>> ep8248e_mdio_driver = {
>> 	.probe = ep8248e_mdio_probe,
>> 	.remove = ep8248e_mdio_remove,
>> };
>> +#endif
>
> This is wrong -- ep8248e doesn't use the FS_ENET_MDIO_FCC code.

You're correct this should be CONFIG_MDIO_BITBANG

- k
