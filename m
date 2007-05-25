Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 28BEBDDE3F
	for <linuxppc-dev@ozlabs.org>; Fri, 25 May 2007 22:17:38 +1000 (EST)
In-Reply-To: <989B956029373F45A0B8AF0297081890B768A2@zch01exm26.fsl.freescale.net>
References: <989B956029373F45A0B8AF0297081890B768A2@zch01exm26.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <24BADA7A-1716-43B1-BC92-F4DB7ED0D331@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] qe_lib: export symbols to fix compile error when QE
	drivers compile as modules
Date: Fri, 25 May 2007 07:15:56 -0500
To: Li Yang-r58472 <LeoLi@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Paul <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 24, 2007, at 9:45 PM, Li Yang-r58472 wrote:

>
>> -----Original Message-----
>> From: Kumar Gala [mailto:galak@kernel.crashing.org]
>> Sent: Thursday, May 24, 2007 7:44 PM
>> To: Li Yang-r58472
>> Cc: Paul; linuxppc-dev@ozlabs.org
>> Subject: Re: [PATCH] qe_lib: export symbols to fix compile error when
> QE drivers
>> compile as modules
>>
>>
>> On May 24, 2007, at 4:14 AM, Li Yang wrote:
>>
>>> Export symbols of qe_lib to be used by QE drivers.
>>>
>>> Signed-off-by: Li Yang <leoli@freescale.com>
>>> ---
>>> arch/powerpc/sysdev/qe_lib/ucc.c      |    7 +++++++
>>> arch/powerpc/sysdev/qe_lib/ucc_fast.c |    8 ++++++++
>>> arch/powerpc/sysdev/qe_lib/ucc_slow.c |   12 ++++++++++--
>>> 3 files changed, 25 insertions(+), 2 deletions(-)
>>
>> A number of the EXPORT_SYMBOL() are not used by any in kernel drivers
>> and thus should not be added.  See comments below.  Also, should
>> these be EXPORT_SYMBOL_GPL().
>
> Some of them are not used by in kernel driver, but they are used by  
> some
> off kernel drivers and driver in development.  Shouldn't we export  
> them?

Nope, its been a pretty established rule that we don't export symbols  
for drivers not in the kernel.  These drivers should really be  
submitted for acceptance into the kernel and than we can export the  
symbols they need.

While I can see a need for the *slow* symbols to be exported until  
there is a driver needing them we shouldn't export the symbols.

> I know Linux is again non-GPL modules, but Freescale won't be forcing
> customers to use GPL as long as Linux doesn't ban non-GPL module
> completely.

That's fine.

>>> static void get_cmxucr_reg(int ucc_num, volatile u32 ** p_cmxucr,
>>> u8 * reg_num,
>>> 			   u8 * shift)
>>> @@ -122,6 +126,7 @@ static void get_cmxucr_reg(int ucc_num,
>>> volatile u32 ** p_cmxucr, u8 * reg_num,
>>> 		break;
>>> 	}
>>> }
>>> +EXPORT_SYMBOL(get_cmxucr_reg);
>>
>> remove, you shouldn't be exporting something marked static.
>
> Good catch.
>
> Thanks,
> Leo
