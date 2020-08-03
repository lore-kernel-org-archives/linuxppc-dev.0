Return-Path: <SRS0=LND+=BN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E7A4C433E0
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2020 05:58:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A601620678
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2020 05:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="a7mlrlG8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A601620678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BKnJC1ZTtzDqQL
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2020 15:58:51 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BKnGP5m6wzDqQ4
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Aug 2020 15:57:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=a7mlrlG8; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4BKnGN4mkNz9sTb;
 Mon,  3 Aug 2020 15:57:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1596434236;
 bh=F0bSc6jrjeKr0IDKY7K+/CZpnea8KGB+kABjPGz7rqU=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=a7mlrlG8miMj/2o6SYs/srEk/ykRBFqHEPHQXAC2UmXaRJPX2M6sSpcBGNlUv0IHI
 zCt4VMR1sVXCl9ye3sdhQd9I3n+Ah1SAF/4LHa8GlhW/cZnZend1h/aGd2WhS8yX92
 sj0x+fiAxP/BpRw/O+NMvdBv5ifI6HZM1/hVIp0TnUx0ylfW5ok0c965rnlw6ZvqSw
 JQgnvopmBzWhpvESlx61BN5n/4E4n3EWHSEH+49ZHNRewL3KDWYSCDCTx3rkO7gnbi
 DDQwqobcFiUyzC1pwmP+o9zz7nG0sxmK5M4i5W3xsRfxvjBBvnMG7XYo8KApLfSep+
 pQSMJJvlhiYFw==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH v2 15/16] powerpc/powernv/sriov: Make single PE mode a
 per-BAR setting
In-Reply-To: <20200803044609.GB195@Ryzen-9-3900X.localdomain>
References: <20200722065715.1432738-1-oohall@gmail.com>
 <20200722065715.1432738-15-oohall@gmail.com>
 <20200801061823.GA1203340@ubuntu-n2-xlarge-x86>
 <87r1sp19ag.fsf@mpe.ellerman.id.au>
 <20200803044609.GB195@Ryzen-9-3900X.localdomain>
Date: Mon, 03 Aug 2020 15:57:11 +1000
Message-ID: <87k0yg1dc8.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: linuxppc-dev@lists.ozlabs.org, Oliver O'Halloran <oohall@gmail.com>,
 clang-built-linux@googlegroups.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Nathan Chancellor <natechancellor@gmail.com> writes:
> On Sun, Aug 02, 2020 at 11:12:23PM +1000, Michael Ellerman wrote:
>> Nathan Chancellor <natechancellor@gmail.com> writes:
>> > On Wed, Jul 22, 2020 at 04:57:14PM +1000, Oliver O'Halloran wrote:
>> >> Using single PE BARs to map an SR-IOV BAR is really a choice about what
>> >> strategy to use when mapping a BAR. It doesn't make much sense for this to
>> >> be a global setting since a device might have one large BAR which needs to
>> >> be mapped with single PE windows and another smaller BAR that can be mapped
>> >> with a regular segmented window. Make the segmented vs single decision a
>> >> per-BAR setting and clean up the logic that decides which mode to use.
>> >> 
>> >> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
>> >> ---
>> >> v2: Dropped unused total_vfs variables in pnv_pci_ioda_fixup_iov_resources()
>> >>     Dropped bar_no from pnv_pci_iov_resource_alignment()
>> >>     Minor re-wording of comments.
>> >> ---
>> >>  arch/powerpc/platforms/powernv/pci-sriov.c | 131 ++++++++++-----------
>> >>  arch/powerpc/platforms/powernv/pci.h       |  11 +-
>> >>  2 files changed, 73 insertions(+), 69 deletions(-)
>> >> 
>> >> diff --git a/arch/powerpc/platforms/powernv/pci-sriov.c b/arch/powerpc/platforms/powernv/pci-sriov.c
>> >> index ce8ad6851d73..76215d01405b 100644
>> >> --- a/arch/powerpc/platforms/powernv/pci-sriov.c
>> >> +++ b/arch/powerpc/platforms/powernv/pci-sriov.c
>> >> @@ -260,42 +256,40 @@ void pnv_pci_ioda_fixup_iov(struct pci_dev *pdev)
>> >>  resource_size_t pnv_pci_iov_resource_alignment(struct pci_dev *pdev,
>> >>  						      int resno)
>> >>  {
>> >> -	struct pnv_phb *phb = pci_bus_to_pnvhb(pdev->bus);
>> >>  	struct pnv_iov_data *iov = pnv_iov_get(pdev);
>> >>  	resource_size_t align;
>> >>  
>> >> +	/*
>> >> +	 * iov can be null if we have an SR-IOV device with IOV BAR that can't
>> >> +	 * be placed in the m64 space (i.e. The BAR is 32bit or non-prefetch).
>> >> +	 * In that case we don't allow VFs to be enabled since one of their
>> >> +	 * BARs would not be placed in the correct PE.
>> >> +	 */
>> >> +	if (!iov)
>> >> +		return align;
>> >> +	if (!iov->vfs_expanded)
>> >> +		return align;
>> >> +
>> >> +	align = pci_iov_resource_size(pdev, resno);
>> 
>> That's, oof.
>> 
>> > I am not sure if it has been reported yet but clang points out that
>> > align is initialized after its use:
>> >
>> > arch/powerpc/platforms/powernv/pci-sriov.c:267:10: warning: variable 'align' is uninitialized when used here [-Wuninitialized]
>> >                 return align;
>> >                        ^~~~~
>> > arch/powerpc/platforms/powernv/pci-sriov.c:258:23: note: initialize the variable 'align' to silence this warning
>> >         resource_size_t align;
>> >                              ^
>> >                               = 0
>> > 1 warning generated.
>> 
>> But I can't get gcc to warn about it?
>> 
>> It produces some code, so it's not like the whole function has been
>> elided or something. I'm confused.
>
> -Wmaybe-uninitialized was disabled in commit 78a5255ffb6a ("Stop the
> ad-hoc games with -Wno-maybe-initialized") upstream so GCC won't warn on
> stuff like this anymore.

Seems so. Just that there's no "maybe" here, it's very uninitialised.

> I would assume the function should still be generated since those checks
> are relevant, just the return value is bogus.

Yeah, just sometimes missing warnings boil down to the compiler eliding
whole sections of code, if it can convince itself they're unreachable.

AFAICS there's nothing weird going on here that should confuse GCC, it's
about as straight forward as it gets.

Actually I can reproduce it with:

$ cat > test.c <<EOF
int foo(void *p)
{
        unsigned align;

        if (!p)
                return align;

        return 0;
}
EOF

$ gcc -Wall -Wno-maybe-uninitialized -c test.c
$

No warning.

But I guess that's behaving as documented. The compiler can't prove that
foo() will be called with p == NULL, so it doesn't warn.

cheers
