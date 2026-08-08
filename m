Return-Path: <linuxppc-dev+bounces-25640-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28C76C55174
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Aug 2026 14:35:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hHNpR3WgSz2y2B;
	Sun, 09 Aug 2026 00:35:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1034"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786199711;
	cv=none; b=BJ2qixf4NRHC5LNMADbVvGPG0wmuNoXO7XHiiKH8Xq1bLWfs3fQaXid62i7zZh0KWQMLQCerdjjDAqPPuh43wq2SVc7Zcw/RkbEEeRrYlPLYOViowp/xDi/jOqU8ujCkC6vbB9MacCfpua089+MnPuN31OJUhyqqcUXYJeD546bwE5Ci7DXZe/pOg/O2pd1Q+RV8ghFrmQGLakA/f0j59K46TVZijU1HL9CP8N1/aUR5R5o1inW9FLylP1Zw8TMODQCj65/remJuLBN3+vRCCoo6llf2wYADGOiJ4BEwx4YcAbQghPu4+6Tc8grQ1NyV67eOm3l5WLi8A6C9cjaHAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786199711; c=relaxed/relaxed;
	bh=KmpaHBXYqpfQMYRkdwBsL63a0IxH+KXPMQALNnMgNio=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=GZe7z60VgNxCHoqysfzxX3UiK/19Bl6ErYy/b1ywgZ/ll1dEkGaEDll8wE3hbs8KpLTi+/1qY20868WZ79MrHZUmGMXBGPiXIiW1PqnR0rZLpLB1pd1DRXe4+umMtBbjgIKbwI9Pevdzqf+9gmHzgV671DE3HoQtaFksbgCDxQNpWOSCcORxenaKbgTVvUPLw9t14TrMvN76AeQFXWpgarxl8GMEUB75+ABfDA5vkrfyXbDA1VpcN1NtYwKUAmyL1JsuuEuFktuH55aRIll9tCmA+5kB82DsUULnxNe2QI4U9xRAj3QKX241RvoZueZL8JEl0SJ4vB+vyKPD5R5gdA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Mn/henSt; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Mn/henSt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hHNpP5llFz2xLf
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 09 Aug 2026 00:35:08 +1000 (AEST)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-38e69bdb0fcso437637a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 08 Aug 2026 07:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786199705; x=1786804505; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=KmpaHBXYqpfQMYRkdwBsL63a0IxH+KXPMQALNnMgNio=;
        b=Mn/henStqK6eaIlOLp8X4BmeEa2YI+shGa3fS2N8xT6A596aeCcBJz6A1nies1AvO5
         no/MDX88uiW21l5T0bIN1djdOjk7hGIXfwJ8CibL3owOBn4aB6XpWJL+drMT5J4oxKCe
         Wt7elOd6ma7fcAngWXV/NNsOfhnVVH24QtBSRoPHEIuDiM4pmd05byPPT0g+CCJ9QbVs
         jd+mW18VnDFK798dgzQOfmHOQh0W8pbhs9Ub9gzEDSRexB/hLtorAWXu3twK7dlb79FW
         AjO332RgsF5CSjr8NXEVEBmdmyPSrxglNRQqH/TOTv2SCSLJrIOddel7JJuNgsSDFUQm
         BYCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786199705; x=1786804505;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KmpaHBXYqpfQMYRkdwBsL63a0IxH+KXPMQALNnMgNio=;
        b=AXODgG6fPWQB2nWY/1ccWbYslbKMPVHxz9HUOqqTNTvgz+vVg6vocVOTSHUp5j7HdN
         pESFXkGw0rRqIteOyNXzt1VD2UDqHWrbMUSSTK8jFbZMl/2Mtk+rp6q/liE4hgNR+eFu
         9mOFt7NFODo7vwLZAYxAwhFAm5SXZuzQmOzUmCPftH3rRicMT8UQbPFgh5BCCp/YkSjq
         VR5FgpkWJ3MSS6ywEIBrEe2+84mVHXwVHZi0RzdwWCmc/qHNxlpQOkE1u3xOUnDLJoQ4
         4nMM2ILl3YNC5TQmG682fEkGMJzwdrLw0IGtJEXiemwnNGvhn7s8px1Bba5PtGDVMQrJ
         nWbQ==
X-Gm-Message-State: AOJu0YxKtOH5yo9vKlDdjOCE6h3w+BmuPvpX0LF4ueo6DgHP5eYuhthy
	k4bpBqe5Jwg33rPkXVgbv+lzUV0x21pxuwKaP2QCkYFqZynSK3T4ZZFa
X-Gm-Gg: AR+sD10BYsLC5b5XSzpZatS2tRat80ifEEgTPEKyajtUCq4i+oiE9KrXunHHzGTlbic
	il9YGYcG4zl+mCaqGduybOq1IKZVv0OflDiv8PfjD+SFQfLlkFBVl1U/mebLcdvoRhZ8rGhZlfX
	UmYrIP3+iDlstFsf/te0arcRRzMGjraRfv/E2uDTviydblKRzZ/WmPx2Xlzb2tIaohxTMl9WZds
	WiuuW2SgwodruGSjdQadxgYenSSB6uBojK3Xi0+6GEKfFqlaoTuoWgvZNHmSaKzRdjNh0ObBQx6
	xBs8g4EJr5XW69EdM0DFFVAInAjvqXNrsQluN9KYFYDyN+UuDh4l10AAF4sqonCGY1bcII8+CZP
	gpNno6LqqNH3+0imEe9gUTf6qSoZBzm/owmdpeByHwvRNpPYFm9rg0KGd0gBAE+K0MfOl7l5iXS
	i59UHV0YZf2GqDOFjTPPkz1BYFi+CK03GexaaMQtR8iNVt0rgZ0g/KCJ/yWzU=
X-Received: by 2002:a17:90b:5251:b0:385:393e:7124 with SMTP id 98e67ed59e1d1-3903c5920a9mr31728519a91.14.1786199704945;
        Sat, 08 Aug 2026 07:35:04 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315be86f98esm20190290eec.6.2026.08.08.07.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 07:35:03 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Timothy Pearson <tpearson@raptorengineering.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Shivaprasad G Bhat <sbhat@linux.ibm.com>, Gaurav Batra <gbatra@linux.ibm.com>, maddy@linux.ibm.com, Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: Re: [BUG] VFIO on POWER9 / QEMU fails to allocate 32-bit DMA
In-Reply-To: <31839892.1773.1786167284864.JavaMail.zimbra@raptorengineeringinc.com>
Date: Sat, 08 Aug 2026 19:43:09 +0530
Message-ID: <v79kk8ei.ritesh.list@gmail.com>
References: <334689093.41938.1785796754275.JavaMail.zimbra@raptorengineeringinc.com> <o6fflsxx.ritesh.list@gmail.com> <980372793.1709.1786165222084.JavaMail.zimbra@raptorengineeringinc.com> <wlu1jj0b.ritesh.list@gmail.com> <31839892.1773.1786167284864.JavaMail.zimbra@raptorengineeringinc.com>
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

Timothy Pearson <tpearson@raptorengineering.com> writes:

> ----- Original Message -----
>> From: "Ritesh Harjani" <ritesh.list@gmail.com>
>> To: "Timothy Pearson" <tpearson@raptorengineering.com>
>> Cc: "linuxppc-dev" <linuxppc-dev@lists.ozlabs.org>, "Shivaprasad G Bhat" <sbhat@linux.ibm.com>, "Gaurav Batra"
>> <gbatra@linux.ibm.com>
>> Sent: Saturday, August 8, 2026 12:09:24 AM
>> Subject: Re: [BUG] VFIO on POWER9 / QEMU fails to allocate 32-bit DMA
>
>> Timothy Pearson <tpearson@raptorengineering.com> writes:
>> 
>>> ----- Original Message -----
>>>> From: "Ritesh Harjani" <ritesh.list@gmail.com>
>>>> To: "Timothy Pearson" <tpearson@raptorengineering.com>, "linuxppc-dev"
>>>> <linuxppc-dev@lists.ozlabs.org>
>>>> Cc: "Shivaprasad G Bhat" <sbhat@linux.ibm.com>, "Gaurav Batra"
>>>> <gbatra@linux.ibm.com>
>>>> Sent: Thursday, August 6, 2026 12:27:22 AM
>>>> Subject: Re: [BUG] VFIO on POWER9 / QEMU fails to allocate 32-bit DMA
>>>
>>>> Hi Timothy,
>>>> 
>>>> Timothy Pearson <tpearson@raptorengineering.com> writes:
>>>> 
>>>>> On Linux 6.18, and potentially earlier Linux versions, attempting to pass
>>>>> through any PCI device via VFIO that requires 32-bit DMA results in the
>>>>> following error in the guest VM:
>>>> 
>>>> Can you confirm if you see the same issue on upstream kernel also or is
>>>> it only till v6.18 kernel?
>>>
>>> I'll need to check, but I don't see why it would be limited to 6.18.  This used
>>> to work, but it's fairly obvious IBM hasn't been testing or fixing any of the
>>> VFIO or nested virtualization code for years now, especially on PowerNV.
>>>
>>>>>
>>>>> [   11.705413] cx23885 0000:00:02.0: Warning: IOMMU offset too big for device
>>>>> mask
>>>>> [   11.709245] cx23885 0000:00:02.0: mask: 0xffffffff, table offset:
>>>>> 0x800000000000000
>>>>>
>>>>> The same devices work correctly on the host kernel.  It appears that somehow
>>>>> 32-bit DMA is not available within a pSeries guest on a PowerNV host.
>>>> 
>>>> By any chance did you do kexec in the guest kernel? Is this issue only
>>>> hitting with kexec or even with normal boot up of guest kernel is also
>>>> showing up the same issue?
>>>
>>> Yes, we kexec().  This works on every other architecture, not sure why kexec()
>>> would break it?
>>>
>>> In any case, from where I sit at this point it's IBM's responsibility as the
>>> silicon vendor to ensure basic functionality works -- I don't see these issues
>>> on amd64 or arm64, and frankly on this end we're tired of the constant lack of
>>> QA from IBM causing every single kernel upgrade to be a game of Russian
>>> Roulette.  IBM should be able to spin up a test machine easily enough to
>>> reproduce, this isn't complex -- any card that needs 32-bit DMA is affected
>>> including inexpensive ASmedia USB 3 controllers.  Pass it through to QEMU via
>>> VFIO and watch it fail, it happens every time.
>>>
>> 
>> I was trying to help by asking for basic help from you. If you report a
>> problem upstream than we do expect such basic help e.g. is it only seen
>> with kexec, logs etc, so that we can all save some time here.
>
> No worries, appreciated.  This is only one of several major problems with Linux on PowerNV that we have run into after recent upgrades, and the primary focus at the moment is on restoring broken functionality.  In many cases, that means moving to different hardware, so gathering logs afterward can be difficult / impossible.
>

Sorry to hear that you have been facing such issues recently. I will
bring this up internally. We will try to add more test matrix for
upstream PowerNV (note that we already have PowerNV tested regularly as
part of our upstream CI, but I suppose we could extend more KVM guest
testing there), so that we can reduce down on such reports.

>>>> Could you please share the dmesg logs for both guest and host kernel?
>>>> That might give some more data about this issue.
>>>
>>> I don't have access to the setup at this point since it was already replaced
>>> with something else to restore functionality.
>> 
>> I think this patch [1] might have fixed the issue that you reported and
>> hence wanted to check if you only see the issue with kexec or also with
>> reboots? And if you could have given it a try.
>> 
>> [1]: https://lore.kernel.org/all/20260803224029.60538-1-gbatra@linux.ibm.com/
>> 
>> But anyways - I have already asked others on that thread (who are expert
>> of this area) to confirm if this patch could also fix the error you
>> reported with 32-bit DMA devices.

Although not with VFIO - but I verified this issue by adding e1000
32-bit DMA device on the same PHB where other 64bit DMA devices were
attached (in my Qemu development environment).

And with that I was able to re-create the issue with kexec i.e. on kexec
I see the following error similar to what you reported in your
environment:

[    5.537726] pci 0000:00:01.0: ibm,query-pe-dma-windows(2026) 800 8000000 20000000 returned 0, lb=2000000000 ps=107 wn=0
[    5.540233] pci 0000:00:01.0: Adding to iommu group 0
[    5.556968] pci 0000:00:03.0: Adding to iommu group 0
[    5.567164] PCI: Probing PCI hardware done
[    9.395499] virtio-pci 0000:00:03.0: lsa_required: 0, lsa_enabled: 0, direct mapping: 0
[    9.396111] virtio-pci 0000:00:03.0: lsa_required: 0, lsa_enabled: 0, direct mapping: 0
[   13.228575] e1000: Intel(R) PRO/1000 Network Driver
[   13.229566] e1000: Copyright (c) 1999-2006 Intel Corporation.
[   13.253804] e1000 0000:00:01.0: Warning: IOMMU offset too big for device mask
[   13.255200] e1000 0000:00:01.0: mask: 0xffffffff, table offset: 0x800000000000000
[   13.256611] e1000: No usable DMA config, aborting
[   13.267336] e1000 0000:00:01.0: probe with driver e1000 failed with error -5

This is failing with same error as you had reported:
     "Warning: IOMMU offset too big for device mask"

Whereas after I applied the patch mentioned in [1], I am able to see the
device working fine after kexec. Here are the logs with the fix applied:

[    6.197623] pci 0000:00:01.0: ibm,query-pe-dma-windows(2026) 800 8000000 20000000 returned 0, lb=2000000000 ps=107 wn=0
[    6.201686] pci 0000:00:01.0: Adding to iommu group 0
[    6.221890] pci 0000:00:03.0: Adding to iommu group 0
[    8.991990] virtio-pci 0000:00:03.0: lsa_required: 0, lsa_enabled: 0, direct mapping: 0
[    8.992710] virtio-pci 0000:00:03.0: lsa_required: 0, lsa_enabled: 0, direct mapping: 0
[   11.315607] e1000: Intel(R) PRO/1000 Network Driver
[   11.316191] e1000: Copyright (c) 1999-2006 Intel Corporation.
[   11.671185] e1000 0000:00:01.0 eth1: (PCI:33MHz:32-bit) 52:54:00:12:34:56
[   11.672604] e1000 0000:00:01.0 eth1: Intel(R) PRO/1000 Network Connection

>
> Thank you for the link.  When / if we want to test a migration of that hardware back to VFIO on PowerNV I will ensure that patch is applied before testing.

Sure, I think this should fix the issue you reported. We have tagged
that fix with stable - so we will ensure it is backported to stable
kernel releases as well.

-ritesh


