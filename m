Return-Path: <SRS0=tbgD=FI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87531C4361A
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Dec 2020 12:11:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0C1B22795
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Dec 2020 12:11:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0C1B22795
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CnWlT0t58zDrcN
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Dec 2020 23:11:33 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4CnWTw27GzzDrQf
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Dec 2020 22:59:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4CnWTr2ZGRz9sWk; Fri,  4 Dec 2020 22:59:44 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@ozlabs.org>,
 Greg Kurz <groug@kaod.org>
In-Reply-To: <160673876747.695514.1809676603724514920.stgit@bahia.lan>
References: <160673876747.695514.1809676603724514920.stgit@bahia.lan>
Subject: Re: [PATCH] KVM: PPC: Book3S HV: XIVE: Fix vCPU id sanity check
Message-Id: <160708314553.99163.18261364493188817869.b4-ty@ellerman.id.au>
Date: Fri,  4 Dec 2020 22:59:44 +1100 (AEDT)
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
Cc: linuxppc-dev@lists.ozlabs.org, Cédric Le Goater <clg@kaod.org>, kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 30 Nov 2020 13:19:27 +0100, Greg Kurz wrote:
> Commit 062cfab7069f ("KVM: PPC: Book3S HV: XIVE: Make VP block size
> configurable") updated kvmppc_xive_vcpu_id_valid() in a way that
> allows userspace to trigger an assertion in skiboot and crash the host:
> 
> [  696.186248988,3] XIVE[ IC 08  ] eq_blk != vp_blk (0 vs. 1) for target 0x4300008c/0
> [  696.186314757,0] Assert fail: hw/xive.c:2370:0
> [  696.186342458,0] Aborting!
> xive-kvCPU 0043 Backtrace:
>  S: 0000000031e2b8f0 R: 0000000030013840   .backtrace+0x48
>  S: 0000000031e2b990 R: 000000003001b2d0   ._abort+0x4c
>  S: 0000000031e2ba10 R: 000000003001b34c   .assert_fail+0x34
>  S: 0000000031e2ba90 R: 0000000030058984   .xive_eq_for_target.part.20+0xb0
>  S: 0000000031e2bb40 R: 0000000030059fdc   .xive_setup_silent_gather+0x2c
>  S: 0000000031e2bc20 R: 000000003005a334   .opal_xive_set_vp_info+0x124
>  S: 0000000031e2bd20 R: 00000000300051a4   opal_entry+0x134
>  --- OPAL call token: 0x8a caller R1: 0xc000001f28563850 ---
> 
> [...]

Applied to powerpc/fixes.

[1/1] KVM: PPC: Book3S HV: XIVE: Fix vCPU id sanity check
      https://git.kernel.org/powerpc/c/f54db39fbe40731c40aefdd3bc26e7d56d668c64

cheers
