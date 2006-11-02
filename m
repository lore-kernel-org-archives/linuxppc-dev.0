Return-Path: <vwool@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 718B867CE0
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  3 Nov 2006 00:45:51 +1100 (EST)
Message-ID: <4549F694.1050707@ru.mvista.com>
Date: Thu, 02 Nov 2006 16:45:56 +0300
From: Vitaly Wool <vwool@ru.mvista.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] adding ROM chips to device tree
References: <20061102145539.f0b8657f.vwool@ru.mvista.com>
	<1162474237.11351.7.camel@zod.rchland.ibm.com>
In-Reply-To: <1162474237.11351.7.camel@zod.rchland.ibm.com>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Josh Boyer wrote:
> On Thu, 2006-11-02 at 14:55 +0300, Vitaly Wool wrote:
>   
>> In fact, currently this description can handle only flash devices mapped into memory in a linear way.
>>  For NAND flashes we'll need a whole lot different description but let's solve problems as they arise
>>  since I'm not aware of any ppc board w/ NAND chip yet :)
>>     
>
> Um...  all of the 440EP and 440EPx boards have NAND.  And those have
> been around for a while...
>
>   
Okay, that's nice to know. As you might have noticed, I'm a huge fan of 
NAND flashes :)
>> +
>> +    Required properties:
>> +
>> +     - device_type : has to be "rom"
>>     
>
> Why "rom" instead of "NOR"?
>   
Hmm, it corresponds to Sergei's version. The latter had this as "mtd" 
but following the thread I preferred to give it a more generic name.
However, thinking of it now, I realize that "NOR" is probably better 
since we'll have to define another set of properties for NAND (which 
will be of type "NAND" then) :)
>   
>> +     - compatible : Should be the name of the MTD driver. Currently, this is
>> +       most likely to be "physmap".
>> +     - reg : Offset and length of the register set for the device.
>>     
>
> reg doesn't really describe a register set here.  It's the overall
> memory space for flash.
>   
Absolutely. Basically the description was just taken from Sergei's patch 
with minimal modifications :)
>   
>> +
>> +    Recommended properties :
>> +
>> +     - bank-width : Width of the flash data bus in bytes. Must be specified
>> +       for the NOR flashes.
>>     
>
> This is a required property, not a recommended one.
>   
Yea, better have it in a separate section.


Thanks,
   Vitaly
