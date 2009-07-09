Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 44032B6F20
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Jul 2009 04:14:41 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8620CDDDE2
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Jul 2009 04:14:40 +1000 (EST)
Message-Id: <29A5B467-BD0F-4270-B5A4-EF79D9405E28@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Dale Farnsworth <dale@farnsworth.org>
In-Reply-To: <20090709163900.GA6549@farnsworth.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: binutils 2.19 issue with kernel link
Date: Thu, 9 Jul 2009 13:14:28 -0500
References: <09159ADA-39F9-419E-AE46-4CFAE612AFB9@kernel.crashing.org>
	<20090709163900.GA6549@farnsworth.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 9, 2009, at 11:39 AM, Dale Farnsworth wrote:

> On Wed, Jul 08, 2009 at 05:41:39PM -0500, Kumar Gala wrote:
>> We are seeing an issue w/ld and kernel linking of 32-bit kernels.
>>
>> The ld from fedora 11 (2.19.51.0.2-17.fc11 20090204) ends not  
>> providing
>> the proper address for _end.
>>
>> Building stock v2.6.30 w/the mpc85xx_defconfig we get:
>>
>> 00001000 A _end
>>
>> Using 2.18.50.20080215 we get:
>>
>> c0680000 A _end
>>
>> If we modify the linker script:
>>
>>      _end2 = .;
>>      _end3 = ALIGN(4096);
>>      _end4 = ALIGN(PAGE_SIZE);
>>      . = ALIGN(PAGE_SIZE);
>>      _end = . ;
>>      PROVIDE32 (end = .);
>>
>> and the result is:
>>
>> 00001000 A _end
>> c067f678 A _end2
>> c0680000 A _end3
>> c0680000 A _end4
>>
>> I used an old version of linker (2.18.50.20080215) and re-linked:
>>
>> c067f678 A _end2
>> c0680000 A _end
>> c0680000 A _end3
>> c0680000 A _end4
>>
>> Any ideas?
>
> We have found the following workaround to be useful.
> Thanks to Andrew Jenner at Code Sourcery.
>
> -Dale
>
> Dale Farnsworth
> MontaVista Software
>
> diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/ 
> vmlinux.lds.S
> index acf237f..34b0181 100644
> --- a/arch/powerpc/kernel/vmlinux.lds.S
> +++ b/arch/powerpc/kernel/vmlinux.lds.S
> @@ -282,4 +282,7 @@ SECTIONS
> 	. = ALIGN(PAGE_SIZE);
> 	_end = . ;
> 	PROVIDE32 (end = .);
> +
> +#undef PPC
> +	.PPC.EMB.apuinfo 0 : { *(.PPC.EMB.apuinfo) }
> }

Is there any plans to fix binutils or is this viewed as not a binutils  
regression?

- k
