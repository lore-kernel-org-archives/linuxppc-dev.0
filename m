Return-Path: <SRS0=/GF9=P6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE958C282C3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jan 2019 05:53:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B79A20879
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jan 2019 05:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="SH2i3svk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B79A20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43kHdz5wNVzDqNG
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jan 2019 16:53:27 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43kHPt3m0pzDqMh
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jan 2019 16:42:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="SH2i3svk"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 43kHPt07tpz9s9h; Tue, 22 Jan 2019 16:42:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1548135778; bh=kLpbQLQ8SG+gaNgGnUSxGB5Gg4tirs8GqRmzvIrG85k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SH2i3svkeRH0168LGP/yAh1XT4toZQJT7eyVlUSAAj+sbQm0U8l1g56FWyCCOiIow
 bFpgw5ZmceQU7ee8Hg0Ec1wqRm0KJ0jBfoRXo+jXb5ZiTzppb66E5QEAPsWva80Wkl
 K7sBkq1GpJEUGQ6my+/IiHTmM3qILCsbxqDJ8kEgO2JODAQt2SX27RyBiPWO9TRmGP
 pjRDw7EjuqJXOI0nl3GB5FcfPeDRmbcdqZP7vWnCwkA0a4CQ6Rib/BDfRzZuVCgsi6
 1vumq9NV1Jzt7x8V6cwx+F3Lxg3b34U99ymC4LyOi2rIHK5Y1r01TDvjsvwpUs3Ojy
 dz+wnjDab4WXw==
Date: Tue, 22 Jan 2019 16:23:46 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 11/19] KVM: PPC: Book3S HV: add support for the XIVE
 native exploitation mode hcalls
Message-ID: <20190122052346.GF15124@blackberry>
References: <20190107184331.8429-1-clg@kaod.org>
 <20190107184331.8429-12-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190107184331.8429-12-clg@kaod.org>
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

On Mon, Jan 07, 2019 at 07:43:23PM +0100, Cédric Le Goater wrote:
> The XIVE native exploitation mode specs define a set of Hypervisor
> calls to configure the sources and the event queues :
> 
>  - H_INT_GET_SOURCE_INFO
> 
>    used to obtain the address of the MMIO page of the Event State
>    Buffer (PQ bits) entry associated with the source.
> 
>  - H_INT_SET_SOURCE_CONFIG
> 
>    assigns a source to a "target".
> 
>  - H_INT_GET_SOURCE_CONFIG
> 
>    determines which "target" and "priority" is assigned to a source
> 
>  - H_INT_GET_QUEUE_INFO
> 
>    returns the address of the notification management page associated
>    with the specified "target" and "priority".
> 
>  - H_INT_SET_QUEUE_CONFIG
> 
>    sets or resets the event queue for a given "target" and "priority".
>    It is also used to set the notification configuration associated
>    with the queue, only unconditional notification is supported for
>    the moment. Reset is performed with a queue size of 0 and queueing
>    is disabled in that case.
> 
>  - H_INT_GET_QUEUE_CONFIG
> 
>    returns the queue settings for a given "target" and "priority".
> 
>  - H_INT_RESET
> 
>    resets all of the guest's internal interrupt structures to their
>    initial state, losing all configuration set via the hcalls
>    H_INT_SET_SOURCE_CONFIG and H_INT_SET_QUEUE_CONFIG.
> 
>  - H_INT_SYNC
> 
>    issue a synchronisation on a source to make sure all notifications
>    have reached their queue.

Which ones of these could be implemented in QEMU?  Are there any that
can't possibly be implemented in QEMU because they need to do things
that require calling internal interfaces that userspace doesn't have
access to?

How often do we expect each of these hypercalls to be called?

[snip]

> @@ -682,6 +685,46 @@ int kvmppc_rm_h_cppr(struct kvm_vcpu *vcpu, unsigned long cppr);
>  int kvmppc_rm_h_eoi(struct kvm_vcpu *vcpu, unsigned long xirr);
>  void kvmppc_guest_entry_inject_int(struct kvm_vcpu *vcpu);
>  
> +int kvmppc_rm_h_int_get_source_info(struct kvm_vcpu *vcpu,
> +				    unsigned long flag,
> +				    unsigned long lisn);
> +int kvmppc_rm_h_int_set_source_config(struct kvm_vcpu *vcpu,
> +				      unsigned long flag,
> +				      unsigned long lisn,
> +				      unsigned long target,
> +				      unsigned long priority,
> +				      unsigned long eisn);
> +int kvmppc_rm_h_int_get_source_config(struct kvm_vcpu *vcpu,
> +				      unsigned long flag,
> +				      unsigned long lisn);
> +int kvmppc_rm_h_int_get_queue_info(struct kvm_vcpu *vcpu,
> +				   unsigned long flag,
> +				   unsigned long target,
> +				   unsigned long priority);
> +int kvmppc_rm_h_int_set_queue_config(struct kvm_vcpu *vcpu,
> +				     unsigned long flag,
> +				     unsigned long target,
> +				     unsigned long priority,
> +				     unsigned long qpage,
> +				     unsigned long qsize);
> +int kvmppc_rm_h_int_get_queue_config(struct kvm_vcpu *vcpu,
> +				     unsigned long flag,
> +				     unsigned long target,
> +				     unsigned long priority);
> +int kvmppc_rm_h_int_set_os_reporting_line(struct kvm_vcpu *vcpu,
> +					  unsigned long flag,
> +					  unsigned long reportingline);
> +int kvmppc_rm_h_int_get_os_reporting_line(struct kvm_vcpu *vcpu,
> +					  unsigned long flag,
> +					  unsigned long target,
> +					  unsigned long reportingline);
> +int kvmppc_rm_h_int_esb(struct kvm_vcpu *vcpu, unsigned long flag,
> +			unsigned long lisn, unsigned long offset,
> +			unsigned long data);
> +int kvmppc_rm_h_int_sync(struct kvm_vcpu *vcpu, unsigned long flag,
> +			 unsigned long lisn);
> +int kvmppc_rm_h_int_reset(struct kvm_vcpu *vcpu, unsigned long flag);

Why do we need to provide real-mode versions of these hypercall
handlers?  I thought these hypercalls would only get called
infrequently, and in any case certainly much less frequently than once
per interrupt delivered.  If they are infrequent, then let's leave out
the real-mode version and just handle them in book3s_hv.c.

> @@ -5153,6 +5169,19 @@ static unsigned int default_hcall_list[] = {
>  	H_IPOLL,
>  	H_XIRR,
>  	H_XIRR_X,
> +#endif
> +#ifdef CONFIG_KVM_XIVE
> +	H_INT_GET_SOURCE_INFO,
> +	H_INT_SET_SOURCE_CONFIG,
> +	H_INT_GET_SOURCE_CONFIG,
> +	H_INT_GET_QUEUE_INFO,
> +	H_INT_SET_QUEUE_CONFIG,
> +	H_INT_GET_QUEUE_CONFIG,
> +	H_INT_SET_OS_REPORTING_LINE,
> +	H_INT_GET_OS_REPORTING_LINE,
> +	H_INT_ESB,
> +	H_INT_SYNC,
> +	H_INT_RESET,
>  #endif

The policy is not to add new hcalls to default_hcall_list[].  Is there
a strong reason for adding them here?

Paul.
