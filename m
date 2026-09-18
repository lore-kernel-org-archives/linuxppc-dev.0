Return-Path: <linuxppc-dev+bounces-27751-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AC4FC982D7
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2026 18:33:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmh830pZcz2xft;
	Sat, 19 Sep 2026 04:33:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=23.155.224.40
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789756387;
	cv=none; b=ZX1DEqlxwT+J6l8UMWU5WEXxvGKudEaEVYDrFfCvAjCtaoH6aOi60MSw8ucW9ajr1kGb/Zglb+b2vgb+F8YCluGSOpuxCrjoskeWYI++LHMTjlt4DHv8xX7MHJWdm+ZPe7glzVIWcbKjIsPPSOjI4GALi5fmmP+KZf/65l42o+lZk0Ped5xqb+5qTcEpW0iPgUN+gazVoZ2aGAwUYsmLQfCNu4MgGZXusB05NDiyaWt+SzXVi6denOxbL6x0gNXayQG/psBQzsPqsOqxtgyTHa6mru2gi8PFe3NyO1kVxikfdxmMZtqyOs30bwGlJGCm5SHXc90pJXXpEWbwSIJ4zA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789756387; c=relaxed/relaxed;
	bh=U3BGt4A4hQv1q9q3W8DLkOnkZN53VB/Ua1Sm/ULSDcY=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type; b=FkiB3a7TcMOAHQnHzUxy4PXiWN5FbVRvyKmBxmlbdsuEBg4l78Fg+fteum7VBXYKTtNkZ+OF917OSnhLwSzJM3yxPoE1SXUY9XpyZbM5sFz7WZmUUHBB2ZTXIqEltagDWB+EfU5cv5wMqtymuxomN3PnTxhGQ+tmCQ8x6flhp5rIMYd5RDxf3y36BMLn8qNMM/z/u1/hsCBAB0XdTwbUPHjjWS9WEB5gnY8zBGI2OAWPDA6vB8ehq9np2ITwwlAIQJWx2FqNv7NGszKdgf4qJqEO4R2s1yuK6SOuLgpekSMiBlD3RW1AEZk8yRCCc2EssFu/M+GKAgc1NpxWJnRDIw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com; dkim=pass (1024-bit key; secure) header.d=raptorengineering.com header.i=@raptorengineering.com header.a=rsa-sha256 header.s=B8E824E6-0BE2-11E6-931D-288C65937AAD header.b=AThJVUSo; dkim-atps=neutral; spf=pass (client-ip=23.155.224.40; helo=raptorengineering.com; envelope-from=tpearson@raptorengineering.com; receiver=lists.ozlabs.org) smtp.mailfrom=raptorengineering.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; secure) header.d=raptorengineering.com header.i=@raptorengineering.com header.a=rsa-sha256 header.s=B8E824E6-0BE2-11E6-931D-288C65937AAD header.b=AThJVUSo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=raptorengineering.com (client-ip=23.155.224.40; helo=raptorengineering.com; envelope-from=tpearson@raptorengineering.com; receiver=lists.ozlabs.org)
Received: from raptorengineering.com (mail.raptorengineering.com [23.155.224.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmh803SYrz2xYg
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Sep 2026 04:33:03 +1000 (AEST)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 94E647792DB4;
	Fri, 18 Sep 2026 13:32:56 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id DifNcRpuiAsZ; Fri, 18 Sep 2026 13:32:56 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 003287792DBF;
	Fri, 18 Sep 2026 13:32:55 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com 003287792DBF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
	t=1789756376; bh=U3BGt4A4hQv1q9q3W8DLkOnkZN53VB/Ua1Sm/ULSDcY=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=AThJVUSoN1pkIdwDXUi29u8AJC0MW8LdTIprFnJsPEmxnDC/X/ug04q8UsuMAOlva
	 ye80c3bxJcBJSscFjo+oSPBlll4menGloe1qivexFtj6N5x2GqUbZUpPtGqUFBmPm/
	 ulPz7YjM+ZjjWYOMkQUoyOQOFtOrOozn4SUlQSCw=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id d-y8hPUTT3Cd; Fri, 18 Sep 2026 13:32:55 -0500 (CDT)
Received: from vali.starlink.edu (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id C3D3D7792D8D;
	Fri, 18 Sep 2026 13:32:55 -0500 (CDT)
Date: Fri, 18 Sep 2026 13:32:51 -0500 (CDT)
From: Timothy Pearson <tpearson@raptorengineering.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: Ritesh Harjani <ritesh.list@gmail.com>
Message-ID: <133526175.85096.1789756371777.JavaMail.zimbra@raptorengineeringinc.com>
Subject: [BUG] PCIe passthrough of MCS9990 fails
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
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC152 (Linux)/8.5.0_GA_3042)
Thread-Index: mIB1Ip8gfRnGqO14AFJUnvnJwztj+A==
Thread-Topic: PCIe passthrough of MCS9990 fails

When passing through all eight PCIe functions of a MCS9990 PCIe USB multifunction 1.0/2.0 controller on a PowerNV POWER9 host using qemu, the guest fails to launch:

qemu-system-ppc64: -device vfio-pci,host=0031:01:00.1,bus=bridge-1,addr=00.1: vfio 0031:01:00.1: Failed to set up TRIGGER eventfd signaling for interrupt INTX-0: VFIO_DEVICE_SET_IRQS failure: Device or resource busy

If I instead pass through only one function, or only pass through odd functions (the EHCI controller set), I get the following errors in the guest:

[    0.886625] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.18
[    0.886710] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.886791] usb usb1: Product: EHCI Host Controller
[    0.886845] usb usb1: Manufacturer: Linux 6.18.38 ehci_hcd
[    0.886902] usb usb1: SerialNumber: 0000:01:00.0
[    1.142469] usb 1-1: new high-speed USB device number 2 using ehci-pci
[    6.530490] usb 1-1: device descriptor read/64, error -110
[   22.147501] usb 1-1: device descriptor read/64, error -110
[   22.371536] usb 1-1: new high-speed USB device number 3 using ehci-pci
[   27.526896] usb 1-1: device descriptor read/64, error -110
[   43.141934] usb 1-1: device descriptor read/64, error -110
[   43.245985] usb usb1-port1: attempt power cycle
[   43.638173] usb 1-1: new high-speed USB device number 4 using ehci-pci
[   54.491254] usb 1-1: device not accepting address 4, error -110
[   54.611274] usb 1-1: new high-speed USB device number 5 using ehci-pci

If I reboot the guest, SLOF fails as follows:

Scanning USB
  EHCI: Initializing
usb-ehci: reset failed
usb-ehci: control transfer timed out_
usb-ehci: unable to setup device on port 0

Note that this card works perfectly on the host kernel.

