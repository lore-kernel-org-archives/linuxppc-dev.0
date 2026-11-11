Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED5E606A334
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Nov 2026 07:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=c+CWU2LL
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPZs14KLlz2xWR;
	Wed, 11 Nov 2026 18:29:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.160
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794382149;
	cv=none; b=mmKQUijViljbow3KHxGn5dMHk/tFbXyec5ugc/ajBgcxFxGaLU6rljcIXroOE2nYPL9nx0th6DuC9fjn1k9YdjKbBUlgKOWU4hqHuqPlStXy6nmJToTxhSRwhgicZZdJGO1msq7hZ4YoX30dxE3W8Fk7zrLIsoYmbcLqBTtZOJOMY5PXmpBoMkZ7wdCLiJ9LsWfW0mqREP2kkzSr4Wri4T8r38zCdkuymh0P5EwcbbT5q9Ngr4itSKLpslb1Blb4tT2Jd33ayWGCZVk8Ie6Pm2lsHwbxpLSHd2pPiIb0TV1AM4t6ysV3g02P3bIxp1yzSgBqBaWKOF9gRV6hTiVIXg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794382149; c=relaxed/relaxed;
	bh=wM6zMeAKLdvhkIpwxgAO3T4mTUK9pSOuQdsjhKR++rY=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=FhO8uXJdhzESxjvZ1KDI87sauggbqZwzszlDz+Eth9Xzp6ZbPm2HUHrPVUZ1+9mkmuHLZzFfK+9HHTR1GWanrn7qQtZpS4qIkwwwnHD/LeISGeUIZWylLS/os0REQJWpycQBIISmc84PaPeTyXKcaTQKepcMUJMzugOEJr0UAPaQUHcbBlaKjqZV+Oqe12ewgbbGuDlHuU/s3h6gPJo30tmU9RCJ9H4feIrRlBA34rVi59VUMz9JGcY04DyQAiRugJeX3Ui8jrTsaK3VUW9ehXn9YOuAJL5pTxQ/phXsP/T1+j7+UGu3d0HAwfN8dI76GRWPSCDYYqSjIJcw2xu7qw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=c+CWU2LL; dkim-atps=neutral; spf=pass (client-ip=95.215.58.160; helo=mta1.migadu.com; envelope-from=bradley.morgan@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=c+CWU2LL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.160; helo=mta1.migadu.com; envelope-from=bradley.morgan@linux.dev; receiver=lists.ozlabs.org)
Received: from mta1.migadu.com (out-160.mta1.migadu.com [95.215.58.160])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jPZrt58bKz2xLq
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Nov 2026 18:28:58 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=4r9aoLuyZuGjtmYUR9y2nIUFNZJAGpilVsCFbC4LjQk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794382109; v=1; x=1794986909;
 b=c+CWU2LLpeRf0/eaTmILa8H6V07zgC+rB7oJ85isthyud5xYC2xXpjyKcOSYxY7j6nvpLx9j
 4TDiZCIAUZ33OC0OIRCnwf3l7vrgUN0vfdEH4vktRWWegpfLpP05CHeQ4xr1+1pZl5M1P1vp4Ee
 gxvjqts5giRWzLo4QV29OUh0=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id 8cfec852c9357b27;
	Wed, 11 Nov 2026 07:28:29 +0000
X-Mizu-Trace-ID: 8cfec852c9357b27
X-Migadu-Flow: FLOW_OUT
Date: Wed, 11 Nov 2026 07:28:26 +0000
From: Bradley Morgan <bradley.morgan@linux.dev>
To: ritesh.list@gmail.com
CC: brads@mainlining.org, chleroy@kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
 npiggin@gmail.com, sshegde@linux.ibm.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_powerpc32/modules=3A_Reser?=
 =?US-ASCII?Q?ve_a_PLT_entry_for_ftrace=5Fregs=5Fcaller?=
In-Reply-To: <jymk81uu.ritesh.list@gmail.com>
Message-ID: <80D9FEB3-9FB3-4878-BC66-74C13761CC9A@linux.dev>
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

On 11 November 2026 03:48:41 GMT, Ritesh Harjani <ritesh.list@gmail.com>
wrote:
>Bradley Morgan <brads@mainlining.org> writes:
>
>> Commit 7dfbfb87c243 ("powerpc/ftrace: Activate
>> HAVE_DYNAMIC_FTRACE_WITH_REGS on PPC32") made count_relocs()
>> undercount the PLT entries the loader
>> consumes: module_finalize_ftrace() now creates two trampolines
>> (mod->arch.tramp for ftrace_caller() and mod->arch.tramp_regs for
>> ftrace_regs_caller()), while count_relocs() reserves only one entry
>> for ftrace.
>>
>> So the core .plt ends up one ppc_plt_entry (16 bytes) short. The
>> walk in do_plt_call() scans for a free slot with
>> "while (entry->jump[0])" and has no bound check, so once the last
>> reserved slot is used up, the walk steps past the end of the section
>> and patch_instruction() writes the 4-instruction trampoline into
>> whatever module memory follows the .plt.
>>
>> Count the second entry, mirroring what module_64.c does for the same
>> pair of stubs.
>>
>> Signed-off-by: Bradley Morgan <brads@mainlining.org>
>> ---
>>  arch/powerpc/kernel/module_32.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>
>Do we also need fixes and stable tag here?
>
>Fixes: 7dfbfb87c243 ("powerpc/ftrace: Activate HAVE_DYNAMIC_FTRACE_WITH_REGS on PPC32")
>Cc: stable@vger.kernel.org

Hmm.. could the merger add that? If anyone merges.. :(

>
>
>-ritesh
>

--- Thanks!

