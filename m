Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 8336BDE105
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 13:15:33 +1100 (EST)
Message-ID: <49B7167C.9000004@ru.mvista.com>
Date: Wed, 11 Mar 2009 04:40:12 +0300
From: Valentine <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: Mikhail Zolotaryov <lebon@lebon.org.ua>
Subject: Re: [PATCH] PowerPC 440EPx/GRx fix memory size calculation
References: <20090310195013.GA27835@ru.mvista.com>
	<49B6D427.5050600@lebon.org.ua>
In-Reply-To: <49B6D427.5050600@lebon.org.ua>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mikhail Zolotaryov wrote:
> Valentine Barshak wrote:
>> According to the AMCC 440EPX/GRX user manual,
>> the Chip Select width is always fixed at 1 bit no matter
>> what is actually read from register DDR_10.
>
> Well, from my point of view original kernel code is correct in this part.
>
> Adding one bit into memory address means multiplying memory size by 2 
> i.e. cs=2. The question is: is Chip Select bit used in memory address. 
> ChipSelect input of memory chip enables or disabled it, so if we have 
> only one BankSel installed/connected (DDR0_10[22:23] is 01 or 10) 
> there's no need to use Chip Select bit in an address. On the contrary, 
> if both BankSel lines are connected (DDR0_10[22:23] is 11), to let 
> memory controller know which memory rank to use, Chip Select bit is 
> added into memory address. (and yes, if DDR0_10[22:23] is 00 - no 
> ranks installed, memory size is 0, cs=0)
Yes, you could phrase it that way. According to the PPC440EPx manual, 
the total memory size is calculated based on the following formula:
memsize = cs * (1 << (col+row)) * bank * dpath;
So, if both chipselects are used, we add an extra bit to the memory 
address to distinguish between these chipselects.
There's nothing wrong with this part of the code.
The problem is that the controller is hardwired to use only one 
chipselect, even if both are enabled in the DDR0_10 on PPC440EPx/GRx 
processors.
So, the patch provides a workaround to always use single cs for 
440EPx/GRx (use predefined value instead of reading DDR0_10).
>
> Original kernel code use exactly the same logic as I described above. 
> Please suggest if it's wrong.
Thanks,
Valentine.
