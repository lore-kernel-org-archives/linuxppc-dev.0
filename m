Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 324D5C433EF
	for <linuxppc-dev@archiver.kernel.org>; Sun, 10 Apr 2022 12:28:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KbrrC3Pxwz3c8x
	for <linuxppc-dev@archiver.kernel.org>; Sun, 10 Apr 2022 22:28:43 +1000 (AEST)
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KbrqQ2hwhz2xfT
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Apr 2022 22:28:02 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4KbrqN6BN7z4xQp;
 Sun, 10 Apr 2022 22:28:00 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20220406145802.538416-1-mpe@ellerman.id.au>
References: <20220406145802.538416-1-mpe@ellerman.id.au>
Subject: Re: [PATCH 1/6] powerpc: Fix virt_addr_valid() for 64-bit Book3E &
 32-bit
Message-Id: <164959362975.1306388.3506534126245495622.b4-ty@ellerman.id.au>
Date: Sun, 10 Apr 2022 22:27:09 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
Cc: erhard_f@mailbox.org, wangkefeng.wang@huawei.com, npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 7 Apr 2022 00:57:57 +1000, Michael Ellerman wrote:
> From: Kefeng Wang <wangkefeng.wang@huawei.com>
> 
> mpe: On 64-bit Book3E vmalloc space starts at 0x8000000000000000.
> 
> Because of the way __pa() works we have:
>   __pa(0x8000000000000000) == 0, and therefore
>   virt_to_pfn(0x8000000000000000) == 0, and therefore
>   virt_addr_valid(0x8000000000000000) == true
> 
> [...]

Patches 1 & 2 applied to powerpc/fixes.

[1/6] powerpc: Fix virt_addr_valid() for 64-bit Book3E & 32-bit
      https://git.kernel.org/powerpc/c/ffa0b64e3be58519ae472ea29a1a1ad681e32f48
[2/6] Revert "powerpc: Set max_mapnr correctly"
      https://git.kernel.org/powerpc/c/1ff5c8e8c835e8a81c0868e3050c76563dd56a2c

cheers
