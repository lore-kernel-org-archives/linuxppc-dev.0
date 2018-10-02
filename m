Return-Path: <SRS0=LYrz=MO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24513C43143
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 08:03:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 729972089A
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 08:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="u3LFB2GU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 729972089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42PWq954KBzF3FW
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 18:03:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="u3LFB2GU";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42PWmD4H8tzF3DK
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Oct 2018 18:00:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="u3LFB2GU"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42PWmD2Qtcz9sjD; Tue,  2 Oct 2018 18:00:28 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1003)
 id 42PWmD1Yccz9sj1; Tue,  2 Oct 2018 18:00:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1538467228; bh=vGrxvvEJJIbgQixKclFXrBItSzPWgNcsitXe9JuhL/I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=u3LFB2GUBSTzL4cnFOQtvj/cK9gmEGFvc4BQ3buAoprRISUxrfadkFMMVqTry3y1q
 gFNYydiHaVQbzm8oxlXevRr9W5EQneWa782RaD7sw1XReAsXhKuH1AXgstACkdh8MH
 X0Nczl17tTGyTRUZViMhTVZmhBtq2SLNeFSz8qgxIem9ohJywwe5MrqMPdv0uSRoD5
 jCneUkUDdFUavLqYAoILLuO4rSv4ovT9Vs9JurEKEJFUyE+N5rsSDz/Kx5R1sxwB76
 0VIXlVzRLtv39tK4+j4YScg+sciDVwUyY5m0dCz1UA6IjWBNeqH4oS0zSolkLJI8gg
 IfQFA7hMhB32A==
Date: Tue, 2 Oct 2018 18:00:16 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v2 19/33] KVM: PPC: Book3S HV: Nested guest entry via
 hypercall
Message-ID: <20181002080016.GB26512@fergus>
References: <1538127963-15645-1-git-send-email-paulus@ozlabs.org>
 <1538127963-15645-20-git-send-email-paulus@ozlabs.org>
 <20181002070009.GJ1886@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002070009.GJ1886@umbus.fritz.box>
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
Cc: linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Oct 02, 2018 at 05:00:09PM +1000, David Gibson wrote:
> On Fri, Sep 28, 2018 at 07:45:49PM +1000, Paul Mackerras wrote:
> > This adds a new hypercall, H_ENTER_NESTED, which is used by a nested
> > hypervisor to enter one of its nested guests.  The hypercall supplies
> > register values in two structs.  Those values are copied by the level 0
> > (L0) hypervisor (the one which is running in hypervisor mode) into the
> > vcpu struct of the L1 guest, and then the guest is run until an
> > interrupt or error occurs which needs to be reported to L1 via the
> > hypercall return value.
> > 
> > Currently this assumes that the L0 and L1 hypervisors are the same
> > endianness, and the structs passed as arguments are in native
> > endianness.  If they are of different endianness, the version number
> > check will fail and the hcall will be rejected.
> > 
> > Nested hypervisors do not support indep_threads_mode=N, so this adds
> > code to print a warning message if the administrator has set
> > indep_threads_mode=N, and treat it as Y.
> > 
> > Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
> 
> [snip]
> > +/* Register state for entering a nested guest with H_ENTER_NESTED */
> > +struct hv_guest_state {
> > +	u64 version;		/* version of this structure layout */
> > +	u32 lpid;
> > +	u32 vcpu_token;
> > +	/* These registers are hypervisor privileged (at least for writing) */
> > +	u64 lpcr;
> > +	u64 pcr;
> > +	u64 amor;
> > +	u64 dpdes;
> > +	u64 hfscr;
> > +	s64 tb_offset;
> > +	u64 dawr0;
> > +	u64 dawrx0;
> > +	u64 ciabr;
> > +	u64 hdec_expiry;
> > +	u64 purr;
> > +	u64 spurr;
> > +	u64 ic;
> > +	u64 vtb;
> > +	u64 hdar;
> > +	u64 hdsisr;
> > +	u64 heir;
> > +	u64 asdr;
> > +	/* These are OS privileged but need to be set late in guest entry */
> > +	u64 srr0;
> > +	u64 srr1;
> > +	u64 sprg[4];
> > +	u64 pidr;
> > +	u64 cfar;
> > +	u64 ppr;
> > +};
> 
> I'm guessing the implication here is that most supervisor privileged
> registers need to be set by the L1 to the L2 values, before making the
> H_ENTER_NESTED call.  Is that right?

Right - the supervisor privileged registers that are here are the ones
that the L1 guest needs to have valid at all times (e.g. sprgN), or
that can get clobbered at any time (e.g. srr0/1), or that can't be
set to guest values until just before guest entry (cfar, ppr), or that
are not writable by the supervisor (purr, spurr, dpdes, ic, vtb).

> [snip]
> > +static int kvmppc_handle_nested_exit(struct kvm_vcpu *vcpu)
> > +{
> > +	int r;
> > +	int srcu_idx;
> > +
> > +	vcpu->stat.sum_exits++;
> > +
> > +	/*
> > +	 * This can happen if an interrupt occurs in the last stages
> > +	 * of guest entry or the first stages of guest exit (i.e. after
> > +	 * setting paca->kvm_hstate.in_guest to KVM_GUEST_MODE_GUEST_HV
> > +	 * and before setting it to KVM_GUEST_MODE_HOST_HV).
> > +	 * That can happen due to a bug, or due to a machine check
> > +	 * occurring at just the wrong time.
> > +	 */
> > +	if (vcpu->arch.shregs.msr & MSR_HV) {
> > +		pr_emerg("KVM trap in HV mode while nested!\n");
> > +		pr_emerg("trap=0x%x | pc=0x%lx | msr=0x%llx\n",
> > +			 vcpu->arch.trap, kvmppc_get_pc(vcpu),
> > +			 vcpu->arch.shregs.msr);
> > +		kvmppc_dump_regs(vcpu);
> > +		return RESUME_HOST;
> 
> To make sure I'm understanding right here, RESUME_HOST will
> effectively mean resume the L0, and RESUME_GUEST (without additional
> processing) will mean resume the L2, right?

RESUME_HOST means resume L1 in fact, and RESUME_GUEST means resume L2.
We never go straight out from L2 to L0 because that would leave L1 in
the middle of a hypercall and we would have to have some sort of extra
state to record that fact.  Instead, if we need to do anything like
that (e.g. because of a signal pending for the task), we get to the
point where the H_ENTER_NESTED is finished and the return code is
stored in L1's r3 before exiting to the L0 userspace.

> > @@ -3098,7 +3203,8 @@ static noinline void kvmppc_run_core(struct kvmppc_vcore *vc)
> >  /*
> >   * Load up hypervisor-mode registers on P9.
> >   */
> > -static int kvmhv_load_hv_regs_and_go(struct kvm_vcpu *vcpu, u64 time_limit)
> > +static int kvmhv_load_hv_regs_and_go(struct kvm_vcpu *vcpu, u64 time_limit,
> > +				     unsigned long lpcr)
> 
> I don't understand this change: you've added a parameter, but there's
> no change to the body of the function, so you're not actually using
> the new parameter.

Oops, it should be being used.  Thanks for pointing that out.

> [snip]
> > +/*
> > + * This never fails for a radix guest, as none of the operations it does
> > + * for a radix guest can fail or have a way to report failure.
> > + * kvmhv_run_single_vcpu() relies on this fact.
> > + */
> >  static int kvmhv_setup_mmu(struct kvm_vcpu *vcpu)
> >  {
> >  	int r = 0;
> > @@ -3684,12 +3814,15 @@ static int kvmppc_run_vcpu(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
> >  	return vcpu->arch.ret;
> >  }
> >  
> > -static int kvmppc_run_single_vcpu(struct kvm_run *kvm_run,
> > -				  struct kvm_vcpu *vcpu, u64 time_limit)
> > +int kvmhv_run_single_vcpu(struct kvm_run *kvm_run,
> > +			  struct kvm_vcpu *vcpu, u64 time_limit,
> > +			  unsigned long lpcr)
> 
> IIRC this is the streamlined entry path introduced earlier in the
> series, yes?  Making the name change where it was introduced would
> avoid the extra churn here.

True.

> It'd be nice to have something here to make it more obvious that this
> path is only for radix guests, but I'm not really sure how to
> accomplish that.

It will probably end up getting used for nested HPT guests, when we
implement support for them.

Paul.
