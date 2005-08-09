Return-Path: <kumar.gala@freescale.com>
In-Reply-To: <20050809162133.GL3187@smtp.west.cox.net>
References: <20050809162133.GL3187@smtp.west.cox.net>
Mime-Version: 1.0 (Apple Message framework v733)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B154269E-A429-47B3-B088-68C9BECD9A1C@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Tue, 9 Aug 2005 12:41:54 -0500
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc64-dev@ozlabs.org, Geert Uytterhoeven <geert@linux-m68k.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>
Subject: Re: Merging ppc32 and ppc64
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 9, 2005, at 11:21 AM, Tom Rini wrote:

> On Tue, Aug 09, 2005 at 10:01:05AM -0500, Kumar Gala wrote:
>
>>> I think you are both right, just using different terminology. The
>>> running kernel uses its own representation of the device tree, which
>>> is neither the flattened stuff nor using the OF interfaces. The
>>> conversion from OF to the flattened tree is done by the kernel
>>>
> itself.
>
>>>
>>>      Apple OF  \
>>>          SLOF   \
>>>       pSeries    |-1- prom_init------,
>>>          PIBS   /                     \
>>>           ...  /                       \
>>>                                         \
>>>       other    -----------------------------2--
>>> unflatten_device_tree--3--
>>>   boot loader                              /
>>>                                           /
>>>       iSeries  ----------- early_setup---`
>>>
>>> All "regular" machines enter in the traditional prom_init path (1)
>>> from Open Firmware. The embedded machines that are too memory
>>> constraint
>>> to use SLOF have a flattened device tree in their boot loader and  
>>> the
>>> legacy iSeries boxes can fake the device tree in their
>>> iSeries_early_setup
>>> function. The main entry point (2) is entered by all machines when
>>>
> the
>
>>> flattened device tree is there and the kernel builds its tree
>>> representation
>>> for run time (3).
>>>
>>
>> I guess my point is that in the "new" powerpc arch doing steps 1 & 3
>> should no longer be part of the kernel proper.  The should be handled
>>
>
>
>> by boot wrappers of some form.  I know Ben tool care to ensure that
>> prom_init was isolated from kernel proper and I'm suggesting we move
>> it into a boot wrapper going forward.
>>
>
> That's not 100% true because as Segher said, prom_init.c is part of  
> the
> kernel (tree, image), but is what does the translation.

I'm not sure I follow.  I understand that prom_init.c is part of the  
kernel in ppc64.  I'm saying that such things should NOT be part of  
the arch/powerpc kernel going forward.  They should be handled via  
bootwrappers.

- kumar
