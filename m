Return-Path: <miltonm@bga.com>
Received: from mercury.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id CC57CDDE25
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Feb 2009 03:45:08 +1100 (EST)
In-Reply-To: <cb298a870902041048v57391b62l7701933465b7f43c@mail.gmail.com>
References: <cb298a870901231259h6bd1ae2ag2baeb20173219664@mail.gmail.com>
	<02f6bf324a381ee5c2fc5e91313dbca9@bga.com>
	<cb298a870902041048v57391b62l7701933465b7f43c@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <94c75807ec390be91bde1452536bae51@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: Maple PPC970 kexec crash-dump problems
Date: Fri, 6 Feb 2009 10:53:14 -0600
To: Benjamin Walsh <walsh.benj@gmail.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 4, 2009, at 12:48 PM, Benjamin Walsh wrote:

> Hi Milton,
>
> I've tracked it down to the device tree passed to the second kernel=20
> being screwed-up when patched by kexec-tools. Namely, it was creating=20=

> linux,usable-memory entries that were wrong, and the MMU=20
> initialization hung when it failed allocating for the page tables. I=20=

> hacked the tool, and got passed that point in the init sequence, but=20=

> the very first IO mapped access fails, so the MMU doesn't seem to be=20=

> set up correctly.

I would need more details exactly what you think is wrong.

How does it fail?

If the first IO mapped access fails, then I would ask if you are using=20=

IOMMU.  It is quite possible that the dart iommu code needs to be=20
modified to use the existing mapping table instead of allocating a new=20=

table, otherwise any existing mappings being used by inflight dma would=20=

fail and the that might cause mmio loads to wait for uncompletable dma=20=

writes.   Just a theory with the lack of information you gave me.


>
> Anyway, up to my question: is the crash dump (kdump) kernel supposed=20=

> to use the memory reserved for it by the first kernel for its working=20=

> memory ? e.g. On that board, I have 0->2GB and 4->6GB for a total of=20=

> 4GB of RAM. Let's say I reserve 128M@32M, that's 0x2000000->0xa000000.=20=

> Is the second kernel supposed to use
>
> (0x2000000+<kernel size>) -> 0xa000000
>
> for its memory pool and leave everything else:
>
> 0->0x2000000, 0xa000000 -> 80000000, 0x100000000 -> 0x180000000
>
> as memory that is from the first kernel, used to debug it ?


Yes, but that is not quite how the device tree is formed.

The second kernel will also use the interrupt vector area at address 0.=20=

  Therefore that is saved as the backup region in purgatory to the=20
address allocated in the kdump region.  =10The device tree is then=20
created with linux,usable-memory regions extending the kdump region=20
back to 0, and a reserve entry marking the area as reserved.

In addition, the device tree gets the memory backing tce tables for=20
pseries smp mode.  It may need the page with the dart table, marked=20
reserved, so that the table gets added to the linear map -- except it=20
should be mapped cache inhibited so that may not work either.

>
> Basically, I am trying to figure out if I patched the tool correctly.
>
> Thanks,
> Ben
>
> On Sat, Jan 24, 2009 at 2:52 AM, Milton Miller <miltonm@bga.com> =
wrote:
>> On Sat Jan 24 at 07:59:47 EST in 2009, Benjamin Walsh wrote:
>>> I am trying to use kexec with a crash dump kernel on a Maple board=20=

>>> (Motorola
>>>  ATCA6101 to be precise). This board is running a two-CPU PPC970FX.=20=

>>> I am
>>>  running a 2.6.27-10 kernel and have tried both older kexec-tools=20
>>> and the
>>>  newest ones. I have tried SMP and non-SMP kernels.
>>
>>  Once you start the second cpu it is likly executing instructions=20
>> somewhere.
>>
>>  Priory to 2.6.27 you had to compile a fixxed offset kerenl to run=20
>> kdump. =A0With 2.6.27 that option was removed and replaced with teh=20=

>> relocatable kerenl. =A0However, becasue of the way linux interacts =
with=20
>> open firmware, the kernel will still move itself to 0 unless a=20
>> specific flag is set. =A0 The location of the flag was changed twice=20=

>> during the merge process, and the patches for kexec-tools were not=20
>> made until early this year.
>>
>>
>>> Using kexec -l to fast boot works correctly. However, loading a=20
>>> crash dump
>>>  kernel and triggering a crash via echo c > /proc/sysrq-trigger=20
>>> simply hangs
>>>  the board. I have traced the sequence down to after the call to
>>>  kexec_copy_flush(), when the CPU returns to real-address mode (bl
>>>  real_mode). At this point I have no further debugging information.
>>
>>
>>> Two things could help me:
>>>
>>>  - Getting the fix if this is a known issue and a fix exists. I have=20=

>>> looked
>>>  at recent patches and nothing lept to mind, mostly relocatable=20
>>> kernel
>>>  support.
>>
>>  That is a major change.
>>
>>  That said, I don't know if anyone has tested kexec panic beyond=20
>> pseries for 64 bit powerpc.
>>
>>  I know Paul originally prototyped the relocatable patch on a=20
>> powermac, but I dont' know what if any smp testing he performed. =A0=20=

>> And you said you are actualy on maple not a powermac, so the startup=20=

>> issues are different.
>>
>>
>>> - Obtaining the address of the serial port @3f8 in real mode. The=20
>>> init
>>>  sequence with udbg ON says that the physical address of the port is
>>>  0xf40003f8; however, setting it up in poll mode and trying to stuff
>>>  characters in the tx buffer doesn't produce anything.
>>
>>  Ah yes. =A0In real mode you can only talk to cacheable memory =
without=20
>> implementation specific assistance. =A0However, if you look in the=20
>> kernel for the maple early udbg support, you will find the code you=20=

>> need to talk to that serial port in real mode.
>>
>>
>>>
>>>  Has anyone recently tried to use the serial port in real mode ?
>>>
>>>  Thanks for any help.
>>>
>>>  Ben
>>
>>  Hope this gets you started. =A0I wrote a lot of the kernel code, but =
I=20
>> had the advantage of external jtag access to the processor to see=20
>> where it when ended up when it went astray.
>>
>>  milton
>>
