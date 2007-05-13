Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <46465511.3090000@gmail.com>
References: <20070510200237.GA19756@mag.az.mvista.com>	<20070510200859.GL19756@mag.az.mvista.com>	<20070510233747.GC27188@localhost.localdomain>
	<c3bcf08004bf1d35292b8a5661e6a6e6@kernel.crashing.org>
	<46465511.3090000@gmail.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <70c9e7f82599a85ba1ae974e11db1d8f@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 11/13] powerpc: Add DTS file for the Motorola PrPMC2800
	platform
Date: Sun, 13 May 2007 02:21:31 +0200
To: Jerry Van Baren <gvb.linuxppc.dev@gmail.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>> +			partition-names = "FW Image A\0FW Config Data\0Kernel 
>>>> Image\0Filesystem\0FW Image B";
>>> dtc now supports the syntax:
>>> 	partition-names = "FW Image A", "FW Config Data", ...
>>> for multi-string properties to make this sort of thing less ugly.
>> Nice!  Can you also concatenate different property
>> encodings that way?  Like,
>> 	slot-names = <5>, "Slot A", "Slot C";
>> or something like that?
>> Segher
>
> Hi Segher,
>
> That doesn't make sense to me.  It would be a bugger to understand the 
> value of "slot-names" since <5> is a number and the rest are strings. 
> How do you know it is a number?  How do you know how big it is?

You know that since it is how that particular property is
defined: it is one integer (i.e., 32-bit big-endian),
followed by a string (zero-terminated) for each set bit
in the integer.

A property is always just an array of bytes; its meaning
is determined by what property in what node this is.
Nowhere in a property is is encoded that some parts are
integers, some parts are strings, some parts are just
blobs.

> If <5> is a single byte, it will look like "\05Slot A\0Slot C" (ASCII 
> <ENQ> as the first character of two concatenated strings).  If it is a 
> 4 or 8 byte integer, it will have preceding "nulls" (big endian) which 
> would be even worse.

Not bad at all -- it is trivial to decode _if_ you know
how it is encoded.  You cannot tell by looking at the
property data only.  What is [44 54 53 00] -- just some
bytes, or the integer 0x44545300, or the string "DTS"?
You cannot tell.

> It seems to me that it would be much better as
>   slot-names = "5", "Slot A", "Slot C";
> and do an atoi() conversion if you detect it is or expect it to be 
> numeric.

Hey, I know!  We could redefine OF to use XML instead!

;-)


Segher
