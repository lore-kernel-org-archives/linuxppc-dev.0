Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <46B1F6D4.3070707@ru.mvista.com>
References: <20070730150648.GA5005@ru.mvista.com>	<20070801020836.GB31391@localhost.localdomain>	<65ff446478a9fd0a48061079d5f04f8f@kernel.crashing.org>	<20070801050422.GI31391@localhost.localdomain>
	<20070801054751.GM31391@localhost.localdomain>
	<46B1F6D4.3070707@ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <64f3aef4501de8fc5a72f58def7d6ade@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/6] PowerPC 440EPx: Sequoia DTS
Date: Mon, 6 Aug 2007 22:12:07 +0200
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> +     - compatible : should contain the specific model of flash 
>> chip(s) used
>> +       followed by either "cfi-flash" or "jedec-flash"
>
>    This "compatible" prop (and the node in whole) doesn't say a thing 
> about how the flash is mapped into the CPU address space.

...and it shouldn't.  That's what "ranges" properties in all
the various (grand-)parents of the node are for.

> I strongly disagree that this node provides enough info to select a 
> driver. :-/

If Linux needs more information than what the device _is_, but
also needs information about how it is _used_ on some particular
hardware, to select a driver; then it can bloody well do so.
Nowhere is it said that an OS can _only_ use "compatible" properties
to do its driver selection.

>> +     - reg : Address range of the flash chip
>> +     - bank-width : Width (in bytes) of the flash bank.  Equal to 
>> the device width
>> +       times the number of interleaved chips.
>> +     - device-width : (optional) Width of a single flash chip.  If 
>> omitted,
>> +       assumed to be equal to 'bank-width'.
>
>    Why then not just introduce the "interleave" prop and obsolete the
> "bank-width"?

Because "interleave" is overly complicated and still doesn't handle
all cases.  Also, it's a more confusing name.

The goal here is to handle 98% (or just 90% even) of all cases in
as simple a way as possible; everything else can get special handling
later.

>> +    Flash partitions
>> +     - reg :
>> +     - read-only : (optional)
>
>    All that would look nice but partition is even less of a device 
> than the
> original "rom" node was... well, who cares now? :-)

Some partitions can be useful for the firmware itself, or for
early boot stages; those should be described in the device
tree in some way.  And yes, you certainly can consider an
(aligned) flash partition to be a subdevice of the whole flash
bank.

>    Oh, I see that the new partition representation have really 
> simplified
> parsing -- this function is hardly shorter than the old one... :-P

Neither simplifying machine-parsing nor compacting the kernel
code are a goal at all, I don't see why you bring this up.

>>   static struct of_device_id of_physmap_match[] = {
>>  	{
>> +		.compatible	= "cfi-flash",
>> +		.data		= (void *)"cfi_probe",
>> +	},
>> +	{
>> +		.compatible	= "jedec-flash",
>> +		.data		= (void *)"jedec_probe",
>> +	},
>> +	{
>
>    This would also trigger on non-linearly mapped CFI or JEDEC flashes

No, it wouldn't.

>>   				large-flash@2,0 {
>
>    Hmm... what does @2,0 mean? :-O
>
>>  					reg = <2 0 400000>;

"2,0" is the text representation for the unit address <2 0>
on this bus.


Segher
