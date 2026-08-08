Return-Path: <linuxppc-dev+bounces-25649-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A463C55174
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Aug 2026 16:19:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hHR6s5TzVz2yMl;
	Sun, 09 Aug 2026 02:19:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=23.155.224.40
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786205973;
	cv=none; b=aCdDIKu2YwA88B1cIeBTHLKAHPdNi2tmvUf8oFLNSfDuMgd5zPdgPMm85vvm4wgh58sHuiEWg7cuj7zkF+TlFoim3x+ZjdZWygeBoDc5PrQFX8IN7hCHw0wIpeUPZl0+UiU7GAUMlndQn/MsGRl46ctTJHuZTyOacoeAi9pTQb/elQ3L0n+igrNKdSYB9h3D8rU+iDqqcS9GDMYpH+jMNKVpJ7u7O9Awbrl6VR4/y12yzuezSYaUNZ94bDYp7vpz6CB2BNJLW6PcmW49SQHnZWX88G8RL5RzGxFTKsGum2sMkFquGFwPCRew4TLwrrKVUHro0jjweniWHp1BcdUQaA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786205973; c=relaxed/relaxed;
	bh=99ewr5N9DynXcwT38D3djZxTRuCgO7yGxKDriGYOC/g=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Vt8FT0Zycyy/u3/SFNOrZMfVY50fj+u/pKRCKmb4ZkMx7vqI9RKwXIdnLAhPLYgmn96Jgzkt2cUMOPPGK9dntbnJ5epARAzfeKttUtrwZjSS0hp8dqaD5t+8RNm5c+jbsnBwHabRJkSUvAUX1d0ey3IQxLM9roB2u3jjq0/ThYE5Y+HGOvWXblP8Cnycg0kYocexb1uV1n+mK3W+QnGIhfNM5o0umsXcjCN1eDGJ0C1/xO03HqiG3l80qp1+JGiiIEaCTuIGk8pQHP204lus48xP/Ddb5xishiR9TF5OwBX15B86pxeF0QJFHMoxeYxofk/wbN53n2OdgNpaXvSvLA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com; dkim=pass (1024-bit key; secure) header.d=raptorengineering.com header.i=@raptorengineering.com header.a=rsa-sha256 header.s=B8E824E6-0BE2-11E6-931D-288C65937AAD header.b=I5so2aYj; dkim-atps=neutral; spf=pass (client-ip=23.155.224.40; helo=raptorengineering.com; envelope-from=tpearson@raptorengineering.com; receiver=lists.ozlabs.org) smtp.mailfrom=raptorengineering.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; secure) header.d=raptorengineering.com header.i=@raptorengineering.com header.a=rsa-sha256 header.s=B8E824E6-0BE2-11E6-931D-288C65937AAD header.b=I5so2aYj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=raptorengineering.com (client-ip=23.155.224.40; helo=raptorengineering.com; envelope-from=tpearson@raptorengineering.com; receiver=lists.ozlabs.org)
Received: from raptorengineering.com (mail.raptorengineering.com [23.155.224.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hHR6r0thVz2xLf
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 09 Aug 2026 02:19:32 +1000 (AEST)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 032467791D38;
	Sat,  8 Aug 2026 11:19:30 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id z_57QEGhMrh7; Sat,  8 Aug 2026 11:19:29 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id E48487791D46;
	Sat,  8 Aug 2026 11:19:28 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com E48487791D46
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
	t=1786205968; bh=99ewr5N9DynXcwT38D3djZxTRuCgO7yGxKDriGYOC/g=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=I5so2aYj42Sdinh7E0In8J8QOgXzAllCB+hqr6PaInDuJfRlWcBZZgvrl0gXNdEir
	 ogk8h56zl7cjYILEU9prT2lc99q34T3+PmUyBYm/rK0DfeLM51VTFP4SGc8h3sQ41N
	 9+5GK9ED9kVMd9hOH252y1bsa8s4NcuOvJko2cE0=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id pbrlT69L_0nZ; Sat,  8 Aug 2026 11:19:28 -0500 (CDT)
Received: from vali.starlink.edu (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id ACFAC7790EF0;
	Sat,  8 Aug 2026 11:19:28 -0500 (CDT)
Date: Sat, 8 Aug 2026 11:19:25 -0500 (CDT)
From: Timothy Pearson <tpearson@raptorengineering.com>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, 
	Shivaprasad G Bhat <sbhat@linux.ibm.com>, 
	Gaurav Batra <gbatra@linux.ibm.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Message-ID: <192733194.2399.1786205965385.JavaMail.zimbra@raptorengineeringinc.com>
In-Reply-To: <v79kk8ei.ritesh.list@gmail.com>
References: <334689093.41938.1785796754275.JavaMail.zimbra@raptorengineeringinc.com> <o6fflsxx.ritesh.list@gmail.com> <980372793.1709.1786165222084.JavaMail.zimbra@raptorengineeringinc.com> <wlu1jj0b.ritesh.list@gmail.com> <31839892.1773.1786167284864.JavaMail.zimbra@raptorengineeringinc.com> <v79kk8ei.ritesh.list@gmail.com>
Subject: Re: [BUG] VFIO on POWER9 / QEMU fails to allocate 32-bit DMA
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
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC150 (Linux)/8.5.0_GA_3042)
Thread-Topic: VFIO on POWER9 / QEMU fails to allocate 32-bit DMA
Thread-Index: vUSwfzpw+U6WujoX9m7WbT3pKeW3gw==



----- Original Message -----
> From: "Ritesh Harjani" <ritesh.list@gmail.com>
> To: "Timothy Pearson" <tpearson@raptorengineering.com>
> Cc: "linuxppc-dev" <linuxppc-dev@lists.ozlabs.org>, "Shivaprasad G Bhat" <sbhat@linux.ibm.com>, "Gaurav Batra"
> <gbatra@linux.ibm.com>, "Madhavan Srinivasan" <maddy@linux.ibm.com>, "Venkat Rao Bagalkote" <venkat88@linux.ibm.com>
> Sent: Saturday, August 8, 2026 9:13:09 AM
> Subject: Re: [BUG] VFIO on POWER9 / QEMU fails to allocate 32-bit DMA

> Timothy Pearson <tpearson@raptorengineering.com> writes:
> 
>> ----- Original Message -----
>> No worries, appreciated.  This is only one of several major problems with Linux
>> on PowerNV that we have run into after recent upgrades, and the primary focus
>> at the moment is on restoring broken functionality.  In many cases, that means
>> moving to different hardware, so gathering logs afterward can be difficult /
>> impossible.
>>
> 
> Sorry to hear that you have been facing such issues recently. I will
> bring this up internally. We will try to add more test matrix for
> upstream PowerNV (note that we already have PowerNV tested regularly as
> part of our upstream CI, but I suppose we could extend more KVM guest
> testing there), so that we can reduce down on such reports.

That would be very helpful.  I have a number of other internal reports (and some external customer reports) that I will try to get together for submission here.  Given the testing on PowerNV seems quite sparse at the moment, if you do need additional PowerNV machines for testing we have bare metal cloud leases available.

One of the customer reports I already forwarded up to Github, but further logs aren't available as the customer has already moved to different hardware:

https://github.com/tbsdtv/linux_media/issues/431

The final straw that caused migration on that side was yet another VFIO bug on top of the invalid DMA that prevented EEH recovery and was forcing host resets to thaw the frozen PE.  I'll try to submit that report here as well.

> Although not with VFIO - but I verified this issue by adding e1000
> 32-bit DMA device on the same PHB where other 64bit DMA devices were
> attached (in my Qemu development environment).
> 
> And with that I was able to re-create the issue with kexec i.e. on kexec
> I see the following error similar to what you reported in your
> environment:
> 
> [    5.537726] pci 0000:00:01.0: ibm,query-pe-dma-windows(2026) 800 8000000
> 20000000 returned 0, lb=2000000000 ps=107 wn=0
> [    5.540233] pci 0000:00:01.0: Adding to iommu group 0
> [    5.556968] pci 0000:00:03.0: Adding to iommu group 0
> [    5.567164] PCI: Probing PCI hardware done
> [    9.395499] virtio-pci 0000:00:03.0: lsa_required: 0, lsa_enabled: 0, direct
> mapping: 0
> [    9.396111] virtio-pci 0000:00:03.0: lsa_required: 0, lsa_enabled: 0, direct
> mapping: 0
> [   13.228575] e1000: Intel(R) PRO/1000 Network Driver
> [   13.229566] e1000: Copyright (c) 1999-2006 Intel Corporation.
> [   13.253804] e1000 0000:00:01.0: Warning: IOMMU offset too big for device mask
> [   13.255200] e1000 0000:00:01.0: mask: 0xffffffff, table offset:
> 0x800000000000000
> [   13.256611] e1000: No usable DMA config, aborting
> [   13.267336] e1000 0000:00:01.0: probe with driver e1000 failed with error -5
> 
> This is failing with same error as you had reported:
>     "Warning: IOMMU offset too big for device mask"
> 
> Whereas after I applied the patch mentioned in [1], I am able to see the
> device working fine after kexec. Here are the logs with the fix applied:
> 
> [    6.197623] pci 0000:00:01.0: ibm,query-pe-dma-windows(2026) 800 8000000
> 20000000 returned 0, lb=2000000000 ps=107 wn=0
> [    6.201686] pci 0000:00:01.0: Adding to iommu group 0
> [    6.221890] pci 0000:00:03.0: Adding to iommu group 0
> [    8.991990] virtio-pci 0000:00:03.0: lsa_required: 0, lsa_enabled: 0, direct
> mapping: 0
> [    8.992710] virtio-pci 0000:00:03.0: lsa_required: 0, lsa_enabled: 0, direct
> mapping: 0
> [   11.315607] e1000: Intel(R) PRO/1000 Network Driver
> [   11.316191] e1000: Copyright (c) 1999-2006 Intel Corporation.
> [   11.671185] e1000 0000:00:01.0 eth1: (PCI:33MHz:32-bit) 52:54:00:12:34:56
> [   11.672604] e1000 0000:00:01.0 eth1: Intel(R) PRO/1000 Network Connection
> 
>>
>> Thank you for the link.  When / if we want to test a migration of that hardware
>> back to VFIO on PowerNV I will ensure that patch is applied before testing.
> 
> Sure, I think this should fix the issue you reported. We have tagged
> that fix with stable - so we will ensure it is backported to stable
> kernel releases as well.

That sounds great, thanks.  Does IBM have any plans to support Debian LTS (Freexian) so these patches can flow into the broken distribution kernels?

Thanks!

