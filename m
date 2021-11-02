Return-Path: <SRS0=jSa2=PV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62AE1C43217
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Nov 2021 11:49:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0699A61100
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Nov 2021 11:49:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0699A61100
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Hk7Vg52Svz3gN2
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Nov 2021 22:49:47 +1100 (AEDT)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Hk7G15273z3bhg
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Nov 2021 22:38:49 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Hk7G148Xjz4xdc;
 Tue,  2 Nov 2021 22:38:49 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: kvm-ppc@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20211004145749.1331331-1-npiggin@gmail.com>
References: <20211004145749.1331331-1-npiggin@gmail.com>
Subject: Re: [PATCH] KVM: PPC: Book3S HV: H_ENTER filter out reserved HPTE[B]
 value
Message-Id: <163584789016.1845480.2757100550456404160.b4-ty@ellerman.id.au>
Date: Tue, 02 Nov 2021 21:11:30 +1100
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 5 Oct 2021 00:57:49 +1000, Nicholas Piggin wrote:
> The HPTE B field is a 2-bit field with values 0b10 and 0b11 reserved.
> This field is also taken from the HPTE and used when KVM executes
> TLBIEs to set the B field of those instructions.
> 
> Disallow the guest setting B to a reserved value with H_ENTER by
> rejecting it. This is the same approach already taken for rejecting
> reserved (unsupported) LLP values. This prevents the guest from being
> able to induce the host to execute TLBIE with reserved values, which
> is not known to be a problem with current processors but in theory it
> could prevent the TLBIE from working correctly in a future processor.
> 
> [...]

Applied to powerpc/next.

[1/1] KVM: PPC: Book3S HV: H_ENTER filter out reserved HPTE[B] value
      https://git.kernel.org/powerpc/c/322fda0405fecaaa540b0fa90393830aaadaf420

cheers
