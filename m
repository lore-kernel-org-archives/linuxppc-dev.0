Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A5B21DDE03
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Sep 2007 14:00:48 +1000 (EST)
In-Reply-To: <20070925165845.40B0E2397FB@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
References: <20070925143126.GA30013@localhost.localdomain>
	<20070925143531.GG5323@localhost.localdomain>
	<16E78F0E-B57B-4084-887E-5D2F9C1D0331@kernel.crashing.org>
	<20070925151819.GA6757@localhost.localdomain>
	<20070925165845.40B0E2397FB@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <7881139C-EEF1-41DC-AB0F-115632E892B8@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [spi-devel-general] [PATCH 7/7] [POWERPC][SPI] spi_mpc83xx:	allow
	use on MPC85xx
Date: Tue, 25 Sep 2007 23:00:38 -0500
To: David Brownell <david-b@pacbell.net>
Cc: spi-devel-general@lists.sourceforge.net, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 25, 2007, at 11:58 AM, David Brownell wrote:

>>>> -	depends on SPI_MASTER && PPC_83xx && EXPERIMENTAL
>>>> +	depends on SPI_MASTER && (PPC_83xx || PPC_85xx) && EXPERIMENTAL
>>>
>>> Should that really be just PPC_83xx || QUICC_ENGINE?
>>
>> Well, I thought about that. By now I'm unsure if every QE
>> implementation will be compatible with further ones.
>
> How many other QE implementations exist?  Is that sort of
> gratuitous breakage something Freescale makes a habit of?

We try not to, but HW people are know to do evil things to keep us  
software guys employed.

>> 	So far
>> I've tested this driver on MPC8323 and MPC8568. If we'll see
>> more and more compatible QE SPI controllers, of course we
>> may just do || QUICC_ENGINE.
>>
>> PPC_83xx || PPC_85xx
>> PPC_83xx || QUICC_ENGINE
>>
>> Today first option saves us four bytes. ;-)
>
> It'd be good if someone would look at the relevant docs.
>
> I'll wait for a PPC signoff before I forward this for
> merge with SPI stuff...

I'm still in favor of making it PPC_83xx || QUICC_ENGINE.

So if when we have 87xx with QUICC_ENGINE we don't have to tweak it  
again, but its a minor thing.

- k
