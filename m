Return-Path: <SRS0=YHW0=BB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 020ADC433DF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Jul 2020 05:07:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DAB420771
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Jul 2020 05:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="B53OnyDO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DAB420771
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BBNk96kZ1zDqyb
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Jul 2020 15:07:13 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BBNRw1JgszDqGW
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2020 14:54:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.a=rsa-sha256
 header.s=201707 header.b=B53OnyDO; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 4BBNRv6j1qz9sR4; Wed, 22 Jul 2020 14:54:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1595393691; bh=SPr8+lQ/5tRFTDOXTAmNurdJdDePVRoXfmN5P09ctLw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=B53OnyDOFtochptnZj8D7Rr+5yr9+k3vXB6P84hQJkMpACKGcASdubZYp6mAWYi6i
 TB/A47YLeKWbGnAEkuxJmztAZNsSJI50GkrTDTPjxU77jflAo1yFtuq5nSmtfJfJwE
 c+bwiwGYGkpeewoAnostK4rC5NnL3TMOpPKqnAO2bNFy3O8WtE1SHWAoeyU4daPNbM
 SYL8kW8BWG8wwcGJ1vy8agxkiqiFSJPLkTBF8zVhFIXoFIiphGsjvj/7mKFAXj8Ddl
 2SfHojlzZYFBCWxRwSWVbu4ksvjKZ0D+rNRcqnjto9z5O4U4MigCogrw8xnIkPh+o6
 Wd4vvmk9noaGw==
Date: Wed, 22 Jul 2020 14:54:48 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: Re: [v3 02/15] KVM: PPC: Book3S HV: Cleanup updates for kvm vcpu MMCR
Message-ID: <20200722045448.GC3878639@thinks.paulus.ozlabs.org>
References: <1594996707-3727-1-git-send-email-atrajeev@linux.vnet.ibm.com>
 <1594996707-3727-3-git-send-email-atrajeev@linux.vnet.ibm.com>
 <20200721035420.GA3819606@thinks.paulus.ozlabs.org>
 <B83C440A-1AC4-4737-8AB1-EB9A6B8A474B@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B83C440A-1AC4-4737-8AB1-EB9A6B8A474B@linux.vnet.ibm.com>
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
Cc: ego@linux.vnet.ibm.com, Michael Neuling <mikey@neuling.org>,
 maddy@linux.vnet.ibm.com, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 svaidyan@in.ibm.com, acme@kernel.org, jolsa@kernel.org,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Jul 22, 2020 at 07:39:26AM +0530, Athira Rajeev wrote:
> 
> 
> > On 21-Jul-2020, at 9:24 AM, Paul Mackerras <paulus@ozlabs.org> wrote:
> > 
> > On Fri, Jul 17, 2020 at 10:38:14AM -0400, Athira Rajeev wrote:
> >> Currently `kvm_vcpu_arch` stores all Monitor Mode Control registers
> >> in a flat array in order: mmcr0, mmcr1, mmcra, mmcr2, mmcrs
> >> Split this to give mmcra and mmcrs its own entries in vcpu and
> >> use a flat array for mmcr0 to mmcr2. This patch implements this
> >> cleanup to make code easier to read.
> > 
> > Changing the way KVM stores these values internally is fine, but
> > changing the user ABI is not.  This part:
> > 
> >> diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
> >> index 264e266..e55d847 100644
> >> --- a/arch/powerpc/include/uapi/asm/kvm.h
> >> +++ b/arch/powerpc/include/uapi/asm/kvm.h
> >> @@ -510,8 +510,8 @@ struct kvm_ppc_cpu_char {
> >> 
> >> #define KVM_REG_PPC_MMCR0	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0x10)
> >> #define KVM_REG_PPC_MMCR1	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0x11)
> >> -#define KVM_REG_PPC_MMCRA	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0x12)
> >> -#define KVM_REG_PPC_MMCR2	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0x13)
> >> +#define KVM_REG_PPC_MMCR2	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0x12)
> >> +#define KVM_REG_PPC_MMCRA	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0x13)
> > 
> > means that existing userspace programs that used to work would now be
> > broken.  That is not acceptable (breaking the user ABI is only ever
> > acceptable with a very compelling reason).  So NAK to this part of the
> > patch.
> 
> Hi Paul
> 
> Thanks for checking the patch. I understood your point on user ABI breakage that this particular change can cause.
> I will retain original KVM_REG_PPC_MMCRA and KVM_REG_PPC_MMCR2 order in `kvm.h`
> And with that, additionally I will need below change ( on top of current patch ) for my clean up updates for kvm cpu MMCR to work,
> Because now mmcra and mmcrs will have its own entries in vcpu and is not part of the mmcr[] array
> Please suggest if this looks good

Yes, that looks fine.

By the way, is the new MMCRS register here at all related to the MMCRS
that there used to be on POWER8, but which wasn't present (as far as I
know) on POWER9?

Paul.
