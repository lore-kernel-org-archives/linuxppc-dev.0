Return-Path: <SRS0=sSB4=5S=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71CF0C43331
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Apr 2020 04:26:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B212B20757
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Apr 2020 04:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="VwzWNIq2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B212B20757
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48t94s1XJ9zDqMW
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Apr 2020 15:26:53 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48t92v5M86zDrJq
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Apr 2020 15:25:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=VwzWNIq2; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 48t92t5vMcz9sPF;
 Thu,  2 Apr 2020 15:25:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1585801511;
 bh=bNgjnPN8uJzLvtTvksLQ0SYemBIRzc/Paj22RkIwwAM=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=VwzWNIq2EjeXkJ2nscShwIcy0DagQUNESHkWHf9dUIOcMt8o2v2ednNokaML1RYB4
 hleywooAxUHcc1EhbUa+eccPpaDQOeu726ji2aatoNqfUiC833L0pXI0NxSBQCJVjP
 4UcQHuWmC7YOovh23tBni5Ne9ELdFNfXk3iqX7Bh9oi2IRnaXTtTf6mcgTp1Z3mnjS
 iRgTCJ8IRNx7s8o6GEakTF2lirBPf7zYv4UNCQEw7O0JxZGdxKSk+ZInWnvs/ebWOj
 AkBQ3brstG7efzB/kkaWElXIPT7Jgdysy5NqfiDNkA68HLevH40lCTwp05KNUA89On
 hxijTr3gttbtQ==
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Balamuruhan S <bala24@linux.ibm.com>
Subject: Re: [RFC PATCH 3/4] powerpc ppc-opcode: move ppc instuction encoding
 from test_emulate_step
In-Reply-To: <1585759165.2r0pc78n07.naveen@linux.ibm.com>
References: <20200320081837.1016820-1-bala24@linux.ibm.com>
 <20200320081837.1016820-4-bala24@linux.ibm.com>
 <1585759165.2r0pc78n07.naveen@linux.ibm.com>
Date: Thu, 02 Apr 2020 15:25:18 +1100
Message-ID: <87ftdmtsy9.fsf@mpe.ellerman.id.au>
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
Cc: jniethe5@gmail.com, linuxppc-dev@lists.ozlabs.org, sandipan@linux.ibm.com,
 paulus@samba.org, ravi.bangoria@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:
> Balamuruhan S wrote:
>> Few ppc instructions are encoded in test_emulate_step.c, consolidate them to
>> ppc-opcode.h, fix redefintion errors in bpf_jit caused due to this consolidation.
>> Reuse the macros from ppc-opcode.h
...
>> diff --git a/arch/powerpc/net/bpf_jit32.h b/arch/powerpc/net/bpf_jit32.h
>> index 4ec2a9f14f84..8a9f16a7262e 100644
>> --- a/arch/powerpc/net/bpf_jit32.h
>> +++ b/arch/powerpc/net/bpf_jit32.h
>> @@ -76,13 +76,13 @@ DECLARE_LOAD_FUNC(sk_load_byte_msh);
>>  		else {	PPC_ADDIS(r, base, IMM_HA(i));			      \
>>  			PPC_LBZ(r, r, IMM_L(i)); } } while(0)
>> 
>> -#define PPC_LD_OFFS(r, base, i) do { if ((i) < 32768) PPC_LD(r, base, i);     \
>> +#define _OFFS(r, base, i) do { if ((i) < 32768) EMIT(PPC_ENCODE_LD(r, base, i));     \
> 	   ^^^^^
> Should be PPC_LD_OFFS. For the next version, please also build ppc32 and 
> booke codebase to confirm that your changes in those areas are fine.
>
> PPC_ENCODE_* also looks quite verbose, so perhaps PPC_ENC_* might be 
> better. Otherwise, this patchset looks good to me and should help reuse 
> some of those macros, especially from the eBPF codebase.
>
> Michael,
> Can you let us know if this looks ok to you? Based on your feedback, we 
> will also update the eBPF codebase.

I didn't really like the first patch which does the mass renaming. It
creates a huge amount of churn.

I think I'd be happier if this series just did what it needs, and then
maybe at the end there's a patch to update all the existing names, which
I may or may not take.

As far as the naming, currently we have:

PPC_INST_FOO - just the opcode

PPC_FOO(x) - macro to encode the opcode with x and (usually) also emit a
            .long and stringify.

And you need an in-between that gives you the full instruction but
without the .long and stringify, right?

So how about PPC_RAW_FOO() for just the numeric value, without the .long
and stringify.

We also seem to have a lot of PPC_INST_FOO's that are only ever used in
the PPC_INST macro. I'm inclined to fold those into the PPC_INST macro,
to avoid people accidentally using the PPC_INST version when they don't
mean to. But that's a separate issue.

cheers
