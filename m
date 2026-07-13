Return-Path: <linuxppc-dev+bounces-24123-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 572B9C44501
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jul 2026 16:39:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzSnS5XYWz3078;
	Tue, 14 Jul 2026 02:39:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783960748;
	cv=none; b=IiBVcWUMzpMafkjiQkXml/1EwkabKEBpO5wnIk29pGVLUh902vhCbTwKApKJu1Y7dD8YQeRY2fhEEmTP3ZvajREC1POzFxHq/bHLbGmZ3bvT5vpjqPpldk14DeR/jBIcPIDMUxRHj9TpP6BJ+7qsV3dJpiQMbxkgTSTcMxmseX8pyn3LeLHYhVZMC3OibXJa8hMUQ8ghbNlhdS1K5FPNY0ZrGL/t/VAFMJHhHpeWJWPKioto/u+nWM9DIGfQn8Zuu5UtekuhdIML+EA6xoYKyOGSnaqYrR054o4AH2yAwjz3VBd8XBgEjvbng155BIFxCMMtK/0OMFp2md+wbAkWog==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783960748; c=relaxed/relaxed;
	bh=+8bn+J1m/2WVL2HRQqPjPX3jby4LCx/UUlRbPjdP5Mc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XQG/OwncXOzi6Szt2mpEUdqiBqA8LjIRBXCIyHEwOzomlg4JWLfnAdoYNqrEnjluLtlmKgRZDsypDDUuEVsj0yiM7FXtgLlfBtiBGUgTUKJqfbxgFt+yfoa/r7sMyrkCROCtCw4DySr44ZmalfKgyM7rlwZAKeJAsmuiFHZ1gKQZCE6JPiqh9XonBH81Gll8ezSk+/0KgdSieQkW0NkO030prccHxLnoytSQIfePKKL8T66tS/ZfrwE8hKbQf7L8bGrLFTFbc0rI+INN7bkLR+clEW89uO1c2VjMIINEnEBDbAdAPQoDXKl7pqNjyBfotV42h+n3cb1VcAyzBA492w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YbbtLsxx; dkim-atps=neutral; spf=pass (client-ip=198.175.65.17; helo=mgamail.intel.com; envelope-from=pawan.kumar.gupta@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YbbtLsxx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.17; helo=mgamail.intel.com; envelope-from=pawan.kumar.gupta@linux.intel.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 65 seconds by postgrey-1.37 at boromir; Tue, 14 Jul 2026 02:39:05 AEST
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzSnP1fLZz306S
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 02:39:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783960746; x=1815496746;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4kZEQHCKkpYpxkKyYJlUA0Zza6SQ8vOAw/fP08uqXDo=;
  b=YbbtLsxxAB+NLx0mmDQBrIPFaDYhPWaoeCuWiFfpMSRMHYgEodLt24Ot
   amGwhmcRrGg7UthzqS+7b8yrWQ9EbzJgamw5/Hz07EWGPbUE1Az5oEVTH
   qHt820kjnoa4yjBTE6QYLr5yo8+qCMBFNw0mAw1zy441Oi7TpSIdfxGF1
   w22SF5wqWFTi8W4W5EfMHI5T0N8ZLk2KQ709N2ZVrqsFBoNQipc9fil+E
   E1Q+tpzvaROTBXBgM6LCYEqT1hyCA9k6s7v/XeKoVw4MCCSJnnE5bgVde
   nzYNDYJcwhL7ZHFBDw/8yZfEG0A4C8xAAaynKN6XVgdKRlowMMYYyX1Pm
   A==;
X-CSE-ConnectionGUID: nPhc7rtPSzyTy81hySBLVw==
X-CSE-MsgGUID: /PfKTQtMQOeb5TLEzBHtZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84591895"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84591895"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 09:37:53 -0700
X-CSE-ConnectionGUID: hWdotUdbRAyEFlX+x/kfWQ==
X-CSE-MsgGUID: leJxOZsNRQSKnAtRZj8eFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="249245643"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 09:37:52 -0700
Date: Mon, 13 Jul 2026 09:37:45 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: bot+bpf-ci@kernel.org
Cc: stable@vger.kernel.org, gregkh@linuxfoundation.org, sashal@kernel.org, 
	bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, x86@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, eddyz87@gmail.com, 
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH 7.1.y 1/6] bpf: Support for hardening against JIT spraying
Message-ID: <ehtglcrfzb4feb2ysknrcyvz7t2vc2ui2nfbunypteeexbsfu7@x477johvq6pl>
References: <20260709-cbpf-jit-spray-hardening-7-1-y-v1-1-5ac5a2d6797f@linux.intel.com>
 <de3ebfe684f280473617b560a9dcf501df07833f835a08eb6e75720cd03662b4@mail.kernel.org>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de3ebfe684f280473617b560a9dcf501df07833f835a08eb6e75720cd03662b4@mail.kernel.org>

On Thu, Jul 09, 2026 at 10:52:04PM +0000, bot+bpf-ci@kernel.org wrote:
> > commit 96cce16e26dd02a8678f1e87f88a4b5cdb63b995 upstream.
> > The BPF JIT allocator packs many small programs into larger executable
> > allocations and reuses space within those allocations as programs are
> > loaded and freed. When fresh code is written into space that a previous
> > program occupied, an indirect jump into the new program can reuse a branch
> > prediction left behind by the old one.
> > Flush the indirect branch predictors before reusing JIT memory so that
> > indirect jumps into a newly written program don't reuse predictions from an
> > old program that occupied the same space.
> > Introduce bpf_arch_pred_flush_enabled static key and bpf_arch_pred_flush
> > static call for flushing the branch predictors on JIT memory reuse.
> > Architectures that need a flush, can update it to a predictor flush
> > function. By default, its a NOP and does not emit any CALL.
> > Allocations larger than a pack are not covered by this flush. That is safe
> > because cBPF programs (the unprivileged attack surface) are bounded well
> > below a pack size. Issue a warning if this assumption is ever violated
> > while the flush is active.
> > Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> > Acked-by: Daniel Borkmann <daniel@iogearbox.net>
> > Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> 
> The reuse path this patch hardens (bpf_prog_pack_alloc() finding a free
> area within a pack, and the size > BPF_PROG_PACK_SIZE branch) comes from
> the pack allocator that first packed many programs into shared executable
> allocations and reused freed space within a pack.
> 
> Should this carry a Fixes: tag pointing at that commit?
> 
>   Fixes: 57631054fae6 ("bpf: Introduce bpf_prog_pack allocator")

It doesn't add much value. This commit insn't really buggy, it needs no fix
for the eBPF. The fact that cBPF is unprivileged, opens a window for a JIT
spraying attack. Also, the the patch is a backport, so it should stay close
to upstream.

