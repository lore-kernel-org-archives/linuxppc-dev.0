Return-Path: <balbir@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2AFB4DDE1E
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Dec 2007 09:03:16 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id lB7M3DCx030948
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Dec 2007 17:03:13 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lB7M3DA2497070
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Dec 2007 17:03:13 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lB7M3CEr008949
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Dec 2007 17:03:13 -0500
Message-ID: <4759C31D.30003@linux.vnet.ibm.com>
Date: Sat, 08 Dec 2007 03:33:09 +0530
From: Balbir Singh <balbir@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] Fake NUMA emulation for PowerPC
References: <20071207211425.10223.91240.sendpatchset@balbir-laptop>
	<4759BCBA.7060800@linux.vnet.ibm.com>
	<4759BE88.3020702@linux.vnet.ibm.com>
	<200712072258.19331.arnd@arndb.de>
In-Reply-To: <200712072258.19331.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	linuxppc-dev@ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Reply-To: balbir@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:
> On Friday 07 December 2007, Balbir Singh wrote:
>> Balbir Singh wrote:
>>> Geert Uytterhoeven wrote:
>>>> On Sat, 8 Dec 2007, Balbir Singh wrote:
>>>>> +   if (strstr(p, "fake="))
>>>>> +           cmdline = p + 5;        /* 5 is faster than strlen("fake=") */
>>>> Really? My gcc is smart enough to replace the `strlen("fake=")' by 5, even
>>>> without -O.
>>>>
>>> Thanks for pointing that out, but I am surprised that a compiler would
>>> interpret library routines like strlen.
>>>
>> I just tested it and it turns out that you are right. I'll go hunt to
>> see where gcc gets its magic powers from.
>>
> 
> Even if it wasn't: Why the heck would you want to optimize this? The function
> is run _once_ at boot time and the object code gets thrown away afterwards!
> 
> 	Arnd <><

Cause, I see no downside of doing it. The strlen of fake= is fixed.
But having said that, I am not a purist about the approach, I just want
cmdline to point after "fake="

-- 
	Warm Regards,
	Balbir Singh
	Linux Technology Center
	IBM, ISTL
