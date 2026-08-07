Return-Path: <linuxppc-dev+bounces-25536-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 318ADC5AC7A
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Aug 2026 02:46:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGT6p2XQzz30FB;
	Fri, 07 Aug 2026 12:46:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786070770;
	cv=none; b=NfpGS8IRcfSXJ02Fa7oJWh+a5DTC5LnguEbIgujcykSKz3PVWusKPNkby+FuwKdqe5ztxM3PIJsRH9EzGgIuu1A5CQ6oYNlzvJwC+lq5BHEx0lxXPeqX1uurISUhzo/+kOS6hgPal90CioXu0rKC98NqK/BLQRZFQkScIQ/1pUk62bx73uit1/Ld+NSpN/dhwJAkPs0Dvc2Eot1/hjQxZubUzNPLJRAbeHEqvOHx9g9TjYw6HhE6HMZyEzPvHGCXOScuSFHzM0Ixsh5wli8+bsstVWkVJid/66CwFHmJwPCfEmmA/wi04CREglPe3d6svXou/WJxeiw8bBLNVjnsrg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786070770; c=relaxed/relaxed;
	bh=cGAigAv9qTLUUJepoIiK8+xQUGcQy/mbHbtZRpAl3rg=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=bbShch4WljaXLWXsoZij2GbANKuNIEKqCbu56RUe26q2ZLXSnz8GwHyxz++5uK5dF6RG72iiZg04jJP3fZraq5dQ5hVu13hGA7jWTMtIrFVUxeTqmTE6yk/yhpNfcWrc9D9H/NrWXG7TQiCMBXqzmAUh4n5YYsBODO0uBOu9voSrlKwFj3PQUG3WsZ3E67LDwkMmH6YN86U8GaHZoQ/4GDT5bLwthMD0n4s5QT0uOB5WgZcXD/LN4BFkfUi6LFhTLsk/K0yAwDuxx8v/TxtJ/y7LzbwIqJQmeD6YjexW+Di3DXzLlu5plwfgGuAAvckNbSMRDqLaLZpCZJnyh+vDkw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=J7xtgTfN; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=J7xtgTfN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGT6n3bs9z306N
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Aug 2026 12:46:08 +1000 (AEST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-2d032846c95so36575765ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Aug 2026 19:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786070766; x=1786675566; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=cGAigAv9qTLUUJepoIiK8+xQUGcQy/mbHbtZRpAl3rg=;
        b=J7xtgTfNvl8/SkSVWTIHMd+DgEgmyJe9hOo/JBlCWQF5W2OvvGvJQdE4XBo2h4IAY+
         fEWQhq+R8kpgYu6hHHDGoWT3VIqyc3K6mDCwL5YtqqNGZ+u13zyrxMgip+zlx3Am9Cqe
         KXHKUwzanhtpdcTuOgvzkluaEWLu0iQQ3MhpH//fK8c8jmUzwETZYgM/Pm0+QGracGST
         8qyDzzM58ZIH9Xis6W8bjb2KDkN1YPFL/lsrjwXal+oHaOGLuoqD9tbTNFk6iV504SP0
         CzMnRJYiBU313jlJgF3nbgroLYY8dzcu/NtNr8mENntGxhUWDvjPIW+IIeMU+AuXL/2s
         ujlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786070766; x=1786675566;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cGAigAv9qTLUUJepoIiK8+xQUGcQy/mbHbtZRpAl3rg=;
        b=eJjuMHj1gFOzORXsYNkatfCl1ucxIRiiBSJF2o3lIVgaiZccVGbu8r4JdUaMcGOQ43
         d1bd+f1LEviN9MLp6ZLWhZhZwE3/rg+F+QQAVMgkBywJytwGg/0EDm8wrjUiSrDW0Cxr
         3Ljeewh/vIH6KfDh5hhk06G7C5quyLIWITccqUOe6DnPL7we4FxbAzEUi/wOnFUwlrNj
         aWo65sDZlHzCYpyKqwqeILhPz62KmpgRfpNVeyS4pfr1yB0wIXPBiw3G9OUcusBYz/gI
         FjTR/q3uwouymjo//Q9p4YNEEUHbR5CDZWgqOzj2HPcOUI4uMA9gXX2NUIdN0gngvHS/
         qsLg==
X-Forwarded-Encrypted: i=1; AHgh+RrE1A0o+/194YDYeBAq08l/Ve84M+1EeKZQBPnWeyL5YtVuddS52KFbpeatNeU7j20HxZ/9ZPtJHIKBnao=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxAzJa1mAKe7qZrVkfQv1//XSdh5QRCVlemfRHoiE1LBHosrvH2
	rZI1j03jbJgWBvcdK2Y5bs18sp94cTkJhDMCuKY4gnHAz4DXpbxe0En82Wix/A==
X-Gm-Gg: AR+sD12afM+hNWAqAha1usQl7No6N4/+V6s5vcN2thTdHiqwl+Z8QPQjw90uX15Q/Sq
	btjyRVHskOLjxzh545ygftV9Z90mU6CDDylehQa/1DspL899LF0penlN9J9ZpfpK7MGiBTmFvnl
	MTcjr2sC/4RIlQwqI1p86OyKZgHYxcTRXZxWJWBHPjfpEhp8GehFn/AOS8ybQEalB38DW1fw1V/
	5HVfry97dhxwPE1yCxC75QINiTWejTxkJxSLTSJSSBk1DD1CqHqIN2Cmxt2MeKzPLDdstyl1um3
	EQG1hG8Vl1UKWbsBr+IXD3LcoXYGxbffpMbHKhdYxoTaAzrL3DI5cvgCInih21Q69pHjf7wbPlf
	pCyJafD6mG5etwaA6APJ6Nw3N4yBqCCiVtiOFRrLXvaGCiJkMdACCqgbnQGdSTXhW+YLLmZ2pdg
	NDSdqorNLbLoKaWkmx182rsKfOv30BeFYoOhGL8ZbFvlyOFFKIM+ZSPRpZJGLs
X-Received: by 2002:a17:902:c952:b0:2ca:619f:9733 with SMTP id d9443c01a7336-2d0ca9620bfmr211897085ad.17.1786070766256;
        Thu, 06 Aug 2026 19:46:06 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315bebde2e6sm1462086eec.21.2026.08.06.19.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 19:46:05 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Gaurav Batra <gbatra@linux.ibm.com>, maddy@linux.ibm.com
Cc: sbhat@linux.ibm.com, vaibhav@linux.ibm.com, harshpb@linux.ibm.com, npiggin@gmail.com, Gaurav Batra <gbatra@linux.ibm.com>, stable@vger.kernel.org, linuxppc-dev@lists.ozlabs.org 
Subject: Re: [PATCH v2] powerpc/pseries/iommu: switch to Default DMA window during kdump
In-Reply-To: <20260803224029.60538-1-gbatra@linux.ibm.com>
Date: Fri, 07 Aug 2026 08:08:32 +0530
Message-ID: <jyq2lknr.ritesh.list@gmail.com>
References: <20260803224029.60538-1-gbatra@linux.ibm.com>
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

Gaurav Batra <gbatra@linux.ibm.com> writes:

> In PowerPC (pseries) a non-virtualized adapter will have 2 DMA windows -
> 2GB default and a larger Dynamic DMA Window (DDW). DDW is large enough to
> map total RAM to a device.
>
> During normal functioning of OS, since RAM is pre-mapped, 2GB default
> window is not used. The only scenario it might get used is when buffers in
> pmemory are mapped to the device for DMA.
>
> As of today, during kdump, during early device discovery, pci_dma_find()
> finds that the device has 2 DMA windows. It selects to use DDW. This is a
> kdump path and DMA window is needed for IO to the device.
>
> Although commit 09a3c1e46142 ("powerpc/pseries/iommu: IOMMU table is not
> initialized for kdump over SR-IOV") fixed an issue during kdump with SR-IOV
> case, but this also made the kdump prefer DDW over the default DMA window
> when both are present (dedicated adapter case). Since the DDW is fully
> mapped by the previous kernel, iommu_table_clear() can free only
> KDUMP_MIN_TCE_ENTRIES (2048) TCEs for use by kdump kernel.
>
> This is not enough when the dump device is NVMe over Fibre Channel.
> Because nvme-fc driver DMA-maps the cmds and resp IUs of every
> pre-allocated request and each such mapping consumes roughly:
>
>     32 (IO queues, one per cpus = nr_cpus) *
>     64 (queue_depth, blk-mq kdump limit) *
>     2 (cmd+resp) = 4096
>
> This is already double of what we have without counting admin queues and
> lpfc driver's own allocations / mapping requirement. Hence this results
> into iommu_alloc failures like -
>
> lpfc 0153:70:00.0: iommu_alloc failed,
> tbl 0000000034ebcf5e vaddr 00000000d814df0b npages 1
> lpfc 0153:70:00.0: FCP Op failed - cmdiu dma mapping failed.
> lpfc 0153:70:00.0: iommu_alloc failed,
> tbl 0000000034ebcf5e vaddr 000000009779e4d2 npages 1
> lpfc 0153:70:00.0: FCP Op failed - cmdiu dma mapping failed.
>
> iommu_map_phys+0x1c4/0x1f0 (unreliable)
> dma_iommu_map_phys+0x54/0xa0
> dma_map_phys+0x3f8/0x590
> __nvme_fc_init_request+0x110/0x300 [nvme_fc]
> nvme_fc_init_request+0x60/0xb8 [nvme_fc]
> blk_mq_alloc_map_and_rqs+0x388/0x510
> blk_mq_alloc_tag_set+0x2a4/0x5f0
> nvme_alloc_io_tag_set+0xe0/0x1e0 [nvme_core]
> nvme_fc_connect_ctrl_work+0x85c/0xdac [nvme_fc]
> process_one_work+0x1e4/0x5a0
> worker_thread+0x1ec/0x3e0
>
> Increasing the number of free TCE entries in iommu_table_clear() will
> increase the probability of hitting EEH since there could still be some
> active IOs from the previous life of the kernel.
>
> Hence this patch partially reverts the previous fixes commit and
> switches the kdump's default back to 2GB default DMA window instead of
> DDW window. This window will mostly be empty. Or, could be slightly used
> if buffers in pmemory were mapped for IO.

BTW w/o this fix the only TCE window that kdump & kexec uses is DDW
which won't work for 32-bit capable DMA devices correct? So I think this
should also fix the kexec & kdump case where we have a 32-bit DMA device
- which otherwise will fail to function after kexec with the following
error:

"Warning: IOMMU offset too big for device mask"
"mask: 0xffffffff, table offset: 0x800000000000000"

Thoughts?

>
> Fixes: 09a3c1e46142 ("powerpc/pseries/iommu: IOMMU table is not initialized for kdump over SR-IOV")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gaurav Batra <gbatra@linux.ibm.com>
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


