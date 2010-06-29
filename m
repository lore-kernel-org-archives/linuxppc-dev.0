Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A3531B6EF7
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 29 Jun 2010 17:32:29 +1000 (EST)
In-Reply-To: <9B84B663-7DC6-4543-96F7-23F77106065C@suse.de>
References: <1277508314-915-1-git-send-email-agraf@suse.de>
	<1277508314-915-12-git-send-email-agraf@suse.de>
	<2078D8A9-7D36-4B5D-A779-9BBAB545A53D@kernel.crashing.org>
	<9B84B663-7DC6-4543-96F7-23F77106065C@suse.de>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <07830DA6-1B53-4E84-A0E2-8449289C71F1@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 11/26] KVM: PPC: Make RMO a define
Date: Tue, 29 Jun 2010 09:32:20 +0200
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

>>> On PowerPC it's very normal to not support all of the physical  
>>> RAM in real mode.
>>
>> Oh?  Are you referring to "real mode limit", or 32-bit  
>> implementations with
>> more than 32 address lines, or something else?
>
> The former.

Okay.  In that case, the hypervisor can usually access all of physical
ram directly, unless it limits itself; and a supervisor gets either
no real mode access, or all ram, or some part -- whatever the hypervisor
likes.

If you access outside of ram, you will most likely get a machine check.
Depends on the implementation (like most things here).

>> Either way, RMO is a really bad name for this, since that name is  
>> already
>> used for a similar but different concept.
>
> It's the same concept, no? Not all physical memory is accessible  
> from real mode.

I think you're looking for "real mode limit":

The concept is called "offset real mode".

RMO ("real mode offset") is the value that is ORed to an effective  
address
to make the physical address (not added, "offset" is a pretty bad name).
RML ("real mode limit") is the value that has to be bigger than the  
effective
address or you will get an exception.
RMA ("real mode area") is the name for the range of addresses usable  
in offset
real mode.

>> Also, it seems you construct the physical address by masking out  
>> bits from
>> the effective address.  Most implementations will trap or machine  
>> check if
>> you address outside of physical address space, instead.
>
> Well the only case where I remember to have hit a real RMO case is  
> on the PS3 - that issues a data/instruction storage interrupt when  
> accessing anything > 8MB in real mode.
>
> So I'd argue this is heavily implementation specific.

It is.  So what is the behaviour you want to implement?

> Apart from that what I'm trying to cover is that on ppc64 accessing  
> 0xc0000000000000 in real mode gets you 0x0. Is there a better name  
> for this?

(You missed two zeroes).
In hypervisor real mode, the top few bits are magic.  They are used  
for e.g.
enabling hypervisor offset real mode.
In supervisor real mode, those bits are ignored (and all other bits  
that do
not correspond to physical address lines may also be ignored).


Maybe you want to call it physical_address_mask or similar?


Segher
