Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 036BFDE026
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 20:12:11 +1000 (EST)
Message-Id: <C8A43609-A9F7-463F-A7D5-160EFA15E170@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18429.33325.923972.430150@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: Status of patches (ppc32 mm init clean and 85xx kernel reloc)
Date: Thu, 10 Apr 2008 05:11:59 -0500
References: <88C63CCF-7ED6-486F-8E95-FABD6CEE92E0@kernel.crashing.org>
	<18429.33325.923972.430150@cargo.ozlabs.ibm.com>
Cc: ppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> [POWERPC] Clean up some linker and symbol usage
>>
>> No comments.  Straight forward patch.
>
> Well, it is changing behaviour.  In particular, klimit is not
> necessarily the same as _end.  It starts out initialized to &_end but
> then gets advanced by some allocations very early in the boot IIRC.
> It might be true by now that nothing reserves memory by advancing
> klimit any more, but if that is true then the patch description needs
> to mention that klimit is no longer used and this patch makes it no
> longer usable.  In fact in that case you should remove all mention of
> klimit.
>
> Also, this patch means that the region from PHYSICAL_START to
> __pa(stext) is no longer reserved, which is another behaviour change
> that deserves to be mentioned.

so I see iseries updating klimit.

>> [POWERPC] Update linker script to properly set physical addresses
>>
>> You felt LOAD_OFFSET should be (CONFIG_PAGE_OFFSET -
>> CONFIG_PHYSICAL_START).  I disagreed.  We need to resolve.
>
> I think you're right, actually, now, assuming that
> CONFIG_PHYSICAL_START is the physical address of the start of the
> kernel (actually, why don't you use that instead of __pa(stext) in
> your patch [9/11]?).

I think I can just drop that change in the patch now that I look at  
it.  My previous plan had been to get ride of PHYSICAL_START but now  
that we still have it I don't see any reason I need to change that  
particular lmb reserve.

(i'll repost the full series with a minor bit of re-ordering).

- k
