Return-Path: <fkan@amcc.com>
Received: from sdcmail02.amcc.com (sdcmail02.amcc.com [198.137.200.73])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "Messaging Gateway Appliance Demo Cert",
	Issuer "Messaging Gateway Appliance Demo Cert" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 6B2D9DDFD6
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Mar 2009 10:12:31 +1100 (EST)
Message-ID: <49BAE5E1.7080606@amcc.com>
Date: Fri, 13 Mar 2009 16:01:53 -0700
From: Feng Kan <fkan@amcc.com>
MIME-Version: 1.0
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH] PowerPC 440EPx/GRx fix memory size calculation
References: <49B58779.9040905@lebon.org.ua><20090311103716.GE26415@zod.rchland.ibm.com><49B80BA3.1090301@ru.mvista.com>
	<200903120702.03286.sr@denx.de>
In-Reply-To: <200903120702.03286.sr@denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, lebon@lebon.org.ua
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Guys:
     Sequoia uses on board discrete memory with one rank. So one chip 
select would be fine.
Turning on both won't matter, since the other cs is never used.

Feng Kan

 Stefan Roese wrote:
> On Wednesday 11 March 2009, Valentine Barshak wrote:
>   
>> I've been looking at the docs once again and actually I couldn't find an
>>    explanation there. And I don't have that e-mail from AMCC support
>> that I got a while back regarding the issue anymore.
>> There might have been some misunderstanding.
>> The docs (PPC440EPX UM 19.2 Device Address Mapping) say that the chip
>> select field width is always fixed at one bit, but this doesn't actually
>>   mean that there's always one chip select used.
>> The patch works fine on Sequoia and another Sequoia-like board with 1GB
>> RAM installed, but it might not work with 2GB RAM. I've tried to play
>> with DDR0_10 settings and Sequoia works fine regardless of what's
>> actually written to DDR0_10.
>> So, probably the best way would be to fix that in u-boot
>> amcc/sequoia/sdram.c by doing mtsdram(DDR0_10, 0x00000100); instead of
>> mtsdram(DDR0_10, 0x00000300);
>> Sorry, for confusion, but after reviewing the docs, I think that
>> only REDUC interpretation has to be fixed. The chips select part should
>> be fixed in u-boot sdram code for Sequoia as was originally proposed by
>> Mikhail.
>>
>> Stefan, could you please take a look?
>>     
>
> I'll apply the U-Boot patch today. But as Josh pointed out, we should try to 
> find a way for the bootwrapper to work in all cases.
>
> Best regards,
> Stefan
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>
>   
