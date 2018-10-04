Return-Path: <SRS0=m9yV=MQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD3AC64EBC
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 04:58:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C0E220684
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 04:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="D39+ddIX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C0E220684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Qgdc4T7CzF3B8
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 14:58:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="D39+ddIX";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42QgX60lgzzF37M
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Oct 2018 14:53:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="D39+ddIX"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42QgX55m8zz9s8T; Thu,  4 Oct 2018 14:53:57 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1003)
 id 42QgX555whz9s7T; Thu,  4 Oct 2018 14:53:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1538628837; bh=98nywkIcNGl4R3IEJLColDIPDgFIsoCPYXB8iuDtjbM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=D39+ddIXpGSipf0dFiSZHSVCYLLb+cSDbzj3mSOPNAF+/y7C+g5e1Ehe4l1VHD1uj
 vholDANVSP5sPOQHZOahq+IgIkWmHEHJTQrxG26Z6ZOX4AH9pQCJqunINhLQTMfr9Z
 /iVMZJTy0La9LLUifPi+DjDM6i5x6Mjh++2vlweqgMj5BIRHg60RD17dnaTtOXQtvR
 QV2E2dWc+ZGk2nD0fLaSuud0B8y9+OM5kDNHLg0RJJApshJEQkgWC119G44YTn4zE1
 pBDDiTziePibs8AWHuU/1Hmvo8+mPZPlnxCEfn/YfmhfG4afV3dbZBM1SA/ULHtOFa
 oPqwdH+iNoJ+A==
Date: Thu, 4 Oct 2018 13:03:21 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v3 30/33] KVM: PPC: Book3S HV: Allow HV module to load
 without hypervisor mode
Message-ID: <20181004030321.GA16300@fergus>
References: <1538479892-14835-1-git-send-email-paulus@ozlabs.org>
 <1538479892-14835-31-git-send-email-paulus@ozlabs.org>
 <20181003061514.GW1886@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181003061514.GW1886@umbus.fritz.box>
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

On Wed, Oct 03, 2018 at 04:15:15PM +1000, David Gibson wrote:
> On Tue, Oct 02, 2018 at 09:31:29PM +1000, Paul Mackerras wrote:
> > With this, the KVM-HV module can be loaded in a guest running under
> > KVM-HV, and if the hypervisor supports nested virtualization, this
> > guest can now act as a nested hypervisor and run nested guests.
> > 
> > This also adds some checks to inform userspace that HPT guests are not
> > supported by nested hypervisors, and to prevent userspace from
> > configuring a guest to use HPT mode.
> > 
> > Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
> > ---
> >  arch/powerpc/kvm/book3s_hv.c | 20 ++++++++++++++++----
> >  1 file changed, 16 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> > index f630e91..196bff1 100644
> > --- a/arch/powerpc/kvm/book3s_hv.c
> > +++ b/arch/powerpc/kvm/book3s_hv.c
> > @@ -4237,6 +4237,10 @@ static int kvm_vm_ioctl_get_smmu_info_hv(struct kvm *kvm,
> >  {
> >  	struct kvm_ppc_one_seg_page_size *sps;
> >  
> > +	/* If we're a nested hypervisor, we only support radix guests */
> > +	if (kvmhv_on_pseries())
> > +		return -EINVAL;
> > +
> >  	/*
> >  	 * POWER7, POWER8 and POWER9 all support 32 storage keys for data.
> >  	 * POWER7 doesn't support keys for instruction accesses,
> > @@ -4822,11 +4826,15 @@ static int kvmppc_core_emulate_mfspr_hv(struct kvm_vcpu *vcpu, int sprn,
> >  
> >  static int kvmppc_core_check_processor_compat_hv(void)
> >  {
> > -	if (!cpu_has_feature(CPU_FTR_HVMODE) ||
> > -	    !cpu_has_feature(CPU_FTR_ARCH_206))
> > -		return -EIO;
> > +	if (cpu_has_feature(CPU_FTR_HVMODE) &&
> > +	    cpu_has_feature(CPU_FTR_ARCH_206))
> > +		return 0;
> >  
> > -	return 0;
> > +	/* Can run as nested hypervisor on POWER9 in radix mode. */
> > +	if (cpu_has_feature(CPU_FTR_ARCH_300) && radix_enabled())
> 
> Shouldn't we probe the parent hypervisor for ability to support nested
> guests before we say "yes" here?

Well, we do check that the parent hypervisor can support nested
hypervisors, it's just done later on.  And to match nitpick with
nitpick, this is a function evaluating _processor_ compatibility, and
a POWER9 processor in radix mode does have everything necessary to
support nested hypervisors -- if the parent hypervisor doesn't support
nested hypervisors, that's not a deficiency in the processor.

Paul.
