Return-Path: <SRS0=Xegb=OQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD9BC07E85
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 11:45:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E3232083D
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 11:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="IhLMhj7P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E3232083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43B9cq4CcjzDrN8
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 22:44:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="IhLMhj7P";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43B9Yg4WkNzDrP2
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Dec 2018 22:42:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="IhLMhj7P"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 43B9Yg39Rgz9s47; Fri,  7 Dec 2018 22:42:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1544182935; bh=Z+EfcRvH1AiEq18p88/wm84Fb/tBgdLbx4o2ZabXZFE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=IhLMhj7P4GEdWr8wYPbJaLqKFT/lbTF9GuttA85Zls1adK5vF+E24iFcXqh3v2NAE
 bUNhfKVtBznIXRyPe3M4oUPgstXZx0Zza53EeMqsgEPP12x+0kvNGGyJwqhqjDcyTm
 gL6xf9XoRJYoA/5sc8oPwZ5bH5tNOumjqg8MdktymvjQrCJGA2wzQuOyBJxUvSextL
 pezM82VeHfR4w5fzVwG4z4llIfMB5gE6f+gScpLk15W19+LDk+uXSKNB5OsJrFiZI6
 pO1XvO1o6s+JgP1x+keAoiED1W+evys7iTDoHLYvr5GiMMvvPIXKWa4GBJnMARlTA6
 CtJj4nAVHJhXg==
Date: Fri, 7 Dec 2018 22:42:12 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] KVM: PPC: Book3S PR: Set hflag to indicate that POWER9
 supports 1T segments
Message-ID: <20181207114212.GA23129@blackberry>
References: <20181207034326.3564-1-sjitindarsingh@gmail.com>
 <20181207034326.3564-2-sjitindarsingh@gmail.com>
 <871s6tlhln.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871s6tlhln.fsf@concordia.ellerman.id.au>
User-Agent: Mutt/1.5.24 (2015-08-30)
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
Cc: aik@ozlabs.ru, linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>, kvm@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Dec 07, 2018 at 10:08:20PM +1100, Michael Ellerman wrote:
> Suraj Jitindar Singh <sjitindarsingh@gmail.com> writes:
> 
> > When booting a kvm-pr guest on a POWER9 machine the following message is
> > observed:
> > "qemu-system-ppc64: KVM does not support 1TiB segments which guest expects"
> >
> > This is because the guest is expecting to be able to use 1T segments
> > however we don't indicate support for it. This is because we don't set
> > the BOOK3S_HFLAG_MULTI_PGSIZE flag in the hflags in kvmppc_set_pvr_pr()
> > on POWER9.
> >
> > POWER9 does indeed have support for 1T segments, so add a case for
> > POWER9 to the switch statement to ensure it is set.
> 
> If this just checked mmu_has_feature(MMU_FTR_1T_SEGMENT) it would have
> been right in this case, and we'd also never have to update it in
> future.
> 
> Any reason not to?

PR KVM can emulate a different processor from the host.  Checking
mmu_has_feature() will tell you about the host, not the CPU being
emulated.

Paul.
