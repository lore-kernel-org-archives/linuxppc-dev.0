Return-Path: <linuxppc-dev+bounces-25865-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51820C5CFC1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Aug 2026 14:56:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hM50Z50B2z2ykT;
	Sat, 15 Aug 2026 00:56:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=23.155.224.40
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786719406;
	cv=none; b=QWNUUJTm+LfE/tVvVnW8vRb197ox4i+3RkAAHenFwfqIKZ5jxVuCUE7b8eRMwLTEOW/rJTGY3JuFehr3E0A/Pg5kLbzwI0KbsGP/jn7LdO3DQU/sXsExgzb8kzza2iKx77a3/W1ZNZq7ADhmt5o9uGWenpabdQezjcRoH1W6IgdFGfbREjbQHNfEnsGY7i/3blvMTd2N8TMk4xpiEfiOXCj89rFmf2BbglpJSFbKsCEsIa3Ld4+s3IRJzzAUZMi9e/eao8oxHka4TC9RI4pBRWW8V0pDdC5qSB7T91o6y/02OlbibHbsN6kvck6yExYc3YWD7ntUj20mIIqw8xFY8g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786719406; c=relaxed/relaxed;
	bh=lnVleaSQJyZ+tKT1gbPtirf/T3kHaUq3DaFNZOqmmH0=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type; b=EAUxF5luThVZS0zjW8Uq6dKv21hRHtkI9QhaG0EsIJIWt7V3PkmwYoNWj2e/NGfLDxTEiaAIJJbbfnZo9mXjczcwLpuOBxnm+frbv6T082RfgfR8X+KGE9pw6EK+x3l9il6S6PuJVhc0KcHjxibtnA9qcpOpjmHDkWWmdIlBiSflchTRlMXkMdJ91rXGgtiZxrCNp6w+93mRyOmSwyJd3PJQrdHSpQCoq1Gb7aQcLaUJeI6gPBW5lngsML007gQc7gHKF3QH2sZvLXS9I5B6AkH5uODy5hHqHPx0jqfD1j7Paa4PcH4We6fMdyUjzBU1/jrYN77A4ybqN+2zW0fgow==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com; dkim=pass (1024-bit key; secure) header.d=raptorengineering.com header.i=@raptorengineering.com header.a=rsa-sha256 header.s=B8E824E6-0BE2-11E6-931D-288C65937AAD header.b=RWcvdkVJ; dkim-atps=neutral; spf=pass (client-ip=23.155.224.40; helo=raptorengineering.com; envelope-from=tpearson@raptorengineering.com; receiver=lists.ozlabs.org) smtp.mailfrom=raptorengineering.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; secure) header.d=raptorengineering.com header.i=@raptorengineering.com header.a=rsa-sha256 header.s=B8E824E6-0BE2-11E6-931D-288C65937AAD header.b=RWcvdkVJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=raptorengineering.com (client-ip=23.155.224.40; helo=raptorengineering.com; envelope-from=tpearson@raptorengineering.com; receiver=lists.ozlabs.org)
Received: from raptorengineering.com (mail.raptorengineering.com [23.155.224.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hM50W04wLz2yRP
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Aug 2026 00:56:42 +1000 (AEST)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id D86D47790AD9;
	Fri, 14 Aug 2026 09:56:34 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id rvC-c1bWMlQD; Fri, 14 Aug 2026 09:56:34 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 64A2F7790B9D;
	Fri, 14 Aug 2026 09:56:34 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com 64A2F7790B9D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
	t=1786719394; bh=lnVleaSQJyZ+tKT1gbPtirf/T3kHaUq3DaFNZOqmmH0=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=RWcvdkVJl/RxhdzO4+jzfMMhNKWJHaeVEF8FG8oUh1d8DevB1aC7A20YODzqu+lAj
	 748YKdtJsHE/TWIcu2Zn3ai+5LtNsD+yhzj7v8X/I2NeJrttRxSF+P0RhlIyFnAzaK
	 F6X6jVR2t2QCQlsbdUOlOVfyqkGp8oil0nJNiFrw=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Q0Cc2r79JhJ3; Fri, 14 Aug 2026 09:56:34 -0500 (CDT)
Received: from vali.starlink.edu (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 3B54F7790957;
	Fri, 14 Aug 2026 09:56:34 -0500 (CDT)
Date: Fri, 14 Aug 2026 09:56:30 -0500 (CDT)
From: Timothy Pearson <tpearson@raptorengineering.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: Ritesh Harjani <ritesh.list@gmail.com>
Message-ID: <582904882.11159.1786719390349.JavaMail.zimbra@raptorengineeringinc.com>
Subject: [BUG] Continuously increasing spurious interrupts inside pSeries
 guest on PowerNV host
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
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC151 (Linux)/8.5.0_GA_3042)
Thread-Index: RhW/9HGclNG0p4Lc6WJv/0xagH2V7A==
Thread-Topic: Continuously increasing spurious interrupts inside pSeries guest on PowerNV host

With kernel 6.12 (Debian stable) we see a continuously increasing spurious interrupt count inside a pSeries guest running on a PowerNV host:

cat /proc/interrupts
           CPU0
 16:          0  XIVE-IPI   0 Edge      IPI-0
 17:          0  XIVE-IRQ 4096 Edge      RAS_EPOW
 21:          2  XIVE-IRQ 4353 Edge      hvc_console
 23:          0  XIVE-IRQ 4097 Edge      RAS_HOTPLUG
 24:          0  pSeries-PCI-MSI   0 Edge      virtio0-config
 25:      50995  pSeries-PCI-MSI   1 Edge      virtio0-input.0
 26:      45569  pSeries-PCI-MSI   2 Edge      virtio0-output.0
 27:          0  pSeries-PCI-MSI 16384 Edge      virtio1-config
 28:          6  pSeries-PCI-MSI 16385 Edge      virtio1-input
LOC:       5781   Local timer interrupts for timer event device
BCT:          0   Broadcast timer interrupts for timer event device
LOC:          2   Local timer interrupts for others
SPU:     449927   Spurious interrupts
PMI:          0   Performance monitoring interrupts
MCE:          0   Machine check exceptions
NMI:          0   System Reset interrupts
WDG:          0   Watchdog soft-NMI interrupts
DBL:          0   Doorbell interrupts

The spurious interrupts are apparently from the virtio0-[input|output] devices.

