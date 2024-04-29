Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CA75C4345F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Apr 2024 03:21:33 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=SGASX9zK;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VSTBh1QCdz3cVY
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Apr 2024 13:21:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=SGASX9zK;
	dkim-atps=neutral
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VST9r4f8jz3c2t
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Apr 2024 13:20:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1714360848;
	bh=2hKXH2j/7nDl/GpmYLi00ajlbcLDtOnf5W96l8eEnh4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=SGASX9zKPtuI9Qg3Ob2u4stBrZBj89zNpDVaqXIgl07um7nu83JIht6uGFjpANZWX
	 y+lKcOvAFS+9QLre1wXXUAz+fG9jBrbHc64KBXHyUCMA4mKToikMo0HjaT8JW79HwR
	 JfneX1ajbXsPIoQr+Mwujuvq0oJsGkinpTFYgia6EQZ7/705rZQhk/HXanTKWV52+v
	 c0/ufW28veAsDmvuMN6L5Dxz3s59k6aEw3RCjdJ3z/cZicfWGwgM7fa0XJEDMWGmMI
	 EKKb57JXz6Td1OwFJ+lyyBo9gegHRTmuYkvcDX9HxoPKp2KTys8wfT9zxMGnt3uaOw
	 7N7DaiYTcNHkQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VST9n4tXVz4wcF;
	Mon, 29 Apr 2024 13:20:45 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nathan Lynch <nathanl@linux.ibm.com>, Nathan Lynch via B4 Relay
 <devnull+nathanl.linux.ibm.com@kernel.org>, Nicholas Piggin
 <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, "Naveen N. Rao"
 <naveen.n.rao@linux.ibm.com>
Subject: Re: [PATCH] powerpc/pseries: Enforce hcall result buffer validity
 and size
In-Reply-To: <87h6fnu7ar.fsf@li-e15d104c-2135-11b2-a85c-d7ef17e56be6.ibm.com>
References: <20240408-pseries-hvcall-retbuf-v1-1-ebc73d7253cf@linux.ibm.com>
 <874jcac3xb.fsf@mail.lhotse>
 <87cyqy7il1.fsf@li-e15d104c-2135-11b2-a85c-d7ef17e56be6.ibm.com>
 <87h6fnu7ar.fsf@li-e15d104c-2135-11b2-a85c-d7ef17e56be6.ibm.com>
Date: Mon, 29 Apr 2024 13:20:42 +1000
Message-ID: <878r0wkg6t.fsf@mail.lhotse>
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Nathan Lynch <nathanl@linux.ibm.com> writes:
> Nathan Lynch <nathanl@linux.ibm.com> writes:
>> Michael Ellerman <mpe@ellerman.id.au> writes:
>>> Nathan Lynch via B4 Relay <devnull+nathanl.linux.ibm.com@kernel.org>
>>> writes:
>>>>
>>>> plpar_hcall(), plpar_hcall9(), and related functions expect callers to
>>>> provide valid result buffers of certain minimum size. Currently this
>>>> is communicated only through comments in the code and the compiler has
>>>> no idea.
>>>>
>>>> For example, if I write a bug like this:
>>>>
>>>>   long retbuf[PLPAR_HCALL_BUFSIZE]; // should be PLPAR_HCALL9_BUFSIZE
>>>>   plpar_hcall9(H_ALLOCATE_VAS_WINDOW, retbuf, ...);
>>>>
>>>> This compiles with no diagnostics emitted, but likely results in stack
>>>> corruption at runtime when plpar_hcall9() stores results past the end
>>>> of the array. (To be clear this is a contrived example and I have not
>>>> found a real instance yet.)
>>>
>>> We did have some real stack corruption bugs in the past.
>>>
>>> I referred to them in my previous (much uglier) attempt at a fix:
>>>
>>>   https://patchwork.ozlabs.org/project/linuxppc-dev/patch/1476780032-21643-2-git-send-email-mpe@ellerman.id.au/
>>>
>>> Annoyingly I didn't describe them in any detail, but at least one of them was:
>>>
>>>   24c65bc7037e ("hwrng: pseries - port to new read API and fix stack
>>>   corruption")
>>
>> Thanks for this background.
>>
>>
>>> Will this catch a case like that? Where the too-small buffer is not
>>> declared locally but rather comes into the function as a pointer?
>>
>> No, unfortunately. But here's a sketch that forces retbuf to be an
>> array [...]
>
> I've made some attempts to improve on this, but I think the original
> patch as written may be the best we can do without altering existing
> call sites or introducing new APIs and types.
...
>
> OK with taking the patch as-is?

Yeah. It's an improvement, even if it's not the full solution.

cheers
