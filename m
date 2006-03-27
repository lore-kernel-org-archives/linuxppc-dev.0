Return-Path: <antonio.dibacco@aruba.it>
Received: from mx1.aruba.it (mxaruba.aruba.it [62.149.128.10])
	by ozlabs.org (Postfix) with SMTP id 2CE9067B22
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 27 Mar 2006 20:38:28 +1100 (EST)
Message-ID: <20060327093822.480.qmail@mx1.aruba.it>
References: <20060327064907.23992.qmail@mx1.aruba.it>
	<200603270953.11079.roger.larsson@norran.net>
	<4427A9C1.3060000@berghof.com>
In-Reply-To: <4427A9C1.3060000@berghof.com> 
From: "antonio.dibacco" <antonio.dibacco@aruba.it>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Interpreting /proc/meminfo. How much free memory do I have?
Date: Mon, 27 Mar 2006 09:38:22 GMT
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I don't understand the meaning of "Inactive". They are not used but the 
kernel cannot give this memory to a requesting process because we tipically 
don't have a swap device on a linux embedded board. Where we can store the 
Inactive page? Am I wrong?
If I run a process that continuosly allocates memory and print out the total 
allocated memory when it receives SIGINT or SIGTERM, I think I get the real 
"free memory"! 

Bye,
Antonio. 

Eberhard Stoll Scrive: 

> Roger Larsson schrieb: 
> 
>>On måndag 27 mars 2006 08.49, antonio.dibacco wrote:
>>   
>>
>>>Hi, 
>>>
>>>I'm a little bit puzzled with the fields in /proc/meminfo. Which fields
>>>have I to sum up to get the amount of free memory?
>>>     
>>>
>>
>>>From a 2.6 /proc/meminfo
>>
>>MemTotal:       515532 kB
>>MemFree:          6012 kB
>>Buffers:         79964 kB
>>Cached:          83264 kB
>>SwapCached:      82840 kB
>>Active:         294024 kB
>>Inactive:       130304 kB
>>- - - 
>>
>>Completely free is only MemFree. But those pages are only needed for
>>interrupt handlers (close enough). 
>>
>>Cached pages are also free but since they contain data that maybe will
>>be needed again (unmodified data that already is on disk) they are not
>>returned to MemFree state. 
>>
>>Inactive pages has not been in use for awhile and can be written out
>>if needed (some are probably unmodified and quick to get)
>>   
>>
> Active + Inactive + MemFree is not equal MemTotal. Where can i find the
> offset? 
> 
> Thanks,
> Eberhard 
> 
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
 
