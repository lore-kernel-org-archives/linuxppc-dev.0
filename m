Return-Path: <SRS0=dmdX=PA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E5D6C43387
	for <linuxppc-dev@archiver.kernel.org>; Sun, 23 Dec 2018 13:15:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8A252184D
	for <linuxppc-dev@archiver.kernel.org>; Sun, 23 Dec 2018 13:15:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8A252184D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43N2tB4NnczDqXV
	for <linuxppc-dev@archiver.kernel.org>; Mon, 24 Dec 2018 00:15:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43N2r0545VzDqVq
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Dec 2018 00:13:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43N2r01js5z9sDL;
 Mon, 24 Dec 2018 00:13:51 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Scott Wood <oss@buserror.net>
Subject: Re: Pull request: scottwood/linux.git next
In-Reply-To: <20181222044250.GA7651@home.buserror.net>
References: <20181222044250.GA7651@home.buserror.net>
Date: Mon, 24 Dec 2018 00:13:52 +1100
Message-ID: <877eg0idwv.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Scott,

Scott Wood <oss@buserror.net> writes:
> Highlights include elimination of legacy clock bindings use from dts
> files, an 83xx watchdog handler, fixes to old dts interrupt errors, and
> some minor cleanup.
>
> The following changes since commit 8c6c942d33f2a79439e86f8f406afae40a5bc767:
>
>   powerpc/eeh: Fix debugfs_simple_attr.cocci warnings (2018-12-20 22:59:03 +1100)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.git next
>
> for you to fetch changes up to 5f470b3638a4ed03df79b993ece819cac2f4ca7e:
>
>   powerpc/configs/85xx: Enable CONFIG_DEBUG_KERNEL (2018-12-21 22:07:54 -0600)
>
> ----------------------------------------------------------------
> Alexandre Belloni (1):
>       powerpc/fsl-rio: fix spelling mistake "reserverd" -> "reserved"
>
> Christoph Hellwig (1):
>       powerpc/fsl_pci: simplify fsl_pci_dma_set_mask

This one breaks networking on my p5020ds.

dmesg is just full of:

  e1000e 2000:01:00.0: Tx DMA map failed

Haven't had time to dig any further.

cheers
