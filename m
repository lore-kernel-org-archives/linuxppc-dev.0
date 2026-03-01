Return-Path: <linuxppc-dev+bounces-17473-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8ACDFD0056
	for <linuxppc-dev@archiver.kernel.org>; Sun,  1 Mar 2026 07:00:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fNtHG4cxrz2yF1;
	Sun, 01 Mar 2026 18:00:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772348410;
	cv=none; b=nZFjUXkeKRwf9vM6BbDXx+kDjQ/D9ASnmCnK4s+tcjh/Zrf4M8PUPDVGnj/yn/6lX2VbAPxAUCV2hvIDowjzwmBExuqOqI7QY0fFVxZJ6hznJamgEzvGBNT+DkPyYE2Tp+LfTAWuQFgPcJBj0t0nMp7YFCH0r/KVZM6i8/npZpZjobrbrEOEw/AqUYdWX/Bkt3tdN04ZFaO/e7nqh1ZfXby4cHD3fqyMQJeKCD+lwSsZKYslosEm1dhuAA6HLR65CLTqbPGMD2aCl1JuU8gLKBHNdsIOD/SqV4BfvFbvxOMGhsv4aMTjXlUl4oYsCDVRMzvov6AEYyDFJh4rsKkQTg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772348410; c=relaxed/relaxed;
	bh=I8EQo/NbWjLKrDlFxdsKTBfRrpz+7VWtsvEBPsnJquA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IEv7w6oyRexGlL8yzdDcpGe9dZLx3BFE/90bqIra3jL6eshPwa7qBLzmRx7KSudorQjQWb6OnByABH8SzcpI9UBREoBJ1iI3HwdxFa3AEdCTmsEg+2xZw7V7ju44P++O6j96Q6kmNfbTdccFHzN5eMUSJlu0OI4yV6Z7bf+sHmbeIUT6V6YokhCaT76Q3jsZ4VnTMhuKkZD24UbCFQnrrRiDDj1WnriojdBQWeyAHtvDfNemQXGNhi9pwUsYpp0wlHAqIU490uxr/i1WqCF0KN3MQUwA/TNWEf6GTDlgpgHr1y6dxEsdtY4Ue/NbaOQnw7zaj1Nhu+Z22CIAkvt1jw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=UHCNbsgy; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=SYECe4KG; dkim-atps=neutral; spf=pass (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=namcao@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=UHCNbsgy;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=SYECe4KG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=namcao@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fNtHD2KMLz2yFK
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 01 Mar 2026 18:00:08 +1100 (AEDT)
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772348402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I8EQo/NbWjLKrDlFxdsKTBfRrpz+7VWtsvEBPsnJquA=;
	b=UHCNbsgyx/6ZWOygB5rCjnV9ylgVGph4Q5rD/PkSl7E0vMV/eNKHF9wjEkasjXBawmTFMH
	1XAOi+vz7QdZMPANg1U1iAgm6GHCoF6780fRGrXjBloae1sbrc9We+lxIfPGHloYzit0mQ
	F1NxWo14CeIBA5SCTjai1giJithnZ5+0uKQPm55mcRxZ4vJcCkjw17BStPo6Q9jVcBR7ZP
	o1c+ZHWH4y6obBA/9uz1oXmvhOHPpFuF/XvI0wZF/qWlJLFZlfn4aOQ7voc9WR3ZCCwoUR
	1YNNIU4gWryB+TMZruvP3n6EMBTmfJj/Qg/hgEf7yE1JiIcC2p/mjlxTh2Pqxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772348402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I8EQo/NbWjLKrDlFxdsKTBfRrpz+7VWtsvEBPsnJquA=;
	b=SYECe4KGSP/zVd5WloNpXB8nNRX4FTDjfqx+O8v978PDMMwI/6lozc9SiZmc4D2Obd7nw6
	6A+ARbmoW+JjGyDA==
To: Nilay Shroff <nilay@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, sparclinux@vger.kernel.org
Cc: wangruikang@iscas.ac.cn, tglx@kernel.org, maddy@linux.ibm.com,
 mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, gjoyce@ibm.com,
 helgaas@kernel.org, davem@davemloft.net, andreas@gaisler.com, Nilay Shroff
 <nilay@linux.ibm.com>
Subject: Re: [PATCHv2 1/2] powerpc/pci: Initialize msi_addr_mask for
 OF-created PCI devices
In-Reply-To: <20260220070239.1693303-2-nilay@linux.ibm.com>
References: <20260220070239.1693303-1-nilay@linux.ibm.com>
 <20260220070239.1693303-2-nilay@linux.ibm.com>
Date: Sun, 01 Mar 2026 13:59:46 +0700
Message-ID: <87a4ws6nml.fsf@yellow.woof>
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
Content-Type: text/plain

Nilay Shroff <nilay@linux.ibm.com> writes:
> Recent changes replaced the use of no_64bit_msi with msi_addr_mask.
> As a result, msi_addr_mask is now expected to be initialized to
> DMA_BIT_MASK(64) when a pci_dev is set up. However, this initialization
> was missed on powerpc due to differences in the device initialization
> path compared to other (x86) architecture. Due to this, now PCI device
> probe method fails on powerpc system.
>
> On powerpc systems, struct pci_dev instances are created from device
> tree nodes via of_create_pci_dev(). Because msi_addr_mask was not
> initialized there, it remained zero. Later, during MSI setup,
> msi_verify_entries() validates the programmed MSI address against
> pdev->msi_addr_mask. Since the mask was not set correctly, the
> validation fails, causing PCI driver probe failures for devices on
> powerpc systems.
>
> Initialize pdev->msi_addr_mask to DMA_BIT_MASK(64) in
> of_create_pci_dev() so that MSI address validation succeeds and device
> probe works as expected.
>
> Fixes: 386ced19e9a3 ("PCI/MSI: Convert the boolean no_64bit_msi flag to a DMA address mask")
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>

I ran into this problem today. Great that it's already been fixed.

Reviewed-by: Nam Cao <namcao@linutronix.de>
Tested-by: Nam Cao <namcao@linutronix.de>

Nam

