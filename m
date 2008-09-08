Return-Path: <bgill@blarg.am.freescale.net>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B6007DDDD4
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Sep 2008 05:10:01 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m88J9ucp004406
	for <linuxppc-dev@ozlabs.org>; Mon, 8 Sep 2008 12:09:57 -0700 (MST)
Received: from blarg.am.freescale.net (blarg.am.freescale.net [10.82.19.176])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	m88J9uQE020112
	for <linuxppc-dev@ozlabs.org>; Mon, 8 Sep 2008 14:09:56 -0500 (CDT)
Received: from blarg.am.freescale.net (localhost.localdomain [127.0.0.1])
	by blarg.am.freescale.net (8.14.2/8.14.2) with ESMTP id m88J9tQB012227
	for <linuxppc-dev@ozlabs.org>; Mon, 8 Sep 2008 14:09:55 -0500
Received: (from bgill@localhost)
	by blarg.am.freescale.net (8.14.2/8.14.2/Submit) id m88J9tfG012225
	for linuxppc-dev@ozlabs.org; Mon, 8 Sep 2008 14:09:55 -0500
From: Becky Bruce <becky.bruce@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/4] POWERPC: 32/64-bit DMA code merge and cleanup
Date: Mon,  8 Sep 2008 14:09:51 -0500
Message-Id: <1220900995-11928-1-git-send-email-becky.bruce@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


This patch series merges the 32 and 64-bit dma code and does some
other cleanup.  This has changed a bit since the RFC was submitted
a few months ago - I incorporated most of the comments from Christoph,
including moving the iommu-specific code into its own file and dropping
numa_node from archdata - we now use the version in the struct
device.

Now that the 32-bit code has a dma_ops structure that is used to
access the dma functions, we will be more easily able to implement
swiotlb or iommu-type dma by setting dma_ops up to use an alternate
set of operations.

I have tested this code on 8641 and 8572 platforms using the popular
kernel build as well as full runs of LTP.  I have built 64-bit
platforms, but have no means to test there, so I would greatly
appreciate any feedback you can provide on possible issues. 

Cheers,
Becky
