Return-Path: <SRS0=DRoX=MN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A515C43143
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 09:09:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 408512064A
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 09:09:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 408512064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42NxLb1cYCzF38b
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 19:09:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: lists.ozlabs.org; spf=permerror (mailfrom)
 smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57;
 helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42NxJf32KBzF35X
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Oct 2018 19:08:02 +1000 (AEST)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w9197LPO026802;
 Mon, 1 Oct 2018 04:07:21 -0500
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id w9197JJA026785;
 Mon, 1 Oct 2018 04:07:19 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Mon, 1 Oct 2018 04:07:19 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Bin Meng <bmeng.cn@gmail.com>
Subject: Re: [PATCH 2/2] powerpc/64: Increase stack redzone for 64-bit kernel
 to 512 bytes
Message-ID: <20181001090719.GD23155@gate.crashing.org>
References: <1538288720-14910-1-git-send-email-bmeng.cn@gmail.com>
 <1538288720-14910-2-git-send-email-bmeng.cn@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538288720-14910-2-git-send-email-bmeng.cn@gmail.com>
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
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, Sep 29, 2018 at 11:25:20PM -0700, Bin Meng wrote:
>  /*
> - * Size of redzone that userspace is allowed to use below the stack
> + * Size of redzone that kernel/userspace is allowed to use below the stack
>   * pointer.  This is 288 in the 64-bit big-endian ELF ABI, and 512 in
>   * the new ELFv2 little-endian ABI, so we allow the larger amount.
> - *
> - * For kernel code we allow a 288-byte redzone, in order to conserve
> - * kernel stack space; gcc currently only uses 288 bytes, and will
> - * hopefully allow explicit control of the redzone size in future.
>   */

Btw: patches welcome!  This will never be useful for userland code, so no
one in GCC land is looking at this (we did not even know it is wanted).


Segher
