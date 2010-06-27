Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 668ADB6EFE
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 27 Jun 2010 19:10:14 +1000 (EST)
References: <1277508314-915-1-git-send-email-agraf@suse.de>
	<1277508314-915-12-git-send-email-agraf@suse.de>
	<2078D8A9-7D36-4B5D-A779-9BBAB545A53D@kernel.crashing.org>
Message-Id: <9B84B663-7DC6-4543-96F7-23F77106065C@suse.de>
From: Alexander Graf <agraf@suse.de>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <2078D8A9-7D36-4B5D-A779-9BBAB545A53D@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
Mime-Version: 1.0 (iPhone Mail 7E18)
Subject: Re: [PATCH 11/26] KVM: PPC: Make RMO a define
Date: Sun, 27 Jun 2010 11:08:10 +0200
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


Am 26.06.2010 um 18:52 schrieb Segher Boessenkool <segher@kernel.crashing.org 
 >:

>> On PowerPC it's very normal to not support all of the physical RAM  
>> in real mode.
>
> Oh?  Are you referring to "real mode limit", or 32-bit  
> implementations with
> more than 32 address lines, or something else?

The former.

>
> Either way, RMO is a really bad name for this, since that name is  
> already
> used for a similar but different concept.

It's the same concept, no? Not all physical memory is accessible from  
real mode.

>
> Also, it seems you construct the physical address by masking out  
> bits from
> the effective address.  Most implementations will trap or machine  
> check if
> you address outside of physical address space, instead.

Well the only case where I remember to have hit a real RMO case is on  
the PS3 - that issues a data/instruction storage interrupt when  
accessing anything > 8MB in real mode.

So I'd argue this is heavily implementation specific.

Apart from that what I'm trying to cover is that on ppc64 accessing  
0xc0000000000000 in real mode gets you 0x0. Is there a better name for  
this?

Alex

>
