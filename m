Return-Path: <cbf123@mail.usask.ca>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe001.messaging.microsoft.com [216.32.180.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2F1022C02EF
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Jul 2013 07:08:47 +1000 (EST)
Message-ID: <51E07056.8040007@mail.usask.ca>
Date: Fri, 12 Jul 2013 15:08:38 -0600
From: Chris Friesen <cbf123@mail.usask.ca>
MIME-Version: 1.0
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: visible memory seems wrong in kexec crash dump kernel
References: <51DF1BBB.5060904@mail.usask.ca> <51DF2229.5010604@mail.usask.ca>
 <20130712012142.GA24112@concordia>
In-Reply-To: <20130712012142.GA24112@concordia>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: kexec@lists.infradead.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, Vivek Goyal <vgoyal@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/11/2013 07:21 PM, Michael Ellerman wrote:
> On Thu, Jul 11, 2013 at 03:22:49PM -0600, Chris Friesen wrote:
>> On 07/11/2013 02:55 PM, Chris Friesen wrote:
>>> Hi,
>>>
>>> I'm running 2.6.34 with kexec 2.0.1 on a Freescale p5020-based system
>>> with 8GB of memory.  (It's an embedded system and I can't do much
>>> about the fact that it's using older software.)
>>
>> I should probably clarify this...I may be able to update kexec, I
>> can't update the kernel but I can backport more recent code if
>> necessary.
>>
>> Looking at the version of kexec that I have, it seems like where x86
>> uses "memmap=" to specify the memory map usable by the capture
>> kernel, powerpc does something different.
>
>  From memory, it's been years, on powerpc we add properties to the memory
> nodes in the device tree that specify which memory is usable. The
> properties are called "linux,usable-memory", and in modern kernels they
> are read in early_init_dt_scan_memory().

I turned on the instrumentation in early_init_dt_scan_memory() and got 
the following when jumping to the capture kernel:

memory scan node memory, reg size 16, data: 0 0 2 0,
  - 0 ,  200000000

That 0x200000000 matches the fact that I'm seeing 8GB of memory 
available in the recovery kernel.

If I boot the original kernel with "crashkernel=224M@32M", should I 
expect that only 224MB is marked as "linux,usable-memory" in the 
recovery kernel?

Chris
