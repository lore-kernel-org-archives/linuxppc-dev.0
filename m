Return-Path: <linuxppc-dev+bounces-25195-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80931C54FCD
	for <linuxppc-dev@archiver.kernel.org>; Sat,  1 Aug 2026 07:25:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hBvbq471xz2xwN;
	Sat, 01 Aug 2026 17:25:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::534"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785569127;
	cv=none; b=fOiDOMflaUBOsoQ/Q714ZOR1623119hHa8xy0vXm22P1nKIraIK+11OEuZHry3+kPzvSRC2+upwaKYsL9I1iIHnP6kA6EiEfTtSabBIGjEFTNbzffsvtTc68ZzwwH+bYXNZyB3Y0sGyxYJJyY3G7SpyrW7us2zQ21gCxP5I4oB8SgIVk6g+TW/xD+y1Vpizou9nIfeaNBCiRaHIF0pyg/TlgN6iZ24orAuaFm9l2GRHCkI1M0XRpMDuwhZgbVFA0ICqtpH2YMYL5LjJuO+qUg3J3n3A5hXdvqmEP5alwWsdl1gLeadJCEC8z+VQnp5Ikjz7xMQMPFqZU0MxUb3dSIA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785569127; c=relaxed/relaxed;
	bh=tzMA5DwhYd178hnbY4SkQjNiBAA69LUdqB/4NARJ6r8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=Mjc3/RPHHRmkaHXNYvizIGuYvzVMKGkOs7IpPigA5c3mccvr+g+zyPJF68SihfLqTRVn1WVEhAMN62n9TM1kv1XkLFA0Ixoms8tRRq5pXP+K32QCSMEEeCsJ03DArV22RP4aU9wvI8lsuhqBT4nRCWOquWOuY3Qe8VL1l2zXjK8ZFJZM7WYUAZvZjqNFiv0i16WA4c7b6V8p4GEIMWKK3y6njdSvVPRGJCP15YWvr6nu/QabrcuoCYnHsLh09YeuM8U+dDHyf4AW4N6SCi7ubDGYS3e8jc4raudGEf1/xHouNXepHi07lJcb2Gik5kc7RSg+XVhY9Fx5OhhsjprAvg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VU42MWee; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::534; helo=mail-pg1-x534.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VU42MWee;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::534; helo=mail-pg1-x534.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hBvbn5RkRz2x9g
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 01 Aug 2026 17:25:24 +1000 (AEST)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-ca7c1176317so1543276a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 01 Aug 2026 00:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785569121; x=1786173921; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=tzMA5DwhYd178hnbY4SkQjNiBAA69LUdqB/4NARJ6r8=;
        b=VU42MWee3i31iM1pCQwMb9lolYwE1ka+zZi6lVirQxlCLxfIQnDmVDw+u4y3neKgJQ
         zjRFoSBXKIRg/Z4JcKJK92mlXL2qNMB/m+zZNnzA08sxiCWCXa6eZo/Z7RNp8uHIFWLU
         QSNCPfzuzJIOsQhiC9Go1FZLMQzWliXBNTogpBFJiQgDEQG7e8m2aj1EP4VCdvoObeNR
         yw7H4EdiW8+w5DZR1FpJxTHRLsZPHX1AOGon4QOOdj/kg6qEqAcvzFD9XhCGXoTxIoti
         bvMBCTSwP8KLqG645CxIo+QI/fbUSbL0jYRIQOKpHvHUVobl2tRpXxBFObifBZ8sS9o0
         G/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785569121; x=1786173921;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tzMA5DwhYd178hnbY4SkQjNiBAA69LUdqB/4NARJ6r8=;
        b=bqXt0pRPE/xJ2//rOqma/N6qeeT+pQpCUcDBihD0FFWprUn3kOBNMpHNsyiNAn8iaG
         X5go172pXW9L3eF7YQC3fubNOjfbdZLLJS0G8fVMlTwimu8EMSZvCcLJA5fcS17+dXn9
         iyb1NjwhyA3IajdbJpIgupF70I5aU/cZu3zKmPpGhhLX1hG87nRXCyQGZQlLeXPE1P0l
         xTDVzHdOBrETz84QaYsrobNd37E63prd7xxVx7fTBRRHYvxxxAfnvwSoWGMOgTx582Xk
         Cvt8YtbuAMXsDqzUxATIk2DrHDlsOKkXNTwmBO62zuzuQrvI+zM0MAW/eBa5nxai+QEN
         E9pA==
X-Forwarded-Encrypted: i=1; AHgh+RoodOYXYbP20Iiqb/ThD2SnY3UBsavkoLLS+8asEyOsUf7eGyfqgkn1B0cwWdLFvHv7WlpWq0TXmathKUo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyAJCKRcn3Z/jRXKM+bcF+m2xWvIELQF/ejco2Lyz54WtUS/Ttb
	aEgah3hRrAUR+e7puVM7cFF/3zvNE2OP8JVJl1nCZmiNh2eF/kzJgw+n
X-Gm-Gg: AR+sD12frID5JUFxL57Ig49V5bnj7dd6wbkB/W18fPlUB4rIUIwzJAAJKDb1XGGkUuc
	dcz3IxjqGR46BdIQBFBC1DrqNkOyGKw07Ljpn+aJB4clvgzjRxyaSCZWAEfddZIoCYr9VHxDyuB
	JYQzNgEeF+19ndWHUPvy8hFlevaKx2NSXU+zDDsU7fyREzFPFYkgJ6VbKHhn6z6DkiYxXsrsDfi
	2eFuIS1OFhfMgABSfTg+ZbkBpQCYdeQtADOcKkM4oafhS544EKZQcuzOIBnbmu2yVe1mjBE8fzl
	qua/H0zVQwKWxevnKZrvKThXIzOQWhzz5ZJGMfLWT45GvegDZ1ZQ6IhZ1ojgaaecfDPaHIj8wKH
	KoC+IoCD41d820QlCtKQTQqWF9XQkhuzXs9AzPNb2yzxEpAl140nk69biKcNpHcxAn/Cil/fW1Z
	u4A2LwmpiFxeeH67REvn3Lvy0KOUPpp8JX3Zew2mzx57C9KPqM9WgJaE/Ha4P/uN2GHdB3fg==
X-Received: by 2002:a05:6a21:4e02:b0:3b4:c9d5:cd5b with SMTP id adf61e73a8af0-3c92a53ef40mr2707962637.13.1785569121052;
        Sat, 01 Aug 2026 00:25:21 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153dd4e666sm19939416eec.4.2026.08.01.00.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 00:25:19 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Gaurav Batra <gbatra@linux.ibm.com>, maddy@linux.ibm.com
Cc: npiggin@gmail.com, ltc-dev@lists.linux.ibm.com, linuxppc-dev@lists.ozlabs.org, sbhat@linux.ibm.com, harshpb@linux.ibm.com, vaibhav@linux.ibm.com
Subject: Re: [PATCH] powerpc/pseries/iommu: switch to Default DMA window during kdump
In-Reply-To: <c627cb09-5ac1-41f1-aaa1-88221f39c0c6@linux.ibm.com>
Date: Sat, 01 Aug 2026 11:25:00 +0530
Message-ID: <5x1umll7.ritesh.list@gmail.com>
References: <20260720203034.95244-1-gbatra@linux.ibm.com> <8q6sms4w.ritesh.list@gmail.com> <c627cb09-5ac1-41f1-aaa1-88221f39c0c6@linux.ibm.com>
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

>>
>> So looking at above, I had few questions -
>> 1. In your kdump kernel how many nr_cpus you are booting up with?
>>     Recently what I heard rhel/sles might be using nr_cpus=16/32. @Sourabh?
>>     So the calculation in nvme-fc driver then becomes:
>>       32(nr_cpus) * 64(queue_depth) * 2(cmd+resp) = 4096
>>
>>    If you are able to reproduce this issue 100% of the time - then can
>>    you try kdump with nr_cpus=1 and see whether it fixes your iommu alloc
>>    failure?
>
> Initially, when I reproduced this issue, I was not passing any value to
>
> nr_cpus to the kdump kernel. I made changes to /etc/sysconfig/kdump to pass
>
> nr_cpus=1. With this the kdump was successful. I tried with 
> nr_cpus=16/32. These
>
> were successful as well. Though, in these cases, I did notice a few 
> iommu_alloc failures
>
> (maybe < 10), vmcore was gathered successfully.
>
> I started to see the issue with nr_cpus=64. My LPAR is configured with 
> max cpus = 64. So,
>
> earlier, when I was not specifying nr_cpus in the /etc/sysconfig/kdump, 
> kdump could be
>
> defaulting to 64 CPUs and hence allocating more resources during kdump.
>

Was this issue not reported via any system testing? Is this something
that you found on your own when you attach nvme-fc?
The reason I am interested in knowing that was - because the distro
default for rhel/sles will be 16/32 cpus, so was wondering if it was
repored with the default values as well and what were they?


>> 2. Also were there more than 1 controller attached? Which can change the
>>    above calculation then.
>
> Only 1 controller. Here is the output of lscpi
>
> ltcd41-lp11:~ # lspci
> 0153:70:00.0 Fibre Channel: Emulex Corporation LPe37000/LPe38000 Series 
> 32Gb/64Gb Fibre Channel Adapter (rev 10)
> 0153:70:00.1 Fibre Channel: Emulex Corporation LPe37000/LPe38000 Series 
> 32Gb/64Gb Fibre Channel Adapter (rev 10)
> 0153:70:00.2 Fibre Channel: Emulex Corporation LPe37000/LPe38000 Series 
> 32Gb/64Gb Fibre Channel Adapter (rev 10)
> 0153:70:00.3 Fibre Channel: Emulex Corporation LPe37000/LPe38000 Series 
> 32Gb/64Gb Fibre Channel Adapter (rev 10)
>
>>
>> Looking at the lpfc and nvme-fc driver - a lot of the calculation are
>> based on nr_online_cpus. I somehow think if we clamp that value of
>> nr_online_cpus, we should stop seeing these alloc failures.
>> Thoughts?
>>
>> Hopefully, if you can work on some above points further, it will also
>> explain why are we seeing this failures only now. Is this something that
>> has caused an issue after RHEL/SLES moved to nr_cpus=16/32?
>
> it seems this got exposed because in my test LPAR, nr_cpus=1/16/32 was not
>
> getting passed to the kdump kernel.
>
>> Or was it after this commit from v6.9?
>>     ec30b461f3d: ("blk-mq: don't change nr_hw_queues and nr_maps for kdump kernel")
>>
>>> Here are the driver logs and stack
>>>
>>> lpfc 0153:70:00.0: iommu_alloc failed,
>>> tbl 0000000034ebcf5e vaddr 00000000d814df0b npages 1
>>> lpfc 0153:70:00.0: FCP Op failed - cmdiu dma mapping failed.
>>> lpfc 0153:70:00.0: iommu_alloc failed,
>>> tbl 0000000034ebcf5e vaddr 000000009779e4d2 npages 1
>>> lpfc 0153:70:00.0: FCP Op failed - cmdiu dma mapping failed.
>>>
>>> iommu_map_phys+0x1c4/0x1f0 (unreliable)
>>> dma_iommu_map_phys+0x54/0xa0
>>> dma_map_phys+0x3f8/0x590
>>> __nvme_fc_init_request+0x110/0x300 [nvme_fc]
>>> nvme_fc_init_request+0x60/0xb8 [nvme_fc]
>>> blk_mq_alloc_map_and_rqs+0x388/0x510
>>> blk_mq_alloc_tag_set+0x2a4/0x5f0
>>> nvme_alloc_io_tag_set+0xe0/0x1e0 [nvme_core]
>>> nvme_fc_connect_ctrl_work+0x85c/0xdac [nvme_fc]
>>> process_one_work+0x1e4/0x5a0
>>> worker_thread+0x1ec/0x3e0
>>>
>>> Increasing the number of free TCE entries in iommu_table_clear() will
>>> increase the probability of hitting EEH since there could still be some
>>> active IOs from the previous life of the kernel.
>>>
>>> Instead, during kdump, we can switch to default 2GB DMA window. This window
>>> will mostly be empty. Or, could be slightly used if buffers in pmemory
>>> were mapped for IO.
>>>
>> This will still remain a problem when we have SR-IOV adapter attached
>> correct? Because in that case we only get 1 window, so we anyway can't
>> use default window in kdump case. Correct?
>
> you are right. The patch is fixing the dedicated adapter path only by 
> switching to
>
> default window for kdump. Before I submitted the patch, I did try SR-IOV 
> path as well.
>
> Here, I assigned a virtualized adapter to LPAR and gathered kdump over 
> NFS. I checked the
>
> footprint of DMA buffers in this path. They were not much. I think, I 
> did sent these details
>
> in my emails (the discussion/advice).
>
>
> seems to me the least invasive fix for this very narrow problem.

I went back and looked at the history of why do we use DDW window during
kdump instead of default window. It looks like this commit itself
changed the default to DDW instead of default window :) i.e.
  Fixes: 09a3c1e46142 ("powerpc/pseries/iommu: IOMMU table is not initialized for kdump over SR-IOV")

The commit msg is very detailed and explains a lof of things but somehow
it didn't explain on why did we change the default to always use ddw
window instead of using default window.

>
> Your insight and thoughts?
>

Somehow in the current commit msg we didn't mention that this commit is
just a partial revert of that previous fixes commit - i.e. we are
switching back to using 2GB default DMA window as the preferred window
for kdump case.

IMO, let's please also _add_ something like this to the existing commit
msg, so that it becomes clear for others.

<snip>
  (after this) ...kdump path and DMA window is needed for IO to the device.

Although this commit fixed an issue during kdump with SR-IOV case,
  09a3c1e46142 ("powerpc/pseries/iommu: IOMMU table is not initialized for kdump over SR-IOV")
but this also made the kdump prefer DDW over the default DMA window when
both are present (dedicated adapter case). Since the DDW is fully mapped
by the previous kernel, iommu_table_clear() can free only
KDUMP_MIN_TCE_ENTRIES (2048) TCEs for use by kdump kernel.

This is not enough when the dump device is NVMe over Fibre Channel.
Because nvme-fc driver DMA-maps the cmds and resp IUs of every
pre-allocated request and each such mapping consumes roughly:
       32(IO queues, one per cpus = nr_cpus) * 64(queue_depth, blk-mq kdump limit) * 2(cmd+resp) = 4096

This is already double of what we have without counting admin queues and
lpfc driver's own allocations / mapping requirement. Hence this results
into iommu_alloc failures like - 

lpfc 0153:70:00.0: iommu_alloc failed,
tbl 0000000034ebcf5e vaddr 00000000d814df0b npages 1
lpfc 0153:70:00.0: FCP Op failed - cmdiu dma mapping failed.
lpfc 0153:70:00.0: iommu_alloc failed,
tbl 0000000034ebcf5e vaddr 000000009779e4d2 npages 1
lpfc 0153:70:00.0: FCP Op failed - cmdiu dma mapping failed.

iommu_map_phys+0x1c4/0x1f0 (unreliable)
dma_iommu_map_phys+0x54/0xa0
dma_map_phys+0x3f8/0x590
__nvme_fc_init_request+0x110/0x300 [nvme_fc]
nvme_fc_init_request+0x60/0xb8 [nvme_fc]
blk_mq_alloc_map_and_rqs+0x388/0x510
blk_mq_alloc_tag_set+0x2a4/0x5f0
nvme_alloc_io_tag_set+0xe0/0x1e0 [nvme_core]
nvme_fc_connect_ctrl_work+0x85c/0xdac [nvme_fc]
process_one_work+0x1e4/0x5a0
worker_thread+0x1ec/0x3e0

Increasing the number of free TCE entries in iommu_table_clear() will
increase the probability of hitting EEH since there could still be some
active IOs from the previous life of the kernel.

Hence this patch partially reverts the previous fixes commit and
switches the kdump's default back to 2GB default DMA window instead of
DDW window. This window will mostly be empty. Or, could be slightly used
if buffers in pmemory were mapped for IO.

Fixes: 09a3c1e46142 ("powerpc/pseries/iommu: IOMMU table is not initialized for kdump over SR-IOV")
Cc: stable@vger.kernel.org

(before this) ...Signed-off-by:...
</snip>


With that added to the commit msg - please also feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

>
> Thanks a lot
>
> Gaurav
>

Thanks again for adding detailed info. After looking at the history, I
agree we can partially revert the previous patch to prefer the default
DMA window for kdump case.

> As of now SR-IOV path doesn't seems to be of concern. But, I think, the 
> correct overall fix
>
> should be to maintain the DDW state --> if it is pre-mapped DDW, 
> transfer this knowledge to kdump.
>
> With this, the DDW will be intact and buffers pre-mapped, as before. 
> But, this requires more work
>
> and thorough testing by FVT/ISST. So, I kept this for later. For now, 
> switching to default window

I guess for kdump using 2GB default DMA window is not an issue, however
I agree that for kexec case we should find a way to fix this.
Because IIUC - kexec path on pseries is not performant today. It doesn't
use pre-mapped TCEs. So if someone is doing any I/O performance
measurement, we have to go via the full reboot cycle instead of just
using kexec.

-ritesh

