Return-Path: <panto@intracom.gr>
Received: from mailserv.intranet.gr (mailserv.intranet.GR [146.124.14.106])
	by ozlabs.org (Postfix) with ESMTP id D35DC67A7D
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 31 Jan 2005 18:15:12 +1100 (EST)
Received: from mailserv.intranet.gr (localhost [127.0.0.1])
	by mailserv.intranet.gr (8.13.1/8.13.1) with ESMTP id j0V7HsHE028147
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 31 Jan 2005 09:17:54 +0200 (EET)
Message-ID: <41FDD9A3.9040604@intracom.gr>
Date: Mon, 31 Jan 2005 09:09:23 +0200
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: robin.gilks@tait.co.nz
References: <41F70114.5040200@tait.co.nz> <41F74169.9050006@intracom.gr>
	<41FD5C91.404@tait.co.nz>
In-Reply-To: <41FD5C91.404@tait.co.nz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: ppc embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: 8xx bus monitoring
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Robin Gilks wrote:
> Pantelis Antoniou wrote:
> 
>> Robin Gilks wrote:
>>
>>> Greetings
>>>
>>> System is a MPC859 based controller.
>>>
>>> I'm trying to determine whether a peripheral is not responding to 
>>> memory fetches by using the bus monitor feature on the Transfer 
>>> Acknowledge (TA) signal. This is set to the maximum count in the Bus 
>>> Monitor Timeout (BMT) in the System Protect Control Register (SYPCR). 
>>> The monitoring is enabled by setting the Bus Monitor Enable (BME) bit 
>>> in SYPCR as well.
>>>
>>> I understand that I can use the Transfer Error Status Register (TESR) 
>>> to read the fact that I have had a timeout by checking the Data 
>>> Transfer Monitor Timeout (DTMT) bit in this register.
>>>
>>> The problem is, how do I know any error has occured so I know to look 
>>> at  the TESR. I can't see a way of generating an exception from this 
>>> condition.
>>>
>>> Any help appreciated.
>>>
>>
>> You get a machine check exception.
>>
>> It's pretty obvious then :)
>>
> 
> Using a 2.4.22 based kernel, as far as I can see a machine check should 
> be trapped (its only allowed to cause a reset in the reboot code I 
> think). Assuming I got it right and it really is trapped, how come I 
> always get a reset:-((
> 
> Any pointers to the code that does setup for causing an exception 
> (rather than reset) would be appreciated.
> 

Check the MSR register at the time of the access.
Is RI set? If not instead of an exception you get a reset...

Regards

Pantelis
