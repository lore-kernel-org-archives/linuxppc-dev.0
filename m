Return-Path: <SRS0=hRxk=V3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF6DC433FF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jul 2019 18:29:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 906762064A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jul 2019 18:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wkG/el70"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 906762064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45ylSV5NWvzDqWW
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Jul 2019 04:28:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=helgaas@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="wkG/el70"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45ylN34ysQzDqWJ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jul 2019 04:25:07 +1000 (AEST)
Received: from localhost (unknown [69.71.4.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E66F82087F;
 Tue, 30 Jul 2019 18:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1564511105;
 bh=2xncdpK2J1RersRdjUzIlXExFmZioyenQiPobsms38I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=wkG/el70Z3il0Z8+OdQuanuSkDxOvC+ZkzjEzWuTzbFHpKZv+kLZuaQXwOJ5GinhX
 1Vm+dEqxDYq8jNWNdMxQw5CFKnO99k9uuzCsdVjFY1FoSWpGbndvVX5t8pu/eTrBvy
 h0sJpcy4GffeO7R5WdLzSlefy0e6Qf/9B8+xW87M=
Date: Tue, 30 Jul 2019 13:25:03 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Denis Efremov <efremov@linux.com>
Subject: Re: [PATCH v2 0/5] PCI: Convert pci_resource_to_user() to a weak
 function
Message-ID: <20190730182503.GJ203187@google.com>
References: <20190729101401.28068-1-efremov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729101401.28068-1-efremov@linux.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: Michal Simek <monstr@monstr.eu>, linux-pci@vger.kernel.org,
 linux-mips@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
 linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 Paul Burton <paul.burton@mips.com>, Paul Mackerras <paulus@samba.org>,
 James Hogan <jhogan@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Jul 29, 2019 at 01:13:56PM +0300, Denis Efremov wrote:
> Architectures currently define HAVE_ARCH_PCI_RESOURCE_TO_USER if they want
> to provide their own pci_resource_to_user() implementation. This could be
> simplified if we make the generic version a weak function. Thus,
> architecture specific versions will automatically override the generic one.
> 
> Changes in v2:
> 1. Removed __weak from pci_resource_to_user() declaration
> 2. Fixed typo s/spark/sparc/g
> 
> Denis Efremov (5):
>   PCI: Convert pci_resource_to_user to a weak function
>   microblaze/PCI: Remove HAVE_ARCH_PCI_RESOURCE_TO_USER
>   mips/PCI: Remove HAVE_ARCH_PCI_RESOURCE_TO_USER
>   powerpc/PCI: Remove HAVE_ARCH_PCI_RESOURCE_TO_USER
>   sparc/PCI: Remove HAVE_ARCH_PCI_RESOURCE_TO_USER
> 
>  arch/microblaze/include/asm/pci.h |  2 --
>  arch/mips/include/asm/pci.h       |  1 -
>  arch/powerpc/include/asm/pci.h    |  2 --
>  arch/sparc/include/asm/pci.h      |  2 --
>  drivers/pci/pci.c                 |  8 ++++++++
>  include/linux/pci.h               | 12 ------------
>  6 files changed, 8 insertions(+), 19 deletions(-)

Thanks, I added Paul's ack, squashed into a single patch since I think
it's easier to see what's going on then, and applied to pci/misc for
v4.5.
