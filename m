Return-Path: <linuxppc-dev+bounces-18003-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F100EFD88DE
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Mar 2026 02:23:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVvgq2Lthz3bTf;
	Wed, 11 Mar 2026 13:23:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773195831;
	cv=none; b=BwtkxRwZCAwQYW64ZL3Ki0YvgfOGyAblFsy4oxLvuPY9uFpV2EAQQ+M2vfsE/B5iHh/qQkgWYvUCZz/cpeWtcft1oelR1BAGRitwyWBurmfdz0PwmAYDqAkNPU1i/04m6M5+O/sptuxXq1bnQm4VN0Phzkmj/vUqJFslzUJBxLK+37QwCTmALLv2FszYPoVlo6rgyF4NP4lutWzRZAdNMrK8di17Gt/hLpGSXxcy9FSW/CrT758iBID6W4TCiwsDzDJ4PCjjYsfcDsRD6r8io3fawLVyHgSzSu08+IwMTU3lm+7IiyYunxZeWM0gurwwryzuvisy3C80X72Men1V5g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773195831; c=relaxed/relaxed;
	bh=MMltWOW0k43bLww3FIPfAmLCchQbUS14K7m8AEoPvKs=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type; b=A3lL8tfhzaMunferKsxTRgTl8i+HET6xS0TjcYw2+J2K+I0anqTRrsuq2qXk08OIwWZQsXnn6Rwid7e1C4Bsd2ewllRFxqa8WpMJgDXWFvTkmAUUWocJHVTczH7ezfjOHMrJq6Yca5cKVIV3yp/UZ8yYU561idLeISw2MRvlDLthmQLiVjTww/kMqr7DWTysYVZmn3DJ64EsIjr7PbzJu+HiDgJmujH9fFfiLh+86VwSP7JtoSDEOPSyanTi99U2nHp7vRCv31nIdiY9+5xOg08WkzEHml2057cPmr1tLXBQuE0JglCht21cECIwhUdbCklHEod0eAYWFwWRziq8JA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=cOuxowvo; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=cOuxowvo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fVvgp3q75z30hq
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2026 13:23:50 +1100 (AEDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-354bc7c2c46so8294271a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2026 19:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773195828; x=1773800628; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MMltWOW0k43bLww3FIPfAmLCchQbUS14K7m8AEoPvKs=;
        b=cOuxowvobA0MqYKsMxwKoVN1BZ4mM93dFhGe9Q7QIaxKfD6s9it7bIOc2w0BJW7nsN
         qPqpfMtzF6irWb9zZq5k64f402Jc80+QVfbzK3M0kbUk3G9V9FlXDF5R3DVP86vVM1tq
         mmQYFsubZ027k8fKTt8Pxz+62cE/c67/dnGDI8g8P/fxMu4Drcr01lewKwrZwzcWXRzN
         x+u24Yh+0KRur5hTOLnfll/+6O5ElxMSW1+5fYwKLGzbaaKtcFacnGddBjfiV1hHqzrB
         9LoH6Dd7fVasZVHV+Q6CFS7RcOkiNXyGh/wnBEVEGKYuTshmamACfWDabDJ507nVKpbU
         Jwgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773195828; x=1773800628;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MMltWOW0k43bLww3FIPfAmLCchQbUS14K7m8AEoPvKs=;
        b=N3Qb5FrlonZfkHgas/F9xGprblVog8KKD8VAIxcQvNTE9QEZ520IUf8BfGoZ+WEt4D
         pQ388Ey2ufE18bBoj06zEQNxzyXSGVfa17uqmYrdm1st1dhDlJCC5VRYcvYuo4LEuT0L
         pc3rWqYdXtFgsrMvTpsaS5SPmIyE04U2zRer8qciY9FtpBsxZaSV01Z7o8Ly7RUSJLWr
         sDxBwZXrsY8qZu0oPgpsrkSjDuCX2YA6rxDpQ4AIn0ezbkXHeww9BZTmcaUlq6Sxe9ZT
         uNq4GgbtK2n0zEtRevSZiiw56lASqKc/2B5Io3kPrwXXkWZoHn4f+WSoRHNAv0InQV6q
         /PGw==
X-Gm-Message-State: AOJu0YyJmRAXrQv4xE/nh8Perto4dtzcf3yvCL4CulNfnjQdYrHMlfD8
	2Xmclu4Piu7XR8PCuThmiU4dLX+AFmF0k6TZLOGtJrYiWeeGtaKyGYy4
X-Gm-Gg: ATEYQzw1k3ySO7wpY7TMZZ5WbZ5HZq6bU8el0/BiJ6fWOjEB4Ajx9FT3pDU23JYjxuS
	1y1xDZiYZOrwzlYPEcPR7KginoBLrSBnUWqVldGkoVEOpIsyUIPgdwfJ2KdIRCsrV0lo49IUyB4
	l/uw7p+73Ucl20YgnjR23a7K5DQJZNfuweNfgSjf2/Ww3cL9XW1SOaLuvJb3qMpDKjimDtTgide
	BbpPuTcYCCfBPIboGbYFg8oDgJYYt4VJZJd4pCnHk3BF0OPVmWtE0tqkzv0KDBwmvqPywQMH7vd
	gU3NUrHz2aDxADTIxbMr7TbzszP016iTYFHvs3qwcU8w32cDT4noziy9b80g+ZNgHxAD4qQnwla
	hMnCXZLj9i9qFmiNRImuEPEC9GSxxOLlBIiW5VTxzfnUtGs8n3agbRMrMJtoCYytEGZkexcTqy2
	dBWE2qQZtcs9nnVQ4gklbgtw==
X-Received: by 2002:a17:90a:c884:b0:354:c593:b1a8 with SMTP id 98e67ed59e1d1-35a0124b91cmr932718a91.13.1773195828309;
        Tue, 10 Mar 2026 19:23:48 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359fc97356dsm1413731a91.8.2026.03.10.19.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 19:23:47 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Alex Williamson <alex@shazbot.org>
Cc: linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>, Christophe Leroy <chleroy@kernel.org>, linux-mm@kvack.org, kvm@vger.kernel.org, Peter Xu <peterx@redhat.com>, alex@shazbot.org
Subject: Re: [PATCH v2 1/2] drivers/vfio_pci_core: Change PXD_ORDER check from switch case to if/else block
In-Reply-To: <20260309154637.3abf76af@shazbot.org>
Date: Wed, 11 Mar 2026 07:50:24 +0530
Message-ID: <1phrumxj.ritesh.list@gmail.com>
References: <b155e19993ee1f5584c72050192eb468b31c5029.1773058761.git.ritesh.list@gmail.com> <20260309154637.3abf76af@shazbot.org>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Alex Williamson <alex@shazbot.org> writes:

> Subject prefix should be "vfio/pci:".
>
> On Mon,  9 Mar 2026 18:08:37 +0530
> "Ritesh Harjani (IBM)" <ritesh.list@gmail.com> wrote:
>
>> Architectures like PowerPC uses runtime defined values for
>
> s/uses/use/
>

@maddy can we wrap this in while applying?
Otherwise - please let me know and I can re-send another version.

>> PMD_ORDER/PUD_ORDER. This is because it can use either RADIX or HASH MMU
>> at runtime using kernel cmdline. So the pXd_index_size is not known at
>> compile time. Without this fix, when we add huge pfn support on powerpc
>> in the next patch, vfio_pci_core driver compilation can fail with the
>> following errors.
>> 
>>   CC [M]  drivers/vfio/vfio_main.o
>>   CC [M]  drivers/vfio/group.o
>>   CC [M]  drivers/vfio/container.o
>>   CC [M]  drivers/vfio/virqfd.o
>>   CC [M]  drivers/vfio/vfio_iommu_spapr_tce.o
>>   CC [M]  drivers/vfio/pci/vfio_pci_core.o
>>   CC [M]  drivers/vfio/pci/vfio_pci_intrs.o
>>   CC [M]  drivers/vfio/pci/vfio_pci_rdwr.o
>>   CC [M]  drivers/vfio/pci/vfio_pci_config.o
>>   CC [M]  drivers/vfio/pci/vfio_pci.o
>>   AR      kernel/built-in.a
>> ../drivers/vfio/pci/vfio_pci_core.c: In function ‘vfio_pci_vmf_insert_pfn’:
>> ../drivers/vfio/pci/vfio_pci_core.c:1678:9: error: case label does not reduce to an integer constant
>>  1678 |         case PMD_ORDER:
>>       |         ^~~~
>> ../drivers/vfio/pci/vfio_pci_core.c:1682:9: error: case label does not reduce to an integer constant
>>  1682 |         case PUD_ORDER:
>>       |         ^~~~
>> make[6]: *** [../scripts/Makefile.build:289: drivers/vfio/pci/vfio_pci_core.o] Error 1
>> make[6]: *** Waiting for unfinished jobs....
>> make[5]: *** [../scripts/Makefile.build:546: drivers/vfio/pci] Error 2
>> make[5]: *** Waiting for unfinished jobs....
>> make[4]: *** [../scripts/Makefile.build:546: drivers/vfio] Error 2
>> make[3]: *** [../scripts/Makefile.build:546: drivers] Error 2
>> 
>> Fixes: f9e54c3a2f5b7 ("vfio/pci: implement huge_fault support")
>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> ---
>> v1 -> v2:
>> 1. addressed review comments from Christophe [1]
>> [1]: https://lore.kernel.org/linuxppc-dev/0b8fce7a61561640634317a5e287cdb4794715fd.1772170860.git.ritesh.list@gmail.com/
>> 
>>  drivers/vfio/pci/vfio_pci_core.c | 19 +++++++------------
>>  1 file changed, 7 insertions(+), 12 deletions(-)
>> 
>> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
>> index d43745fe4c84..0967307235b8 100644
>> --- a/drivers/vfio/pci/vfio_pci_core.c
>> +++ b/drivers/vfio/pci/vfio_pci_core.c
>> @@ -1670,21 +1670,16 @@ vm_fault_t vfio_pci_vmf_insert_pfn(struct vfio_pci_core_device *vdev,
>>  	if (vdev->pm_runtime_engaged || !__vfio_pci_memory_enabled(vdev))
>>  		return VM_FAULT_SIGBUS;
>> 
>> -	switch (order) {
>> -	case 0:
>> +	if (!order)
>>  		return vmf_insert_pfn(vmf->vma, vmf->address, pfn);
>> -#ifdef CONFIG_ARCH_SUPPORTS_PMD_PFNMAP
>> -	case PMD_ORDER:
>> +
>> +	if (IS_ENABLED(CONFIG_ARCH_SUPPORTS_PMD_PFNMAP) && order == PMD_ORDER)
>>  		return vmf_insert_pfn_pmd(vmf, pfn, false);
>> -#endif
>> -#ifdef CONFIG_ARCH_SUPPORTS_PUD_PFNMAP
>> -	case PUD_ORDER:
>> +
>> +	if (IS_ENABLED(CONFIG_ARCH_SUPPORTS_PUD_PFNMAP) && order == PUD_ORDER)
>>  		return vmf_insert_pfn_pud(vmf, pfn, false);
>> -		break;
>> -#endif
>> -	default:
>> -		return VM_FAULT_FALLBACK;
>> -	}
>> +
>> +	return VM_FAULT_FALLBACK;
>>  }
>>  EXPORT_SYMBOL_GPL(vfio_pci_vmf_insert_pfn);
>
> Otherwise LGTM.  This appears to be no change for current use cases, so
> I assume this will go in through ppc trees.
>

I think that will make sense to take these 2 patches via the same tree,
so that we don't see any build issues on powerpc when the next patch
enables huge pfnmap support.

> Reviewed-by: Alex Williamson <alex@shazbot.org>

Thanks!

