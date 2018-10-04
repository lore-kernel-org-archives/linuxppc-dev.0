Return-Path: <SRS0=m9yV=MQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87493C64EBC
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 09:51:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB1D12098A
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 09:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="K2n12Bwr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB1D12098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Qp6v2wQ3zF34W
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 19:51:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="K2n12Bwr";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Qp3x500VzDqkL
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Oct 2018 19:48:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="K2n12Bwr"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42Qp3x3vCdz9s7h; Thu,  4 Oct 2018 19:48:29 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1003)
 id 42Qp3x3Lkgz9s8J; Thu,  4 Oct 2018 19:48:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1538646509; bh=dqFVSOW8seAKRewSWtKFrRayE3vjrwLctOnS6w4ZUQM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=K2n12BwrJ57YfhWF/CKaGT4IHoknuIqTcrxShmwLnBU6Y81ea/GPgppmP9Pkf4pUe
 hdXVWwn5uQWWVMjGhs0RP0NqdyUR4IWMEkoKCJE9SsUdDxOTaT9as1lqfaFfUAAi3g
 +2+3nii2DNsMMldArUCe3+5Qq+JvLskIjYnwyam3fQYHPi08182tLqrU53IgtdVxal
 M1a6PSdDb4QyDZu+ajCt8AkOnoAf8hc1t3nbJgGMEFxV9K9BrsEU+stwbAWabFNmTU
 RIdjSEirFZ0uA5+2zTjvGEqe3t+3UUMoy4+EzlupxWkS1hYoYMQt56BIhrDNbul7Ax
 ddOHhVVNRdRhQ==
Date: Thu, 4 Oct 2018 19:48:26 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v3 33/33] KVM: PPC: Book3S HV: Add a VM capability to
 enable nested virtualization
Message-ID: <20181004094826.GC3255@fergus>
References: <1538479892-14835-1-git-send-email-paulus@ozlabs.org>
 <1538479892-14835-34-git-send-email-paulus@ozlabs.org>
 <20181003062144.GY1886@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181003062144.GY1886@umbus.fritz.box>
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

On Wed, Oct 03, 2018 at 04:21:44PM +1000, David Gibson wrote:
> On Tue, Oct 02, 2018 at 09:31:32PM +1000, Paul Mackerras wrote:
> > With this, userspace can enable a KVM-HV guest to run nested guests
> > under it.
[snip]
> > +/* If set, guests are allowed to create and control nested guests */
> > +static bool enable_nested = true;
> > +module_param(enable_nested, bool, S_IRUGO | S_IWUSR);
> > +MODULE_PARM_DESC(enable_nested, "Enable nested virtualization (only on POWER9)");
> 
> I'd suggest calling the module parameter just "nested" to match x86.

OK.

> >  /* If set, the threads on each CPU core have to be in the same MMU mode */
> >  static bool no_mixing_hpt_and_radix;
> >  
> > @@ -5188,6 +5193,17 @@ static int kvmhv_configure_mmu(struct kvm *kvm, struct kvm_ppc_mmuv3_cfg *cfg)
> >  	return err;
> >  }
> >  
> > +static int kvmhv_enable_nested(struct kvm *kvm, bool enable)
> > +{
> > +	if (!(enable_nested && cpu_has_feature(CPU_FTR_ARCH_300)))
> > +		return -EINVAL;
> 
> Maybe EPERM, rather than EINVAL.  There's nothing invalid about the
> ioctl() parameters - we just can't do what they want.

Just for pedantry's sake, I'll make it EPERM for !enable_nested and
ENODEV for !POWER9. :)

Paul.

