Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7F183DDFA8
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2008 08:16:25 +1000 (EST)
Message-Id: <E47F9F6D-80A7-4CB0-8509-FCDCE5E38787@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: benh@kernel.crashing.org
In-Reply-To: <1216244518.7740.205.camel@pasglop>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: SW TLB MMU rework and SMP issues (pte read/write)
Date: Wed, 16 Jul 2008 17:12:55 -0500
References: <BF59BFC7-736B-4D3F-9227-97DC90CE4739@kernel.crashing.org>
	<1216174045.7740.152.camel@pasglop>
	<B2B96B0D-960F-4FB1-A5C1-6146EFB7E563@kernel.crashing.org>
	<1216244518.7740.205.camel@pasglop>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 16, 2008, at 4:41 PM, Benjamin Herrenschmidt wrote:

> On Wed, 2008-07-16 at 15:57 -0500, Kumar Gala wrote:
>> This makes sense.  I think we need to order the stores in set_pte_at
>> regardless of CONFIG_SMP.
>
> Nah, that shouldn't be necessary.

Yeah I finally came to that realization.

>> Also, I think we should change pte_clear to
>> use pte_update() so we only clear the low-order flag bits.  Patch  
>> will
>> be sent shortly for review.
>
> Well... at one point at least we did rely on a PTE page with all PTEs
> cleared to be blank. It don't know if that's still the case, I need to
> look.

Doesn't look like we do anything special, we just call free_pages or  
__free_pages in arch/powerpc/mm/pgtable_32.c.

- k
