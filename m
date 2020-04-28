Return-Path: <SRS0=O865=6M=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F47CC83000
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Apr 2020 23:43:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC5902070B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Apr 2020 23:43:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC5902070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49BdVv2W7FzDqvx
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Apr 2020 09:43:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (SPF Permanent Error: Unknown mechanism
 found: ip:192.40.192.88/32) smtp.mailfrom=kernel.crashing.org
 (client-ip=63.228.1.57; helo=gate.crashing.org;
 envelope-from=segher@kernel.crashing.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by lists.ozlabs.org (Postfix) with ESMTP id 49BdSN436dzDqtt
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2020 09:40:52 +1000 (AEST)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 03SNelvK008990;
 Tue, 28 Apr 2020 18:40:47 -0500
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id 03SNel35008989;
 Tue, 28 Apr 2020 18:40:47 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Tue, 28 Apr 2020 18:40:46 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2] powerpc/64: BE option to use ELFv2 ABI for big endian
 kernels
Message-ID: <20200428234046.GP17645@gate.crashing.org>
References: <20200428112517.1402927-1-npiggin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428112517.1402927-1-npiggin@gmail.com>
User-Agent: Mutt/1.4.2.3i
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

Hi!

On Tue, Apr 28, 2020 at 09:25:17PM +1000, Nicholas Piggin wrote:
> +config BUILD_BIG_ENDIAN_ELF_V2
> +	bool "Build big-endian kernel using ELFv2 ABI (EXPERIMENTAL)"
> +	depends on PPC64 && CPU_BIG_ENDIAN && EXPERT
> +	default n
> +	select BUILD_ELF_V2
> +	help
> +	  This builds the kernel image using the ELFv2 ABI, which has a
> +	  reduced stack overhead and faster function calls. This does not
> +	  affect the userspace ABIs.
> +
> +	  ELFv2 is the standard ABI for little-endian, but for big-endian
> +	  this is an experimental option that is less tested (kernel and
> +	  toolchain). This requires gcc 4.9 or newer and binutils 2.24 or
> +	  newer.

Is it clear that this is only for 64-bit?  Maybe this text should fit
that in somewhere?

It's not obvious to people who do not already know that ELFv2 is just
the (nick-)name of a particular ABI, not a new kind of ELF (it is just
version 1 ELF in fact), and that ABI is for 64-bit Power only.


Segher
