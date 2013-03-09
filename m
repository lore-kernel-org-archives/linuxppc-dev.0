Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id DB4712C033D
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Mar 2013 21:12:31 +1100 (EST)
References: <1362790950-23065-1-git-send-email-agraf@suse.de>
 <1362814152.6977.32.camel@pasglop>
Mime-Version: 1.0 (1.0)
In-Reply-To: <1362814152.6977.32.camel@pasglop>
Content-Type: text/plain;
	charset=us-ascii
Message-Id: <6A2B118A-FC18-4D20-8A7A-DEA2D79CE459@suse.de>
From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH] powerpc: Fix dynamic relocation
Date: Sat, 9 Mar 2013 11:12:24 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Am 09.03.2013 um 08:29 schrieb Benjamin Herrenschmidt <benh@kernel.crashing.=
org>:

> On Sat, 2013-03-09 at 02:02 +0100, Alexander Graf wrote:
>> Commit 5ac47f7a introduced dynamic relocation of code by manually
>> relocating TOC entries. However, we need to access the TOC using
>> the physical address that we have for it, not the virtual address
>> that we can't even access yet.
>>=20
>> Drop the offset from the TOC accessing pointer.
>>=20
>> This fixes Linux 3.9 booting on OpenBIOS for me.
>>=20
>> Signed-off-by: Alexander Graf <agraf@suse.de>
>>=20
>> ---
>>=20
>> I've also encountered breakage on a G5 Mac, not sure if it's related.
>> I'll have to test whether this is the culprit on that one too.
>=20
> That might fix the mac too.. Anton's patch assumed OF ran in real mode
> in which case the top bits of the address are ignored, meaning we could
> use kernel virtual addresses but that isn't the case with Apple OF which
> has MMU enabled and maps memory 1:1. I suppose OpenBIOS has the same
> problem ? Or is this a 32-bit issue as well ?

That's exactly what OpenBIOS does, yes :).

Alex

>=20
>> Ben, please make sure that this gets into 3.9.
>> ---
>> arch/powerpc/kernel/prom_init.c |    2 +-
>> 1 files changed, 1 insertions(+), 1 deletions(-)
>>=20
>> diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_i=
nit.c
>> index 7f7fb7f..2bf7cc3 100644
>> --- a/arch/powerpc/kernel/prom_init.c
>> +++ b/arch/powerpc/kernel/prom_init.c
>> @@ -2851,7 +2851,7 @@ static void reloc_toc(void)
>>        (__prom_init_toc_end - __prom_init_toc_start) / sizeof(long);
>>=20
>>    /* Need to add offset to get at __prom_init_toc_start */
>> -    __reloc_toc(__prom_init_toc_start + offset, offset, nr_entries);
>> +    __reloc_toc(__prom_init_toc_start, offset, nr_entries);
>>=20
>>    mb();
>> }
>=20
>=20
