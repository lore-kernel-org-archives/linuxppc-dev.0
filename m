Return-Path: <ankur_maheshwari@procsys.com>
Received: from mailsvr.procsys.com (unknown [61.95.206.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 84A98DDE21
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  8 Sep 2008 16:06:56 +1000 (EST)
Message-ID: <48C4BF6E.9020109@procsys.com>
Date: Mon, 08 Sep 2008 11:30:14 +0530
From: Ankur Maheshwari <ankur_maheshwari@procsys.com>
MIME-Version: 1.0
To: Dave Littell <littelld@verizon.net>
Subject: Re: direct access to Flash from userland
References: <0B45E93C5FF65740AEAE690BF3848B7AD38369@rennsmail04.eu.thmulti.com>	<200809051750.13421.arnd@arndb.de>
	<48C1F9E2.2030502@verizon.net>
In-Reply-To: <48C1F9E2.2030502@verizon.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dave Littell wrote:
> Arnd Bergmann wrote:
>   
>> On Thursday 04 September 2008, Fillod Stephane wrote:
>>     
>>>> Is there a way for a userland application to issue non-CFI commands
>>>> directly to a Flash device?  (This is a 2.6.18-based kernel on a AMCC
>>>> PPC440EPx platform.)
>>>>         
>>> I don't know whether there's specific ioctl for such purpose.
>>> Have you tried to read the mtd source? You may also hack the mtd
>>> layer to add your command. Definitely a question for 
>>> http://www.linux-mtd.infradead.org/mail.html
>>>
>>>       
>> There is no ioctl command for sending arbitrary requests to the
>> flash, but it sounds like something that should be implemented
>> in the kernel, in mtdchar, depending on what the command does.
>>
>> What are you actually trying to do with those commands?
>>
>>     
>
> Hi Arnd,
>
> There are some sector protection options and a user-writable
> one-time-programmable section that's larger than the presently
> implemented 8-byte area that I need to support.
>
>
> Thanks,
> Dave
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>   
Hi Arnd,

You can consider "fw_env" utility (used for changing [read/write] U-boot 
environment variables from Linux) provided with u-boot source. You still 
need to enable mtd-char support.
Please check u-boot-source/tools/env directory for details.

thanks,
Ankur
