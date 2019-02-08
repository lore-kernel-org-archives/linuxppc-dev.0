Return-Path: <SRS0=r06i=QP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B54BC169C4
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 06:13:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63DF120811
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 06:13:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63DF120811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43wlHg1y4zzDqWH
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 17:13:51 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43wlG073L8zDqKJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Feb 2019 17:12:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 43wlG05crcz9sLw; Fri,  8 Feb 2019 17:12:24 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43wlG04yh4z9s3x;
 Fri,  8 Feb 2019 17:12:24 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v2] powerpc/64: Fix memcmp reading past the end of src/dest
In-Reply-To: <20190207125256.GW14180@gate.crashing.org>
References: <20190207115313.31078-1-mpe@ellerman.id.au>
 <20190207125256.GW14180@gate.crashing.org>
Date: Fri, 08 Feb 2019 17:12:21 +1100
Message-ID: <87bm3mkdve.fsf@concordia.ellerman.id.au>
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
Cc: linuxppc-dev@ozlabs.org, chandan@linux.ibm.com, npiggin@gmail.com,
 daniel@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Segher Boessenkool <segher@kernel.crashing.org> writes:
> On Thu, Feb 07, 2019 at 10:53:13PM +1100, Michael Ellerman wrote:
>> Chandan reported that fstests' generic/026 test hit a crash:
>
>> The instruction dump decodes as:
>>   subfic  r6,r5,8
>>   rlwinm  r6,r6,3,0,28
>>   ldbrx   r9,0,r3
>>   ldbrx   r10,0,r4	<-
>> 
>> Which shows us doing an 8 byte load from c00000062ac3fff9, which
>> crosses the page boundary at c00000062ac40000 and faults.
>> 
>> It's not OK for memcmp to read past the end of the source or
>> destination buffers.
>
> It's not okay to access memory pages unsolicited.  Reading past the end
> is fine per se.

Yeah I guess that's true.

Things like KASAN/valgrind probably disagree, but KASAN at least
overrides memcmp AIUI.

I guess I feel better about it not reading past the end of the buffers,
but maybe I'm being paranoid.

The other complication is we support multiple page sizes, so detecting a
page boundary is more complicated than it could be.

So I guess I'm inclined to stick with this approach, but I can update
the change log.

cheers
