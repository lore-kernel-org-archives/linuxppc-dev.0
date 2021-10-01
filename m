Return-Path: <SRS0=1eNT=OV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B2AC433F5
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Oct 2021 11:30:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3711661994
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Oct 2021 11:30:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3711661994
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HLSbK36WPz3c7D
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Oct 2021 21:30:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=A3k2s8EL;
	dkim-atps=neutral
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HLSZZ5j5lz2ync
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Oct 2021 21:29:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=A3k2s8EL; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4HLSZZ2R17z4xbG;
 Fri,  1 Oct 2021 21:29:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
 s=201909; t=1633087798;
 bh=UIL0S5Vjc6FwFGELw9jSfBp3QYkrY9shNk2HabCaeek=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=A3k2s8ELrktgCmpuwykr7E/mwkOsuhkSXKQ1OQShNm+y2YKnAtAsmdCm2PvrGr+e5
 6puplxAovsYx7uFw3lZqdStXV13cE+OtSCyPwHfcllUl7B69sXfdsbwgv/vzFjt0zB
 AFUFmZo9jfFRQKE4OQeS+p7wcqqybueFBhnj4BqalsnMjfsYDKi3GEzPTayHKBhsVY
 DTi28B0qAifa3ZEh0QqPpPl8m8rFYzFUPbLu7Qu+QM2DqTqo8i/+32V9MjjDwGMRPF
 VMjffrOo9+1mE+9RAFrAyQ1e4UAH5CGArMsrEZa7PYJX0rOrg3gSNgSZIQmF2Zx+tp
 xwo+o8yXjyrnA==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Daniel Axtens <dja@axtens.net>, Athira Rajeev
 <atrajeev@linux.vnet.ibm.com>, acme@kernel.org, jolsa@kernel.org
Subject: Re: [V2 2/4] tools/perf: Refactor the code definition of perf reg
 extended mask in tools side header file
In-Reply-To: <87o889mfl3.fsf@linkitivity.dja.id.au>
References: <20210930122055.1390-1-atrajeev@linux.vnet.ibm.com>
 <20210930122055.1390-3-atrajeev@linux.vnet.ibm.com>
 <87o889mfl3.fsf@linkitivity.dja.id.au>
Date: Fri, 01 Oct 2021 21:29:57 +1000
Message-ID: <87v92hq8y2.fsf@mpe.ellerman.id.au>
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
Cc: kjain@linux.ibm.com, maddy@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, rnsastry@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Daniel Axtens <dja@axtens.net> writes:
> Hi Athira,
>
>> PERF_REG_PMU_MASK_300 and PERF_REG_PMU_MASK_31 defines the mask
>> value for extended registers. Current definition of these mask values
>> uses hex constant and does not use registers by name, making it less
>> readable. Patch refactor the macro values in perf tools side header file
>> by or'ing together the actual register value constants.
>>
> This looks like a good simplification.
>
>> -/* Exclude MMCR3, SIER2, SIER3 for CPU_FTR_ARCH_300 */
>> -#define	PERF_EXCLUDE_REG_EXT_300	(7ULL << PERF_REG_POWERPC_MMCR3)
>
> This file is uAPI - are we allowed to remove a define? Could a program
> built against these headers now fail to compile because we've removed it?

Yeah that's true.

In this case I think I'd rather we remove it though, because:
 - it was never meant to be part of the uapi, it was just meant for use
   in the construction of PERF_REG_PMU_MASK_300, and is no longer needed
   for that.
 - it's only been in the header since v5.12, so I think the chance of
   anything using it is essentially zero.


cheers
