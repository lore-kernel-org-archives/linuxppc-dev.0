Return-Path: <SRS0=TRtS=2J=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6AFBC43603
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Dec 2019 11:03:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 217A824650
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Dec 2019 11:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="nz2yMamR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 217A824650
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47dps85LmmzDqnv
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Dec 2019 22:03:40 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47dpmw6yMmzDqgG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Dec 2019 22:00:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.b="nz2yMamR"; dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 47dpmw3sM2z9sPK; Thu, 19 Dec 2019 22:00:00 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 47dpmv6hY7z9sP6;
 Thu, 19 Dec 2019 21:59:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1576753200;
 bh=9DgfDxZL5lACm7q7lGR4p4NUM1XFDLiTxKkghwiemps=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=nz2yMamR5Xe2QWdPYkhMRyh1CLRDqCncJ11UYMCTNVa6Z1vwdydd0jwDzncIfjdNM
 uvcKQFa2ebttLB5XOxJBvwJvT3YgyPrftUyHKq0BkRd1Iiz8ptA+EhdwnNcrirA8ER
 pFM3s9AowbxXPc2MrfHr4Li/S0aaFCHO4tURaczvt8YNzfDeC5J89U7tovNhmau9Vj
 7h/NdRE+O+7jvSTGY8RHQbthsZw+kURqLXwCrXfdEl1A4UCrUoFGrjkDsbo+LWvBwT
 5k9tWXTMbDyGc3co/jU/rcLFdhoEMXqIVFnRkvx2QRsXtXi8Pp1X3QzUEqhSgJJVbL
 ++utJbTOL+kYQ==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] powerpc/pseries/svm: Don't access some SPRs
In-Reply-To: <20191218235753.GA12285@us.ibm.com>
References: <20191218043048.3400-1-sukadev@linux.ibm.com>
 <875zidoqok.fsf@mpe.ellerman.id.au> <20191218235753.GA12285@us.ibm.com>
Date: Thu, 19 Dec 2019 21:59:57 +1100
Message-ID: <87immcmvgy.fsf@mpe.ellerman.id.au>
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
Cc: andmike@linux.ibm.com, linuxram@us.ibm.com, kvm-ppc@vger.kernel.org,
 linuxppc-dev@ozlabs.org, Sukadev Bhattiprolu <sukadev@linux.ibm.com>,
 bauerman@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com> writes:
> Michael Ellerman [mpe@ellerman.id.au] wrote:
>> 
>> eg. here.
>> 
>> This is the fast path of context switch.
>> 
>> That expands to:
>> 
>> 	if (!(mfmsr() & MSR_S))
>> 		asm volatile("mfspr %0, SPRN_BESCR" : "=r" (rval));
>> 	if (!(mfmsr() & MSR_S))
>> 		asm volatile("mfspr %0, SPRN_EBBHR" : "=r" (rval));
>> 	if (!(mfmsr() & MSR_S))
>> 		asm volatile("mfspr %0, SPRN_EBBRR" : "=r" (rval));
>> 
>
> Yes, should have optimized this at least :-)
>> 
>> If the Ultravisor is going to disable EBB and BHRB then we need new
>> CPU_FTR bits for those, and the code that accesses those registers
>> needs to be put behind cpu_has_feature(EBB) etc.
>
> Will try the cpu_has_feature(). Would it be ok to use a single feature
> bit, like UV or make it per-register group as that could need more
> feature bits?

We already have a number of places using is_secure_guest():

  arch/powerpc/include/asm/mem_encrypt.h: return is_secure_guest();
  arch/powerpc/include/asm/mem_encrypt.h: return is_secure_guest();
  arch/powerpc/include/asm/svm.h:#define get_dtl_cache_ctor()     (is_secure_guest() ? dtl_cache_ctor : NULL)
  arch/powerpc/kernel/machine_kexec_64.c: if (is_secure_guest() && !(image->preserve_context ||
  arch/powerpc/kernel/paca.c:     if (is_secure_guest())
  arch/powerpc/kernel/sysfs.c:    return sprintf(buf, "%u\n", is_secure_guest());
  arch/powerpc/platforms/pseries/iommu.c: if (!is_secure_guest())
  arch/powerpc/platforms/pseries/smp.c:   if (cpu_has_feature(CPU_FTR_DBELL) && !is_secure_guest())
  arch/powerpc/platforms/pseries/svm.c:   if (!is_secure_guest())


Which could all (or mostly) be converted to use a cpu_has_feature(CPU_FTR_SVM).

So yeah I guess it makes sense to do that, create a CPU_FTR_SVM and set
it early in boot based on MSR_S.

You could argue it's a firmware feature, so should be FW_FEATURE_SVM,
but we don't use jump_labels for firmware features so they're not as
nice for hot-path code like register switching. Also the distinction
between CPU and firmware features is a bit arbitrary.

cheers
