Return-Path: <SRS0=Sivu=TH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E88B8C004C9
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 May 2019 15:01:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36C5820578
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 May 2019 15:01:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36C5820578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44z2qJ68B8zDqKZ
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 May 2019 01:01:00 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44z2hK5TdzzDq9J
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 May 2019 00:54:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 44z2hH6zbqz9s00;
 Wed,  8 May 2019 00:54:55 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: Crashes in linux-next on powerpc with CONFIG_PPC_KUAP and
 CONFIG_JUMP_LABEL_FEATURE_CHECK_DEBUG
Date: Wed, 08 May 2019 00:54:51 +1000
Message-ID: <87k1f2wc04.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: Stephen Rothwell <sfr@ozlabs.org>, Petr Mladek <pmladek@suse.cz>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi folks,

Just an FYI in case anyone else is seeing crashes very early in boot in
linux-next with the above config options.

The problem is the combination of some new code called via printk(),
check_pointer() which calls probe_kernel_read(). That then calls 
allow_user_access() (PPC_KUAP) and that uses mmu_has_feature() too early
(before we've patched features). With the JUMP_LABEL debug enabled that
causes us to call printk() & dump_stack() and we end up recursing and
overflowing the stack.

Because it happens so early you don't get any output, just an apparently
dead system.

The stack trace (which you don't see) is something like:

  ...
  dump_stack+0xdc
  probe_kernel_read+0x1a4
  check_pointer+0x58
  string+0x3c
  vsnprintf+0x1bc
  vscnprintf+0x20
  printk_safe_log_store+0x7c
  printk+0x40
  dump_stack_print_info+0xbc
  dump_stack+0x8
  probe_kernel_read+0x1a4
  probe_kernel_read+0x19c
  check_pointer+0x58
  string+0x3c
  vsnprintf+0x1bc
  vscnprintf+0x20
  vprintk_store+0x6c
  vprintk_emit+0xec
  vprintk_func+0xd4
  printk+0x40
  cpufeatures_process_feature+0xc8
  scan_cpufeatures_subnodes+0x380
  of_scan_flat_dt_subnodes+0xb4
  dt_cpu_ftrs_scan_callback+0x158
  of_scan_flat_dt+0xf0
  dt_cpu_ftrs_scan+0x3c
  early_init_devtree+0x360
  early_setup+0x9c


The simple fix is to use early_mmu_has_feature() in allow_user_access(),
but we'd rather not do that because it penalises all
copy_to/from_users() for the life of the system with the cost of the
runtime check vs the jump label. The irony is probe_kernel_read()
shouldn't be allowing user access at all, because we're reading the
kernel not userspace.

For now if you're hitting it just turn off 
CONFIG_PPC_KUAP and/or CONFIG_JUMP_LABEL_FEATURE_CHECK_DEBUG.

cheers
