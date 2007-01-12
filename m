Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4EA66DDEF7
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Jan 2007 08:19:01 +1100 (EST)
In-Reply-To: <1168635154.5011.31.camel@localhost.localdomain>
References: <32F3CC26D4DAC44E8ECD07155727A46E816A47@zch01exm20.fsl.freescale.net>
	<1168599942.5011.21.camel@localhost.localdomain>
	<BDC705EB-9078-44FD-800E-D9ADD18B9471@kernel.crashing.org>
	<1168635154.5011.31.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <615F9884-6695-485A-A4B4-A53BD98F969E@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [patch][5/5] powerpc: Add the general support for Embedded
	Floating-Point instructions
Date: Fri, 12 Jan 2007 15:18:15 -0600
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 12, 2007, at 2:52 PM, Benjamin Herrenschmidt wrote:

> On Fri, 2007-01-12 at 12:39 -0600, Kumar Gala wrote:
>> On Jan 12, 2007, at 5:05 AM, Benjamin Herrenschmidt wrote:
>>
>>>
>>>>> Why do we need a separate ret_from_except_spe_full?
>>>>
>>>> I'm not sure if the kernel will return from exception in a multi-
>>>> thread
>>>> way, but the truth is if restoring EVRs in exsiting
>>>> ret_from_except_full,
>>>> some non-SPE exception will try to retore EVR. At that time, the
>>>> MSR[SPE] may not be enabled, which will cause error.
>>>
>>> Hrm... you can restore them before returning from the exception  
>>> if you
>>> are careful about doing that with preempt/irqs off I suppose.
>>
>> Which is what I thought having the exception be EXC_XFER_EE and
>> flush_spe_to_thread should get you.
>>
>> I dont see any reason to dirty up the 'exception' path for stuff we
>> can do in C code.
>
> Well, doing that means that you will flush the SPE to the thread  
> struct
> and disable it, return to userland with SPE disabled, and right away
> take a new exception as soon as the next SPE instruction is reached.
> Maybe not optimal...

Well we could reload the registers on exit if wanted to.  Also, if  
want to be more efficient, we should only flush the registers we need.

I think its a fair assumption that nothing is going to interrupt the  
handling of the exception, so its safe to assume the process causing  
the interrupt will be the same one we return to.

- k
