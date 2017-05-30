Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wcWZB4xD3zDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 21:28:18 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/3] powerpc/powernv/pci: Reduce spam when dumping PEST
In-Reply-To: <e5441c6f-d2e4-428a-9b1d-49a15e5be39c@au1.ibm.com>
References: <20170530054637.0D6C4AC0B9@b01ledav006.gho.pok.ibm.com>
 <e5441c6f-d2e4-428a-9b1d-49a15e5be39c@au1.ibm.com>
Date: Tue, 30 May 2017 21:28:15 +1000
Message-ID: <87wp8y4m9c.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Andrew Donnellan <andrew.donnellan@au1.ibm.com> writes:
> On 30/05/17 15:44, Russell Currey wrote:
>> diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
>> index 935ccb249a8a..4852ac8d0b4d 100644
>> --- a/arch/powerpc/platforms/powernv/pci.c
>> +++ b/arch/powerpc/platforms/powernv/pci.c
>> @@ -227,11 +227,38 @@ void pnv_teardown_msi_irqs(struct pci_dev *pdev)
>>  }
>>  #endif /* CONFIG_PCI_MSI */
>>
>> +/* Nicely print the contents of the PE State Tables (PEST). */
>> +static void pnv_pci_dump_pest(__be64 pestA[], __be64 pestB[], int pest_size)
>> +{
>> +	__be64 prevA = ULONG_MAX, prevB = ULONG_MAX;
>> +	bool dup = false;
>> +	int i;
>> +
>> +	for (i = 0; i < pest_size; i++) {
>> +		__be64 peA = be64_to_cpu(pestA[i]);
>> +		__be64 peB = be64_to_cpu(pestB[i]);
>> +
>> +		if (peA != prevA || peB != prevB) {
>> +			if (dup) {
>> +				pr_info("PE[..%03x] A/B: as above\n", i-1);
>> +				dup = false;
>> +			}
>> +			prevA = peA;
>> +			prevB = peB;
>> +			if (peA >> 63 || peB >> 63)
>> +				pr_info("PE[%03x] A/B: %016llx %016llx\n",
>> +					i, peA, peB);
>> +		} else if (!dup && (peA >> 63 || peB >> 63)) {
>
> I'd prefer "peA >> 63" to be expressed as "peA & PPC_BIT(0)" but that 
> might just be me?

You and a few other people who are also wrong ;)

Using PPC_BIT() means people have to go and dereference that macro
before they can grok the code, and when they do look at the macro they
go "huh, wut is this insanity".

Whereas everyone knows what >> 63 does.

It's true PPC_BIT() might make it clearer when you're comparing the
documentation to the code, but that happens less often - especially
because most people can't (easily) get the documentation.


Having said that I don't love the use of >> 63 here. Better would be:

#define PE_MASK	(1ull << 63)	// Name could be better if I knew what this code was doing

if (peA & PE_MASK)
	...


Even better IMHO is to fully flesh out the constant:

#define PE_MASK	0x8000000000000000

Because then if you see the value in a memory dump or reg dump or
whatever, you can easily match the value up.


eg. if you look at a MSR value:

  0x9000000002001002

How quickly can you spot which bit is VEC based on:

  #define __MASK(X)	(1UL<<(X))
  #define MSR_VEC_LG	25	        /* Enable AltiVec */
  #define MSR_VEC		__MASK(MSR_VEC_LG)	/* Enable AltiVec */

vs:

  #define MSR_VEC	0x0000000002000000ull	/* Enable AltiVec */

cheers
