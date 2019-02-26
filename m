Return-Path: <SRS0=JJ8i=RB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C753DC43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 05:28:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D32D20652
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 05:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="iOQKO9cs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D32D20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 447nQb0G5czDqC4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 16:28:07 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 447nLS4N9vzDqL9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2019 16:24:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="iOQKO9cs"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 447nLR6T84z9s5c; Tue, 26 Feb 2019 16:24:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1551158671; bh=qYhp7tCO0MK9psw9zorMWXKSqEC/+bDlC7ys4ych5dQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=iOQKO9cspDeAkxfAWkY/FuefaX2Rr9acUvinXW4Pb4SYBc1MQTE0mGpETgDu4hT3l
 87HqpFe9iBgOlqg3MJdEfn/IKg5jRkFjH87es0mmLF8wBSd1KZ5jaH/p7jfN3Xvj5+
 zXSbqdqUTuO+m8FBubts9C8t9vjT27gVOFsXXzS58+6fvtCIpUeY1stjAmRSEg5lXi
 NdEsetQCKy8en/0hFRZW3lwp2oFoTxwVRSNK1kxBw/RJdhy6dXewGIK/7synHZth+0
 bzocXNtiYqBO0TNrtXsHan4pzjLpCyeDqepHOMzEdpQBoC1MgUnE0XFh0Zs1GeexYf
 GhKtCabK0RA/A==
Date: Tue, 26 Feb 2019 16:24:29 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v2 06/16] KVM: PPC: Book3S HV: XIVE: add controls for the
 EQ configuration
Message-ID: <20190226052429.GC28015@blackberry>
References: <20190222112840.25000-1-clg@kaod.org>
 <20190222112840.25000-7-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190222112840.25000-7-clg@kaod.org>
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
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Feb 22, 2019 at 12:28:30PM +0100, Cédric Le Goater wrote:
> These controls will be used by the H_INT_SET_QUEUE_CONFIG and
> H_INT_GET_QUEUE_CONFIG hcalls from QEMU. They will also be used to
> restore the configuration of the XIVE EQs in the KVM device and to
> capture the internal runtime state of the EQs. Both 'get' and 'set'
> rely on an OPAL call to access from the XIVE interrupt controller the
> EQ toggle bit and EQ index which are updated by the HW when event
> notifications are enqueued in the EQ.
> 
> The value of the guest physical address of the event queue is saved in
> the XIVE internal xive_q structure for later use. That is when
> migration needs to mark the EQ pages dirty to capture a consistent
> memory state of the VM.
> 
> To be noted that H_INT_SET_QUEUE_CONFIG does not require the extra
> OPAL call setting the EQ toggle bit and EQ index to configure the EQ,
> but restoring the EQ state will.

[snip]

> +/* Layout of 64-bit eq attribute */
> +#define KVM_XIVE_EQ_PRIORITY_SHIFT	0
> +#define KVM_XIVE_EQ_PRIORITY_MASK	0x7
> +#define KVM_XIVE_EQ_SERVER_SHIFT	3
> +#define KVM_XIVE_EQ_SERVER_MASK		0xfffffff8ULL
> +
> +/* Layout of 64-bit eq attribute values */
> +struct kvm_ppc_xive_eq {
> +	__u32 flags;
> +	__u32 qsize;
> +	__u64 qpage;
> +	__u32 qtoggle;
> +	__u32 qindex;
> +	__u8  pad[40];
> +};

This is confusing.  What's the difference between an "eq attribute"
and an "eq attribute value"?  Is the first actually a queue index or
a queue identifier?

Also, the kvm_ppc_xive_eq is not 64 bits, so the comment above it is
wrong.  Maybe you meant "64-byte"?

[snip]

> +	page = gfn_to_page(kvm, gpa_to_gfn(kvm_eq.qpage));
> +	if (is_error_page(page)) {
> +		pr_warn("Couldn't get guest page for %llx!\n", kvm_eq.qpage);
> +		return -ENOMEM;
> +	}
> +	qaddr = page_to_virt(page) + (kvm_eq.qpage & ~PAGE_MASK);

Isn't this assuming that we can map the whole queue with a single
gfn_to_page?  That would only be true if kvm_eq.qsize <= PAGE_SHIFT.
What happens if kvm_eq.qsize > PAGE_SHIFT?

Paul.
