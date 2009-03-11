Return-Path: <jwboyer@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.234])
	by ozlabs.org (Postfix) with ESMTP id B75E6DDD0C
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2009 08:57:55 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id l9so204151rvb.9
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 14:57:53 -0700 (PDT)
Sender: Josh Boyer <jwboyer@gmail.com>
Date: Wed, 11 Mar 2009 17:57:28 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: [PATCH] PowerPC 440EPx/GRx fix memory size calculation
Message-ID: <20090311215728.GA12676@zod.rchland.ibm.com>
References: <49B58779.9040905@lebon.org.ua>
	<20090310195013.GA27835@ru.mvista.com>
	<20090311103716.GE26415@zod.rchland.ibm.com>
	<49B80BA3.1090301@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <49B80BA3.1090301@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>, lebon@lebon.org.ua
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 11, 2009 at 10:06:11PM +0300, Valentine Barshak wrote:
> Josh Boyer wrote:
>> On Tue, Mar 10, 2009 at 10:50:13PM +0300, Valentine Barshak wrote:
>>> I was just going to submit a patch for that too.
>>> Indeed, the denali_fixup_memsize() miscalculated a couple of address
>>> field widths. We were lucky to eventually get the right result,
>>> because the effect of the first error was killed by the other one.
>>> According to the AMCC 440EPX/GRX user manual,
>>> the Chip Select width is always fixed at 1 bit no matter
>>> what is actually read from register DDR_10.
>>> The workaround is to use a predefined chipselect value for 440EPx/GRx.
>>> Also, setting the REDUC bit (REDUC = 1) enables 32-bit data path.
>>> If REDUC = 0, full data path of 64 bits is used.
>>>
>>> Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
>>> Signed-off-by: Mikhail Zolotaryov <lebon@lebon.org.ua>
>>
>> I've been looking over this one a bit more.  At the moment, I'm inclined
>> to queue this up in my -next branch.  I would like to see if Mikhail
>> could test it though, and have Valentine answer the question in the hard
>> wired part.
>
> I've been looking at the docs once again and actually I couldn't find an  
>   explanation there. And I don't have that e-mail from AMCC support that 
> I got a while back regarding the issue anymore.
> There might have been some misunderstanding.
> The docs (PPC440EPX UM 19.2 Device Address Mapping) say that the chip  
> select field width is always fixed at one bit, but this doesn't actually  
>  mean that there's always one chip select used.
> The patch works fine on Sequoia and another Sequoia-like board with 1GB  
> RAM installed, but it might not work with 2GB RAM. I've tried to play  
> with DDR0_10 settings and Sequoia works fine regardless of what's  
> actually written to DDR0_10.
> So, probably the best way would be to fix that in u-boot
> amcc/sequoia/sdram.c by doing mtsdram(DDR0_10, 0x00000100); instead of  
> mtsdram(DDR0_10, 0x00000300);
> Sorry, for confusion, but after reviewing the docs, I think that
> only REDUC interpretation has to be fixed. The chips select part should  
> be fixed in u-boot sdram code for Sequoia as was originally proposed by  
> Mikhail.

Ok, so we're back to using Mikhail's original patch then?

josh
