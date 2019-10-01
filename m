Return-Path: <SRS0=t3e+=X2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FAKE_REPLY_C,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E80E5C352AA
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Oct 2019 20:04:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AFC02133F
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Oct 2019 20:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FFLjlRze"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AFC02133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46jVbR3Q7xzDqDy
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Oct 2019 06:04:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=helgaas@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="FFLjlRze"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46jVYS21MTzDq6k
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Oct 2019 06:02:35 +1000 (AEST)
Received: from localhost (unknown [69.71.4.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 78D2D2133F;
 Tue,  1 Oct 2019 20:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1569960153;
 bh=xlZUpmFgQH3QfurVZdSrkgPMpFDOx60wfJXzh3sZXxw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=FFLjlRze/atn4kWOCCQKFsH7ZBBfCicUGw/oLbnxK2WLl8cWAK4piR7quUce1iz0O
 nRiQ7YL6cW8yjjOxD6tHV962n70GJFkFsZb9rgGt6Fbe5ZZYwqJFTPEX5p+1VIfB7m
 4Jf/HaE0mI31eofang7CrhVoZNh+HUO1lLncVXDE=
Date: Tue, 1 Oct 2019 15:02:29 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: Re: [RFC PATCH 0/9] Fixes and Enablement of ibm,drc-info property
Message-ID: <20191001200229.GA64312@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1569910334-5972-1-git-send-email-tyreld@linux.ibm.com>
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
Cc: nathanl@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Oct 01, 2019 at 01:12:05AM -0500, Tyrel Datwyler wrote:
> There was an initial previous effort yo add support for the PAPR
> architected ibm,drc-info property. This property provides a more
> memory compact representation of a paritions Dynamic Reconfig
> Connectors (DRC). These can otherwise be thought of the currently
> partitioned, or available, but yet to be partitioned, system resources
> such as cpus, memory, and physical/logical IOA devices.
> 
> The initial implementation proved buggy and was fully turned of by
> disabling the bit in the appropriate CAS support vector. We now have
> PowerVM firmware in the field that supports this new property, and 
> further to suppport partitions with 24TB+ or possible memory this
> property is required to perform platform migration.
> 
> This serious fixup the short comings of the previous implementation
> in the areas of general implementation, cpu hotplug, and IOA hotplug.
> 
> Tyrel Datwyler (9):
>   powerpc/pseries: add cpu DLPAR support for drc-info property
>   powerpc/pseries: fix bad drc_index_start value parsing of drc-info
>     entry
>   powerpc/pseries: fix drc-info mappings of logical cpus to drc-index
>   PCI: rpaphp: fix up pointer to first drc-info entry
>   PCI: rpaphp: don't rely on firmware feature to imply drc-info support
>   PCI: rpaphp: add drc-info support for hotplug slot registration
>   PCI: rpaphp: annotate and correctly byte swap DRC properties
>   PCI: rpaphp: correctly match ibm,my-drc-index to drc-name when using
>     drc-info
>   powerpc: Enable support for ibm,drc-info property
> 
>  arch/powerpc/kernel/prom_init.c                 |   2 +-
>  arch/powerpc/platforms/pseries/hotplug-cpu.c    | 117 ++++++++++++++++------
>  arch/powerpc/platforms/pseries/of_helpers.c     |   8 +-
>  arch/powerpc/platforms/pseries/pseries_energy.c |  23 ++---
>  drivers/pci/hotplug/rpaphp_core.c               | 124 +++++++++++++++++-------
>  5 files changed, 191 insertions(+), 83 deletions(-)

Michael, I assume you'll take care of this.  If I were applying, I
would capitalize the commit subjects and fix the typos in the commit
logs, e.g.,

  s/the this/the/
  s/the the/that the/
  s/short coming/shortcoming/
  s/seperate/separate/
  s/bid endian/big endian/
  s/were appropriate/where appropriate/
  s/name form/name from/

etc.  git am also complains about space before tab whitespace errors.
And it adds a few lines >80 chars.
