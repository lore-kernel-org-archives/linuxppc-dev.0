Return-Path: <SRS0=RfJf=5E=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6325C43332
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Mar 2020 10:53:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 192BF20752
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Mar 2020 10:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="NcoYYhhh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 192BF20752
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48jkKX2QPGzDr6d
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Mar 2020 21:53:36 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48jkHw4PkjzDr6d
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2020 21:52:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=NcoYYhhh; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 48jkHv5qYjz9sPk;
 Thu, 19 Mar 2020 21:52:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1584615132;
 bh=Q9W0bkEbrTF7/GAT+BMM9NI2FGO9VNaXKyo7h7RZcuo=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=NcoYYhhhoAcnPIHtBhjAcxnTxZJdz3dsxipSCNznLxJbWUMreN2iu2OFilICDujFO
 G/F7pQGGJJ82HPjKAF4NrtRpI4gTXpU20RYg4y7F3pvrdcSlSPI4kqtBCFb0aYKbqe
 Z6NTAczHcDWfw2u26e9cOILPcAScYZRr/fP91/Eh/RMVCjF9T+qDtWB8TV0cvi2ukw
 6NSqW8v7yKcjUS92VdX3IbJllOMmLGjh6kir4+Wjkp0Emfs0sFM+xNg2OuebTpwo0t
 WODrxxq8ksyH42QJcJzV7fquNbCP6ANi12UuwdzIKFUMsBYZluVlDFoCO0SWpTzNP2
 y6QdsGnlRSMIg==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: Re: [PATCH v3] powerpc/perf: Use SIER_USER_MASK while updating
 SPRN_SIER for EBB events
In-Reply-To: <1584533181-4331-1-git-send-email-atrajeev@linux.vnet.ibm.com>
References: <1584533181-4331-1-git-send-email-atrajeev@linux.vnet.ibm.com>
Date: Thu, 19 Mar 2020 21:52:12 +1100
Message-ID: <87r1xod3c3.fsf@mpe.ellerman.id.au>
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
Cc: maddy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Athira,

Athira Rajeev <atrajeev@linux.vnet.ibm.com> writes:
> Sampled Instruction Event Register (SIER), is a PMU register,
                                                               ^
                                                               that
> captures architecture state for a given sample. And sier_user_mask
           ^                                          ^
           don't think we need "architecture"         SIER_USER_MASK

> defined in commit 330a1eb7775b ("powerpc/perf: Core EBB support for 64-bit
> book3s") defines the architected bits that needs to be saved from the SPR.

Not quite, it defines the bits that are visible to userspace.

And I think it's true that for EBB events the bits we need/want to save
are only the user visible bits.

> Currently all of the bits from SIER are saved for EBB events. Patch fixes
> this by ANDing the "sier_user_mask" to data from SIER in ebb_switch_out().
> This will force save only architected bits from the SIER.

s/architected/user visible/


But, why does it matter? The kernel saves the user visible bits, as well
as the kernel-only bits into the thread struct. And then later the
kernel restores that value into the hardware before returning to
userspace.

But the hardware enforces the visibility of the bits, so userspace can't
observe any bits that it shouldn't.

Or is there some other mechanism whereby userspace can see those bits? ;)

If there was, what would the security implications of that be?

cheers

> Fixes: 330a1eb7775b ("powerpc/perf: Core EBB support for 64-bit book3s")
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> ---
> Changelog:
> v2 -> v3:
> - Corrected name of SIER register in commit message
>   as pointed by Segher Boessenkool
> v1 -> v2:
> - Make the commit message more clearer.
>
>  arch/powerpc/perf/core-book3s.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
> index 3086055..48b61cc 100644
> --- a/arch/powerpc/perf/core-book3s.c
> +++ b/arch/powerpc/perf/core-book3s.c
> @@ -579,7 +579,7 @@ static void ebb_switch_out(unsigned long mmcr0)
>  		return;
>  
>  	current->thread.siar  = mfspr(SPRN_SIAR);
> -	current->thread.sier  = mfspr(SPRN_SIER);
> +	current->thread.sier  = mfspr(SPRN_SIER) & SIER_USER_MASK;
>  	current->thread.sdar  = mfspr(SPRN_SDAR);
>  	current->thread.mmcr0 = mmcr0 & MMCR0_USER_MASK;
>  	current->thread.mmcr2 = mfspr(SPRN_MMCR2) & MMCR2_USER_MASK;
> -- 
> 1.8.3.1
