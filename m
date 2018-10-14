Return-Path: <SRS0=geFq=M2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81190C6787C
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Oct 2018 07:06:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2279020659
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Oct 2018 07:06:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2279020659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Xt0H1t66zF3Bw
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Oct 2018 18:06:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linutronix.de
 (client-ip=2a01:7a0:2:106d:700::1; helo=galois.linutronix.de;
 envelope-from=tglx@linutronix.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linutronix.de
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a01:7a0:2:106d:700::1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Xswp4zjPzF3Cd
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Oct 2018 18:03:22 +1100 (AEDT)
Received: from p5492fe24.dip0.t-ipconnect.de ([84.146.254.36] helo=nanos)
 by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
 (Exim 4.80) (envelope-from <tglx@linutronix.de>)
 id 1gBZny-0007bP-Ve; Sun, 14 Oct 2018 08:23:11 +0200
Date: Sun, 14 Oct 2018 08:23:10 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: move bus (PCI, PCMCIA, EISA, rapdio) config to drivers/
In-Reply-To: <20181013151016.31674-1-hch@lst.de>
Message-ID: <alpine.DEB.2.21.1810140822540.1438@nanos.tec.linutronix.de>
References: <20181013151016.31674-1-hch@lst.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required, ALL_TRUSTED=-1,
 SHORTCIRCUIT=-0.0001
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
Cc: linux-arch@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dominik Brodowski <linux@dominikbrodowski.net>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Alexandre Bounine <alex.bou9@gmail.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, 13 Oct 2018, Christoph Hellwig wrote:

> Hi all,
> 
> currently every architecture that wants to provide on of the common
> periphal busses needs to add some boilerplate code and include the
> right Kconfig files.   This series instead just selects the presence
> (when needed) and then handles everything in the bus-specific
> Kconfig file under drivers/.

Nice cleanup.

Acked-by: Thomas Gleixner <tglx@linutronix.de>
