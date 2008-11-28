Return-Path: <Thomas.Hommel@gefanuc.com>
Received: from ext-nj2ut-4.online-age.net (ext-nj2ut-4.online-age.net
	[64.14.54.233])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ext-nj2ut.online-age.net",
	Issuer "Savvis Communications Root CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 66A10DDDEA
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Nov 2008 01:13:15 +1100 (EST)
Received: from int-nj2ut-6.online-age.net (int-nj2ut-6.online-age.net
	[3.159.237.75])
	by ext-nj2ut-4.online-age.net (8.13.6/8.13.6/20051114-SVVS-TLS-DNSBL)
	with ESMTP id mASE48Nr025451
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Nov 2008 09:04:08 -0500
Received: from ALPMLEF02.e2k.ad.ge.com (int-nj2ut-6.online-age.net
	[3.159.237.75])
	by int-nj2ut-6.online-age.net (8.13.6/8.13.6/20050510-SVVS) with ESMTP
	id mASE47t8020260
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Nov 2008 09:04:08 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: DMA from memory to local bus
Date: Fri, 28 Nov 2008 15:04:04 +0100
Message-ID: <62DDBB9E5E23CC4A929EE46F9427CEAF01654DD8@BUDMLVEM04.e2k.ad.ge.com>
From: "Hommel, Thomas (GE EntSol,
	Intelligent Platforms)" <Thomas.Hommel@gefanuc.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi all,
I'm currently developing a driver and want to make use of the DMA
offload engine. Data has to be transferred from memory to a device on
the local bus and vice versa.
At a first look, the function dma_async_memcpy_buf_to_buf() seemed to be
suitable, but it does not translate addresses correctly. Both addresses
are treated as if they were in memory.
In my configuration, the buffer is located in memory, but the device's
I/O space is mapped into vmalloc space via ioremap(). How can I access
the I/O space corectly from the DMA controller? I also checked the
return of virt_to_phys() and this does not deliver the correct physical
address.
The board is based on MPC8641D and I'm using the on-chip DMA engine.

Thanks for your help
Thomas
