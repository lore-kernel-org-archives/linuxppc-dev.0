Return-Path: <SRS0=IY60=O4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29318C43387
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Dec 2018 10:03:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CEDC21871
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Dec 2018 10:03:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CEDC21871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43KVnk1jRTzDqNn
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Dec 2018 21:03:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43KVl848WKzDqKL
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Dec 2018 21:00:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43KVl81PJBz9s2P;
 Wed, 19 Dec 2018 21:00:52 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH kernel v5 14/20] powerpc/powernv/npu: Add compound IOMMU
 groups
In-Reply-To: <3a3f83d5-aac4-7823-a230-234d025c5faf@ozlabs.ru>
References: <20181213061734.16651-1-aik@ozlabs.ru>
 <20181213061734.16651-15-aik@ozlabs.ru>
 <87ftuus732.fsf@concordia.ellerman.id.au>
 <3a3f83d5-aac4-7823-a230-234d025c5faf@ozlabs.ru>
Date: Wed, 19 Dec 2018 21:00:52 +1100
Message-ID: <87pntxrg2z.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Jose Ricardo Ziviani <joserz@linux.ibm.com>,
 Sam Bobroff <sbobroff@linux.ibm.com>, Alistair Popple <alistair@popple.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Piotr Jaroszynski <pjaroszynski@nvidia.com>, kvm-ppc@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Leonardo Augusto =?utf-8?Q?Guimar=C3=A3es?= Garcia <lagarcia@br.ibm.com>,
 Reza Arbab <arbab@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Alexey Kardashevskiy <aik@ozlabs.ru> writes:
> On 19/12/2018 11:17, Michael Ellerman wrote:
>> Alexey Kardashevskiy <aik@ozlabs.ru> writes:
>>> diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
>>> index dc629ee..3468eaa 100644
>>> --- a/arch/powerpc/platforms/powernv/npu-dma.c
>>> +++ b/arch/powerpc/platforms/powernv/npu-dma.c
>>> @@ -372,8 +358,263 @@ struct npu {
>> ...
>>> +
>>> +static void pnv_comp_attach_table_group(struct npu_comp *npucomp,
>>> +		struct pnv_ioda_pe *pe)
>>> +{
>>> +	if (WARN_ON(npucomp->pe_num == NV_NPU_MAX_PE_NUM))
>>> +		return;
>>> +
>>> +	npucomp->pe[npucomp->pe_num] = pe;
>>> +	++npucomp->pe_num;
>>> +}
>>> +
>>> +struct iommu_table_group *pnv_try_setup_npu_table_group(struct pnv_ioda_pe *pe)
>>> +{
>>> +	struct iommu_table_group *table_group;
>>> +	struct npu_comp *npucomp;
>>> +	struct pci_dev *gpdev = NULL;
>>> +	struct pci_controller *hose;
>>> +	struct pci_dev *npdev;
>>> +
>>> +	list_for_each_entry(gpdev, &pe->pbus->devices, bus_list) {
>>> +		npdev = pnv_pci_get_npu_dev(gpdev, 0);
>>> +		if (npdev)
>>> +			break;
>>> +	}
>>> +
>>> +	if (!npdev)
>>> +		/* It is not an NPU attached device, skip */
>>> +		return NULL;
>> 
>> This breaks some configs with:
>> 
>>   arch/powerpc/platforms/powernv/npu-dma.c:550:5: error: 'npdev' may be used uninitialized in this function [-Werror=uninitialized]
>
>
> gcc 5, 7 and 8 do not warn about this, I have to disable
> list_for_each_entry() above to recreate this.
>
> I even compiled gcc 5.5 which some of your buildmachines use and yet no
> error on this:
>
> make O=/home/aik/pbuild/kernel-le/ KCFLAGS=-Werror=all ARCH=powerpc
> CROSS_COMPILE=/opt/cross/gcc-powerpc64le-linux-5.5.0-nolibc/bin/powerpc64le-linux-
> arch/powerpc/platforms/powernv/npu-dma.o

Odd. That error is from kisskb like the others.

http://kisskb.ellerman.id.au/kisskb/buildresult/13622793/

Seems it's GCC 4.6.3 that is producing that one. Not sure why newer
compilers aren't warning about it.


It's pretty obviously correct though, unless you can prove that the list
is never empty?

	struct pci_dev *npdev;

	list_for_each_entry(gpdev, &pe->pbus->devices, bus_list) {
		npdev = pnv_pci_get_npu_dev(gpdev, 0);
		if (npdev)
			break;
	}

	if (!npdev)
		/* It is not an NPU attached device, skip */
		return NULL;


cheers
