Return-Path: <SRS0=vnEJ=O5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 478F8C43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 11:30:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0B3D2080D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 11:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="mktFUWm7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0B3D2080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43L8hb3cNtzDr6B
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 22:30:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="mktFUWm7";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com;
 envelope-from=aik@ozlabs.ru; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ozlabs-ru.20150623.gappssmtp.com
 header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="mktFUWm7"; 
 dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43L8dd3xH6zDr2j
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Dec 2018 22:28:20 +1100 (AEDT)
Received: by mail-pl1-x641.google.com with SMTP id w4so757337plz.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Dec 2018 03:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vCppfmD4UgvXJ5Xp9SPYLml5K9LFeDynszsIHeM3Fa0=;
 b=mktFUWm7NV7zo2fF+VZ783oItrfbrMkU/Km4MUsAtVWFwd8l26/n+trSrPOILiEEDD
 lzfwz46R9x6YrPN+CggKdVztApfKUo6pKen1taBPWRJKNPyfg/FeyekxRHAM2jsIs9hp
 kjlXt8jdFi0qCO0mAHYczjCmNBFniIl6OYyDpe14Mb9umbb2Ymhn2lIJj6sA3ODzgLeJ
 qTkgtHgAZaYw2BJyWN1uZ86913IoY2jE4IPf5I10YKMvYYpH9ZldDqb7JeJTA7WGG90Q
 CRAVa+cWwM6tXqHz66WEch6K4syIDigJzn+i9ad7xxB+5Q15uSc3HsUdTyGB0PQpWHQm
 +CRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=vCppfmD4UgvXJ5Xp9SPYLml5K9LFeDynszsIHeM3Fa0=;
 b=QsjcLgZzo5TdGVFH0aBDVe0yzgn8EqD/Y500N9UmmMRv6u4E4mqz4N122t1lWPbFOq
 M2BkxhFlsbC/ToskgUG649qEYCQk3QkcsaoExjuHhduttiq5CD37L2BN7faWzzo7DGgz
 R4jmdPlsGrceJm0I6IMd39OtLatNIcgf4e/0FTqu4Q4pWBD54I+k6UYTdJPpcVELmyEc
 MGWtDcsNcuI6AT+7qPUF0AAM2w+SyFBkZo8nRf0dcB5Fyzrs1TyM6RaZBpkvUppybQcW
 1joxNFBGBPGL7ZTiad+2xtTPV6pq+4vsiwgUMyRc6svF5vJSxhS8OHChOIHV2/HU9+sY
 0n1w==
X-Gm-Message-State: AA+aEWZn3PoORoOkAMpsJz1NcKDXRqfmMZEP42/T4te9tODId2XJKs4y
 ok5GSbpF4jHShVQiR5hiAFUYvg==
X-Google-Smtp-Source: AFSGD/WHunhtdAOhgA1AvDjn0pdtVZWKntAXC9OmS1eyyM3Se1aaACjw3hg536zzYfwugTn0k3FA6Q==
X-Received: by 2002:a17:902:6bc9:: with SMTP id
 m9mr23360147plt.173.1545305296896; 
 Thu, 20 Dec 2018 03:28:16 -0800 (PST)
Received: from [192.168.10.152] (124-171-140-5.dyn.iinet.net.au.
 [124.171.140.5])
 by smtp.gmail.com with ESMTPSA id 24sm38202912pfl.32.2018.12.20.03.28.07
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Dec 2018 03:28:15 -0800 (PST)
Subject: Re: [PATCH kernel v7 00/20] powerpc/powernv/npu, vfio: NVIDIA V100 +
 P9 passthrough
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
References: <20181220082350.58113-1-aik@ozlabs.ru>
 <87h8f8r10z.fsf@concordia.ellerman.id.au>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Openpgp: preference=signencrypt
Autocrypt: addr=aik@ozlabs.ru; keydata=
 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
Message-ID: <8da1b46e-1ef1-d2b5-2d2b-c633fb827c47@ozlabs.ru>
Date: Thu, 20 Dec 2018 22:28:03 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <87h8f8r10z.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: Christoph Hellwig <hch@infradead.org>,
 Jose Ricardo Ziviani <joserz@linux.ibm.com>, kvm@vger.kernel.org,
 Sam Bobroff <sbobroff@linux.ibm.com>, Alistair Popple <alistair@popple.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>, kvm-ppc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Piotr Jaroszynski <pjaroszynski@nvidia.com>,
 =?UTF-8?Q?Leonardo_Augusto_Guimar=c3=a3es_Garcia?= <lagarcia@br.ibm.com>,
 Reza Arbab <arbab@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 20/12/2018 20:38, Michael Ellerman wrote:
> Alexey Kardashevskiy <aik@ozlabs.ru> writes:
> 
>> My bad, I was not cc-ing everyone but now with v7 I am, sorry about that.
> 
> I've already applied v6, I'll assume this is unchanged from that unless
> you tell me otherwise.

14/20 has fixed warning about uninitialized npdev, 20/20 has fixed
comment about one capability:

[fstn1-p1 kernel]$ git diff 7e04f09 9128bd1
diff --git a/arch/powerpc/platforms/powernv/npu-dma.c
b/arch/powerpc/platforms/powernv/npu-dma.c
index ed81426..12b8421 100644
--- a/arch/powerpc/platforms/powernv/npu-dma.c
+++ b/arch/powerpc/platforms/powernv/npu-dma.c
@@ -540,7 +540,7 @@ struct iommu_table_group
*pnv_try_setup_npu_table_group(struct pnv_ioda_pe *pe)
        struct npu_comp *npucomp;
        struct pci_dev *gpdev = NULL;
        struct pci_controller *hose;
-       struct pci_dev *npdev;
+       struct pci_dev *npdev = NULL;

        list_for_each_entry(gpdev, &pe->pbus->devices, bus_list) {
                npdev = pnv_pci_get_npu_dev(gpdev, 0);
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 22b825c..5562587 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -390,8 +390,7 @@ struct vfio_region_info_cap_nvlink2_ssatgt {
 };

 /*
- * Capability with compressed real address (aka SSA - small system
address),
- * used to match the NVLink bridge with a GPU. Also contains a link speed.
+ * Capability with an NVLink link speed.
  */
 #define VFIO_REGION_INFO_CAP_NVLINK2_LNKSPD    5



> 
> cheers
> 
>> This is for passing through NVIDIA V100 GPUs on POWER9 systems.
>> 20/20 has the details of hardware setup.
>>
>> This implements support for NVIDIA V100 GPU with coherent memory and
>> NPU/ATS support available in the POWER9 CPU. The aim is to support
>> unmodified vendor driver in the guest.
>>
>> This is pushed to (both guest and host kernels):
>> https://github.com/aik/linux/tree/nv2
>>
>> Matching qemu is pushed to github:
>> https://github.com/aik/qemu/tree/nv2
>>
>> Skiboot bits are here:
>> https://github.com/aik/skiboot/tree/nv2
>>
>> The individual patches have changelogs. v7 fixes compile warning
>> and updates a VFIO capability comment in 20/20.
>>
>> Please comment. Thanks.
>>
>>
>>
>> Alexey Kardashevskiy (20):
>>   powerpc/ioda/npu: Call skiboot's hot reset hook when disabling NPU2
>>   powerpc/mm/iommu/vfio_spapr_tce: Change mm_iommu_get to reference a
>>     region
>>   powerpc/vfio/iommu/kvm: Do not pin device memory
>>   powerpc/powernv: Move npu struct from pnv_phb to pci_controller
>>   powerpc/powernv/npu: Move OPAL calls away from context manipulation
>>   powerpc/pseries/iommu: Use memory@ nodes in max RAM address
>>     calculation
>>   powerpc/pseries/npu: Enable platform support
>>   powerpc/pseries: Remove IOMMU API support for non-LPAR systems
>>   powerpc/powernv/pseries: Rework device adding to IOMMU groups
>>   powerpc/iommu_api: Move IOMMU groups setup to a single place
>>   powerpc/powernv: Reference iommu_table while it is linked to a group
>>   powerpc/powernv/npu: Move single TVE handling to NPU PE
>>   powerpc/powernv/npu: Convert NPU IOMMU helpers to
>>     iommu_table_group_ops
>>   powerpc/powernv/npu: Add compound IOMMU groups
>>   powerpc/powernv/npu: Add release_ownership hook
>>   powerpc/powernv/npu: Check mmio_atsd array bounds when populating
>>   powerpc/powernv/npu: Fault user page into the hypervisor's pagetable
>>   vfio_pci: Allow mapping extra regions
>>   vfio_pci: Allow regions to add own capabilities
>>   vfio_pci: Add NVIDIA GV100GL [Tesla V100 SXM2] subdriver
>>
>>  drivers/vfio/pci/Makefile                     |   1 +
>>  arch/powerpc/include/asm/iommu.h              |  17 +-
>>  arch/powerpc/include/asm/mmu_context.h        |  15 +-
>>  arch/powerpc/include/asm/pci-bridge.h         |   1 +
>>  arch/powerpc/include/asm/pci.h                |   4 +
>>  arch/powerpc/platforms/powernv/pci.h          |  30 +-
>>  drivers/vfio/pci/trace.h                      | 102 ++++
>>  drivers/vfio/pci/vfio_pci_private.h           |  20 +
>>  include/uapi/linux/vfio.h                     |  37 ++
>>  arch/powerpc/kernel/iommu.c                   |  69 +--
>>  arch/powerpc/kvm/book3s_64_vio.c              |  18 +-
>>  arch/powerpc/mm/mmu_context_iommu.c           | 110 +++-
>>  arch/powerpc/platforms/powernv/npu-dma.c      | 549 +++++++++++++++---
>>  arch/powerpc/platforms/powernv/pci-ioda-tce.c |   3 +-
>>  arch/powerpc/platforms/powernv/pci-ioda.c     | 237 ++++----
>>  arch/powerpc/platforms/powernv/pci.c          |  43 +-
>>  arch/powerpc/platforms/pseries/iommu.c        |  88 ++-
>>  arch/powerpc/platforms/pseries/pci.c          |  22 +
>>  drivers/vfio/pci/vfio_pci.c                   |  42 +-
>>  drivers/vfio/pci/vfio_pci_nvlink2.c           | 482 +++++++++++++++
>>  drivers/vfio/vfio_iommu_spapr_tce.c           |  64 +-
>>  drivers/vfio/pci/Kconfig                      |   6 +
>>  22 files changed, 1569 insertions(+), 391 deletions(-)
>>  create mode 100644 drivers/vfio/pci/trace.h
>>  create mode 100644 drivers/vfio/pci/vfio_pci_nvlink2.c
>>
>> -- 
>> 2.17.1

-- 
Alexey
