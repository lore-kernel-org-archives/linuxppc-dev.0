Return-Path: <jimix@watson.ibm.com>
Received: from over.ny.us.ibm.com (over.ny.us.ibm.com [32.97.182.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 54F5C679FB
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Apr 2006 05:21:05 +1000 (EST)
Received: from e3.ny.us.ibm.com ([192.168.1.103])
	by pokfb.esmtp.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k3IIgtRm027504
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Apr 2006 14:42:55 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k3IIgotl002531
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Apr 2006 14:42:50 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k3IIgoB9181482
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Apr 2006 14:42:50 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k3IIgnuu027678
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Apr 2006 14:42:50 -0400
In-Reply-To: <1145383451.20176.9.camel@localhost.localdomain>
References: <5148225C-AE27-4365-A1C2-40C46491AF0D@watson.ibm.com>
	<9B2C87C5-0B69-46E7-B48B-9CDB882836B2@watson.ibm.com>
	<20060413053614.2648467DE3@ozlabs.org>
	<C67D530F-2629-4D6B-986B-0FC7CFE525BF@watson.ibm.com>
	<1144926434.7777.5.camel@localhost.localdomain>
	<2A70CBD7-4A52-4599-8BEF-6AC633F62C83@watson.ibm.com>
	<1144938844.7777.16.camel@localhost.localdomain>
	<1145378886.5314.57.camel@cashmere.sps.mot.com>
	<1145383451.20176.9.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A9DE5BD4-BBB6-44CB-8B0D-B79D8B4AD289@watson.ibm.com>
From: Jimi Xenidis <jimix@watson.ibm.com>
Subject: Re: [patch][rfc]flattened device tree: Passing a dtb (blob) to Linux.
Date: Tue, 18 Apr 2006 14:42:48 -0400
To: michael@ellerman.id.au
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Michael Neuling <mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

ok, to accept (1) means to accept (2).

AFAICT LMB is already handling overlaps.
So the first rough patch I sent should be sufficient.

On Apr 18, 2006, at 2:04 PM, Michael Ellerman wrote:

> On Tue, 2006-04-18 at 11:48 -0500, Jon Loeliger wrote:
>> On Thu, 2006-04-13 at 09:34, Michael Ellerman wrote:
>>> On Thu, 2006-04-13 at 09:19 -0400, Jimi Xenidis wrote:
>>>> Actually, is this even an issue? can the LMB handle repeated
>>>> reservations?
>>>
>>> It can, but we were thinking about adding code to check and warn if
>>> reservations overlap, because it usually indicates a bug. Although
>>> that's probably ok in this case, as long as dtc gets fixed  
>>> eventually.
>>> Another option would be to not warn for identical reservations.
>>
>>>>>>>>> NOTE: that the dtc must also not generate the blob reservation
>>>>>>>>> entry.
>>
>>>>>> looking passed my own world I see:
>>>>>>    - iSeries: not reserving the blob at all
>>>>>
>>>>> That sounds right. I think having the kernel do it is  
>>>>> definitely the
>>>>> right option.
>>
>>
>> OK, I'm back to reading the list and beginning to catch
>> up some here...
>>
>> Let me see if I understand the consensus and direction:
>>
>>     1) DTC should NOT reserve its own blob space in the
>>        memory map, as it does for generated ASM code now,
>>
>>     2) Kernel should reserve the blob space early so as
>>        not to step on itself later,
>>
>>     3a) Kernel LMB handling should be modified to warn
>>         for overlapping LMB reservations,
>>
>> Except that Ben says:
>>
>>     3b) We should make lmb_reserve() of redudant/overlapping
>>         entries become harmless I think. We need to be
>>         backward compatible with earlier blobs that do
>>         contain themselves in the reserve map.
>>
>> I think we should interpret "harmless" to be "warn" and not
>> cause an error at this point in time.
>>
>> I do not think we should have the blob generate its own
>> reservation because it is possible that some post-processing
>> (like U-Boot) can modify and extend it.  Only after that can
>> the blob's true size be determined.  (Sure, it could update
>> on the fly too... but double blah).
>>
>> In all of this, I'm on deck for step 1) above.
>
> Nice summary :)
> I'm up for 3a, we should make redundant/overlapping reserves  
> "harmless",
> by which I mean "not an error", but there should definitely be a  
> warning
> in the dmesg - as it will _usually_ indicate a bug.
>
> cheers
>
> -- 
> Michael Ellerman
> IBM OzLabs
>
> wwweb: http://michael.ellerman.id.au
> phone: +61 2 6212 1183 (tie line 70 21183)
>
> We do not inherit the earth from our ancestors,
> we borrow it from our children. - S.M.A.R.T Person
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
