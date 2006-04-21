Return-Path: <wojciech.kromer@dgt.com.pl>
Received: from dgt.com.pl (mail.dgt.com.pl [195.117.141.2])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6C71E67A65
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 21 Apr 2006 16:42:23 +1000 (EST)
Message-ID: <44487EB9.6090600@dgt.com.pl>
Date: Fri, 21 Apr 2006 08:42:01 +0200
From: Wojciech Kromer <wojciech.kromer@dgt.com.pl>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Re: Upgrading cramfs root file system
References: <200604062238.17972.antonio.dibacco@aruba.it>	<4445E9E1.50204@dgt.com.pl>	<200604202154.45963.antonio.dibacco@aruba.it>
	<20060420221801.55331e15@White64>
In-Reply-To: <20060420221801.55331e15@White64>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dnia 2006-04-20 22:18, Użytkownik White napisał:
> make it easy: if you start an application which do the flash and after
> this a reset.. nothing should happen. I do it that way.
> the application resist completly in RAM .. and all important libs are
> in RAm or in Filesystem Cache.
> It's only important that you pretend any Application from accessing
> Datafiles or start of new application ...
>
> Alternativly, you can put it in a reserved RAM Area ( mark it not
> usable by Linux) and put a Flash Code in your Bootloader (U-boot?)
> after a reset....
>
> But overwrite a cramfs works for me on >100 times without problems.
>
>   

Problems with changing cramfs  and reboot may vary depending on changes 
made to filesystem.
You can't even call reboot, bacause it's not in the prevoius location 
after changing flash.

> Am Thu, 20 Apr 2006 21:54:45 +0200 schrieb Antonio Di Bacco
> <antonio.dibacco@aruba.it> :
>
>   
>> Yes you are right, it is not a good idea to overwrite working cramfs 
>> filesystem. But what happens if I download the new cramfs plus kernel in RAM, 
>> do a checksum and then, completely in kernel mode, disabling all the 
>> interrupts, I write to flash? No process could complain that I am overwriting 
>> because no one is executing.
>>
>>     
Maybe such feature should be added to MTD code.
But disabling interrupts may cause watchdog reset in most embedded 
platforms.
