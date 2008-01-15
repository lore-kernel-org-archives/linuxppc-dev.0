Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D3CC0DDE3A
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jan 2008 01:38:20 +1100 (EST)
Message-Id: <F67546F0-C4CA-4291-85CD-C006DC04620C@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Liu Yu <Yu.Liu@freescale.com>
In-Reply-To: <6EBEC19BF4A8F843BCD6B9155BBE2515D1B58B@zch01exm26.fsl.freescale.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH] Fix carry bug in 128-bit unsigned integer adding
Date: Tue, 15 Jan 2008 08:37:55 -0600
References: <11996295742378-git-send-email-Yu.Liu@freescale.com>
	<7040EDB2-7E89-4BBD-A4FC-50E168F9286F@kernel.crashing.org>
	<6EBEC19BF4A8F843BCD6B9155BBE2515D1B58B@zch01exm26.fsl.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 8, 2008, at 9:05 PM, Liu Yu wrote:

>
>>
>> take a look at how include/math-emu/op-4.h implements
>> __FP_FRAC_ADD_4 & __FP_FRAC_SUB_4.  Will that fix the bug, if
>> so we should make the code match how its done there.
>>
>> - k
>>
>>
>
> The macro define __FP_FRAC_ADD_4 is below. It can fix the carry bug.
> But still exist a problem that r[0-2] and x[0-2] cannot be referred to
> the same variable.
> If r0 and x0 are the same variable, the comparison ( r0 < x0 ) will
> always fail.
> I don't know whether we need to fix this problem.

Not sure.  Probably worth asking this on the glibc list and see if  
they have theories.  (For the short term I'd say lets use the version  
from include/math-emu/op-4.h as a fix.  If r0 & x0 can be the same  
variable the bug exists in a lot more places (glibc soft-fp and  
generic kernel mathemu)

- k
