Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2186AB7ED8
	for <linuxppc-dev@ozlabs.org>; Sat, 15 May 2010 03:57:20 +1000 (EST)
Subject: Re: [PATCH] powerpc: fix ioremap_flags() with book3e pte definition
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1265602870.8287.232.camel@pasglop>
Date: Fri, 14 May 2010 12:57:11 -0500
Message-Id: <87C1CC20-8454-47F7-83C2-E097598BA073@kernel.crashing.org>
References: <1265302382-15142-1-git-send-email-leoli@freescale.com>
	<1265602870.8287.232.camel@pasglop>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: galak@gate.crashing.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Feb 7, 2010, at 10:21 PM, Benjamin Herrenschmidt wrote:

> On Fri, 2010-02-05 at 00:53 +0800, Li Yang wrote:
>> We can't just clear the user read permission in book3e pte, because
>> that will also clear supervisor read permission.  This surely isn't
>> desired.  Fix the problem by adding the supervisor read back.
>>=20
>> Signed-off-by: Li Yang <leoli@freescale.com>
>> ---
>> arch/powerpc/mm/pgtable_32.c |    5 +++++
>> 1 files changed, 5 insertions(+), 0 deletions(-)
>>=20
>> diff --git a/arch/powerpc/mm/pgtable_32.c =
b/arch/powerpc/mm/pgtable_32.c
>> index cb96cb2..aff7c04 100644
>> --- a/arch/powerpc/mm/pgtable_32.c
>> +++ b/arch/powerpc/mm/pgtable_32.c
>> @@ -144,6 +144,11 @@ ioremap_flags(phys_addr_t addr, unsigned long =
size, unsigned long flags)
>> 	/* we don't want to let _PAGE_USER and _PAGE_EXEC leak out */
>> 	flags &=3D ~(_PAGE_USER | _PAGE_EXEC);
>>=20
>> +#if defined(CONFIG_FSL_BOOKE) && defined(CONFIG_PTE_64BIT)
>> +	/* supervisor read permission has just been cleared, add back */
>> +	flags |=3D _PAGE_BAP_SR;
>> +#endif
>> +
>=20
> So this is a bit fishy indeed. pgtable_64.c seems to have the same
> problem in fact.
>=20
> It boils down to the "hack" I have in the new PTE format which =
consists
> of having _SR be part of _PAGE_USER. I wonder if I should change that
> instead. Kumar, what do you reckon ?
>=20
> _Maybe_ an option is to have _PAGE_NO_USER that defaults to be
> ~_PAGE_USER in pte-common.h and can be set in pte-book3e.h to
> only strip out UR and UW ?

We never closed on this.  I think lets add _PAGE_NO_USER

- k=
