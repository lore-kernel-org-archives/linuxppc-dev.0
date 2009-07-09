Return-Path: <dale@farnsworth.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 38CE2B7069
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Jul 2009 05:06:28 +1000 (EST)
Received: from xyzzy.farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DB004DDDA0
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Jul 2009 05:06:27 +1000 (EST)
Date: Thu, 9 Jul 2009 12:06:21 -0700
From: Dale Farnsworth <dale@farnsworth.org>
To: Kumar Gala <galak@kernel.crashing.org>
Message-ID: <20090709190621.GB6549@farnsworth.org>
References: <09159ADA-39F9-419E-AE46-4CFAE612AFB9@kernel.crashing.org>
	<20090709163900.GA6549@farnsworth.org>
	<29A5B467-BD0F-4270-B5A4-EF79D9405E28@kernel.crashing.org>
MIME-Version: 1.0
In-Reply-To: <29A5B467-BD0F-4270-B5A4-EF79D9405E28@kernel.crashing.org>
Subject: Re: binutils 2.19 issue with kernel link
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 09, 2009 at 01:14:28PM -0500, Kumar Gala wrote:
> On Jul 9, 2009, at 11:39 AM, Dale Farnsworth wrote:
>> We have found the following workaround to be useful.
>> Thanks to Andrew Jenner at Code Sourcery.
>>
>> -Dale
>>
>> Dale Farnsworth
>> MontaVista Software
>>
>> diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/ 
>> vmlinux.lds.S
>> index acf237f..34b0181 100644
>> --- a/arch/powerpc/kernel/vmlinux.lds.S
>> +++ b/arch/powerpc/kernel/vmlinux.lds.S
>> @@ -282,4 +282,7 @@ SECTIONS
>> 	. = ALIGN(PAGE_SIZE);
>> 	_end = . ;
>> 	PROVIDE32 (end = .);
>> +
>> +#undef PPC
>> +	.PPC.EMB.apuinfo 0 : { *(.PPC.EMB.apuinfo) }
>> }
>
> Is there any plans to fix binutils or is this viewed as not a binutils  
> regression?

It sure looks like a regression to me, but I don't have details on
a potential fix.

-Dale
