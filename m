Return-Path: <SRS0=DRoX=MN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E696AC43143
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 09:01:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75A322084C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 09:01:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75A322084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Nx9J2V63zF37s
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 19:01:40 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Nx7F3nhYzF35y
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Oct 2018 18:59:53 +1000 (AEST)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w918xJSV022634;
 Mon, 1 Oct 2018 03:59:20 -0500
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id w918xGbL022601;
 Mon, 1 Oct 2018 03:59:16 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Mon, 1 Oct 2018 03:59:15 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Bin Meng <bmeng.cn@gmail.com>
Subject: Re: [PATCH 1/2] powerpc/64: Remove duplicated -mabi=elfv2 for little
 endian targets
Message-ID: <20181001085915.GC23155@gate.crashing.org>
References: <1538288720-14910-1-git-send-email-bmeng.cn@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538288720-14910-1-git-send-email-bmeng.cn@gmail.com>
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

On Sat, Sep 29, 2018 at 11:25:19PM -0700, Bin Meng wrote:
> The -mabi=elfv2 is currently specified twice in the makefile. Remove
> the one that does not test compiler.

This was

ifdef CONFIG_PPC64
cflags-$(CONFIG_CPU_BIG_ENDIAN)         += $(call cc-option,-mabi=elfv1)
cflags-$(CONFIG_CPU_BIG_ENDIAN)         += $(call cc-option,-mcall-aixdesc)
aflags-$(CONFIG_CPU_BIG_ENDIAN)         += $(call cc-option,-mabi=elfv1)
aflags-$(CONFIG_CPU_LITTLE_ENDIAN)      += -mabi=elfv2
endif

and the later setting is

ifeq ($(CONFIG_CPU_LITTLE_ENDIAN),y)
CFLAGS-$(CONFIG_PPC64)  += $(call cc-option,-mabi=elfv2,$(call cc-option,-mcall-aixdesc))
AFLAGS-$(CONFIG_PPC64)  += $(call cc-option,-mabi=elfv2)
else
CFLAGS-$(CONFIG_PPC64)  += $(call cc-option,-mabi=elfv1)
CFLAGS-$(CONFIG_PPC64)  += $(call cc-option,-mcall-aixdesc)
AFLAGS-$(CONFIG_PPC64)  += $(call cc-option,-mabi=elfv1)
endif

Maybe these two pieces should be joined completely?


Segher
