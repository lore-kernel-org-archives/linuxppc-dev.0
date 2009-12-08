Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 49C4BB7B6C
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Dec 2009 02:45:13 +1100 (EST)
Subject: Re: using different format for hugetlbfs
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20091208022855.GC15612@yookeroo>
Date: Tue, 8 Dec 2009 09:44:55 -0600
Message-Id: <82922100-59CF-466B-98E1-79711700AF19@kernel.crashing.org>
References: <230774E3-2D94-44DA-85AC-151485996789@kernel.crashing.org>
	<1259917136.2076.1264.camel@pasglop>
	<90D0766D-30A2-4ABE-9707-C7F64A697BFE@kernel.crashing.org>
	<1259961942.2076.1277.camel@pasglop>
	<5034AAE3-CCF9-446D-AC4B-B3F59C81D507@kernel.crashing.org>
	<1260147877.2076.1346.camel@pasglop>
	<20091208022855.GC15612@yookeroo>
To: David Gibson <dwg@au1.ibm.com>
Cc: linux-ppc list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Dec 7, 2009, at 8:28 PM, David Gibson wrote:

> On Mon, Dec 07, 2009 at 12:04:37PM +1100, Benjamin Herrenschmidt  
> wrote:
>>
>>>
>>> Even than, does that preclude the format I suggested?  I'm assuming
>>> that pgd_t/pud_t/pmd_t are always a double word so the low order 4-
>>> bits should be 0 (on 64-bit),
>
> Double word alignment only gives us 3 low bits.
>
>> so using the lsb as the flag between
>>> hugetlb and normal pointer should still work.
>>
>> Might do, depends if David has enough bits ...  David ?
>
> Well, the flag can go at the bottom, but that will mean grabbing more
> bits at the bottom.  At the moment to cover all the page table sizes
> that are wanted on the various setups we have, I need 5 bits, this
> would push it to 6.  At present, I just force up the minimum alignment
> of any page directory (even if it's natural alignment is smaller) so
> as to make sure I have those bits.  That's pretty easy to adjust, but
> pushing it up too high will start wasting memory, of course.
>
> If we move to a variable sized encoding, as Ben and I have discussed
> on a couple of occasions, I think we could do this though.

I don't understand.  It seems like only the flag bit of normal pointer  
vs hugetlb is the only thing that we need to distinguish.  Once we've  
done that all the other bits are free to use as we see fit.  So the  
less significant bit can be used for that purpose and the size  
encoding, etc we are free to do what we want with.

Am I missing something?

- k
