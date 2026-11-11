Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C52606A321
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Nov 2026 15:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=O4WjbTiC
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPnn24L5Jz2y8p;
	Thu, 12 Nov 2026 02:41:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.175
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794411686;
	cv=none; b=nH/kXOmRi5TMGOSWk+QFc0ZUhGtLc49E6pqjy7T3EY7E4MGopHyKkCuTSqyY4U07V1DxbBCkdXma5kkxGqII+C+s6PvOuHAHi4UPNpwMc0tCU6K9PTZgF1IKuBw0JLLef+8dGsxdueJzVH3weFGjp1jjuJzWhEY7gC5HPicR/9swRnrv6gM9I8aTgflPJhIvWXDbxgFfOF/LydAF2bUpcb2EMD3GDOp1wMPRKiXBwzGbiKgCXol/TzNtEVdVDFXzrKk2BZpGIv4uOp0GDLrAZYwgqnqPBPatT1SFrL6Qmu8yfdUSZJ/OavkhWertjZQgR/wh/UDqiE6jsbZVZDLVPw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794411686; c=relaxed/relaxed;
	bh=V2RK/PzuSKL2WWoPvMWzGQDcrRR0IyUh0nU/ByMaJ4Q=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=IdpAHHrOUsRceQI3O1rDHvJJraRegeD92bxKZzEQfu1HCy2E5eXbWhlpYBbH3qhDlhXmBTLc/1anI6260r83WVOwhi8g4buxiEqCgTMBTIHBQrUG6kJmu0kU2r//EftlPaeSR4xpOg5EUUnhVgWaOyXEyi6VdOiKmEtVX6R2VUcQHdwzvlSP94gf81+1kRMUzE8+gG3PObHxRY5G69yonZwN2VIiuYjabj3X/VQ+5PNf/VK0iPSBzBctSSgmCaXz0BnBVNuTHf61YaEhdZWzmcZr7lf1r5riZMGxRMOmJknHfUydUJtDi1WUSuaa45gRwYYt8aaT/xi2xPstjL9aHA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=O4WjbTiC; dkim-atps=neutral; spf=pass (client-ip=95.215.58.175; helo=mta1.migadu.com; envelope-from=bradley.morgan@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=O4WjbTiC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.175; helo=mta1.migadu.com; envelope-from=bradley.morgan@linux.dev; receiver=lists.ozlabs.org)
Received: from mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jPnmy5kkBz2y8F
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 02:41:21 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=Eu89BSEwRX3HTJBZoUqF/4O/mFGX7rsk8i5L0YqInwg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794411661; v=1; x=1795016461;
 b=O4WjbTiCDcDDTMdSJmO9z6O9LneyWgZ7wTbeHGWbKKuIKNOs6rfmNleYSG+vuW3v8RyTnEak
 O6YENCmg/1/bgm7J7ogOmbEriJR6qGxGoQff97MRQxlRFymbc/LfsIl3ZGEEnU7zE5ekGAIspQ3
 mpWeT4TkDnsfoYbA/tmJTA1o=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id c6d4ac561fa4402f;
	Wed, 11 Nov 2026 15:41:01 +0000
X-Mizu-Trace-ID: c6d4ac561fa4402f
X-Migadu-Flow: FLOW_OUT
Date: Wed, 11 Nov 2026 15:40:57 +0000
From: Bradley Morgan <bradley.morgan@linux.dev>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, ritesh.list@gmail.com
CC: brads@mainlining.org, chleroy@kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, npiggin@gmail.com,
 sshegde@linux.ibm.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_powerpc32/modules=3A_Reser?=
 =?US-ASCII?Q?ve_a_PLT_entry_for_ftrace=5Fregs=5Fcaller?=
In-Reply-To: <371108c3-0314-4015-9ca4-d96a11f1e597@linux.ibm.com>
References: <80D9FEB3-9FB3-4878-BC66-74C13761CC9A@linux.dev> <371108c3-0314-4015-9ca4-d96a11f1e597@linux.ibm.com>
Message-ID: <23E9A6DC-579A-4B62-B35C-578A8E3389BD@linux.dev>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11 November 2026 11:58:28 GMT, Madhavan Srinivasan <maddy@linux.ibm.com>
wrote:
>
>On 11/11/26 12:58 PM, Bradley Morgan wrote:
>> On 11 November 2026 03:48:41 GMT, Ritesh Harjani <ritesh.list@gmail.com>
>> wrote:
>>> Bradley Morgan <brads@mainlining.org> writes:
>>> 
>>>> Commit 7dfbfb87c243 ("powerpc/ftrace: Activate
>>>> HAVE_DYNAMIC_FTRACE_WITH_REGS on PPC32") made count_relocs()
>>>> undercount the PLT entries the loader
>>>> consumes: module_finalize_ftrace() now creates two trampolines
>>>> (mod->arch.tramp for ftrace_caller() and mod->arch.tramp_regs for
>>>> ftrace_regs_caller()), while count_relocs() reserves only one entry
>>>> for ftrace.
>>>> 
>>>> So the core .plt ends up one ppc_plt_entry (16 bytes) short. The
>>>> walk in do_plt_call() scans for a free slot with
>>>> "while (entry->jump[0])" and has no bound check, so once the last
>>>> reserved slot is used up, the walk steps past the end of the section
>>>> and patch_instruction() writes the 4-instruction trampoline into
>>>> whatever module memory follows the .plt.
>>>> 
>>>> Count the second entry, mirroring what module_64.c does for the same
>>>> pair of stubs.
>>>> 
>>>> Signed-off-by: Bradley Morgan <brads@mainlining.org>
>>>> ---
>>>>   arch/powerpc/kernel/module_32.c | 3 +++
>>>>   1 file changed, 3 insertions(+)
>>>> 
>>> Do we also need fixes and stable tag here?
>>> 
>>> Fixes: 7dfbfb87c243 ("powerpc/ftrace: Activate
>HAVE_DYNAMIC_FTRACE_WITH_REGS on PPC32")
>>> Cc: stable@vger.kernel.org
>> Hmm.. could the merger add that? If anyone merges.. :(
>planned to be part of my fixes PR and will add it.
>Thanks for the fix.

No worries, mind changing sob to this email?

>
>Maddy
>>> 
>>> -ritesh
>>> 
>> --- Thanks!
>

--- Thanks!

