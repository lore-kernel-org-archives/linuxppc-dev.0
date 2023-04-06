Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 725E7C7618D
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Apr 2023 00:29:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PsMnS14dnz3fys
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Apr 2023 10:29:16 +1000 (AEST)
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PsMlw6ccVz3fYD
	for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Apr 2023 10:27:56 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4PsMlw3FyFz4xDr;
	Thu,  6 Apr 2023 10:27:56 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, Benjamin Gray <bgray@linux.ibm.com>
In-Reply-To: <20230302225947.81083-1-bgray@linux.ibm.com>
References: <20230302225947.81083-1-bgray@linux.ibm.com>
Subject: Re: [PATCH v2] powerpc/64s: Fix __pte_needs_flush() false positive warning
Message-Id: <168074081763.3666874.3253471572277076314.b4-ty@ellerman.id.au>
Date: Thu, 06 Apr 2023 10:26:57 +1000
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
Cc: npiggin@gmail.com, ruscur@russell.cc
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 03 Mar 2023 09:59:47 +1100, Benjamin Gray wrote:
> Userspace PROT_NONE ptes set _PAGE_PRIVILEGED, triggering a false
> positive debug assertion that __pte_flags_need_flush() is not called
> on a kernel mapping.
> 
> Detect when it is a userspace PROT_NONE page by checking the required
> bits of PAGE_NONE are set, and none of the RWX bits are set.
> pte_protnone() is insufficient here because it always returns 0 when
> CONFIG_NUMA_BALANCING=n.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/64s: Fix __pte_needs_flush() false positive warning
      https://git.kernel.org/powerpc/c/1abce0580b89464546ae06abd5891ebec43c9470

cheers
