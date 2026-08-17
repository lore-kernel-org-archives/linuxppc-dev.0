Return-Path: <linuxppc-dev+bounces-25897-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CD91C5B572
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Aug 2026 00:59:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hNZGy00cgz2xfB;
	Mon, 17 Aug 2026 10:59:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::533"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786928361;
	cv=none; b=JyHcYyAkwt1f3fjdxYFLd+OWUCwv5jV+S7HIASvj3AmSO4iykZ84uVqzKZiDn00lUHRkYrlaJm9g4733BPec3q6O+8clINUf2s/bQq+ynsoVoYmiaNEuSZwkjSma2MyCtDpEaWWkcf5i3zk7HFr2tCk1C46Uh06EABwOg4B/CZp4uG5DppJNBlBtG648IH42Wb4R2G9esIxBTNGwsONnXHYdYxyPcmK8CN39CjVgGzrXI5xW7MZxaonVQSMsyEo967lrGGkzwqfVQkP5yKgE5fnhMnkftFH9Ep8IKJRcYDxYEK1VBo7TQLqEV46PmppyhR8Wu4a8lBkUNyNxhmM9tA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786928361; c=relaxed/relaxed;
	bh=uuS5dJTjzCBe9OWxiZC20f++qso8otPmot2RU8P/3xU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=IcE0ucy41o878I1nqSMK0WoXtXXtJo0bbbpZcs4Tc0LLF6eycycXxwJ8zi7ZrNQUrc+N1J3O8RtnekzPx4pfkopf+Capd8WImpt9t0Obt6HfRK5KeFtYOOYuMUfT3fVm3qVGi5spVdMgmIcbsyzkQXQUszLaxU45/G3UjmKcm86im0nXKhpPkh343Zn7GjhuPqsCq/WV2D9iaaAUxRQj80z0qVlqqQT+cLl2xAn4XOBsLGOrv0TJ1UuHeqe/8hJ1Gv3N7V0lOrZpD56PCyIu7YDO4cZgUKCIJBJWo5rndgEde66ofWG/vCmQNv1pCtELVMFGRrecEHAP9QELuSXsRg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mF+KBTBD; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::533; helo=mail-pg1-x533.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mF+KBTBD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::533; helo=mail-pg1-x533.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hNZGw4zgbz2xSl
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2026 10:59:19 +1000 (AEST)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-cbedda4c154so1504421a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 Aug 2026 17:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786928357; x=1787533157; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=uuS5dJTjzCBe9OWxiZC20f++qso8otPmot2RU8P/3xU=;
        b=mF+KBTBDMYotCuEqNJcA9NFNq5ApzHSmuXpn2EYTF9FcDhsOnWaAoIa32imgb7Gil5
         NmLS/4QrsLy65n1NXTlclWqHyZu8SwslrNu36fqBgwdPOo1zpcmBZmVV25aYnxcc2u5T
         kX/Z9ZvUNkFv8r5RfwvlgHXzPgwTxVEc+4136TFmj7We1rvMoexTIRh6XVKWo3emW38Y
         ymmksJ3w9lpUsj8G9yidhofWR3WI1USTPwzehZkbLQlfWYUBF+O/m1PzFYwqSgMpTuEP
         POw6vo1rlhPcTjjzAxGNgyEkWBP2ISMp8dlVKysvFImLUqNmB+20tPgXKsdn35cbCkmB
         iCSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786928357; x=1787533157;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uuS5dJTjzCBe9OWxiZC20f++qso8otPmot2RU8P/3xU=;
        b=V0nNckCxWzUT5zwAjJB00Zxtd7J38KYabSHYG3tXlDQWUcrOswfFVyB4rW/cy8Vp3T
         37kljYwy7BKqN2KoDQPZ0JNDnwNEbys6xUzEUtyMAEPCXmo5KtJZmShz2xQiPL4W9X7R
         1pUSvC9/PxFqBn8hKBl/QvETjlyxq2x+qRm60e8XMmht41PwMCzIR5wkhAyclrfwdzpC
         rukAWiTB8OL6gveJFlCnTPNR/MniPfZU/gy+R5HvwwnJjO+JvEc0BGnMuO2q95p+cPJ4
         fr6zRN9r5HdQ94WJ1cK1zqb5VeslzJbZewW1unBjuwh30BrChIt8DTYhW/wHtL8Cep2o
         FUDw==
X-Gm-Message-State: AOJu0Yx2jeaOlHV5u7MSulMuCYH0aAG7iBKmS2lvEEVsqKp08WcmYexp
	TG0I4C6PQoQCnSDXjmdCkbb7WSX+KWgF/Ef1FzO/nyzzkE6tlJPpSVeQBohBdbD/
X-Gm-Gg: AR+sD13BC8vydfwEjC8FXhhjVLdcaIFAAo1X8NwvzeUl/WCwL9TfaaP0gnsT9cvku8m
	YjbR4p35ystvhycKlTswMgNMnjA1WDX3XfV3CWC6f8YmBwdDYC6mhPSCCrRJHBlBuXM0E5ix1f9
	26gSAqkZ/GjpfXH7dFiDhFd6AvOyB3uRI0VvNq/XyM+VLxjbSbvfUocXM4r1hxdGpTlK7MPMnhI
	fZG4iEzHUC1Zlx8Vdox3AI96KDSqfCxy2QDkX2+DF9qtLD+AncOPFSWat7EhZ8rjE442q8hDWy6
	dWhRFE6SSDVOOrGfNwICtiZ+8g9BjUZcc5Gp4ne7CzDBZaCSmxfSkQ1XMUIXak3oHX5YhdR0xfR
	kExzIsdYrdxchHPm82AE3gpNtZuJO2YXTBaxtZx1SROJzFoYxt6AHfYqXcK1MNg2YuXoqk7rhzx
	ln6Q4Gp1PL5LlvtOADRZFQwOTTAG+rtyX7z42YreRGUnaUIz+fWNpXgNXVqVPDm+B0UQdo8dqQj
	J5ZtdAg/hLOgE8hcD9nwCnBakofeJ+8p/jrFnBQ0vS2
X-Received: by 2002:a05:6a20:160e:b0:3b4:5ff3:45cb with SMTP id adf61e73a8af0-3cc719ff645mr23740494637.8.1786928356408;
        Sun, 16 Aug 2026 17:59:16 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-326793c43b7sm28578eec.7.2026.08.16.17.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 17:59:15 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Timothy Pearson <tpearson@raptorengineering.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Shivaprasad G Bhat <sbhat@linux.ibm.com>, Gaurav Batra <gbatra@linux.ibm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: Re: [BUG] VFIO on POWER9 / QEMU fails to allocate 32-bit DMA
In-Reply-To: <192733194.2399.1786205965385.JavaMail.zimbra@raptorengineeringinc.com>
Date: Mon, 17 Aug 2026 05:52:18 +0530
Message-ID: <qzjxk345.ritesh.list@gmail.com>
References: <334689093.41938.1785796754275.JavaMail.zimbra@raptorengineeringinc.com> <o6fflsxx.ritesh.list@gmail.com> <980372793.1709.1786165222084.JavaMail.zimbra@raptorengineeringinc.com> <wlu1jj0b.ritesh.list@gmail.com> <31839892.1773.1786167284864.JavaMail.zimbra@raptorengineeringinc.com> <v79kk8ei.ritesh.list@gmail.com> <192733194.2399.1786205965385.JavaMail.zimbra@raptorengineeringinc.com>
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


Hi Timothy

Timothy Pearson <tpearson@raptorengineering.com> writes:

> ----- Original Message -----
>> From: "Ritesh Harjani" <ritesh.list@gmail.com>
>> To: "Timothy Pearson" <tpearson@raptorengineering.com>
>> Cc: "linuxppc-dev" <linuxppc-dev@lists.ozlabs.org>, "Shivaprasad G Bhat" <sbhat@linux.ibm.com>, "Gaurav Batra"
>> <gbatra@linux.ibm.com>, "Madhavan Srinivasan" <maddy@linux.ibm.com>, "Venkat Rao Bagalkote" <venkat88@linux.ibm.com>
>> Sent: Saturday, August 8, 2026 9:13:09 AM
>> Subject: Re: [BUG] VFIO on POWER9 / QEMU fails to allocate 32-bit DMA
>
>> Timothy Pearson <tpearson@raptorengineering.com> writes:
>> 
>>> ----- Original Message -----
>>> No worries, appreciated.  This is only one of several major problems with Linux
>>> on PowerNV that we have run into after recent upgrades, and the primary focus
>>> at the moment is on restoring broken functionality.  In many cases, that means
>>> moving to different hardware, so gathering logs afterward can be difficult /
>>> impossible.
>>>
>> 
>> Sorry to hear that you have been facing such issues recently. I will
>> bring this up internally. We will try to add more test matrix for
>> upstream PowerNV (note that we already have PowerNV tested regularly as
>> part of our upstream CI, but I suppose we could extend more KVM guest
>> testing there), so that we can reduce down on such reports.
>
> That would be very helpful.  I have a number of other internal reports (and some external customer reports) that I will try to get together for submission here.  Given the testing on PowerNV seems quite sparse at the moment, if you do need additional PowerNV machines for testing we have bare metal cloud leases available.
>

Thanks for bringing up your concern. Based on your feedback, we brought
up this topic internally. So currently w.r.t upstream maintainance work,
we have build, boot, selftests and few other test runs, on our PowerNV
systems, but I agree our other major testing was happening on Pseries
platform. So, we decided to add more PowerNV machines to our internal CI
and expand / increase our upstream CI tests and runs on these baremetal
machines too. This is going to happen very soon, so hopefully, this
should reduce such reports in the future.


BTW - notice that the current issue - I reproduced on Pseries
development environment itself. So this one seems to be some special
case where you either have a 32-bit and a 64-bit HW sitting on the same
PE (partitionable endpoint) behind the same iommu group (like sometimes
behind a PCIe switch) or maybe the HW does both 32-bit and 64-bit probe.
But anyways the patch I pointed should fix that problem and we will
ensure it is backported to all stable kernels, and likely the
distributions should pick that up as well (we will take care of that too).

> One of the customer reports I already forwarded up to Github, but further logs aren't available as the customer has already moved to different hardware:
>
> https://github.com/tbsdtv/linux_media/issues/431
>
> The final straw that caused migration on that side was yet another VFIO bug on top of the invalid DMA that prevented EEH recovery and was forcing host resets to thaw the frozen PE.  I'll try to submit that report here as well.
>

Sure thanks. I see you already have shared few reports. We will take a
look at those. If there is anything else please feel free to share it
with us.

>> Although not with VFIO - but I verified this issue by adding e1000
>> 32-bit DMA device on the same PHB where other 64bit DMA devices were
>> attached (in my Qemu development environment).
>> 
>> And with that I was able to re-create the issue with kexec i.e. on kexec
>> I see the following error similar to what you reported in your
>> environment:
>> 
>> [    5.537726] pci 0000:00:01.0: ibm,query-pe-dma-windows(2026) 800 8000000
>> 20000000 returned 0, lb=2000000000 ps=107 wn=0
>> [    5.540233] pci 0000:00:01.0: Adding to iommu group 0
>> [    5.556968] pci 0000:00:03.0: Adding to iommu group 0
>> [    5.567164] PCI: Probing PCI hardware done
>> [    9.395499] virtio-pci 0000:00:03.0: lsa_required: 0, lsa_enabled: 0, direct
>> mapping: 0
>> [    9.396111] virtio-pci 0000:00:03.0: lsa_required: 0, lsa_enabled: 0, direct
>> mapping: 0
>> [   13.228575] e1000: Intel(R) PRO/1000 Network Driver
>> [   13.229566] e1000: Copyright (c) 1999-2006 Intel Corporation.
>> [   13.253804] e1000 0000:00:01.0: Warning: IOMMU offset too big for device mask
>> [   13.255200] e1000 0000:00:01.0: mask: 0xffffffff, table offset:
>> 0x800000000000000
>> [   13.256611] e1000: No usable DMA config, aborting
>> [   13.267336] e1000 0000:00:01.0: probe with driver e1000 failed with error -5
>> 
>> This is failing with same error as you had reported:
>>     "Warning: IOMMU offset too big for device mask"
>> 
>> Whereas after I applied the patch mentioned in [1], I am able to see the
>> device working fine after kexec. Here are the logs with the fix applied:
>> 
>> [    6.197623] pci 0000:00:01.0: ibm,query-pe-dma-windows(2026) 800 8000000
>> 20000000 returned 0, lb=2000000000 ps=107 wn=0
>> [    6.201686] pci 0000:00:01.0: Adding to iommu group 0
>> [    6.221890] pci 0000:00:03.0: Adding to iommu group 0
>> [    8.991990] virtio-pci 0000:00:03.0: lsa_required: 0, lsa_enabled: 0, direct
>> mapping: 0
>> [    8.992710] virtio-pci 0000:00:03.0: lsa_required: 0, lsa_enabled: 0, direct
>> mapping: 0
>> [   11.315607] e1000: Intel(R) PRO/1000 Network Driver
>> [   11.316191] e1000: Copyright (c) 1999-2006 Intel Corporation.
>> [   11.671185] e1000 0000:00:01.0 eth1: (PCI:33MHz:32-bit) 52:54:00:12:34:56
>> [   11.672604] e1000 0000:00:01.0 eth1: Intel(R) PRO/1000 Network Connection
>> 
>>>
>>> Thank you for the link.  When / if we want to test a migration of that hardware
>>> back to VFIO on PowerNV I will ensure that patch is applied before testing.
>> 
>> Sure, I think this should fix the issue you reported. We have tagged
>> that fix with stable - so we will ensure it is backported to stable
>> kernel releases as well.
>
> That sounds great, thanks.  Does IBM have any plans to support Debian LTS (Freexian) so these patches can flow into the broken distribution kernels?
>

yes, we do support that. Once the patch is merged and available in
stable kernels, we will ensure this is backported to this distribution
as well.

> Thanks!

I see you have already shared few more reports with us. We will be
looking into those and will bring those to closure too.

Thanks again for sharing the details with us.

-ritesh


