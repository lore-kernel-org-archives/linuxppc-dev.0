Return-Path: <R58472@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9BA36B6EEC
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Nov 2009 14:00:26 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	nAK30N6S002334
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Nov 2009 20:00:23 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id nAK34SA5000935
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Nov 2009 21:04:28 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [RFC] powerpc/mm: honor O_SYNC flag for memory map
Date: Fri, 20 Nov 2009 11:00:20 +0800
Message-ID: <3A45394FD742FA419B760BB8D398F9EDCBC1F2@zch01exm26.fsl.freescale.net>
In-Reply-To: <8543954E-619A-4A78-A934-CDC326027FD2@kernel.crashing.org>
References: <1258441832-20133-1-git-send-email-leoli@freescale.com>
	<8543954E-619A-4A78-A934-CDC326027FD2@kernel.crashing.org>
From: "Li Yang-R58472" <r58472@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20

>-----Original Message-----
>From: Kumar Gala [mailto:galak@kernel.crashing.org]=20
>
>On Nov 17, 2009, at 1:10 AM, Li Yang wrote:
>
>> Rather than the original intelligent way, we grant user more freedom.
>> This enables user to map cacheable memory not managed by Linux.
>>
>> Signed-off-by: Li Yang <leoli@freescale.com>
>> ---
>> The only direct users of this function is fb_mmap() and=20
>/dev/mem mmap.
>> Although I'm not sure if anything is depending on the intelligent=20
>> setting of cacheability.
>
>is there some reason to change this?

Because there is no way to set mapped memory as cacheable if the memory
is not managed by Linux kernel.  While, it's not rare in real system to
allocate some dedicated memory to a certain application which is not
managed by kernel and then mmap'ed the memory to the application.  The
memory should be cacheable but we can't map it to be cacheable due to
this intelligent setting.  And it is a big hit to the performance.
Moreover, the standard O_SYNC flag suggest that user has the control
over cacheablity, but actually we had not.

- Leo

>
>- k
>
>>
>> arch/powerpc/mm/mem.c |    2 +-
>> 1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c index=20
>> 579382c..0fd267e 100644
>> --- a/arch/powerpc/mm/mem.c
>> +++ b/arch/powerpc/mm/mem.c
>> @@ -101,7 +101,7 @@ pgprot_t phys_mem_access_prot(struct file *file,=20
>> unsigned long pfn,
>> 	if (ppc_md.phys_mem_access_prot)
>> 		return ppc_md.phys_mem_access_prot(file, pfn,=20
>size, vma_prot);
>>
>> -	if (!page_is_ram(pfn))
>> +	if (file->f_flags & O_SYNC)
>> 		vma_prot =3D pgprot_noncached(vma_prot);
>>
>> 	return vma_prot;
>> --
>> 1.6.4
>>
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@lists.ozlabs.org
>> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
>
>
