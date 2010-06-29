Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B6D84B6EF2
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 29 Jun 2010 17:52:56 +1000 (EST)
In-Reply-To: <182AF505-54A6-4F71-AF5D-7CA40D911C35@suse.de>
References: <1277508314-915-1-git-send-email-agraf@suse.de>
	<1277508314-915-12-git-send-email-agraf@suse.de>
	<2078D8A9-7D36-4B5D-A779-9BBAB545A53D@kernel.crashing.org>
	<9B84B663-7DC6-4543-96F7-23F77106065C@suse.de>
	<07830DA6-1B53-4E84-A0E2-8449289C71F1@kernel.crashing.org>
	<182AF505-54A6-4F71-AF5D-7CA40D911C35@suse.de>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <1550A5F0-3A22-48ED-8251-96328E2FEAE3@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 11/26] KVM: PPC: Make RMO a define
Date: Tue, 29 Jun 2010 09:52:51 +0200
To: Alexander Graf <agraf@suse.de>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	KVM list <kvm@vger.kernel.org>,
	"kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>>> Also, it seems you construct the physical address by masking out  
>>>> bits from
>>>> the effective address.  Most implementations will trap or  
>>>> machine check if
>>>> you address outside of physical address space, instead.
>>>
>>> Well the only case where I remember to have hit a real RMO case  
>>> is on the PS3 - that issues a data/instruction storage interrupt  
>>> when accessing anything > 8MB in real mode.
>>>
>>> So I'd argue this is heavily implementation specific.
>>
>> It is.  So what is the behaviour you want to implement?
>
> The one below.

I'm sorry, I lost it.  "Below"?

>>> Apart from that what I'm trying to cover is that on ppc64  
>>> accessing 0xc0000000000000 in real mode gets you 0x0. Is there a  
>>> better name for this?
>>
>> (You missed two zeroes).
>> In hypervisor real mode, the top few bits are magic.  They are  
>> used for e.g.
>> enabling hypervisor offset real mode.
>> In supervisor real mode, those bits are ignored (and all other  
>> bits that do
>> not correspond to physical address lines may also be ignored).
>
> So which bits exactly are reserved? I couldn't find a reference to  
> that part.

If by "reserved" you mean "cannot be used for addressing", it's the  
top four
bits.  Book III-S chapter 5.7.3 in the Power Architecture 2.06 document.
Implementations are allowed to ignore more bits than that.

I believe in earlier versions of the architecture it was the top two  
bits,
not four, but maybe I misremember.

>> Maybe you want to call it physical_address_mask or similar?
>
> PAM - doesn't sound bad :).

And miraculously nothing in the Power arch uses that acronym yet!  But I
would spell it out if I were you, acronyms are confusing.


Segher
