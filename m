Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC1EACD54AC
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Sep 2023 10:08:06 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=l982ROFM;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Rqcmj3Rzyz3cJN
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Sep 2023 20:08:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=l982ROFM;
	dkim-atps=neutral
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Rqcll6LpLz3c9N
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Sep 2023 20:07:15 +1000 (AEST)
Received: by gandalf.ozlabs.org (Postfix)
	id 4Rqcll5dtMz4xNj; Tue, 19 Sep 2023 20:07:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1695118035;
	bh=EG4yywphNOcFKEleUbrLwZC/DLnpAynwhHRc5auN+Bg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=l982ROFME9DhkKEs2ppYKRK0p0D8MCWs/wd8ECBdgVrqnV4T+oE/B/M+TIMtUKAAM
	 MczlhCUbmq9KGcfyee8Ono+uGUKedljAOmDqbSjCWTMlFFYSHtotnaHjWJHlDqdSeF
	 eN0pSKFADnrV0KNBQutUl5lwK2znZ7pBLf9XUZdfMnt2ATBXfZwLYqcDLN91mK0F6U
	 E2YjwjGfRVt0ESYbUk6JiQoEajXJEHLE+m47P525xVDWfgxTaPC3N/dVAclItnjrZu
	 KmbF4Gub9xVfxa/12YQtVrtDtPjcER7dlnnFcPuWt1wYqYpzcKsoYMPMBNRAIOly1F
	 +gCAr+5Cq+yhw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rqcll4gZqz4xDB;
	Tue, 19 Sep 2023 20:07:15 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Aditya Gupta <adityag@linux.ibm.com>
Subject: Re: [PATCH] powerpc: add `cur_cpu_spec` symbol to vmcoreinfo
In-Reply-To: <7wyh7samvysbs5t3uo5txdxxf3kn4dh3ydgkwjwfvewayyi4ej@n6jbmivlnshz>
References: <20230911091409.415662-1-adityag@linux.ibm.com>
 <87v8cc7uva.fsf@mail.lhotse>
 <7wyh7samvysbs5t3uo5txdxxf3kn4dh3ydgkwjwfvewayyi4ej@n6jbmivlnshz>
Date: Tue, 19 Sep 2023 20:07:15 +1000
Message-ID: <87led2tr1o.fsf@mail.lhotse>
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
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>, linuxppc-dev@ozlabs.org, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Aditya Gupta <adityag@linux.ibm.com> writes:
> On Thu, Sep 14, 2023 at 11:22:01PM +1000, Michael Ellerman wrote:
>> Aditya Gupta <adityag@linux.ibm.com> writes:
>> > Presently, while reading a vmcore, makedumpfile uses
>> > `cur_cpu_spec.mmu_features` to decide whether the crashed system had
>> > RADIX MMU or not.
>> >
>> > Currently, makedumpfile fails to get the `cur_cpu_spec` symbol (unless
>> > a vmlinux is passed with the `-x` flag to makedumpfile), and hence
>> > assigns offsets and shifts (such as pgd_offset_l4) incorrecly considering
>> > MMU to be hash MMU.
>> >
>> > Add `cur_cpu_spec` symbol and offset of `mmu_features` in the
>> > `cpu_spec` struct, to VMCOREINFO, so that the symbol address and offset
>> > is accessible to makedumpfile, without needing the vmlinux file
>> 
>> This looks fine.
>> 
>> Seems like cpu_features would be needed or at least pretty useful too?
>> 
>> cheers
>
> Sure, that can be added too, to the vmcoreinfo. Not sure if it's used now, but
> sure it can help to identify features in makedumpfile.
>
> Will add it, in next version.

Please do it in a separate commit to the mmu_features :)

cheers
