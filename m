Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4BB1FDDF84
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Dec 2007 19:52:45 +1100 (EST)
Message-Id: <90B908AC-E879-4046-AAFC-FE79EB78A932@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Li Tony <Tony.Li@freescale.com>
In-Reply-To: <995B09A8299C2C44B59866F6391D2635DB0633@zch01exm21.fsl.freescale.net>
Content-Type: text/plain; charset=GB2312; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH 2/2] powerpc: Add IPIC MSI support
Date: Fri, 14 Dec 2007 02:52:22 -0600
References: <1196764760.2573.10.camel@Guyver>
	<97EB3576-6952-4F36-A243-4EBF981A117F@kernel.crashing.org>
	<995B09A8299C2C44B59866F6391D2635DB0633@zch01exm21.fsl.freescale.net>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Phillips Kim <Kim.Phillips@freescale.com>, Olof Johansson <olof@lixom.net>,
	Jin Zhengxiong <Jason.Jin@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 14, 2007, at 2:47 AM, Li Tony wrote:

>
> Hi,
>
> I think it is possible to make common code to support both IPIC and =20=

> MPIC.
> Currently, the MPIC has already implemented MSI which is different =20
> from IPIC and embedded into the mpic code body.
> If want to unifiy MSI code, we need to remove the current MPIC MSI =20
> implementation.

The MPIC is going to have to support several MSI styles (IBM/U3, =20
PaSemi, and FSL) since we all seem to handle it differently.

> Micheal, what is your opinion ??
>
> Jin is working on 86xx msi now.

What PCIe cards are you using to test MSIs?

- k

>> -----Original Message-----
>> From: Kumar Gala [mailto:galak@kernel.crashing.org]
>> Sent: 2007=C4=EA12=D4=C214=C8=D5 13:45
>> To: Li Tony
>> Cc: Phillips Kim; michael@ellerman.id.au; linuxppc-dev
>> Subject: Re: [PATCH 2/2] powerpc: Add IPIC MSI support
>>
>>
>> On Dec 4, 2007, at 4:39 AM, Li Li wrote:
>>
>>> Modified based on discussion on list.
>>>
>>> 1. Adopt virq_to_hw routine
>>> 2. Correct a legacy bug
>>>
>>> Implements the IPIC MSI as two level interrupt controller.
>>>
>>> Signed-off-by: Tony Li <tony.li@freescale.com>
>>
>> Tony, have you looked at the 85xx/86xx PCIe MSI mechanism?
>> The 2nd level PIC handling seems like its pretty similar
>> between IPIC and MPIC.  Would like to see if we could somehow
>> make the code common for to handle MSIs from both?
>>
>> - k
>>
