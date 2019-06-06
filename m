Return-Path: <SRS0=nl2z=UF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B63C04AB5
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Jun 2019 21:56:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5449204FD
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Jun 2019 21:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="ukxjcF1d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5449204FD
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45KfdD3HBBzDqnG
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Jun 2019 07:56:48 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45Kfbc5wKJzDqbm
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Jun 2019 07:55:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="ukxjcF1d"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 45Kfbb3sJ1z9s00; Fri,  7 Jun 2019 07:55:23 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1003)
 id 45Kfbb3Hs4z9s7h; Fri,  7 Jun 2019 07:55:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1559858123; bh=v2fPZbg0lV/jywlzf1lVRFPPfX0tXSSobcR99ThU+kU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ukxjcF1d4OPWpHSO9EUhznijRmucnyz1uMHaN6KIwJ9mCwLxSPqT9h8z5YGTUpemF
 1AiHTDCY1Kp/Wug/JmNdvDWQyX6+kCMo32Brd8181PBU8amDYobPawwliCrK5Tgb8W
 qlA4kks+lc3pC71kHXqiWqxiq4T3v7XWszFz6Ck2D/dD8q6+7iw94dyoJ5TV945aKl
 g93fKZnLGUCi0xbsNJFRFy5Zat42yFS4UaOf7eojpg5GFbKOiFBnVWRNK45R6seH2w
 WRpygMctPR293+mJCel2LRIDKNH8TuAPfFEW7J060Ykeqoy6Cubz2+KdBW5lWVWiHa
 8vPr5wGwQs8pg==
Date: Fri, 7 Jun 2019 07:55:20 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Murilo Opsfelder =?iso-8859-1?Q?Ara=FAjo?= <mopsfelder@gmail.com>
Subject: Re: [PATCH v3 6/9] KVM: PPC: Ultravisor: Restrict flush of the
 partition tlb cache
Message-ID: <20190606215520.GA1220@blackberry>
References: <20190606173614.32090-1-cclaudio@linux.ibm.com>
 <20190606173614.32090-7-cclaudio@linux.ibm.com>
 <8736kmld0n.fsf@kermit.br.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8736kmld0n.fsf@kermit.br.ibm.com>
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
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Michael Anderson <andmike@linux.ibm.com>, Ram Pai <linuxram@us.ibm.com>,
 Claudio Carvalho <cclaudio@linux.ibm.com>, kvm-ppc@vger.kernel.org,
 Bharata B Rao <bharata@linux.ibm.com>, linuxppc-dev@ozlabs.org,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Thiago Bauermann <bauermann@linux.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Jun 06, 2019 at 04:39:04PM -0300, Murilo Opsfelder Araújo wrote:
> Claudio Carvalho <cclaudio@linux.ibm.com> writes:
> 
> > From: Ram Pai <linuxram@us.ibm.com>
> >
> > Ultravisor is responsible for flushing the tlb cache, since it manages
> > the PATE entries. Hence skip tlb flush, if the ultravisor firmware is
> > available.
> >
> > Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> > Signed-off-by: Claudio Carvalho <cclaudio@linux.ibm.com>
> > ---
> >  arch/powerpc/mm/book3s64/pgtable.c | 33 +++++++++++++++++-------------
> >  1 file changed, 19 insertions(+), 14 deletions(-)
> >
> > diff --git a/arch/powerpc/mm/book3s64/pgtable.c b/arch/powerpc/mm/book3s64/pgtable.c
> > index 40a9fc8b139f..1eeb5fe87023 100644
> > --- a/arch/powerpc/mm/book3s64/pgtable.c
> > +++ b/arch/powerpc/mm/book3s64/pgtable.c
> > @@ -224,6 +224,23 @@ void __init mmu_partition_table_init(void)
> >  	powernv_set_nmmu_ptcr(ptcr);
> >  }
> >
> > +static void flush_partition(unsigned int lpid, unsigned long dw0)
> > +{
> > +	if (dw0 & PATB_HR) {
> > +		asm volatile(PPC_TLBIE_5(%0, %1, 2, 0, 1) : :
> > +			     "r" (TLBIEL_INVAL_SET_LPID), "r" (lpid));
> > +		asm volatile(PPC_TLBIE_5(%0, %1, 2, 1, 1) : :
> > +			     "r" (TLBIEL_INVAL_SET_LPID), "r" (lpid));
> > +		trace_tlbie(lpid, 0, TLBIEL_INVAL_SET_LPID, lpid, 2, 0, 1);
> > +	} else {
> > +		asm volatile(PPC_TLBIE_5(%0, %1, 2, 0, 0) : :
> > +			     "r" (TLBIEL_INVAL_SET_LPID), "r" (lpid));
> > +		trace_tlbie(lpid, 0, TLBIEL_INVAL_SET_LPID, lpid, 2, 0, 0);
> > +	}
> > +	/* do we need fixup here ?*/
> > +	asm volatile("eieio; tlbsync; ptesync" : : : "memory");
> > +}
> > +
> 
> checkpatch.pl seems to complain:
> 
> ERROR: need consistent spacing around '%' (ctx:WxV)
> #125: FILE: arch/powerpc/mm/book3s64/pgtable.c:230:
> +               asm volatile(PPC_TLBIE_5(%0, %1, 2, 0, 1) : :
>                                              ^
> 
> ERROR: need consistent spacing around '%' (ctx:WxV)
> #127: FILE: arch/powerpc/mm/book3s64/pgtable.c:232:
> +               asm volatile(PPC_TLBIE_5(%0, %1, 2, 1, 1) : :
>                                              ^
> 
> ERROR: need consistent spacing around '%' (ctx:WxV)
> #131: FILE: arch/powerpc/mm/book3s64/pgtable.c:236:
> +               asm volatile(PPC_TLBIE_5(%0, %1, 2, 0, 0) : :
>                                              ^

Then clearly checkpatch.pl has a bug.

Paul.
