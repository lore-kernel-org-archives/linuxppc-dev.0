Return-Path: <SRS0=Civx=4U=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C10CC3F2D1
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Mar 2020 23:11:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1DEA20848
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Mar 2020 23:11:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1DEA20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48XCSp74vczDqVn
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Mar 2020 10:11:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (SPF Permanent Error: Unknown mechanism
 found: ip:192.40.192.88/32) smtp.mailfrom=kernel.crashing.org
 (client-ip=63.228.1.57; helo=gate.crashing.org;
 envelope-from=segher@kernel.crashing.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48XCQb1lP8zDqJK
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Mar 2020 10:09:55 +1100 (AEDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 023N9oJc032388;
 Tue, 3 Mar 2020 17:09:50 -0600
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id 023N9ou4032387;
 Tue, 3 Mar 2020 17:09:50 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Tue, 3 Mar 2020 17:09:50 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] powerpc/64: BE option to use ELFv2 ABI for big endian
 kernels
Message-ID: <20200303230950.GM22482@gate.crashing.org>
References: <20200303014527.39377-1-npiggin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200303014527.39377-1-npiggin@gmail.com>
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

On Tue, Mar 03, 2020 at 11:45:27AM +1000, Nicholas Piggin wrote:
> Provide an option to use ELFv2 ABI for big endian builds. This works on
> GCC and clang (since 2014). it is is not officially supported by the GNU
> toolchain, but it can give some useful advantages of the ELFv2 ABI for
> BE (e.g., less stack usage). Some distros build BE ELFv2 userspace.

It is not officially supported in the sense that a) as a host config,
it does not exist *at all* (this isn't relevant for the kernel, it does
not use a libc or other libraries, of course); and b) as a target config,
it is not supported in the sense that no one tests it, so we cannot say
anything about what quality code it generates, if it works at all, etc.

But we *do* allow "-mbig -mabi=elfv2", it's just a chicken-and-egg
problem to have this properly tested.  If someone would regularly test
it (incl. sending the test results to gcc-testresults@), I don't see why
it would not become a supported platform.

> +override flavour := linux-ppc64v2

That isn't a good name, heh.  This isn't "v2" of anything...  Spell out
the name "ELFv2"?  Or as "elfv2"?  It is just a name after all, it is
version 1 in all three version fields in the ELF headers!


Anyway, looks like it will work, let's see where this goes :-)

Reviewed-by: Segher Boessenkool <segher@kernel.crashing.org>


Segher
