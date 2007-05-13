Return-Path: <gvb.linuxppc.dev@gmail.com>
Message-ID: <4647098D.9050901@gmail.com>
Date: Sun, 13 May 2007 08:50:21 -0400
From: Jerry Van Baren <gvb.linuxppc.dev@gmail.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 11/13] powerpc: Add DTS file for the Motorola PrPMC2800
	platform
References: <20070510200237.GA19756@mag.az.mvista.com>	<20070510200859.GL19756@mag.az.mvista.com>	<20070510233747.GC27188@localhost.localdomain>
	<c3bcf08004bf1d35292b8a5661e6a6e6@kernel.crashing.org>
	<46465511.3090000@gmail.com>
	<70c9e7f82599a85ba1ae974e11db1d8f@kernel.crashing.org>
In-Reply-To: <70c9e7f82599a85ba1ae974e11db1d8f@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool wrote:
>>>>> +            partition-names = "FW Image A\0FW Config Data\0Kernel 
>>>>> Image\0Filesystem\0FW Image B";
>>>> dtc now supports the syntax:
>>>>     partition-names = "FW Image A", "FW Config Data", ...
>>>> for multi-string properties to make this sort of thing less ugly.
>>> Nice!  Can you also concatenate different property
>>> encodings that way?  Like,
>>>     slot-names = <5>, "Slot A", "Slot C";
>>> or something like that?
>>> Segher
>>
>> Hi Segher,
>>
>> That doesn't make sense to me.  It would be a bugger to understand the 
>> value of "slot-names" since <5> is a number and the rest are strings. 
>> How do you know it is a number?  How do you know how big it is?
> 
> You know that since it is how that particular property is
> defined: it is one integer (i.e., 32-bit big-endian),
> followed by a string (zero-terminated) for each set bit
> in the integer.

[snip]

> Not bad at all -- it is trivial to decode _if_ you know
> how it is encoded.  You cannot tell by looking at the
> property data only.  What is [44 54 53 00] -- just some
> bytes, or the integer 0x44545300, or the string "DTS"?
> You cannot tell.

OK.  I was coming from the u-boot "fdt print" command.  We do a pretty 
good job of guessing the print format (byte/word/long/string/strings), 
but this would fail the detection circuitry and be printed as a byte 
array [00, 00, 00, 05, 44, 54, ...] (the default format) because it 
takes a-priori knowledge to print it in the original input format.  Not 
quite as pretty, but NBD.

>> It seems to me that it would be much better as
>>   slot-names = "5", "Slot A", "Slot C";
>> and do an atoi() conversion if you detect it is or expect it to be 
>> numeric.
> 
> Hey, I know!  We could redefine OF to use XML instead!
> ;-)

Oooo Oooo Oooo.  No wait, we're embedded, we march to the beat of a 
different drummer.  Nevermind.  :-D

> Segher

Thanks,
gvb
