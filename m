Return-Path: <linuxppc-dev+bounces-25866-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAB93C5CFCF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Aug 2026 15:14:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hM5PK1wH9z2ykT;
	Sat, 15 Aug 2026 01:14:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=23.155.224.40
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786720485;
	cv=none; b=N5zedmC0ay4SslTrkV+gjrcq57+QEWJRWdSB02OZwVQpxESEWOj1NLlH37V9Lku2nddQcJSjion37g9ai8F/LEvodzuJyIu7Vm+k/cu+1FuEpWRy830cBB8uoEu6suDkx4pGvKcW5q9lzzlIQYjRfi4t3U8MoGBcjIBn+yDuJV8ortUyy6LfoGwProVwMFxZWcTheLbO9xouuOH0dOkqP3yibTo7i/RiW+E7rfujHcOnSFQGDUJTDf/On5+AIfrNz2BM61DPVlZ+9wl8uxC0MgG6xFJEyg3m5nnm4RIDry2RZT0oCkdxJpEkfEmjkbufi3ToLdArYFjAD8fFY3UN6A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786720485; c=relaxed/relaxed;
	bh=nomeKP1WwIqIYt//G0anLxougcjRKDGYsDugTrc6pA0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=E6vkxFAvBlrQY+Nh5yd6yaUhA4YWJ0ij9qnyhfS0TTb7/H5UevftlBqju0k9azDbVqDKbglp6d5aK33FUrrzowXaZdG6UVeQ9u9Yb48Vn+ZyOLuj4VuYoKSCMpV9XRAGJfyDV68Dn+bNs5NHU449mzlMBdJblZM2XFe5z80cNwX7oNflfCJ6L+cwbx+ANhtE3PmZP2r7bQo14svr87yyELi+d0h1zNb4Gpyl7+bcb6lASiRfIWrkwKDorRIWCd/D7lJ8t7gBgsc5TfHqxRUU5/QICor8+TnGaTUwfBhCCdQsc0GX//kJDtpEbgrgRe1q3bdX+/G4Z6pQLwk9YXWfuQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com; dkim=pass (1024-bit key; secure) header.d=raptorengineering.com header.i=@raptorengineering.com header.a=rsa-sha256 header.s=B8E824E6-0BE2-11E6-931D-288C65937AAD header.b=hIe2B4K9; dkim-atps=neutral; spf=pass (client-ip=23.155.224.40; helo=raptorengineering.com; envelope-from=tpearson@raptorengineering.com; receiver=lists.ozlabs.org) smtp.mailfrom=raptorengineering.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; secure) header.d=raptorengineering.com header.i=@raptorengineering.com header.a=rsa-sha256 header.s=B8E824E6-0BE2-11E6-931D-288C65937AAD header.b=hIe2B4K9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=raptorengineering.com (client-ip=23.155.224.40; helo=raptorengineering.com; envelope-from=tpearson@raptorengineering.com; receiver=lists.ozlabs.org)
Received: from raptorengineering.com (mail.raptorengineering.com [23.155.224.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hM5PJ18TCz2yRP
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Aug 2026 01:14:44 +1000 (AEST)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 1FFF27791C88;
	Fri, 14 Aug 2026 10:14:42 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id l43qxvueDiZh; Fri, 14 Aug 2026 10:14:41 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 7F0F37791C91;
	Fri, 14 Aug 2026 10:14:41 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com 7F0F37791C91
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
	t=1786720481; bh=nomeKP1WwIqIYt//G0anLxougcjRKDGYsDugTrc6pA0=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=hIe2B4K9C+HoAe7SGjXAUf0unLPbarIrBJJPRRFBUwEu5AabQzISGlw3RK9ZCQaJB
	 VyafPa/H+QRuQDmD2SsHWAdKp3IaUUDmLSQbrNsz/+LPuGA72z9v3HbioBpTbMk3P3
	 ZmOXdbdD065EMBQC+p7HFiGcyn6UCkUI5ROJi7OM=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id uCwmSGu4wlP3; Fri, 14 Aug 2026 10:14:41 -0500 (CDT)
Received: from vali.starlink.edu (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 5B0417790C83;
	Fri, 14 Aug 2026 10:14:41 -0500 (CDT)
Date: Fri, 14 Aug 2026 10:14:41 -0500 (CDT)
From: Timothy Pearson <tpearson@raptorengineering.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: Ritesh Harjani <ritesh.list@gmail.com>
Message-ID: <187679096.11195.1786720481203.JavaMail.zimbra@raptorengineeringinc.com>
In-Reply-To: <582904882.11159.1786719390349.JavaMail.zimbra@raptorengineeringinc.com>
References: <582904882.11159.1786719390349.JavaMail.zimbra@raptorengineeringinc.com>
Subject: Re: [BUG] Continuously increasing spurious interrupts inside
 pSeries guest on PowerNV host
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
Thread-Topic: Continuously increasing spurious interrupts inside pSeries guest on PowerNV host
Thread-Index: RhW/9HGclNG0p4Lc6WJv/0xagH2V7K1VyFVu



----- Original Message -----
> From: "Timothy Pearson" <tpearson@raptorengineeringinc.com>
> To: "linuxppc-dev" <linuxppc-dev@lists.ozlabs.org>
> Cc: "Ritesh Harjani" <ritesh.list@gmail.com>
> Sent: Friday, August 14, 2026 9:56:30 AM
> Subject: [BUG] Continuously increasing spurious interrupts inside pSeries guest on PowerNV host

> With kernel 6.12 (Debian stable) we see a continuously increasing spurious
> interrupt count inside a pSeries guest running on a PowerNV host:
> 
> cat /proc/interrupts
>           CPU0
> 16:          0  XIVE-IPI   0 Edge      IPI-0
> 17:          0  XIVE-IRQ 4096 Edge      RAS_EPOW
> 21:          2  XIVE-IRQ 4353 Edge      hvc_console
> 23:          0  XIVE-IRQ 4097 Edge      RAS_HOTPLUG
> 24:          0  pSeries-PCI-MSI   0 Edge      virtio0-config
> 25:      50995  pSeries-PCI-MSI   1 Edge      virtio0-input.0
> 26:      45569  pSeries-PCI-MSI   2 Edge      virtio0-output.0
> 27:          0  pSeries-PCI-MSI 16384 Edge      virtio1-config
> 28:          6  pSeries-PCI-MSI 16385 Edge      virtio1-input
> LOC:       5781   Local timer interrupts for timer event device
> BCT:          0   Broadcast timer interrupts for timer event device
> LOC:          2   Local timer interrupts for others
> SPU:     449927   Spurious interrupts
> PMI:          0   Performance monitoring interrupts
> MCE:          0   Machine check exceptions
> NMI:          0   System Reset interrupts
> WDG:          0   Watchdog soft-NMI interrupts
> DBL:          0   Doorbell interrupts
> 
> The spurious interrupts are apparently from the virtio0-[input|output] devices.

Actually, I don't know where the spurious interrupts are coming from.  This is in XIVE mode.  Switching to XICS mode via -M pseries,ic-mode=xics greatly reduces the rate of spurious interrupts, but does not eliminate them.

I don't recall this being an issue on the 5.x series kernels, but do not have the ability to test either those or the 7.x series at the moment.

