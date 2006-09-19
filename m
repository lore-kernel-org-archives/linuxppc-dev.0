Return-Path: <jonandia@aotek.es>
Message-ID: <450FE61C.6050006@fagorautomation.es>
Date: Tue, 19 Sep 2006 14:44:12 +0200
From: Josu Onandia <jonandia@fagorautomation.es>
MIME-Version: 1.0
To: Esben Nielsen <nielsen.esben@gogglemail.com>
Subject: Re: Measure Interrupt Latency on MPC5200B
References: <ac3922a00609140500j79e33fb3lfecbefc151ce3b41@mail.gmail.com><45
	0FDCFD.9040102@fagorautomation.es>
	<Pine.LNX.4.64.0609191414090.10784@frodo.shire>
In-Reply-To: <Pine.LNX.4.64.0609191414090.10784@frodo.shire>
Content-Type: text/plain;
	charset=ISO-8859-1;
	format=flowed
Cc: Linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Esben Nielsen wrote:

> On Tue, 19 Sep 2006, Josu Onandia wrote:
>
>> Syed Amer Gilani wrote:
>>
>>> We have a MPC5200B(ppc) Board from Phytec, running with a 2.6 Linux
>>> Kernel. For Documentation purposes and testings how patches to the
>>> Kernel affects real time capabilities we want to measure the Interrupt
>>> Latency.
>>> I only found tools for other arches or patches for far to old kernels.
>>> Does somebody know a way for a 2.6 kernel on ppc? I already thought of
>>> generating a signal on an Output of the Board and measure it with a
>>> Oscilloscope but i don't find that method satisfying.
>>>
>>> Thank you in advance,
>>> Syed Amer Gilani
>>> _______________________________________________
>>> Linuxppc-embedded mailing list
>>> Linuxppc-embedded@ozlabs.org
>>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>>>
>>>
>> Hi. I'm sorry for my own latency, but I've been very busy.
>>
>> I'm measuring interrup latency in an MPC5200B, too, but with Linux 2.4.
>>
>> With this processor you can use the TB registers to measure a lapse 
>> of time.
>>
>> I use a GPT timer to generate a periodic interrupt. From the interrupt
>> routine I read the TBL and compare it with the expected value.
>>
>> I do this using RTAI, because I need real-time response to interrupts,
>> but I suppose that with little effort you can port it to standard Linux.
>>
>> If you want more details, or my actual source code, email me.
>>
>> Josu Onandia
>>
>>
>
> What are your results under the normal kernel and under RTAI?
> Have anyone tried with -rt kernels? What are the results?
>
> I work for a company using MPC5200 with VxWorks. It could be fun to 
> compare numbers...
>
> Esben

This is a Lite5200B running at 462MHz, kernel 2.4.25 and RTAI 24.1.11, 
from Denx.

I haven't tried under normal kernel. With RTAI I have 1,5usec from the 
actual interrupt until RTAI call my ISR function. This adds the 
processor latency plus the RTAI dispatcher overhead. With heavy IO load, 
ethernet and disk, the maximum is 8usec.

I'd really like to see your results, to compare with a real RTOS.

Josu
