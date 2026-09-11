Return-Path: <linuxppc-dev+bounces-27145-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 992FFC88E53
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Sep 2026 18:00:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hhMlH0pZ6z2xpv;
	Sat, 12 Sep 2026 04:00:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=23.155.224.40
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789149611;
	cv=none; b=I4BSfq6nbuIjizTJd+FzTR7lH7n9jMCKl9Qh/McQx8t9dQpQog9Kfc7bNBV4Ng3ZnwaOfqfkI16URozqWrHcDc5j8nK43bLCcoKuSnTqg05Seu/Rop6aXoKBgwwqjWo8bpPYK1oeiUyY+qI6WxWIlqwHS1Z+BNtp+3R/VxJxmeOxg+RezxYaKRM8IkKD2NoIRGKEA7CsEnVXRClx+4FjxC07w2/UM4pghK+x/7aPEKhbWnU0lPmGcpGf2xwhKw/lBaFz1VLFJ6A6le2uDo9N5Knu3ue61iaKVydDqlgsr8D4Ep+KfJNg1EVe2ve5P+NHOgX+uucTm4HJPoXUqd7/pg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789149611; c=relaxed/relaxed;
	bh=2nsUrl0bWMyjLZPAXPT4M+vOKy2/EVQjo4gQCeT/jS8=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type; b=jrKmO2sJ2bwXIMBHpTOQBIeuvG88kD7VQz+dbeHmQLm2kux+obWXtzD0aZBjM7NFmZqyZV73CreTybj4W23relU7BfbdtiPmzdaGd39Nxpl4O6OavCFW1YSfqFB56WwCnhQRT+m6hQdwVWjYBNV9krRCoVIk1lJdrW07bta498jEwkk3EBaWKU/5XLreQfSR6PqQGh+pKCoPYKERB7BJykHbLfH9u9GVTNvW62ibxBJQ4I4qbGRGMErxIghEtW8gIUFR6O0UAlfSO2bJksTmOPvolH8pebtXbAsTlyU9x05NhCsyPakvNO+D5yK7DsLPTK3RJO694xDYceucFNlLbw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com; dkim=pass (1024-bit key; secure) header.d=raptorengineering.com header.i=@raptorengineering.com header.a=rsa-sha256 header.s=B8E824E6-0BE2-11E6-931D-288C65937AAD header.b=R1z0ckMp; dkim-atps=neutral; spf=pass (client-ip=23.155.224.40; helo=raptorengineering.com; envelope-from=tpearson@raptorengineering.com; receiver=lists.ozlabs.org) smtp.mailfrom=raptorengineering.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; secure) header.d=raptorengineering.com header.i=@raptorengineering.com header.a=rsa-sha256 header.s=B8E824E6-0BE2-11E6-931D-288C65937AAD header.b=R1z0ckMp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=raptorengineering.com (client-ip=23.155.224.40; helo=raptorengineering.com; envelope-from=tpearson@raptorengineering.com; receiver=lists.ozlabs.org)
Received: from raptorengineering.com (mail.raptorengineering.com [23.155.224.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hhMlD2bP6z2xfB
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Sep 2026 04:00:07 +1000 (AEST)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id A6A027792C06;
	Fri, 11 Sep 2026 13:00:04 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id T5rbgsv7cWMj; Fri, 11 Sep 2026 13:00:04 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 14B577792C2B;
	Fri, 11 Sep 2026 13:00:04 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com 14B577792C2B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
	t=1789149604; bh=2nsUrl0bWMyjLZPAXPT4M+vOKy2/EVQjo4gQCeT/jS8=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=R1z0ckMpOaQxwQKmw5Q4lV16gTmWPnJ5T7KHuEpivgkYJn21Ey8QUDr31yTdaUVva
	 UIVV66zYa6lP1RFmpwEhR2l4J9d/RRjm/chYwnZgUj2Neh1flq66gd/i6wmR2c3ysG
	 k9ZPSMTcSxI071HWXI4auzRw6bwA3RRIfPZAQEOk=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id NK6jwUJFHs5B; Fri, 11 Sep 2026 13:00:03 -0500 (CDT)
Received: from vali.starlink.edu (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id DF7867792A5A;
	Fri, 11 Sep 2026 13:00:03 -0500 (CDT)
Date: Fri, 11 Sep 2026 13:00:00 -0500 (CDT)
From: Timothy Pearson <tpearson@raptorengineering.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: Ritesh Harjani <ritesh.list@gmail.com>
Message-ID: <1530814489.70866.1788970481000.JavaMail.zimbra@raptorengineeringinc.com>
Subject: [BUG] PCIe passthrough of USB controller unstable / data corruption
 on PowerNV
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
X-Mailer: Zimbra 8.5.0_GA_3042
Thread-Index: vrvQTDP8RPum/CowPKyoTICZs0MLYw==
Thread-Topic: PCIe passthrough of USB controller unstable / data corruption on PowerNV

When passing through a TUSB7340 PCIe USB 3.0 controller on a PowerNV POWER9 host using qemu, the controller initially appears to function but is unstable, leading to increasing errors / data corruption and an eventual disconnect of the attached USB device(s).  This is with Linux 6.18.38 on both host and guest, however the same instability also appears with Debian Stable (6.12) kernels.

With an Empia USB device, an example of the instability in dmesg is a series of errors which repeats sporadically every few hours:

em28xx 1-4:1.0: reading from i2c device at 0x1c failed (error=-5)
em28xx 1-4:1.0: failed to get i2c transfer status from bridge register (error=-5)
em28xx 1-4:1.0: writing to i2c device at 0x1c failed (error=-5)
em28xx 1-4:1.0: failed to get i2c transfer status from bridge register (error=-5)

These errors eventually culminate in a device failure after 2-3 days of guest uptime:

usb 1-4: USB disconnect, device number 2
em28xx 1-4:1.0: Disconnecting em28xx #1
em28xx 1-4:1.0: Disconnecting em28xx

Any attempt to reset the guest at this point will not bring the device back online, likely because data corruption has caused the device to lock up (i.e. writing bad data to control registers).  Note this issue persists across multiple different systems and devices, it is *not* a device specific hardware failure or a power problem.

My suspicion is either data corruption in DMA between guest and host or lost interrupts from the XHCI controller to the guest.  It should be relatively easy to reproduce using an off the shelf TUSB7340 EVM card and one of the inexpensive Empia-based ATSC USB tuner sticks; though it is likely that other EHCI devices will also experience data corruption, it will be harder to detect e.g. a handful of corrupt bytes on a USB mass storage device vs. the very obvious bridge failures on the tuner sticks.

