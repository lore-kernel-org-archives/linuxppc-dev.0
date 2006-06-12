Return-Path: <stig@lizardlogic.co.uk>
Received: from murano.lizardlogic.co.uk (unknown [195.10.246.108])
	by ozlabs.org (Postfix) with ESMTP id 6A3BA67B1C
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 Jun 2006 03:19:03 +1000 (EST)
Received: from [192.168.1.42] (horatio.newtec.dk [80.198.224.34])
	by murano.lizardlogic.co.uk (Postfix) with ESMTP id 8C1721000BA
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 12 Jun 2006 17:57:28 +0100 (BST)
Mime-Version: 1.0 (Apple Message framework v624)
In-Reply-To: <447F2C0E.1000306@xilinx.com>
References: <EDF27F298D4B03498AE0C249A941DFF803D6E6@de01exm68.ds.mot.com>	
	<447E1725.4010908@nicta.com.au> <447F1E48.10808@xilinx.com>
	<528646bc0606011008o35096b43p42cc6aa9c0002f8c@mail.gmail.com>
	<447F2C0E.1000306@xilinx.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <3843e543d6792dd2752c060ad597194f@lizardlogic.co.uk>
From: Stephen Telfer <stig@lizardlogic.co.uk>
Subject: Re: Linux 2.4 Kernel on Xilinx Virtex4 FX100's PPC
Date: Mon, 12 Jun 2006 17:57:27 +0100
To: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I have been working on an FX60 part with PVR 0x20011430.  It has memory 
attached to the PLB.  I have noticed some possible corruptions during 
linux kernel boot that appear to follow a pattern.  If a variable is 
stored immediately before a function call is made or returns, the 
callee/caller when reading the value gets stale data.  Print the value 
of the variable in-between and coherency returns.

Does that sound like a known problem?  I went through the errata on 
solution record 20658 but nothing looked like a good fit.  So I'm 
assuming at the moment it's some stupid bug of my own...

Any suggestions gratefully appreciated.

Regards,
Stig Telfer


On 1 Jun 2006, at 19:03, Peter Ryser wrote:

> It's a little bit more complicated than that but your statement is
> basically correct.
>
> - Peter
>
>
> Grant Likely wrote:
>
>> On 6/1/06, Peter Ryser <peter.ryser@xilinx.com> wrote:
>>
>>> There are some silicon issues on the PPC405 in V4 with PVR 0x20011430
>>> which are documented in Xilinx solution record 20658. All these 
>>> issues
>>> are fixed in silicon where the PPC405 has a PVR of 0x20011470.
>>>
>>> Said that it's not true that the caches cannot be used in silicon 
>>> with
>>> PVR 0x20011430. The problem is a corner case which does not show in
>>> typical designs.
>>
>>
>> If I understand correctly, the cache issue only shows up with RAM
>> attached to the OPB (instead of PLB).  Is that correct?
>>
>> Cheers,
>> g.
>>
>>
>
>
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
