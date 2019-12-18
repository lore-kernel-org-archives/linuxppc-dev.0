Return-Path: <SRS0=gJAX=2I=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E59C43603
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Dec 2019 05:47:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED42D20733
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Dec 2019 05:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="P8P7Oc3C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED42D20733
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47d3tS20FNzDqZp
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Dec 2019 16:47:12 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47d3fD18hWzDqYJ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Dec 2019 16:36:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="P8P7Oc3C"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 47d3fC3JrGz9sRs; Wed, 18 Dec 2019 16:36:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1576647395; bh=vkkInNqS+SwPpU3kaJCTXghI/oELZZ27t+qKvtMxzA8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=P8P7Oc3Cp7HwjsBZTwpp+jcJ43wH03dnhYSwWHzKeY0UGpZvcz6RniJv3T23jYaCT
 zHQwSA1cLT/7NmuQBXAcmB29XKf8vZKlISVS0y1qCdwyGB5B8lzNFWCN3vLsxlYHYN
 AuaroncnYHWL+mqcNnlw+Dtf6dnQZsBiO8jxcXv6XPWVpxfnG4XWc8yJm4OuYk6l5w
 QmLPGj7IQ45+2Cn1tyCgBEQlY7FQWScOfIoiKDrWc0P9gIBLg2pVBew3gVQLGgpLaH
 c5x9SyHb1ah+r/S2fA3X6QQRZimPzu7Z0n9etxJ3dOhYReq34a6I/Sl4S2s51rwuJK
 7pyOvfzgPWmTQ==
Date: Wed, 18 Dec 2019 16:36:32 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: Re: [PATCH V3 2/2] KVM: PPC: Implement H_SVM_INIT_ABORT hcall
Message-ID: <20191218053632.GC29890@oak.ozlabs.ibm.com>
References: <20191215021104.GA27378@us.ibm.com>
 <20191215021208.GB27378@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191215021208.GB27378@us.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: linuxram@us.ibm.com, kvm-ppc@vger.kernel.org,
 Bharata B Rao <bharata@linux.ibm.com>, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, Dec 14, 2019 at 06:12:08PM -0800, Sukadev Bhattiprolu wrote:
> 
> Implement the H_SVM_INIT_ABORT hcall which the Ultravisor can use to
> abort an SVM after it has issued the H_SVM_INIT_START and before the
> H_SVM_INIT_DONE hcalls. This hcall could be used when Ultravisor
> encounters security violations or other errors when starting an SVM.
> 
> Note that this hcall is different from UV_SVM_TERMINATE ucall which
> is used by HV to terminate/cleanup an VM that has becore secure.
> 
> The H_SVM_INIT_ABORT should basically undo operations that were done
> since the H_SVM_INIT_START hcall - i.e page-out all the VM pages back
> to normal memory, and terminate the SVM.
> 
> (If we do not bring the pages back to normal memory, the text/data
> of the VM would be stuck in secure memory and since the SVM did not
> go secure, its MSR_S bit will be clear and the VM wont be able to
> access its pages even to do a clean exit).
> 
> Based on patches and discussion with Paul Mackerras, Ram Pai and
> Bharata Rao.
> 
> Signed-off-by: Ram Pai <linuxram@linux.ibm.com>
> Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.ibm.com>
> Signed-off-by: Bharata B Rao <bharata@linux.ibm.com>

Minor comment below, but not a showstopper.  Also, as Bharata noted
you need to hold the srcu lock for reading.

> +	for (i = 0; i < KVM_ADDRESS_SPACE_NUM; i++) {
> +		struct kvm_memory_slot *memslot;
> +		struct kvm_memslots *slots = __kvm_memslots(kvm, i);
> +
> +		if (!slots)
> +			continue;
> +
> +		kvm_for_each_memslot(memslot, slots)
> +			kvmppc_uvmem_drop_pages(memslot, kvm, false);
> +	}

Since we use the default KVM_ADDRESS_SPACE_NUM, which is 1, this code
isn't wrong but it is more verbose than it needs to be.  It could be

	kvm_for_each_memslot(kvm_memslots(kvm), slots)
		kvmppc_uvmem_drop_pages(memslot, kvm, false);

Paul.
