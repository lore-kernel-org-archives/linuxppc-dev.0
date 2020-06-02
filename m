Return-Path: <SRS0=JEJ8=7P=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052AEC433DF
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2020 05:29:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB299206A2
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2020 05:29:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB299206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49bgZV4rVyzDqTL
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2020 15:29:06 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49bgVb2FktzDqRw
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jun 2020 15:25:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 49bgVZ4Rgbz9sSg; Tue,  2 Jun 2020 15:25:42 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 49bgVZ3B6Mz9sSn; Tue,  2 Jun 2020 15:25:41 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 595d153dd1022392083ac93a1550382cbee127e0
In-Reply-To: <20200526061808.2472279-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH] powerpc/64s: Fix restore of NV GPRs after facility
 unavailable exception
Message-Id: <49bgVZ3B6Mz9sSn@ozlabs.org>
Date: Tue,  2 Jun 2020 15:25:41 +1000 (AEST)
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
Cc: npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 2020-05-26 at 06:18:08 UTC, Michael Ellerman wrote:
> Commit 702f09805222 ("powerpc/64s/exception: Remove lite interrupt
> return") changed the interrupt return path to not restore non-volatile
> registers by default, and explicitly restore them in paths where it is
> required.
> 
> But it missed that the facility unavailable exception can sometimes
> modify user registers, ie. when it does emulation of move from DSCR.
> 
> This is seen as a failure of the dscr_sysfs_thread_test:
>   test: dscr_sysfs_thread_test
>   [cpu 0] User DSCR should be 1 but is 0
>   failure: dscr_sysfs_thread_test
> 
> So restore non-volatile GPRs after facility unavailable exceptions.
> 
> Currently the hypervisor facility unavailable exception is also wired
> up to call facility_unavailable_exception().
> 
> In practice we should never take a hypervisor facility unavailable
> exception for the DSCR. On older bare metal systems we set HFSCR_DSCR
> unconditionally in __init_HFSCR, or on newer systems it should be
> enabled via the "data-stream-control-register" device tree CPU
> feature.
> 
> Even if it's not, since commit f3c99f97a3cd ("KVM: PPC: Book3S HV:
> Don't access HFSCR, LPIDR or LPCR when running nested"), the KVM code
> has unconditionally set HFSCR_DSCR when running guests.
> 
> So we should only get a hypervisor facility unavailable for the DSCR
> if skiboot has disabled the "data-stream-control-register" feature,
> and we are somehow in guest context but not via KVM.
> 
> Given all that, it should be unnecessary to add a restore of
> non-volatile GPRs after the hypervisor facility exception, because we
> never expect to hit that path. But equally we may as well add the
> restore, because we never expect to hit that path, and if we ever did,
> at least we would correctly restore the registers to their post
> emulation state.
> 
> In future we can split the non-HV and HV facility unavailable handling
> so that there is no emulation in the HV handler, and then remove the
> restore for the HV case.
> 
> Fixes: 702f09805222 ("powerpc/64s/exception: Remove lite interrupt return")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc fixes.

https://git.kernel.org/powerpc/c/595d153dd1022392083ac93a1550382cbee127e0

cheers
