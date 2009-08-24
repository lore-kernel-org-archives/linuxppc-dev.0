Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 773A0B70BA
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 25 Aug 2009 02:12:50 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D4AC3DDD0C
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Aug 2009 02:12:49 +1000 (EST)
Message-Id: <8951DD4A-6F85-4E24-A55C-2E8759E14DF7@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1250729028.4810.42.camel@pasglop>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v936)
Subject: Re: [PATCH 1/5] powerpc/mm: Add MMU features for TLB reservation &
	Paired MAS registers
Date: Mon, 24 Aug 2009 11:12:40 -0500
References: <1250658513-13009-1-git-send-email-galak@kernel.crashing.org>
	<1250666756.4810.16.camel@pasglop>
	<AC207041-6DB9-476E-B171-C1F6E10D3FAB@kernel.crashing.org>
	<1250729028.4810.42.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 19, 2009, at 7:43 PM, Benjamin Herrenschmidt wrote:

> On Wed, 2009-08-19 at 16:37 -0500, Kumar Gala wrote:
>> On Aug 19, 2009, at 2:25 AM, Benjamin Herrenschmidt wrote:
>
>> The whole thing only ever gets called if we had tlbsrx. so is there
>> any utility in making a part of conditional on tlbsrx?
>
> I don't think so ... this is the second level TLB miss handler when
> the first level takes a hit on the virtually linear page tables, I
> has nothing to do with tlbsrx... however, it does offset the return
> address back into the first level handler by -4 to account for
> replaying the tlbsrx instruction which you probably don't want to do.

Duh.  Wasn't looking at the fall through.

But is there any reason to even have any of the 6 instructions in the  
'virt_page_table_tlb_miss_done' path if we don't have TLBSRX?

- k
