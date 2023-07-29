Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C036AC001DC
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Jul 2023 07:50:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RCc9N0qtRz3cTR
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Jul 2023 17:50:00 +1000 (AEST)
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RCc8K0Hhmz2yVn
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Jul 2023 17:49:05 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4RCc8J39pZz4wy7;
	Sat, 29 Jul 2023 17:49:04 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, Naveen N Rao <naveen@kernel.org>
In-Reply-To: <20230621051349.759567-1-naveen@kernel.org>
References: <20230621051349.759567-1-naveen@kernel.org>
Subject: Re: [PATCH] powerpc/ftrace: Create a dummy stackframe to fix stack unwind
Message-Id: <169061688928.236508.2659343767835003491.b4-ty@ellerman.id.au>
Date: Sat, 29 Jul 2023 17:48:09 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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
Cc: Nicholas Piggin <npiggin@gmail.com>, Steven Rostedt <rostedt@goodmis.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 21 Jun 2023 10:43:49 +0530, Naveen N Rao wrote:
> With ppc64 -mprofile-kernel and ppc32 -pg, profiling instructions to
> call into ftrace are emitted right at function entry. The instruction
> sequence used is minimal to reduce overhead. Crucially, a stackframe is
> not created for the function being traced. This breaks stack unwinding
> since the function being traced does not have a stackframe for itself.
> As such, it never shows up in the backtrace:
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/ftrace: Create a dummy stackframe to fix stack unwind
      https://git.kernel.org/powerpc/c/41a506ef71eb38d94fe133f565c87c3e06ccc072

cheers
