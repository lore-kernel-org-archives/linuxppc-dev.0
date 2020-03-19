Return-Path: <SRS0=RfJf=5E=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84AF2C4332B
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Mar 2020 23:39:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37B7B2076C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Mar 2020 23:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="ZqGPQQT9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37B7B2076C
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48k3KZ3f25zDr5J
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Mar 2020 10:39:46 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48k3Cm3X3tzDr41
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2020 10:34:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.a=rsa-sha256
 header.s=201707 header.b=ZqGPQQT9; dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 48k3Cm2kn9z9sSQ; Fri, 20 Mar 2020 10:34:44 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1003)
 id 48k3Cl752Bz9sRN; Fri, 20 Mar 2020 10:34:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1584660884; bh=qqarS8RUzT5oByS0Dv5M1W/QDT2JjnNGafGudwfpqIY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZqGPQQT9hIicpkVTP8U8355GLkIl4mNolvydHn0A/7Bq7vdrx8V6QNNhkfh09sNlw
 9e8UPQ9PZU+AxXW7dsKJwHyNfEqtATzW7QYlYb5AlcEhqPBG13yYmVbSVDE0Zy0WxT
 ixc6wLKEYXDxBC4Il5h55tcHE79hBm7be4azj3iUheP16bayLZCAL8Had7cTbIUZ6V
 MULEOOmZ+opqH2QdWV0EkvhIeztyyozOgpHRrdM5cfIDWWVF+8XlH/G9+l4RUhC+8S
 o15F3BA6XRKpYatCW6lMBWpYZRSQD7kpnIXshWH1UTE+JdORyQWnoYS/DCXLxGyp73
 OUosK1yxCMedg==
Date: Fri, 20 Mar 2020 10:32:56 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Subject: Re: [PATCH] KVM: PPC: Book3S HV: Fix H_CEDE return code for nested
 guests
Message-ID: <20200319233256.GD3260@blackberry>
References: <20200310211128.17672-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310211128.17672-1-mdroth@linux.vnet.ibm.com>
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
Cc: linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Mar 10, 2020 at 04:11:28PM -0500, Michael Roth wrote:
> The h_cede_tm kvm-unit-test currently fails when run inside an L1 guest
> via the guest/nested hypervisor.
> 
>   ./run-tests.sh -v
>   ...
>   TESTNAME=h_cede_tm TIMEOUT=90s ACCEL= ./powerpc/run powerpc/tm.elf -smp 2,threads=2 -machine cap-htm=on -append "h_cede_tm"
>   FAIL h_cede_tm (2 tests, 1 unexpected failures)
> 
> While the test relates to transactional memory instructions, the actual
> failure is due to the return code of the H_CEDE hypercall, which is
> reported as 224 instead of 0. This happens even when no TM instructions
> are issued.
> 
> 224 is the value placed in r3 to execute a hypercall for H_CEDE, and r3
> is where the caller expects the return code to be placed upon return.
> 
> In the case of guest running under a nested hypervisor, issuing H_CEDE
> causes a return from H_ENTER_NESTED. In this case H_CEDE is
> specially-handled immediately rather than later in
> kvmppc_pseries_do_hcall() as with most other hcalls, but we forget to
> set the return code for the caller, hence why kvm-unit-test sees the
> 224 return code and reports an error.
> 
> Guest kernels generally don't check the return value of H_CEDE, so
> that likely explains why this hasn't caused issues outside of
> kvm-unit-tests so far.
> 
> Fix this by setting r3 to 0 after we finish processing the H_CEDE.
> 
> RHBZ: 1778556
> 
> Fixes: 4bad77799fed ("KVM: PPC: Book3S HV: Handle hypercalls correctly when nested")
> Cc: linuxppc-dev@ozlabs.org
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: Paul Mackerras <paulus@ozlabs.org>
> Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>

Thanks, applied to my kvm-ppc-next branch.

Paul.
