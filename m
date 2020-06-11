Return-Path: <SRS0=eRxT=7Y=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F1B5C433DF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jun 2020 21:04:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 783BA20836
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jun 2020 21:04:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 783BA20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49jbvT6Ym9zDqr6
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Jun 2020 07:04:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (SPF Permanent Error: Unknown mechanism
 found: ip:192.40.192.88/32) smtp.mailfrom=kernel.crashing.org
 (client-ip=63.228.1.57; helo=gate.crashing.org;
 envelope-from=segher@kernel.crashing.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by lists.ozlabs.org (Postfix) with ESMTP id 49jbsk4Xp6zDqP3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2020 07:02:49 +1000 (AEST)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 05BL2WSL021038;
 Thu, 11 Jun 2020 16:02:32 -0500
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id 05BL2UHa021034;
 Thu, 11 Jun 2020 16:02:30 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Thu, 11 Jun 2020 16:02:30 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: Linux powerpc new system call instruction and ABI
Message-ID: <20200611210230.GH31009@gate.crashing.org>
References: <20200611081203.995112-1-npiggin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611081203.995112-1-npiggin@gmail.com>
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
Cc: libc-dev@lists.llvm.org, linux-api@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, musl@lists.openwall.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi!

On Thu, Jun 11, 2020 at 06:12:01PM +1000, Nicholas Piggin wrote:
> Calling convention
> ------------------
> The proposal is for scv 0 to provide the standard Linux system call ABI 
> with the following differences from sc convention[1]:
> 
> - lr is to be volatile across scv calls. This is necessary because the 
>   scv instruction clobbers lr. From previous discussion, this should be 
>   possible to deal with in GCC clobbers and CFI.
> 
> - cr1 and cr5-cr7 are volatile. This matches the C ABI and would allow the
>   kernel system call exit to avoid restoring the volatile cr registers
>   (although we probably still would anyway to avoid information leaks).
> 
> - Error handling: The consensus among kernel, glibc, and musl is to move to
>   using negative return values in r3 rather than CR0[SO]=1 to indicate error,
>   which matches most other architectures, and is closer to a function call.

What about cr0 then?  Will it be volatile as well (exactly like for
function calls)?

> Notes
> -----
> - r0,r4-r8 are documented as volatile in the ABI, but the kernel patch as
>   submitted currently preserves them. This is to leave room for deciding
>   which way to go with these.

The kernel has to set it to *something* that doesn't leak information ;-)


Segher
