Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 48872DDF93
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2009 10:08:21 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n2BN5VJQ022591
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 19:05:31 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n2BN8I0e186996
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 19:08:18 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n2BN8HNM026940
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 19:08:18 -0400
Date: Wed, 11 Mar 2009 19:07:51 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Valentine <vbarshak@ru.mvista.com>
Subject: Re: [PATCH] PowerPC 440EPx/GRx fix memory size calculation
Message-ID: <20090311230751.GA3788@zod.rchland.ibm.com>
References: <49B58779.9040905@lebon.org.ua>
	<20090310195013.GA27835@ru.mvista.com>
	<20090311103716.GE26415@zod.rchland.ibm.com>
	<49B80BA3.1090301@ru.mvista.com>
	<20090311215728.GA12676@zod.rchland.ibm.com>
	<49B8367B.5060402@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <49B8367B.5060402@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>, lebon@lebon.org.ua
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 12, 2009 at 01:08:59AM +0300, Valentine wrote:
>>> So, probably the best way would be to fix that in u-boot
>>> amcc/sequoia/sdram.c by doing mtsdram(DDR0_10, 0x00000100); instead 
>>> of  mtsdram(DDR0_10, 0x00000300);
>>> Sorry, for confusion, but after reviewing the docs, I think that
>>> only REDUC interpretation has to be fixed. The chips select part 
>>> should  be fixed in u-boot sdram code for Sequoia as was originally 
>>> proposed by  Mikhail.
>>
>> Ok, so we're back to using Mikhail's original patch then?
>>
>> josh
>
> Yes, but until u-boot is fixed this will break Sequoia/Rainier support.

Well, that's sort of a problem.  The wrapper will have to deal with both
a fixed and unfixed u-boot because not everyone will update their u-boot
with the fix.

So we need a patch for the wrapper that works in all cases.

josh
