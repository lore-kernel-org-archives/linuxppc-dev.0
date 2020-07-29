Return-Path: <SRS0=Q9Mk=BI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8179CC433E0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jul 2020 01:17:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0E7D207E8
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jul 2020 01:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="UxEKgHV0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0E7D207E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BGbHT3FzmzDr5V
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jul 2020 11:17:09 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BGbFK4810zDqxD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2020 11:15:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=UxEKgHV0; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 4BGbFK1TbMz9sSy; Wed, 29 Jul 2020 11:15:17 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4BGbFJ0Qhjz9sRW;
 Wed, 29 Jul 2020 11:15:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1595985317;
 bh=uLD3L3DOKgJ2d1NC32eZyYYdag6TLa6nReuwfKtIbCg=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=UxEKgHV0KiOjp3qRusBz2S3sjmtAiTE1oCvCgnfRuEuSn1kkp+Jx0+MEF+ozPCAZC
 x8bgKeVUNY+wXri/8XnjJj7suHZNu/l639huAXpHph568BQdZAU2U94bzjyWldttvm
 mVl1zrsh+yNPRMb5kinHvGdaqjFIECn5/kQf9b6EOCxouOzKdxofVz1ytU0QacXDkv
 J7cRYJDeEhRrJ83DCGVu7+4MCdj2lmStKpttXXR0fg6s6WPeMCZpyOgs/D4+6ZfFHT
 u7BUtR8ieCbqkSmiRkuMWiwgLNA+cgTtRX7AIZMAqS3uteJB1AJUmC+1v350NVhRjn
 gB+xizwWf4WaQ==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Hari Bathini <hbathini@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RESEND PATCH v5 07/11] ppc64/kexec_file: enable early kernel's
 OPAL calls
In-Reply-To: <23baef6a-6ddc-572a-82c5-21a7fa441485@linux.ibm.com>
References: <159579157320.5790.6748078824637688685.stgit@hbathini>
 <159579233676.5790.10701756666641782647.stgit@hbathini>
 <87365b7nx4.fsf@mpe.ellerman.id.au>
 <23baef6a-6ddc-572a-82c5-21a7fa441485@linux.ibm.com>
Date: Wed, 29 Jul 2020 11:15:12 +1000
Message-ID: <87v9i75dgf.fsf@mpe.ellerman.id.au>
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
Cc: Pingfan Liu <piliu@redhat.com>, Kexec-ml <kexec@lists.infradead.org>,
 Nayna Jain <nayna@linux.ibm.com>, Petr Tesarik <ptesarik@suse.cz>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>,
 lkml <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Sourabh Jain <sourabhjain@linux.ibm.com>, Vivek Goyal <vgoyal@redhat.com>,
 Dave Young <dyoung@redhat.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>,
 Eric Biederman <ebiederm@xmission.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hari Bathini <hbathini@linux.ibm.com> writes:
> On 28/07/20 7:16 pm, Michael Ellerman wrote:
>> Hari Bathini <hbathini@linux.ibm.com> writes:
>>> Kernel built with CONFIG_PPC_EARLY_DEBUG_OPAL enabled expects r8 & r9
>>> to be filled with OPAL base & entry addresses respectively. Setting
>>> these registers allows the kernel to perform OPAL calls before the
>>> device tree is parsed.
>> 
>> I'm not convinced we want to do this.
>> 
>> If we do it becomes part of the kexec ABI and we have to honour it into
>> the future.
>> 
>> And in practice there are no non-development kernels built with OPAL early
>> debugging enabled, so it's not clear it actually helps anyone other than
>> developers.
>> 
>
> Hmmm.. kexec-tools does it since commit d58ad564852c ("kexec/ppc64
> Enable early kernel's OPAL calls") for kexec_load syscall. So, we would
> be breaking kexec ABI either way, I guess.

Ugh, OK.

> Let me put this patch at the end of the series in the respin to let you
> decide whether to have it or not..

Thanks.

cheers
