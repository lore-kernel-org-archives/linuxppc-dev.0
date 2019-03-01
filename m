Return-Path: <SRS0=P3hO=RE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA04C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 08:02:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 111492087E
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 08:02:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="JczKtg+x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 111492087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 449hjq46blzDqQv
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 19:02:55 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 449hgw1npNzDqQg
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Mar 2019 19:01:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="JczKtg+x"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 449hgv6vZbz9s7h; Fri,  1 Mar 2019 19:01:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1551427275; bh=czCH7qiITt7bkPpLBbbqI991RP9QLyBtwG8vCb2yzPw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JczKtg+xxRdzy77tnWQq5sXWtMmEm671dZydCKRHnlCXLIFS0+FxBwmkuCRE8j9+Z
 d7z/6njCjnmTTzxPYTtpCO6Rl3cxEdEyN8eOcLJ9A/TLRX/405o89RKSCQl4+SdT57
 L/e7esv5yJWejxXXGOawoCk8HCY+XrNLBLd67gWxpUNqaIHW7wgMrZBLZtTvycJQoT
 mI/dypdykWbbaeaYQ+vD4xcwGQ/iIaFEuCNY47B4Fgnk9cJpTJknxkYxEtFkVjLJrW
 wDAhOSrmNzFIOWQYMExmtoCEiqIls/MCpr66HZsXki/kXH0+sscgBz8HsXZ3QGtLdQ
 1AgJM9XBSqRcw==
Date: Fri, 1 Mar 2019 19:01:13 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] KVM: PPC: powerpc: Add count cache flush parameters to
 kvmppc_get_cpu_char()
Message-ID: <20190301080113.GB22341@blackberry>
References: <20190301032516.29919-1-sjitindarsingh@gmail.com>
 <87bm2vjdbw.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bm2vjdbw.fsf@concordia.ellerman.id.au>
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
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>, kvm@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Mar 01, 2019 at 05:52:51PM +1100, Michael Ellerman wrote:
> Suraj Jitindar Singh <sjitindarsingh@gmail.com> writes:
> 
> > Add KVM_PPC_CPU_CHAR_BCCTR_FLUSH_ASSIST &
> > KVM_PPC_CPU_BEHAV_FLUSH_COUNT_CACHE to the characteristics returned from
> > the H_GET_CPU_CHARACTERISTICS H-CALL, as queried from either the
> > hypervisor or the device tree.
> >
> > Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> > ---
> >  arch/powerpc/include/uapi/asm/kvm.h |  2 ++
> >  arch/powerpc/kvm/powerpc.c          | 18 ++++++++++++++----
> >  2 files changed, 16 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> > index b90a7d154180..a99dcac91e50 100644
> > --- a/arch/powerpc/kvm/powerpc.c
> > +++ b/arch/powerpc/kvm/powerpc.c
> > @@ -2251,12 +2253,16 @@ static int kvmppc_get_cpu_char(struct kvm_ppc_cpu_char *cp)
> >  		if (have_fw_feat(fw_features, "enabled",
> >  				 "fw-count-cache-disabled"))
> >  			cp->character |= KVM_PPC_CPU_CHAR_COUNT_CACHE_DIS;
> > +		if (have_fw_feat(fw_features, "enabled",
> > +				 "fw-count-cache-flush-bcctr2,0,0"))
> 
> I don't think there's any reason KVM needs to be querying the device
> tree directly, is there?
> 
> Can't it just use the security flags (security_features.h), that are
> initialised by the powernv platform code based on the device tree.

My recollection is that the security flags didn't have all the
information we need.  It's possible that's no longer true.

I merged the patch and sent a pull request to Paolo; using the same
pattern as the existing code made it a low-risk patch and I wanted to
get it in for 5.1.  For 5.2 we can look at changing it over if you
like.

Paul.
