Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC147C433EF
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Jul 2022 10:19:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Lg5jg1qmgz3f8X
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Jul 2022 20:19:35 +1000 (AEST)
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Lg5h14WGYz30Lp
	for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Jul 2022 20:18:09 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Lg5h12vQYz4xvW;
	Sat,  9 Jul 2022 20:18:09 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, Fabiano Rosas <farosas@linux.ibm.com>
In-Reply-To: <20220624142712.790491-1-farosas@linux.ibm.com>
References: <20220624142712.790491-1-farosas@linux.ibm.com>
Subject: Re: [PATCH v2] KVM: PPC: Align pt_regs in kvm_vcpu_arch structure
Message-Id: <165736167068.12236.7214130104736401975.b4-ty@ellerman.id.au>
Date: Sat, 09 Jul 2022 20:14:30 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
Cc: kvm-ppc@vger.kernel.org, npiggin@gmail.com, muriloo@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 24 Jun 2022 11:27:12 -0300, Fabiano Rosas wrote:
> The H_ENTER_NESTED hypercall receives as second parameter the address
> of a region of memory containing the values for the nested guest
> privileged registers. We currently use the pt_regs structure contained
> within kvm_vcpu_arch for that end.
> 
> Most hypercalls that receive a memory address expect that region to
> not cross a 4K page boundary. We would want H_ENTER_NESTED to follow
> the same pattern so this patch ensures the pt_regs structure sits
> within a page.
> 
> [...]

Applied to powerpc/topic/ppc-kvm.

[1/1] KVM: PPC: Align pt_regs in kvm_vcpu_arch structure
      https://git.kernel.org/powerpc/c/f5c847ea19d323974d6f7c7e9fa4858ce0727096

cheers
