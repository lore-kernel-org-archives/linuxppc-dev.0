Return-Path: <SRS0=RfJf=5E=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A44C4332D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Mar 2020 23:44:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAE4C20740
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Mar 2020 23:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="okApgmuZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAE4C20740
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48k3RG52X3zDrQS
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Mar 2020 10:44:42 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48k3Cm564JzDr5J
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2020 10:34:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.a=rsa-sha256
 header.s=201707 header.b=okApgmuZ; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 48k3Cm3QZgz9sSL; Fri, 20 Mar 2020 10:34:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1584660884; bh=LG8xa3mS/oJ94UFOhSt2KGXBPPU42IS8V/3vBwMyZ/o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=okApgmuZWnbdSgXyMpMtt0Ag/byLSD5AFy8eQz8G5nuUs5kEs60eQBs0ktqfCnfih
 ilfkajX1ztYMWdMYeyI+j0w5jQDsuHWC7xOb7xZQAccxqr5JGueyfWtPv5nj7rFSlt
 PVjsyByaNGFBFXttYFegapoB+zlNhG9a++d6vj7M1PmgYcqSVVCr2FVYENuWZfRPnl
 pf80sFN6VBuIhTxBL8t/ckNSQgdXO6MmVgVwGXO9ErEpwfS4py5v8Ij3TSbjtAtP6w
 LVmzSt2gF+3avbt9maTtZGZFyGVDGHDWEFU5hDdFKmCr2b4qE/pIzw/afREjLT+af9
 +MTiv8dylJHOA==
Date: Fri, 20 Mar 2020 10:34:34 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 0/3] KVM: PPC: Fix host kernel crash with PR KVM
Message-ID: <20200319233434.GF3260@blackberry>
References: <158455340419.178873.11399595021669446372.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158455340419.178873.11399595021669446372.stgit@bahia.lan>
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
Cc: kvm-ppc@vger.kernel.org,
 Sean Christopherson <sean.j.christopherson@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Mar 18, 2020 at 06:43:24PM +0100, Greg Kurz wrote:
> Recent cleanup from Sean Christopherson introduced a use-after-free
> condition that crashes the kernel when shutting down the VM with
> PR KVM. It went unnoticed so far because PR isn't tested/used much
> these days (mostly used for nested on POWER8, not supported on POWER9
> where HV should be used for nested), and other KVM implementations for
> ppc are unaffected.
> 
> This all boils down to the fact that the path that frees the per-vCPU
> MMU data goes through a complex set of indirections. This obfuscates
> the code to the point that we didn't realize that the MMU data was
> now being freed too early. And worse, most of the indirection isn't
> needed because only PR KVM has some MMU data to free when the vCPU is
> destroyed.
> 
> Fix the issue (patch 1) and simplify the code (patch 2 and 3).

I have put this series in my kvm-ppc-next branch, and I believe
Michael Ellerman is putting patch 1 in his fixes branch so it gets
into 5.6.

Thanks,
Paul.
