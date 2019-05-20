Return-Path: <SRS0=EeCa=TU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE625C04AAF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 May 2019 06:40:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2729D20815
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 May 2019 06:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="KlUgt4Mg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2729D20815
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 456q5N1s1yzDqM7
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 May 2019 16:40:08 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 456q2g6WBczDqCM
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 May 2019 16:37:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="KlUgt4Mg"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 456q2g491qz9sBK; Mon, 20 May 2019 16:37:47 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1003)
 id 456q2g3Df9z9s6w; Mon, 20 May 2019 16:37:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1558334267; bh=PNedFHkkuQzcJ3wxJ8NC9BpfSFJPvCUXblZ49yZlqsc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KlUgt4MgHd3B8BHlYvJ2B1gzSvJM5w7HGDLClWT9F190UJn1IloBUPOZdMcPw9+1i
 zduKxRZi2RjwJM5k936+UYMn7/H+DusJij3vatSXygoObqaymBjdmfqet6hUoVGRni
 7spLAe9pxOhQj8ZCrAFBHEhlcKXgQ6vNiyOdQ5WvU+PZgketpJNY7Bl36mHEarVHQz
 0ph0ZY8SU5KVxWkNzq3kncx1aJ7PS4TIrq4HHi5MDl974BZpb4cUdphDLRRrA4OTgK
 C3038eCuD+OaBnDfRpgoamTfRdVbPfpd62pS9MSobzdz/Tdzw10THIWNKXoROlcAuy
 fFhBGDEaNpFZw==
Date: Mon, 20 May 2019 16:17:00 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Claudio Carvalho <cclaudio@linux.ibm.com>
Subject: Re: [RFC PATCH v2 08/10] KVM: PPC: Ultravisor: Return to UV for
 hcalls from SVM
Message-ID: <20190520061700.GC21382@blackberry>
References: <20190518142524.28528-1-cclaudio@linux.ibm.com>
 <20190518142524.28528-9-cclaudio@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190518142524.28528-9-cclaudio@linux.ibm.com>
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
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Michael Anderson <andmike@linux.ibm.com>, Ram Pai <linuxram@us.ibm.com>,
 kvm-ppc@vger.kernel.org, Bharata B Rao <bharata@linux.ibm.com>,
 linuxppc-dev@ozlabs.org, Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Thiago Jung Bauermann <bauerman@linux.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, May 18, 2019 at 11:25:22AM -0300, Claudio Carvalho wrote:
> From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> 
> All hcalls from a secure VM go to the ultravisor from where they are
> reflected into the HV. When we (HV) complete processing such hcalls,
> we should return to the UV rather than to the guest kernel.

This paragraph in the patch description, and the comment in
book3s_hv_rmhandlers.S, are confusing and possibly misleading in
focussing on returns from hcalls, when the change is needed for any
sort of entry to the guest from the hypervisor, whether it is a return
from an hcall, a return from a hypervisor interrupt, or the first time
that a guest vCPU is run.

This paragraph needs to explain that to enter a secure guest, we have
to go through the ultravisor, therefore we do a ucall when we are
entering a secure guest.

[snip]

> +/*
> + * The hcall we just completed was from Ultravisor. Use UV_RETURN
> + * ultra call to return to the Ultravisor. Results from the hcall
> + * are already in the appropriate registers (r3:12), except for
> + * R6,7 which we used as temporary registers above. Restore them,
> + * and set R0 to the ucall number (UV_RETURN).
> + */

This needs to say something like "We are entering a secure guest, so
we have to invoke the ultravisor to do that.  If we are returning from
a hcall, the results are already ...".

> +ret_to_ultra:
> +	lwz	r6, VCPU_CR(r4)
> +	mtcr	r6
> +	LOAD_REG_IMMEDIATE(r0, UV_RETURN)
> +	ld	r7, VCPU_GPR(R7)(r4)
> +	ld	r6, VCPU_GPR(R6)(r4)
> +	ld	r4, VCPU_GPR(R4)(r4)
> +	sc	2
>  
>  /*
>   * Enter the guest on a P9 or later system where we have exactly
> -- 
> 2.20.1

Paul.
