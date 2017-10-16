Return-Path: <aik@ozlabs.ru>
Received: from mail-it0-x242.google.com (mail-it0-x242.google.com
 [IPv6:2607:f8b0:4001:c0b::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yFwXt2G5vzDrFy
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Oct 2017 22:08:11 +1100 (AEDT)
Received: by mail-it0-x242.google.com with SMTP id 72so718111itl.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Oct 2017 04:08:11 -0700 (PDT)
Subject: Re: [PATCH kernel] RFC: prom_init: Fetch flatten device tree from the
 system firmware
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, Thomas Huth
 <thuth@redhat.com>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>,
 Greg Kurz <groug@kaod.org>, slof@lists.ozlabs.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
References: <20171016054917.21577-1-aik@ozlabs.ru>
 <20171016061125.GD2776@umbus.fritz.box>
 <00ec0e99-45dd-dbe0-d75f-4413253e8093@ozlabs.ru>
 <20171016064633.GE2776@umbus.fritz.box>
 <f849afda-4384-f72e-c8cf-15ba5d170f2c@ozlabs.ru>
 <20171016102058.GH4406@gate.crashing.org>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <8e15464a-50e0-e49c-2df1-c692eca9fde4@ozlabs.ru>
Date: Mon, 16 Oct 2017 22:08:02 +1100
MIME-Version: 1.0
In-Reply-To: <20171016102058.GH4406@gate.crashing.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 16/10/17 21:20, Segher Boessenkool wrote:
> On Mon, Oct 16, 2017 at 06:07:06PM +1100, Alexey Kardashevskiy wrote:
>> On 16/10/17 17:46, David Gibson wrote:
> 
>>>>>> +		/* Fixup the boot cpuid */
>>>>>> +		hdr->boot_cpuid_phys = cpu_to_be32(prom.cpu);
>>>>>
>>>>> If SLOF is generating a tree it really should get this header field
>>>>> right as well.
>>>>
>>>>
>>>> Ah, I did not realize it is just a phandle from /chosen/cpu. Will
>>>> fix.
>>>
>>> It's not a phandle.  It's just the "address" (i.e. reg value) of the
>>> boot cpu.
>>
>> Well, it is "reg" of a CPU with phandle==/chosen/cpu so my fdt code needs
>> to look there to pick the right "reg" rather than just plain 0. I'll fix
>> this but in general can it possibly be not a zero in QEMU/SLOF?
> 
> /chosen/cpu is an ihandle, not a phandle. 

Sure, that is what my proposed fdt-boot-cpu  does already.

> Most (if not all) references
> in /chosen are.





-- 
Alexey
