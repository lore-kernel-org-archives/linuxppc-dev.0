Return-Path: <linuxppc-dev+bounces-27985-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42AAAC982EA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Sep 2026 08:12:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hqV7Q4BPMz2ydN;
	Wed, 23 Sep 2026 18:12:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790151138;
	cv=none; b=CzggIYLQp0eI7+2JsAi7/+WY1jb4E/iRw8UObhLRKNLaBAKxqpMPJxX1yOH+O+KqQfF1Ebqo5NMGJ9Ux/ZfqgyjUKmNIykJRm4AGsOyIlQgEF7hivNhIVo8N8tTwlPxnvKgHD3P8LqKwtGLTTxetik4aqj3Am+DOkNYQzKQiluTwVHjV9BBnGoXo8wGOLmq/+QYuI8vknLudaz0WMMiMNzpnxAFfgOfAxez7BGKpuUUBhw6hBLQ7hpIAmJ1DQUQbeZe9IaJPf0/NPajSaU3PIaLKEPyUTnEP9V5/SXmrFOBTKZkexThghaC+wjyakr5J6lpyyLlVudqfdzWD6NkrPg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790151138; c=relaxed/relaxed;
	bh=4RfQtrFJ309a+fLrqfO5VDKsk1rCknVTQEk2e9GBuqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ckq8mIWk0EY+LXEN4xQDT9OGl0JGYxgRYzKIrzQyJSO+kXCnsuvuVn6Q+yBkLK8xTd/eVRohwWyWRO+UNYRjHjbkRNmIHpu0btP6VwaL+4LEc0FRYzwYwop9GX74SjYeZOQG/E8gKY6hIf1fLdPScLJeW9AuJLENwu77AvTZqnCE6bCetI2TFpwh+k/QImwYOX05TK8COND1UA3SABNolk+NWNp9aFiRxrIpGaLE+0KdR8BxkPlVkQTSl4TGLzRb5ExGcVaFRqabUEFN/qNotXRTKWZKMoXDyltedgpzVWDRHd0tvTTp9KtRkM8HKz3OLHqqn+7j1aEtAoPO1wnRvQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V12ssdVB; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kees@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V12ssdVB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kees@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hqV7P3trPz2xs1
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2026 18:12:17 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A093E40C37;
	Wed, 23 Sep 2026 08:12:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81B6A1F000FF;
	Wed, 23 Sep 2026 08:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790151134;
	bh=4RfQtrFJ309a+fLrqfO5VDKsk1rCknVTQEk2e9GBuqM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=V12ssdVBZdEg1YgzOEHBZ1L0Xf4ZbdwzSmtDM5u5ui74Ilhs7xqj9/dmT8mCt1Fov
	 33Gx7Wqkss8Vl/Zo5PMtWEcd5qK01uB16Hou0XgjVLfpwdFONElOxBW3P0vxQLHEqU
	 us3w4q85mbYaZkM1BZmDbLwNvBK/9Dnx7FSuu2oAZuNo3BgKfxIG/mQTC2VcWxrVI7
	 6KLxmACk1DP13sFF3MWN6bY1wtoEgg/Fj+hwOqc9xsBzUNywG3pS4LEVtoXLKLSKuC
	 suEE/hK/yuepyHS7V/YiFgUkrKEtE1lYUm+KWA/OxK8K2paI6mDe2oQykyeuLJ5m8G
	 x9tDwla2KMpWQ==
Date: Wed, 23 Sep 2026 01:12:14 -0700
From: Kees Cook <kees@kernel.org>
To: Bill Wendling <morbo@google.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev, codemender-patching+linux@google.com
Subject: Re: [PATCH] bus: fsl-mc: Annotate fsl_mc_io.portal_virt_addr with
 __counted_by_ptr
Message-ID: <202609230106.7960C12@keescook>
References: <20260922223538.2287676-1-morbo@google.com>
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
In-Reply-To: <20260922223538.2287676-1-morbo@google.com>

On Tue, Sep 22, 2026 at 10:35:38PM +0000, Bill Wendling wrote:
> The GCC and Clang compilers provide the __counted_by_ptr attribute,
> which is used by KASAN and compiler bounds-checking to detect
> out-of-bounds accesses to pointer fields.
> 
> In "struct fsl_mc_io", the "portal_virt_addr" pointer points to the MC
> command portal virtual address. The size of this allocated portal in
> bytes is tracked by the "portal_size" field within the same structure.
> 
> Annotate the "portal_virt_addr" pointer field with
> "__counted_by_ptr(portal_size)" to enable compiler bounds-checking and
> harden against potential out-of-bounds accesses.

Another one where I hope things agree. :)

        mc_portal_size = resource_size(dpmcp_dev->regions);

        error = fsl_create_mc_io(&mc_bus_dev->dev,
                                 mc_portal_phys_addr,
                                 mc_portal_size, dpmcp_dev,
                                 mc_io_flags, &mc_io);
...

        mc_io->portal_size = mc_portal_size;
	...
        mc_portal_virt_addr = devm_ioremap(dev,
                                                   mc_portal_phys_addr,
                                                   mc_portal_size);
	...
        mc_io->portal_virt_addr = mc_portal_virt_addr;

But it actually reminds me that I still want a warning for having
compile-time warning about pointers being stripped from their counter:

                status = mc_read_response(mc_io->portal_virt_addr, cmd);
...
static inline enum mc_cmd_status mc_read_response(struct fsl_mc_command __iomem
                                                  *portal,
                                                  struct fsl_mc_command *resp)
{
        int i;
        enum mc_cmd_status status;

        /* Copy command response header from MC portal: */
        resp->header = cpu_to_le64(readq_relaxed(&portal->header));

Not only is mc_io->portal_virt_addr separated from mc_io->portal_size
via getting passed to mc_read_response(), but it then immediately gets
cast to struct fsl_mc_command.

We should get the __singleton attribute so we can mark function arg
pointers as "not an array", and then these kinds of casts could generate
a run-time check at function call time to check
sizeof(struct fsl_mc_command) against mc_io->portal_size when
__singleton was there, or kick up a warning that the counter got
stripped.

Because as-is, this patch is a no-op: nothing dereferences
mc_io->portal_virt_addr with the counter in context.


-Kees

-- 
Kees Cook

