Return-Path: <SRS0=dpXp=SO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 889EBC10F0E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Apr 2019 07:23:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CF2D2171F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Apr 2019 07:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=russell.cc header.i=@russell.cc header.b="V9fGOqrj";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b2dh3j5U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CF2D2171F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44gTs12750zDqTs
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Apr 2019 17:23:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=russell.cc
 (client-ip=66.111.4.28; helo=out4-smtp.messagingengine.com;
 envelope-from=ruscur@russell.cc; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=russell.cc header.i=@russell.cc header.b="V9fGOqrj"; 
 dkim=pass (2048-bit key;
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.b="b2dh3j5U"; dkim-atps=neutral
X-Greylist: delayed 321 seconds by postgrey-1.36 at bilbo;
 Fri, 12 Apr 2019 17:21:59 AEST
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44gTqC0xhmzDqQP
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2019 17:21:59 +1000 (AEST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id 627E520D9E;
 Fri, 12 Apr 2019 03:16:35 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
 by compute6.internal (MEProxy); Fri, 12 Apr 2019 03:16:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=russell.cc; h=
 mime-version:message-id:in-reply-to:references:date:from:to:cc
 :subject:content-type; s=fm1; bh=ljGWpomICDBFZbhZvUHLL4JGg7WZDEi
 dIIFD3lK7BJU=; b=V9fGOqrjD16ID1+aykhHO79mKFCCgW0tuMzLX/dsgFIfB/8
 CeM0HAvFibARXIMrMbc7SnJv3yqWeIilaoeM0TQMBnMqHAmXyw4hYNIaR5VC7CHE
 qS0PTUw2/5as8aH7J4d+DqMODxYQesQy58EHQe9UxzohfWtLZ9+SHQRGkNaKDh5D
 CihZZwehL9cEjg6x0ejaHJLr0yNDGqIxYVh36XygXVAtCZ4IQbpAMUli4VFQ9Pa+
 S6Q0pmuTIXHY6QfTfFMAO6txDHZBs6850HY2ratIwU/zVE8YoWJl4lB3g0S3FxL0
 FnVc3RmMD/435dXXWoCWDC6ecKChMKBdKfUvKcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=ljGWpo
 mICDBFZbhZvUHLL4JGg7WZDEidIIFD3lK7BJU=; b=b2dh3j5UjVBI9VNx75K4B5
 xVhkuZDJtE9JofqAO6rKKC9WvlmD8UmrkUnSHJt06pkMCmcr7mFzQ4XE0SIIIQh/
 vs6pD4GZQYq2VEw2D6vfoF4ZkAuCeo1Q/lB2J0jRXgSakGi8Zz98DXA/GItzxmuS
 pi4EI/EVcaGdh/wOhbxQTH3Xe4Q12BRb8bEbVEqcEvAh1o3hG+mpZgQ6zhnEldZ3
 h9wMkBzWItzBGn4r8GNISvqJk9Jjk3ab9oc9DVNjtHzvL4MgCxVMsYXHQ5Budg5q
 U/HZ+7cmLvU/Frp8yIcPPtoZ4Lb9Wg4zmTS5xg4EfXASNUvUOq+/XR3+opw8dVOA
 ==
X-ME-Sender: <xms:UDuwXBKfILgsUiD1NsB9-nFkpjSXJ6qCYEqrWigDf17bRc72tt6mHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrvddtgdduudehucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 gfrhhlucfvnfffucdludehmdenucfjughrpefofgggkfgjfhffhffvufgtsehttdertder
 reejnecuhfhrohhmpedftfhushhsvghllhcuvehurhhrvgihfdcuoehruhhstghurhesrh
 hushhsvghllhdrtggtqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecurfgrrhgr
 mhepmhgrihhlfhhrohhmpehruhhstghurhesrhhushhsvghllhdrtggtnecuvehluhhsth
 gvrhfuihiivgeptd
X-ME-Proxy: <xmx:UDuwXMcUjxbTSqPtX1XsBNfEiIUKY52ucHMaO0nGqBkXAAKTZldmXA>
 <xmx:UDuwXApdUxXYpkaVyRhsfF6IkVKPzjrIe7nVCKIq0sS6w0jNs7jP5g>
 <xmx:UDuwXNte8opzg_B5umvtNe75Vcgm1zx61Q_OTkFjGU2B2KEEfOU8-A>
 <xmx:UzuwXDwtovg76-vQOTeldjNqXqSD2jtC3-O4OOKcMrY4z3UB69GyDw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id A486C72392; Fri, 12 Apr 2019 03:16:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.6-332-g22ddc6a-fmstable-20190412v1
Mime-Version: 1.0
X-Me-Personality: 65106424
Message-Id: <182e65bb-eb0e-4ae0-b0d7-faf2e91bba19@www.fastmail.com>
In-Reply-To: <20190412064408.85399-1-aik@ozlabs.ru>
References: <20190412064408.85399-1-aik@ozlabs.ru>
Date: Fri, 12 Apr 2019 03:16:31 -0400
From: "Russell Currey" <ruscur@russell.cc>
To: "Alexey Kardashevskiy" <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
Subject: =?UTF-8?Q?Re:_[PATCH_kernel_RFC_0/2]_powerpc/ioda2:_An_attempt_to_allow_?=
 =?UTF-8?Q?DMA_masks_between_32_and_59?=
Content-Type: text/plain
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Alistair Popple <alistair@popple.id.au>,
 Oliver O'Halloran <oohall@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

I'm gonna try and benchmark this on a few different devices for performance, with 64k TCEs (as is), with larger TCE sizes, and against sketchy bypass.  Hopefully if performance isn't too far off, we can get rid of sketchy bypass entirely and have a more robust solution.

-- 
  Russell Currey
  ruscur@russell.cc

On Fri, Apr 12, 2019, at 4:44 PM, Alexey Kardashevskiy wrote:
> 
> This is an attempt to allow DMA mask 40 or similar which are not large
> enough to use either a PHB3 bypass mode or a sketchy bypass.
> 
> This is based on sha1
> 582549e3fbe1 Linus Torvalds Merge tag 'for-linus' of 
> git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma 
> 
> Please comment. Thanks.
> 
> 
> 
> Alexey Kardashevskiy (2):
>   powerpc/powernv/ioda: Allocate TCE table levels on demand for default
>     DMA window
>   powerpc/powernv/ioda2: Create bigger default window with 64k IOMMU
>     pages
> 
>  arch/powerpc/include/asm/iommu.h              |  8 ++-
>  arch/powerpc/platforms/powernv/pci.h          |  2 +-
>  arch/powerpc/kernel/iommu.c                   | 58 +++++++++++++------
>  arch/powerpc/platforms/powernv/pci-ioda-tce.c | 19 +++---
>  arch/powerpc/platforms/powernv/pci-ioda.c     | 14 ++++-
>  5 files changed, 66 insertions(+), 35 deletions(-)
> 
> -- 
> 2.17.1
> 
>
