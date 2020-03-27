Return-Path: <SRS0=yRDn=5M=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 650C8C43331
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Mar 2020 18:45:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 230B5206F2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Mar 2020 18:45:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 230B5206F2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48prQq6Zg3zDrP1
	for <linuxppc-dev@archiver.kernel.org>; Sat, 28 Mar 2020 05:45:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (SPF Permanent Error: Unknown mechanism
 found: ip:192.40.192.88/32) smtp.mailfrom=kernel.crashing.org
 (client-ip=63.228.1.57; helo=gate.crashing.org;
 envelope-from=segher@kernel.crashing.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by lists.ozlabs.org (Postfix) with ESMTP id 48pr2F2rlwzDrJf
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Mar 2020 05:28:05 +1100 (AEDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 02RIRuXZ023594;
 Fri, 27 Mar 2020 13:27:57 -0500
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id 02RIRt0v023593;
 Fri, 27 Mar 2020 13:27:55 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Fri, 27 Mar 2020 13:27:55 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Fangrui Song <maskray@google.com>
Subject: Re: [PATCH v2] powerpc/boot: Delete unneeded .globl _zimage_start
Message-ID: <20200327182755.GL22482@gate.crashing.org>
References: <20200325164257.170229-1-maskray@google.com>
 <20200326221625.GA22482@gate.crashing.org>
 <20200326222612.zbbiyi75emq6npzn@google.com>
 <20200327152428.GF22482@gate.crashing.org>
 <20200327165054.67pzzjwtg3dc7hx2@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200327165054.67pzzjwtg3dc7hx2@google.com>
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
Cc: Alan Modra <amodra@gmail.com>, Nick Desaulniers <ndesaulniers@google.com>,
 clang-built-linux@googlegroups.com, Joel Stanley <joel@jms.id.au>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Mar 27, 2020 at 09:50:54AM -0700, Fangrui Song wrote:
> We aim for compatibility with GNU in many aspects to make it easier for
> people to switch over. However, just because there is a subtle behavior
> in GNU toolchain does not mean we need to emulate that behavior.

It isn't subtle.  It is the explicit documented behaviour.

> With
> all due respect, there are a large quantity of legacy behaviors we don't
> want to support.

And it isn't legacy at all.  It is simply the defined semantics.

It is semantics that real code relies on (and has for ages) as well.


Segher
