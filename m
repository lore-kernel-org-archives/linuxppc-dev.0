Return-Path: <SRS0=AwiL=AS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 283B6C433E0
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2020 01:07:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBD3A206F6
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2020 01:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="kiqm+4wC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBD3A206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4B146b0MxLzDqTY
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2020 11:07:35 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B143n6zDLzDqT4
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jul 2020 11:05:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=kiqm+4wC; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4B143n4K9Hz9s1x;
 Tue,  7 Jul 2020 11:05:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1594083909;
 bh=EXTy/WT5tn6n6qNIpExAgugH9j2iln8NX5W3O/SunlQ=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=kiqm+4wCQfVusdQRkneZN/Smy+/Ix0pb+U6k8D03amNvXc+YCdnFKkl/3QvuiOdcC
 tfrqCYAChiea2/YIw986JFsL2j7ZpwGi0EkNqHr/ExvagVczG6TV1FRuSe/7BDH4qV
 cOdDkAQEeV+96KdNPb06JOhVa57PwqFR8rxZD1w81qI/fcpPmLBD3EGh/XqakpuZRn
 vbCoDwFyuBZQMwN0ojbV86bHkp/DJ/zgBafkTfdHq+9WUhHKOr2e10mDwlVScArcx5
 6/inxtR0NVO5sFPdNMkshosAcMMd0y+QsJoFwSvoTotk1oE98wwYbiNrGW6IvinNj2
 /iwi5wc+TIUgg==
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v5 18/26] powerpc/book3s64/keys/kuap: Reset AMR/IAMR
 values on kexec
In-Reply-To: <2739323b-51c0-c713-0986-aa0bdaab3184@linux.ibm.com>
References: <20200619135850.47155-1-aneesh.kumar@linux.ibm.com>
 <20200619135850.47155-19-aneesh.kumar@linux.ibm.com>
 <87h7uk6d3m.fsf@mpe.ellerman.id.au>
 <2739323b-51c0-c713-0986-aa0bdaab3184@linux.ibm.com>
Date: Tue, 07 Jul 2020 11:07:24 +1000
Message-ID: <87wo3g3zg3.fsf@mpe.ellerman.id.au>
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
Cc: linuxram@us.ibm.com, bauerman@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
> On 7/6/20 5:59 PM, Michael Ellerman wrote:
>> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
>>> As we kexec across kernels that use AMR/IAMR for different purposes
>>> we need to ensure that new kernels get kexec'd with a reset value
>>> of AMR/IAMR. For ex: the new kernel can use key 0 for kernel mapping and the old
>>> AMR value prevents access to key 0.
>>>
>>> This patch also removes reset if IAMR and AMOR in kexec_sequence. Reset of AMOR
>>> is not needed and the IAMR reset is partial (it doesn't do the reset
>>> on secondary cpus) and is redundant with this patch.
>> 
>> I like the idea of cleaning this stuff up.
>> 
>> But I think tying it into kup/kuep/kuap and the MMU features and ifdefs
>> and so on is overly complicated.
>> 
>> We should just have eg:
>> 
>> void reset_sprs(void)
>> {
>> 	if (early_cpu_has_feature(CPU_FTR_ARCH_206)) {
>>          	mtspr(SPRN_AMR, 0);
>>          	mtspr(SPRN_UAMOR, 0);
>>          }
>> 
>> 	if (early_cpu_has_feature(CPU_FTR_ARCH_207S)) {
>>          	mtspr(SPRN_IAMR, 0);
>>          }
>> }
>> 
>> And call that from the kexec paths.
>
> Will fix. Should that be early_cpu_has_feature()? cpu_has_feature() 
> should work there right?

Yeah I guess. I was thinking if we crashed before code patching was
done, but if that happens we can't kdump anyway. So I'm probably being
over paranoid.

cheers
